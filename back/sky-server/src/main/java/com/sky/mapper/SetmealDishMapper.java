package com.sky.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sky.entity.SetmealDish;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SetmealDishMapper extends BaseMapper<SetmealDish> {

    // 查询关联了此菜品的套餐


}
