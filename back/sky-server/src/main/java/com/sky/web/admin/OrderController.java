package com.sky.web.admin;

import com.sky.dto.OrdersCancelDTO;
import com.sky.dto.OrdersConfirmDTO;
import com.sky.dto.OrdersPageQueryDTO;
import com.sky.dto.OrdersRejectionDTO;
import com.sky.result.PageBean;
import com.sky.result.Result;
import com.sky.service.OrderService;
import com.sky.vo.OrderStatisticsVO;
import com.sky.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    //订单搜索
    @GetMapping("/conditionSearch")
    public Result conditionSearch(OrdersPageQueryDTO dto){
        PageBean pageBean = orderService.findByPage2(dto);
        return Result.success(pageBean);
    }
    //各个状态的订单数量统计
    @GetMapping("/statistics")
    public Result statistics(){
        OrderStatisticsVO orderStatisticsVO = orderService.statistics();
        return Result.success(orderStatisticsVO);
    }
    //查询订单详情
    @GetMapping("/details/{id}")
    public Result findById(@PathVariable Long id){
        OrderVO orderVO = orderService.findById(id);
        return Result.success(orderVO);
    }
    @PutMapping("/confirm")
    public Result confirm(@RequestBody OrdersConfirmDTO ordersConfirmDTO){
        orderService.confirm(ordersConfirmDTO);
        return Result.success();
    }
    @PutMapping("/cancel")
    public Result cancel(@RequestBody OrdersCancelDTO dto){
        orderService.cancel(dto);
        return Result.success();
    }
    @PutMapping("/rejection")
    public Result rejection(@RequestBody OrdersRejectionDTO ordersRejectionDTO){
        orderService.rejection(ordersRejectionDTO);
        return Result.success();
    }
    @PutMapping("/delivery/{id}")
    public  Result delivery (@PathVariable long id){
        orderService.delivery(id);
        return Result.success();
    }
    @PutMapping("/complete/{id}")
    public  Result complete(@PathVariable long id){
        orderService.complete(id);
        return Result.success();

    }
}