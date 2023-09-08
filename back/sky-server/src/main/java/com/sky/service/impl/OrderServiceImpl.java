package com.sky.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sky.constrant.SHOPSTAUTS;
import com.sky.constrant.ShopCache;
import com.sky.context.UserHolder;
import com.sky.dto.OrdersCancelDTO;
import com.sky.dto.OrdersConfirmDTO;
import com.sky.dto.OrdersPageQueryDTO;
import com.sky.dto.OrdersRejectionDTO;
import com.sky.entity.AddressBook;
import com.sky.entity.OrderDetail;
import com.sky.entity.Orders;
import com.sky.entity.ShoppingCart;
import com.sky.exception.BusinessException;
import com.sky.mapper.AddressBookMapper;
import com.sky.mapper.OrderDetailMapper;
import com.sky.mapper.OrdersMapper;
import com.sky.mapper.ShoppingCartMapper;
import com.sky.result.PageBean;
import com.sky.service.OrderService;
import com.sky.service.ShopService;
import com.sky.service.ShoppingCartService;
import com.sky.utils.BaiduUtils;
import com.sky.utils.HttpClientUtil;
import com.sky.vo.OrderStatisticsVO;
import com.sky.vo.OrderSubmitVO;
import com.sky.vo.OrderVO;
import com.sky.websocket.WebSocketServer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;

