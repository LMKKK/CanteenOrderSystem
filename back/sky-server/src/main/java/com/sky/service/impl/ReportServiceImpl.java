package com.sky.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.NumberUtil;
import com.sky.dto.GoodsSalesDTO;
import com.sky.mapper.ReportMapper;
import com.sky.service.ReportService;
import com.sky.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class ReportServiceImpl implements ReportService {

    @Autowired
    private ReportMapper reportMapper;

    //根据开始和结束日期活动日期列表
    private List<LocalDate> getDateList(LocalDate begin, LocalDate end) {
        List<LocalDate> dateList = new ArrayList<>();
        LocalDate dateIndex = begin;//日期指针

        while (!dateIndex.isAfter(end)) {
            dateList.add(dateIndex);
            dateIndex = dateIndex.plusDays(1);//指针后移1天
        }

        log.info("得到的日期集合:{}", dateList);
        return dateList;
    }

    @Override
    public TurnoverReportVO turnoverStatistics(LocalDate begin, LocalDate end) {
        //1. 根据传入的begin和end,构建一个日期集合
        List<LocalDate> dateList = getDateList(begin, end);

        //2. 声明返回变量
        List turnoverList = new ArrayList();//营业额集合

        //3. 凑数据
        for (LocalDate date : dateList) {
            double amount = reportMapper.sumOrderAmountByStatusAndDate(5, date);
            turnoverList.add(amount);
        }

        System.out.println(CollectionUtil.join(dateList, ","));
        System.out.println(CollectionUtil.join(turnoverList, ","));

        //4. 组装返回结果
        return TurnoverReportVO.builder()
                .dateList(CollectionUtil.join(dateList, ","))
                .turnoverList(CollectionUtil.join(turnoverList, ","))
                .build();
    }
    @Override
    public OrderReportVO ordersStatistics(LocalDate begin, LocalDate end) {
        //1. 获取日期列表
        List<LocalDate> dateList = getDateList(begin, end);

        //2. 声明返回变量
        List orderCountList = new ArrayList(); //订单数列表
        int totalOrderCount = 0;//订单总数

        List validOrderCountList = new ArrayList(); //有效订单总数列表
        int validOrderCount = 0;//有效订单数

        double orderCompletionRate = 0; //完成率=有效订单数 / 总订单数 * 100%


        //3. 凑数据
        for (LocalDate date : dateList) {
            //3-1 查询每天的订单数
            int num = reportMapper.countOrderByStatusAndDate(null, date);
            //3-2 放到订单数列表
            orderCountList.add(num);
            totalOrderCount += num;

            //3-3 查询每天有效订单数
            int num2 = reportMapper.countOrderByStatusAndDate(5, date);
            validOrderCountList.add(num2);
            //3-4 查询有效订单总数
            validOrderCount += num2;
        }

        if (totalOrderCount > 0 && validOrderCount > 0) {
            orderCompletionRate = validOrderCount * 1.0 / totalOrderCount;
            orderCompletionRate = NumberUtil.round(orderCompletionRate, 4).doubleValue();//保留小数点
        }


        //4. 返回结果
        return OrderReportVO.builder()
                .dateList(CollectionUtil.join(dateList,","))
                .orderCountList(CollectionUtil.join(orderCountList,","))
                .validOrderCountList(CollectionUtil.join(validOrderCountList,","))
                .totalOrderCount(totalOrderCount)
                .validOrderCount(validOrderCount)
                .orderCompletionRate(orderCompletionRate)
                .build();
    }
    @Override
    public UserReportVO userStatistics(LocalDate begin, LocalDate end) {
        //1. 获取日期列表
        List<LocalDate> dateList = getDateList(begin, end);

        //2. 声明返回变量
        List newUserList = new ArrayList(); // 每天新增用户数
        List totalUserList = new ArrayList(); // 每天累计新增用户数

        //3. 凑数据
        int total = 0; //存储到某天为止累加新增数量
        for (LocalDate date : dateList) {
            //查询每天新增用户数
            int num = reportMapper.countUserByDate(date);
            newUserList.add(num);

            total+=num;
            totalUserList.add(total);
        }

        //4. 组装返回结果
        return UserReportVO.builder()
                .dateList(CollectionUtil.join(dateList,","))
                .newUserList(CollectionUtil.join(newUserList,","))
                .totalUserList(CollectionUtil.join(totalUserList,","))
                .build();
    }
    @Override
    public SalesTop10ReportVO top10(LocalDate begin, LocalDate end) {
        //1. 声明返回变量
        List<String> nameList = new ArrayList();
        List<Integer> numberList = new ArrayList();

        //2. 凑数据
        List<GoodsSalesDTO> list = reportMapper.top10(begin, end);
        if (CollectionUtil.isNotEmpty(list)) {
            for (GoodsSalesDTO dto : list) {
                nameList.add(dto.getName());
                numberList.add(dto.getNumber());
            }
        }

        //3. 返回结果
        return SalesTop10ReportVO.builder()
                .nameList(CollectionUtil.join(nameList,","))
                .numberList(CollectionUtil.join(numberList,","))
                .build();
    }
    @Override
    public BusinessDataVO businessData(LocalDate today) {
        //1. 声明返回变量
        double turnover = 0; //营业额
        int validOrderCount = 0;//有效订单数
        double orderCompletionRate = 0;//订单完成率
        double unitPrice = 0;//平均客单价
        int newUsers = 0;//新增用户数

        //2. 凑
        //2-1 营业额
        turnover = reportMapper.sumOrderAmountByStatusAndDate(5, today);
        //2-2 有效订单数
        validOrderCount = reportMapper.countOrderByStatusAndDate(5, today);
        //2-3 订单完成率
        int totalOrderCount = reportMapper.countOrderByStatusAndDate(null, today);
        if (totalOrderCount > 0 && validOrderCount > 0) {
            orderCompletionRate = validOrderCount * 1.0 / totalOrderCount;
            orderCompletionRate = NumberUtil.round(orderCompletionRate, 4).doubleValue();
        }
        //2-4 平均客单价
        if (turnover > 0 && validOrderCount > 0) {
            unitPrice = turnover / validOrderCount;
            unitPrice = NumberUtil.round(unitPrice, 4).doubleValue();
        }
        //2-5 新增用户数
        newUsers = reportMapper.countUserByDate(today);

        //3. 封装返回
        return BusinessDataVO.builder()
                .turnover(turnover)
                .validOrderCount(validOrderCount)
                .orderCompletionRate(orderCompletionRate)
                .unitPrice(unitPrice)
                .newUsers(newUsers)
                .build();
    }
    @Override
    public OrderOverViewVO overviewOrders(LocalDate today) {
        //1. 声明变量
        int allOrders = 0;//全部订单
        int cancelledOrders = 0;//已取消数量 6
        int completedOrders = 0;//已完成数量 5
        int deliveredOrders = 0;//待派送数量 3
        int waitingOrders = 0;//待接单数量 2

        //2. 凑
        allOrders = reportMapper.countOrderByStatusAndDate(null, today);
        cancelledOrders = reportMapper.countOrderByStatusAndDate(6, today);
        completedOrders = reportMapper.countOrderByStatusAndDate(5, today);
        deliveredOrders = reportMapper.countOrderByStatusAndDate(3, today);
        waitingOrders = reportMapper.countOrderByStatusAndDate(2, today);

        //3. 返回
        return OrderOverViewVO.builder()
                .allOrders(allOrders)
                .cancelledOrders(cancelledOrders)
                .completedOrders(completedOrders)
                .deliveredOrders(deliveredOrders)
                .waitingOrders(waitingOrders)
                .build();
    }
}