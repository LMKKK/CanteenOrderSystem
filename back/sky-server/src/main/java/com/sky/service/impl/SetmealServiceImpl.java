package com.sky.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sky.constrant.SetmealCache;
import com.sky.constrant.SetmealConstrant;
import com.sky.dto.SetmealDTO;
import com.sky.dto.SetmealPageDTO;
import com.sky.entity.Category;
import com.sky.entity.Dish;
import com.sky.entity.Setmeal;
import com.sky.entity.SetmealDish;
import com.sky.exception.BusinessException;
import com.sky.mapper.CategoryMapper;
import com.sky.mapper.SetmealDishMapper;
import com.sky.mapper.SetmealMapper;
import com.sky.result.PageBean;
import com.sky.service.SetmealService;
import com.sky.vo.DishOverViewVO;
import com.sky.vo.DishVO;
import com.sky.vo.SetmealOverViewVO;
import com.sky.vo.SetmealVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

@Service
@Slf4j
public class SetmealServiceImpl implements SetmealService {

    @Autowired
    private SetmealMapper setmealMapper;

    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private SetmealDishMapper setmealDishMapper;

    @Autowired
    private RedisTemplate redisTemplate;


    @Override
    public SetmealOverViewVO findstatus() {
        LambdaQueryWrapper<Setmeal> LambdaQueryWrapper = new LambdaQueryWrapper<>();
        LambdaQueryWrapper.eq(Setmeal::getStatus, 0);
        long aLong = setmealMapper.selectCount(LambdaQueryWrapper);
        LambdaQueryWrapper<Setmeal> LambdaQueryWrapper1 = new LambdaQueryWrapper<>();
        LambdaQueryWrapper1.eq(Setmeal::getStatus, 1);
        long aLong1 = setmealMapper.selectCount(LambdaQueryWrapper1);
        SetmealOverViewVO setmealOverViewVO = new SetmealOverViewVO();
        int aLong2 = (int) aLong;
        int aLong3 = (int) aLong1;

        setmealOverViewVO.setDiscontinued(aLong2);
        setmealOverViewVO.setSold(aLong3);

        return setmealOverViewVO;
    }

    @Override
    public PageBean<SetmealVO> findByPage(SetmealPageDTO dto) {
        //1. 设置分页条件
        Page<Setmeal> page = new Page<>(dto.getPage(), dto.getPageSize());

        //2. 执行查询
        LambdaQueryWrapper<Setmeal> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StrUtil.isNotEmpty(dto.getName()), Setmeal::getName, dto.getName())
                .eq(dto.getCategoryId() != null, Setmeal::getCategoryId, dto.getCategoryId())
                .eq(dto.getStatus() != null, Setmeal::getStatus, dto.getStatus())
                .orderByDesc(Setmeal::getUpdateTime);

        //3. 执行查询
        setmealMapper.selectPage(page, wrapper);

        //4. 循环遍历设置分类名称
        List<Setmeal> records = page.getRecords();


        List<SetmealVO> setmealVOList = new ArrayList<>();
        if (CollectionUtil.isNotEmpty(records)) {
            for (Setmeal setmeal : records) {
                //1. 复制属性
                SetmealVO setmealVO = BeanUtil.copyProperties(setmeal, SetmealVO.class);
                //2. 设置分类名称
                Category category = categoryMapper.selectById(setmeal.getCategoryId());
                String name = "未分类";
                if(category != null){
                    name = category.getName();
                }
                setmealVO.setCategoryName(name);
                //3. 添加到集合
                setmealVOList.add(setmealVO);
            }
        }

