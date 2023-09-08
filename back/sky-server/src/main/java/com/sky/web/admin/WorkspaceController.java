package com.sky.web.admin;

import com.sky.result.Result;
import com.sky.service.DishService;
import com.sky.service.ReportService;
import com.sky.service.SetmealService;
import com.sky.vo.BusinessDataVO;
import com.sky.vo.DishOverViewVO;
import com.sky.vo.OrderOverViewVO;
import com.sky.vo.SetmealOverViewVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

@RestController
@RequestMapping("/admin/workspace")
public class WorkspaceController {

    @Autowired
    private ReportService reportService;
    @Autowired
    private DishService dishService;
    @Autowired
    private SetmealService setmealService;

    //今日运营数据
    @GetMapping("/businessData")
    public Result businessData(){
        //1. 获取今天的日期
        LocalDate today = LocalDate.now();
        //2. 调用service查询
        BusinessDataVO vo = reportService.businessData(today);
        //3. 返回结果
        return Result.success(vo);
    }
    //菜品
    @GetMapping("/overviewDishes")
    public  Result Dish(){
        DishOverViewVO findstatus = dishService.findstatus();
        return Result.success(findstatus);

    }
    //套餐
    @GetMapping("/overviewSetmeals")
    public  Result Setmeal(){
     SetmealOverViewVO findstatus = setmealService.findstatus();
        return Result.success(findstatus);

    }
    @GetMapping("/overviewOrders")
    public Result overviewOrders(){
        //1. 获取今天的日期
        LocalDate today = LocalDate.now();
        //2. 调用service查询
        OrderOverViewVO vo = reportService.overviewOrders(today);
        //3. 返回结果
        return Result.success(vo);
    }

}