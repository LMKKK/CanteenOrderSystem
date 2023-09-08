package com.sky.task;

import cn.hutool.core.collection.CollectionUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sky.entity.Orders;
import com.sky.mapper.OrdersMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;

@Component
@Slf4j
public class OrderTask {

    @Autowired
    private OrdersMapper ordersMapper;

    //检查超时未支付的订单
    @Scheduled(cron = "0 * * * * ?")
    public void processTimeOutOrder(){
        log.info("开始清理超时未支付订单....");
        //1. 查询超时订单
        //select * from order where status = 未支付 and order_time < 现在-15
        LocalDateTime time = LocalDateTime.now().minusMinutes(15);
        System.out.println(time);

        LambdaQueryWrapper<Orders> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Orders::getStatus,1);
        wrapper.lt(Orders::getOrderTime,time);
        List<Orders> ordersList = ordersMapper.selectList(wrapper);

        //2. 遍历订单,更新
        if (CollectionUtil.isNotEmpty(ordersList)) {
            for (Orders orders : ordersList) {
                orders.setStatus(6);
                orders.setCancelReason("订单超时未支付");
                orders.setCancelTime(LocalDateTime.now());
                ordersMapper.updateById(orders);
            }
        }
        log.info("结束清理超时未支付订单....");
    }

    //检查超时未完成的订单
    @Scheduled(cron = "0 0 1 * * ?")
    public void processToOver(){
        log.info("开始清理超时未完成订单....");
        //1. 查询超时订单
        //select * from order where status = 派送中 and order_time < 现在-1小时
        LocalDateTime time = LocalDateTime.now().minusHours(1);
        System.out.println(time);


        LambdaQueryWrapper<Orders> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Orders::getStatus,4);
        wrapper.lt(Orders::getOrderTime,time);
        List<Orders> ordersList = ordersMapper.selectList(wrapper);

        //2. 遍历订单,更新
        if (CollectionUtil.isNotEmpty(ordersList)) {
            for (Orders orders : ordersList) {
                orders.setStatus(5);
                ordersMapper.updateById(orders);
            }
        }
        log.info("结束清理超时未完成订单....");
    }
}