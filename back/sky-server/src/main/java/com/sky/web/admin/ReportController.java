package com.sky.web.admin;

import cn.hutool.core.io.resource.ClassPathResource;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.util.MapUtils;
import com.alibaba.excel.write.metadata.WriteSheet;
import com.alibaba.excel.write.metadata.fill.FillConfig;
import com.sky.result.Result;
import com.sky.service.ReportService;
import com.sky.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/admin/report")
public class ReportController {

    @Autowired
    private ReportService reportService;

    //营业额统计
    @GetMapping("/turnoverStatistics")
    public Result turnoverStatistics(
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end
    ){
        TurnoverReportVO vo = reportService.turnoverStatistics(begin,end);
        return Result.success(vo);
    }
    //订单统计
    @GetMapping("/ordersStatistics")
    public Result ordersStatistics(
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end) {

        OrderReportVO vo = reportService.ordersStatistics(begin, end);
        return Result.success(vo);
    }
    @GetMapping("/userStatistics")
    public Result userStatistics(
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end) {

        UserReportVO vo = reportService.userStatistics(begin, end);
        return Result.success(vo);
    }
    //查询销量排名top10
    @GetMapping("/top10")
    public Result top10(
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate begin,
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate end) {
        SalesTop10ReportVO vo = reportService.top10(begin, end);
        return Result.success(vo);
    }
    //报表导出
    @GetMapping("/export")
    public Result execl(HttpServletResponse httpServletResponse) throws IOException {
        LocalDate begin=LocalDate.now().minusDays(30);
         LocalDate end=LocalDate.now().minusDays(1);
        List<LocalDate> dateList = getDateList(begin, end);
        ArrayList<BusinessDataVO> businessDataVOS = new ArrayList<>();
        double turnover=0;//营业额
        int validOrderCount=0;//有效订单数
        double orderCompletionRate=0;//订单完成率
        double unitPrice=0;//平均客单价
        int newUsers=0;//新增用户数
        int total=0; //总记录数
        for (LocalDate localDate : dateList) {
            BusinessDataVO businessDataVO = reportService.businessData(localDate);
            businessDataVO.setDate(localDate);
            businessDataVOS.add(businessDataVO);
            //统计加和
            turnover+=businessDataVO.getTurnover();
            orderCompletionRate+=businessDataVO.getOrderCompletionRate();
            newUsers+=businessDataVO.getNewUsers();
            validOrderCount+=businessDataVO.getValidOrderCount();
            unitPrice+=businessDataVO.getUnitPrice();

        }
        orderCompletionRate=orderCompletionRate/30;
        unitPrice=unitPrice/30;
        BusinessDataVO build = BusinessDataVO.builder().beginTime(begin).endTime(end).turnover(turnover)
                .orderCompletionRate(orderCompletionRate).newUsers(newUsers).validOrderCount(validOrderCount)
                .unitPrice(unitPrice).total(businessDataVOS.size()).build();
        File file = new ClassPathResource("template/运营数据报表模板.xlsx").getFile();
        try (ExcelWriter excelWriter = EasyExcel.write(httpServletResponse.getOutputStream()).withTemplate(file).build()) {
            WriteSheet writeSheet = EasyExcel.writerSheet().build();
            // 这里注意 入参用了forceNewRow 代表在写入list的时候不管list下面有没有空行 都会创建一行，然后下面的数据往后移动。默认 是false，会直接使用下一行，如果没有则创建。
            FillConfig fillConfig = FillConfig.builder().forceNewRow(Boolean.TRUE).build();
            //填充列表
            excelWriter.fill(businessDataVOS, fillConfig, writeSheet);


            //填充单个字段
            Map<String, Object> map = MapUtils.newHashMap();
            map.put("date", "2019年10月9日13:28:28");
            map.put("total", 1000);
            excelWriter.fill(build, writeSheet);
        }
        return Result.success();

    }
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
}