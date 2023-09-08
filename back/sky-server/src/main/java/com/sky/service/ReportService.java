package com.sky.service;

import com.sky.dto.GoodsSalesDTO;
import com.sky.vo.*;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public interface ReportService {
    //营业额统计
    TurnoverReportVO turnoverStatistics(LocalDate begin, LocalDate end);

    OrderReportVO ordersStatistics(LocalDate begin, LocalDate end);

    UserReportVO userStatistics(LocalDate begin, LocalDate end);

    SalesTop10ReportVO top10(LocalDate begin, LocalDate end);

    BusinessDataVO businessData(LocalDate today);

    OrderOverViewVO overviewOrders(LocalDate today);
}