        //5. 返回结果
        return new PageBean<SetmealVO>(page.getTotal(), setmealVOList);
    }

    @Transactional
    @Override
    public void save(SetmealDTO setmealDTO) {
        //1. 从dto中提取套餐基本信息,保存到套餐表中,主键返回
        Setmeal setmeal = BeanUtil.copyProperties(setmealDTO, Setmeal.class);
        setmeal.setStatus(1);//默认起售
        setmealMapper.insert(setmeal);
        log.info("保存之后的套餐信息是:{}", setmeal);

        //2. 从dto中提取套餐中的菜品信息,遍历之后设置套餐id, 保存到中间表
        List<SetmealDish> setmealDishes = setmealDTO.getSetmealDishes();
        if (CollectionUtil.isNotEmpty(setmealDishes)) {
            setmealDishes.stream().forEach(setmealDish -> {
                //设置套餐id
                setmealDish.setSetmealId(setmeal.getId());

                //保存到中间表
                setmealDishMapper.insert(setmealDish);
            });
        }
    }

    @Override
    public SetmealVO findById(Long id) {
        //1. 根据套餐id去套餐表查询基本信息
        Setmeal setmeal = setmealMapper.selectById(id);

        //2. 复制到vo
        SetmealVO setmealVO = BeanUtil.copyProperties(setmeal, SetmealVO.class);

        //3. 设置分类名称
        Category category = categoryMapper.selectById(setmeal.getCategoryId());
        setmealVO.setCategoryName(category.getName());

        //4. 设置菜品列表
        LambdaQueryWrapper<SetmealDish> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(SetmealDish::getSetmealId, setmeal.getId());
        List<SetmealDish> setmealDishes = setmealDishMapper.selectList(wrapper);
        setmealVO.setSetmealDishes(setmealDishes);

        //4. 返回
        return setmealVO;
    }

    @Transactional
    @Override
    public void update(SetmealDTO setmealDTO) {
        //1. 从dto中提取套餐基本信息,保存到套餐表中,主键返回
        Setmeal setmeal = BeanUtil.copyProperties(setmealDTO, Setmeal.class);
        setmealMapper.updateById(setmeal);

        //2. 从dto中提取套餐中的菜品信息
        List<SetmealDish> setmealDishes = setmealDTO.getSetmealDishes();

        if (CollectionUtil.isNotEmpty(setmealDishes)) {
            //3. 根据套餐id从中间表删除
            LambdaQueryWrapper<SetmealDish> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(SetmealDish::getSetmealId, setmealDTO.getId());
            setmealDishMapper.delete(wrapper);

            //4. 重新遍历菜品列表完成添加
            setmealDishes.stream().forEach(setmealDish -> {
                //设置套餐id
                setmealDish.setSetmealId(setmeal.getId());

                //保存到中间表
                setmealDishMapper.insert(setmealDish);
            });
        }
    }

    @Override
    public List<Setmeal> findList(Long categoryId) {
        LambdaQueryWrapper<Setmeal> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Setmeal::getCategoryId, categoryId);
        wrapper.eq(Setmeal::getStatus, 1);
        return setmealMapper.selectList(wrapper);
    }

    @Override
    public void startOrStop(Setmeal build) {
        setmealMapper.updateById(build);
    }

    @Override
    public void deleteByIds(List<Long> ids) {
        // 1. 检查状态，在售状态无法删除
        // 2. 删除套餐，同时在关联表中删除菜品

        ids.stream()
                .forEach(id -> {
                    Setmeal setmeal = setmealMapper.selectById(id);
                    // 1. 检查状态，在售状态无法删除
                    if (setmeal == null) {
                        throw new BusinessException("该套餐不存在，请刷新后重试");
                    }
                    if (setmeal.getStatus() == SetmealConstrant.ON) {
                        throw new BusinessException("有套餐是在售状态，不可以删除");
                    }
                    // 删除套餐
                    setmealMapper.deleteById(setmeal);
                    // 删除缓存
                    if (Boolean.TRUE.equals(redisTemplate.delete(SetmealCache.PREFIX + setmeal.getCategoryId()))) {
                        log.info("删除缓存成功");
                    } else {
                        log.info("删除缓存失败，可能还没有缓存");
                    }
                    // 2. 删除套餐，同时在关联表中删除菜品
                    LambdaQueryWrapper<SetmealDish> deleteWrapper = new LambdaQueryWrapper<>();
                    deleteWrapper.eq(SetmealDish::getSetmealId, setmeal.getId());
                    setmealDishMapper.delete(deleteWrapper);

                });
    }
}
