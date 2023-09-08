package com.sky.web.app;


import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.sky.context.UserHolder;
import com.sky.dto.OrdersPageQueryDTO;
import com.sky.dto.OrdersPaymentDTO;
import com.sky.entity.Orders;
import com.sky.mapper.OrdersMapper;
import com.sky.result.PageBean;
import com.sky.result.Result;
import com.sky.service.OrderService;
import com.sky.vo.OrderSubmitVO;
import com.sky.vo.OrderVO;
import com.sky.websocket.WebSocketServer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user/order")
public class AppOrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private OrdersMapper ordersMapper;
    @Autowired
    private WebSocketServer webSocketServer;

    //保存订单
    @PostMapping("/submit")
    public Result save(@RequestBody Orders orders) {
        OrderSubmitVO orderSubmitVO = orderService.save(orders);
        return Result.success(orderSubmitVO);
    }

    //    // 订单支付
//    @PutMapping("/payment")
//    public Result payment(@RequestBody OrdersPaymentDTO ordersPaymentDTO) throws Exception {
//        //根据订单Number修改  订单的状态、支付方式、支付状态、结账时间
//        //set部分
//        Orders orders1 = new Orders();
//        orders1.setStatus(Orders.TO_BE_CONFIRMED);
//        orders1.setPayStatus(Orders.PAID);
//        orders1.setCheckoutTime(LocalDateTime.now());
//        //where部分
//        LambdaUpdateWrapper<Orders> wrapper = new LambdaUpdateWrapper<>();
//        wrapper.eq(Orders::getNumber, ordersPaymentDTO.getOrderNumber());
//        //更新
//        ordersMapper.update(orders1, wrapper);
//        //返回结果
//        return Result.success(new OrderSubmitVO());
//    }
    //历史订单查询
    @GetMapping("/historyOrders")
    public Result historyOrders(OrdersPageQueryDTO dto) {
        //1. 设置登录用户id
        dto.setUserId(UserHolder.get());
        //2. 调用service查询
        PageBean<OrderVO> pageBean = orderService.findByPage(dto);
        //3. 返回结果
        return Result.success(pageBean);
    }

    @PutMapping("/cancel/{id}")
    public Result cancel(@PathVariable Long id) {
        orderService.cancelById(id);
        return Result.success();
    }

    //查询订单详情
    @GetMapping("/orderDetail/{id}")
    public Result findById(@PathVariable Long id) {
        OrderVO orderVO = orderService.findById(id);
        return Result.success(orderVO);
    }

    @PostMapping("/repetition/{id}")
    public Result repetition(@PathVariable Long id) {
        orderService.repetitionById(id);
        return Result.success();
    }

    //催单
    @GetMapping("/reminder/{id}")
    public Result reminder(@PathVariable Long id) {
        orderService.reminderById(id);
        return Result.success();
    }


    // 订单支付
    @PutMapping("/payment")
    public Result payment(@RequestBody OrdersPaymentDTO ordersPaymentDTO) throws Exception {
        //根据订单Number修改  订单的状态、支付方式、支付状态、结账时间
        //set部分
        Orders orders = new Orders();
        orders.setStatus(Orders.TO_BE_CONFIRMED);
        orders.setPayStatus(Orders.PAID);
        orders.setCheckoutTime(LocalDateTime.now());
        //where部分
        LambdaUpdateWrapper<Orders> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(Orders::getNumber, ordersPaymentDTO.getOrderNumber());
        //更新
        ordersMapper.update(orders, wrapper);

        //添加一个来单提醒
        //1. 组装发送给前台消息
        //1-1 查询订单id
        LambdaQueryWrapper<Orders> wrapper1 = new LambdaQueryWrapper<>();
        wrapper1.eq(Orders::getNumber, ordersPaymentDTO.getOrderNumber());
        Orders orders1 = ordersMapper.selectOne(wrapper1);


        //1-2 准备一个Map
        Map<String, Object> map = new HashMap<>();
        map.put("type", 1);
        map.put("orderId", orders1.getId() + "");
        map.put("content", "订单号:" + ordersPaymentDTO.getOrderNumber());
        String s = JSON.toJSONString(map);

        //1-3. 使用ws发送出去
        webSocketServer.sendToAllClient(s);

        //返回结果
        return Result.success(new OrderSubmitVO());
    }

}