@Service
@Transactional
@Slf4j
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrdersMapper ordersMapper;
    @Autowired
    private OrderDetailMapper orderDetailMapper;
    @Autowired
    private AddressBookMapper addressBookMapper;
    @Autowired
    private ShoppingCartService shoppingCartService;
    @Autowired
    private ShoppingCartMapper shoppingCartMapper;
    @Autowired
    private WebSocketServer webSocketServer;

    @Autowired
    private ShopService shopService;

    @Autowired
    RedisTemplate redisTemplate;

    @Autowired
    private BaiduUtils baiduUtils;

    @Override
    public OrderSubmitVO save(Orders orders) {
        log.info("顾客提交订单");
        Integer shop_status = (Integer) redisTemplate.opsForValue().get(ShopCache.SHOP_STATUS);
        // 再次获取状态
        if (shop_status != null && shop_status == SHOPSTAUTS.OFF) {
            log.info("客官~~本店已打烊了！早点休息吧QAQ");
            throw new BusinessException("客官~~本店已打烊了！早点休息吧QAQ");

        }

        //1. 根据地址id查询地址信息
        // 如果该用户还没有设置收获地址，则先选择收货地址
        AddressBook addressBook = addressBookMapper.selectById(orders.getAddressBookId());
        if (addressBook == null) {
            throw new BusinessException("请先选择收货地址");
        }

        //2. 根据登录用户id查询目前的购物车
        List<ShoppingCart> shoppingCartList = shoppingCartService.findList();
        if (CollectionUtil.isEmpty(shoppingCartList)) {
            throw new BusinessException("请先选择下单商品");
        }

        baiduUtils.checkOutOfRange(addressBook.getProvinceName() + addressBook.getCityName() + addressBook.getDistrictName() + addressBook.getDetail());

        //3. 保存订单
        //3-1 补齐订单字段
        orders.setNumber(UUID.randomUUID().toString().replace("-", ""));//订单号: 自己生成,要求唯一(不能大于32位)
        orders.setStatus(Orders.PENDING_PAYMENT);//订单状态: 1待付款
        orders.setUserId(UserHolder.get());//下单人id
        orders.setOrderTime(LocalDateTime.now());//下单时间
        orders.setPayStatus(Orders.UN_PAID);//支付状态: 未支付
        orders.setPhone(addressBook.getPhone());//收货人手机号
        orders.setAddress(addressBook.getProvinceName() + addressBook.getCityName() + addressBook.getDistrictName() + addressBook.getDetail());//收货地址
        orders.setConsignee(addressBook.getConsignee());

        //3-2 保存到订单表(主键返回)
        ordersMapper.insert(orders);

        //4. 保存订单详情
        //4-1 遍历购物车列表,得到每个购物项
        for (ShoppingCart shoppingCart : shoppingCartList) {
            //4-2 购物项--订单详情
            OrderDetail orderDetail = BeanUtil.copyProperties(shoppingCart, OrderDetail.class, "id");
            //4-3 补齐订单id
            orderDetail.setOrderId(orders.getId());
            //4-4 保存订单详情
            orderDetailMapper.insert(orderDetail);
        }

        //5. 清空购物车
        shoppingCartService.clean();

        //6. 返回VO
        OrderSubmitVO orderSubmitVO = OrderSubmitVO.builder()
                .id(orders.getId())
                .orderNumber(orders.getNumber())
                .orderTime(orders.getOrderTime())
                .orderAmount(orders.getAmount())
                .build();
        return orderSubmitVO;
    }

    @Override
    public PageBean<OrderVO> findByPage(OrdersPageQueryDTO dto) {
        //1. 设置分页条件
        Page<Orders> page = new Page<>(dto.getPage(), dto.getPageSize());

        //2. 设置业务条件
        LambdaQueryWrapper<Orders> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(UserHolder.get() != null, Orders::getUserId, UserHolder.get());
        wrapper.eq(dto.getStatus() != null, Orders::getStatus, dto.getStatus());
        wrapper.orderByDesc(Orders::getOrderTime);

        //3. 执行查询
        ordersMapper.selectPage(page, wrapper);

        //4. 为每个订单填充订单详情
        List<OrderVO> orderVOList = new ArrayList<>();
        List<Orders> ordersList = page.getRecords();
        if (CollectionUtil.isNotEmpty(ordersList)) {
            for (Orders orders : ordersList) {
                //3-1 复制
                OrderVO orderVO = BeanUtil.copyProperties(orders, OrderVO.class);
                //3-2 调用orderDetailMapper根据订单id查询详情列表
                LambdaQueryWrapper<OrderDetail> wrapper1 = new LambdaQueryWrapper<>();
                wrapper1.eq(OrderDetail::getOrderId, orderVO.getId());
                List<OrderDetail> details = orderDetailMapper.selectList(wrapper1);
                //3-3 将detail封装到vo
                orderVO.setOrderDetailList(details);
                //3-4 条件到集合
                orderVOList.add(orderVO);
            }
        }

        //5. 返回结果
        return new PageBean<OrderVO>(page.getTotal(), orderVOList);
    }

    @Override
    public void cancelById(Long id) {
        //1. 根据订单id查询
        Orders orders = ordersMapper.selectById(id);

        //2. 判断订单状态
        if (orders.getStatus() > 2) { //3已接单 4派送中 5已完成 6已取消
            throw new BusinessException("订单无法取消,请联系商家");
        }

        //3. 修改订单状态
        //3-1 构建一个修改对象
        Orders ordersUpdate = new Orders();
        ordersUpdate.setId(id);
        ordersUpdate.setStatus(6);
        ordersUpdate.setCancelReason("用户取消订单");
        ordersUpdate.setCancelTime(LocalDateTime.now());
//        Orders ordersUpdate = Orders.builder()
//                .id(id)
//                .status(6)//已取消
//                .cancelReason("用户取消订单")
//                .cancelTime(LocalDateTime.now())
//                .packAmount().tablewareNumber().build();
        //3-2 如果是已支付的订单,需要发起微信退款请求
        if (orders.getPayStatus() == 1) {
            try {
                //weChatPayUtil.refund(orderVO.getNumber(), orderVO.getNumber(), new BigDecimal(0.01), new BigDecimal(0.01));
                ordersUpdate.setPayStatus(2);//2退款
            } catch (Exception e) {
                throw new BusinessException("微信退款失败,联系商家");
            }
        }
        //3-3 执行修改
        ordersMapper.updateById(ordersUpdate);
    }

    @Override
    public OrderVO findById(Long id) {
        //1. 根据订单id从订单表查询订单基本信息
        Orders orders = ordersMapper.selectById(id);

        //2. 根据订单id从订单详情表查询订单详情列表
        LambdaQueryWrapper<OrderDetail> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(OrderDetail::getOrderId, id);
        List<OrderDetail> orderDetailList = orderDetailMapper.selectList(wrapper);

        //3. 组装返回vo
        OrderVO orderVO = BeanUtil.copyProperties(orders, OrderVO.class);
        orderVO.setOrderDetailList(orderDetailList);
        return orderVO;
    }



    @Override
    @Transactional
    public void repetitionById(Long id) {
        //1. 清空当前用户目前购物车中的内容
        shoppingCartService.clean();

        //2. 根据订单id查询订单详情列表
        LambdaQueryWrapper<OrderDetail> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(OrderDetail::getOrderId, id);
        List<OrderDetail> orderDetailList = orderDetailMapper.selectList(wrapper);

        //3. 遍历详情列表
        if (CollectionUtil.isNotEmpty(orderDetailList)) {
            for (OrderDetail orderDetail : orderDetailList) {
                //3-1 每一个订单详情--->购物车1项
                ShoppingCart shoppingCart = BeanUtil.copyProperties(orderDetail, ShoppingCart.class, "id");
                //3-2 补齐参数
                shoppingCart.setUserId(UserHolder.get());
                shoppingCart.setCreateTime(LocalDateTime.now());
                //3-3 保存到购物车表
                shoppingCartMapper.insert(shoppingCart);
            }
        }
    }

    @Override
    public PageBean findByPage2(OrdersPageQueryDTO dto) {
        Page<Orders> page = new Page<>(dto.getPage(), dto.getPageSize());
        LambdaQueryWrapper<Orders> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(dto.getStatus() != null, Orders::getStatus, dto.getStatus())
                .eq(StrUtil.isNotEmpty(dto.getNumber()), Orders::getNumber, dto.getNumber())
                .eq(StrUtil.isNotEmpty(dto.getPhone()), Orders::getPhone, dto.getPhone())
                .between(dto.getBeginTime() != null, Orders::getOrderTime, dto.getBeginTime(), dto.getEndTime())
                .orderByDesc(Orders::getOrderTime);
        ordersMapper.selectPage(page, wrapper);
        //4. 为每个订单填充订单详情
        List<OrderVO> orderVOList = new ArrayList<>();
        List<Orders> ordersList = page.getRecords();
        if (CollectionUtil.isNotEmpty(ordersList)) {
            for (Orders orders : ordersList) {
                //3-1 复制
                OrderVO orderVO = BeanUtil.copyProperties(orders, OrderVO.class);
                //3-2 调用orderDetailMapper根据订单id查询详情列表
                LambdaQueryWrapper<OrderDetail> wrapper1 = new LambdaQueryWrapper<>();
                wrapper1.eq(OrderDetail::getOrderId, orderVO.getId());
                List<OrderDetail> details = orderDetailMapper.selectList(wrapper1);
                //3-3 将detail封装到vo
                orderVO.setOrderDetailList(details);
                StringBuilder sb = new StringBuilder();
                for (OrderDetail detail : details) {
                    sb.append(detail.getName() + "*" + detail.getNumber() + ";");
                }
                orderVO.setOrderDishes(sb.toString());
                //3-4 条件到集合
                orderVOList.add(orderVO);
            }

        }
        return new PageBean<OrderVO>(page.getTotal(), orderVOList);
    }

    @Override
    public OrderStatisticsVO statistics() {
        //查询各个状态  2待接单 3已接单 4派送中
        LambdaQueryWrapper<Orders> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Orders::getStatus, 2);
        int toBeConfirmedCount = ordersMapper.selectCount(wrapper).intValue();

        LambdaQueryWrapper<Orders> wrapper1 = new LambdaQueryWrapper<>();
        wrapper1.eq(Orders::getStatus, 3);
        int confirmedCount = ordersMapper.selectCount(wrapper1).intValue();

        LambdaQueryWrapper<Orders> wrapper2 = new LambdaQueryWrapper<>();
        wrapper2.eq(Orders::getStatus, 4);
        int deliveryInProgressCount = ordersMapper.selectCount(wrapper2).intValue();

        //返回
        return OrderStatisticsVO.builder()
                .toBeConfirmed(toBeConfirmedCount)
                .confirmed(confirmedCount)
                .deliveryInProgress(deliveryInProgressCount).build();
    }

    @Override
    public void confirm(OrdersConfirmDTO ordersConfirmDTO) {
        //1. 查询订单信息
        Orders orders = ordersMapper.selectById(ordersConfirmDTO.getId());

        //2. 判断状态
        if (orders.getStatus() != 2) { //2 待接单
            throw new BusinessException("订单状态有误");
        }

        //3. 执行修改
        Orders ordersUpdate = new Orders();
        ordersUpdate.setId(ordersConfirmDTO.getId());
        ordersUpdate.setStatus(3);

//        Orders ordersUpdate = Orders.builder()
//                .id(ordersConfirmDTO.getId())
//                .status(3)//3 已接单
//                .build();
        ordersMapper.updateById(ordersUpdate);
    }

    @Override
    public void cancel(OrdersCancelDTO dto) {
        //1. 查询订单信息
        Orders orders = ordersMapper.selectById(dto.getId());

        //2. 判断状态
        if (orders.getStatus() == 5 && orders.getStatus() == 6) {
            throw new BusinessException("订单状态有误");
        }
        Orders ordersUpdate = new Orders();
        ordersUpdate.setId(dto.getId());
        ordersUpdate.setCancelReason(dto.getCancelReason());
        ordersUpdate.setStatus(6);
        ordersUpdate.setCancelTime(LocalDateTime.now());

        //判断支付状态,如果是已支付,退款
        if (orders.getPayStatus() == 1) {
            //调用微信退款

            //修改状态为已退款
            ordersUpdate.setPayStatus(2);
        }

        ordersMapper.updateById(ordersUpdate);
    }


    @Override
    public void rejection(OrdersRejectionDTO ordersRejectionDTO) {
        //1. 查询订单信息
        Orders orders = ordersMapper.selectById(ordersRejectionDTO.getId());

        //2. 判断状态
        if (orders.getStatus() != 2) { //2 待接单
            throw new BusinessException("订单状态有误");
        }
        Orders ordersUpdate = new Orders();
        ordersUpdate.setId(ordersRejectionDTO.getId());
        ordersUpdate.setStatus(6);
        ordersUpdate.setCancelReason("商家拒单");
        ordersUpdate.setRejectionReason(ordersRejectionDTO.getRejectionReason());
        ordersUpdate.setCancelTime(LocalDateTime.now());

        //3. 修改订单状态--已取消
//        Orders ordersUpdate = Orders.builder()
//                .id(ordersRejectionDTO.getId())
//                .status(6) //6 取消
//                .cancelReason("商家拒单")
//                .rejectionReason(ordersRejectionDTO.getRejectionReason())
//                .cancelTime(LocalDateTime.now())
//                .build();

        //判断支付状态,如果是已支付,退款
        if (orders.getPayStatus() == 1) {
            //调用微信退款

            //修改状态为已退款
            ordersUpdate.setPayStatus(2);
        }

        ordersMapper.updateById(ordersUpdate);
    }

    @Override
    public void delivery(long id) {
        //1. 查询订单信息
        Orders orders = ordersMapper.selectById(id);

        //2. 判断状态
        if (orders.getStatus() != 3) { //2 待派送单
            throw new BusinessException("订单状态有误");
        }
        Orders ordersUpdate = new Orders();
        ordersUpdate.setId(id);
        ordersUpdate.setStatus(4);
        ordersUpdate.setCancelTime(LocalDateTime.now());
        ordersMapper.updateById(ordersUpdate);

    }

    @Override
    public void complete(long id) {
        //1. 查询订单信息
        Orders orders = ordersMapper.selectById(id);

        //2. 判断状态
        if (orders.getStatus() != 4) { //2 待派送单
            throw new BusinessException("订单状态有误");
        }
        Orders ordersUpdate = new Orders();
        ordersUpdate.setId(id);
        ordersUpdate.setStatus(5);
        ordersUpdate.setCancelTime(LocalDateTime.now());
        ordersMapper.updateById(ordersUpdate);

    }


    @Override
    public void reminderById(Long id) {
        //1. 查询订单
        Orders orders = ordersMapper.selectById(id);
        if (orders == null || orders.getStatus() != 2) {
            throw new BusinessException("状态错误");
        }
        //2. 构建消息对象
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("type", 2);
        map.put("orderId", id + "");
        map.put("content", "订单号：" + orders.getNumber());
        //3 对象转JSON
        String json = JSON.toJSONString(map);
        //4. 调用websocket终端,发送消息给浏览器
        webSocketServer.sendToAllClient(json);
    }
}