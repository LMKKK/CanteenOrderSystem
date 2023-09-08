package com.sky.service;

import com.sky.dto.SetmealDTO;
import com.sky.dto.SetmealPageDTO;
import com.sky.entity.Setmeal;
import com.sky.result.PageBean;
import com.sky.vo.SetmealOverViewVO;
import com.sky.vo.SetmealVO;

import java.util.List;

public interface SetmealService {

     SetmealOverViewVO findstatus();


    //分页查询
    PageBean<SetmealVO> findByPage(SetmealPageDTO setmealPageDTO);
    //新增
    void save(SetmealDTO setmealDTO);
    //主键查询
    SetmealVO findById(Long id);
    //更新
    void update(SetmealDTO setmealDTO);

    //查询套餐列表
    List<Setmeal> findList(Long categoryId);

    void startOrStop(Setmeal build);

    void deleteByIds(List<Long> ids);
}
