package com.sky.mapper;

import com.sky.dto.GoodsSalesDTO;
import org.apache.ibatis.annotations.Mapper;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface ReportMapper {
    double sumOrderAmountByStatusAndDate (Integer status, LocalDate date);
    int countOrderByStatusAndDate(Integer status, LocalDate date);
    int countUserByDate(LocalDate date);
    //top10
    List<GoodsSalesDTO> top10(LocalDate begin, LocalDate end);
}
