package com.sky.service;

import com.sky.dto.OrdersCancelDTO;
import com.sky.dto.OrdersConfirmDTO;
import com.sky.dto.OrdersPageQueryDTO;
import com.sky.dto.OrdersRejectionDTO;
import com.sky.entity.Orders;
import com.sky.result.PageBean;
import com.sky.vo.OrderStatisticsVO;
import com.sky.vo.OrderSubmitVO;
import com.sky.vo.OrderVO;

public interface OrderService {

    //保存订单
    OrderSubmitVO save(Orders orders);

    PageBean<OrderVO> findByPage(OrdersPageQueryDTO dto);

    void cancelById(Long id);

    OrderVO findById(Long id);

    void repetitionById(Long id);

    PageBean findByPage2(OrdersPageQueryDTO dto);

    OrderStatisticsVO statistics();

    void confirm(OrdersConfirmDTO ordersConfirmDTO);

    void cancel(OrdersCancelDTO dto);

    void rejection(OrdersRejectionDTO ordersRejectionDTO);

    void delivery(long id);

    void complete(long id);

    void reminderById(Long id);
}