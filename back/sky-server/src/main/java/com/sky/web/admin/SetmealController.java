package com.sky.web.admin;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sky.constrant.SetmealCache;
import com.sky.dto.SetmealDTO;
import com.sky.dto.SetmealPageDTO;
import com.sky.entity.Setmeal;
import com.sky.mapper.SetmealMapper;
import com.sky.result.PageBean;
import com.sky.result.Result;
import com.sky.service.SetmealService;
import com.sky.vo.SetmealVO;
import com.sun.org.apache.xpath.internal.operations.Bool;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin/setmeal")
@Slf4j
public class SetmealController {

    @Autowired
    private SetmealService setmealService;
    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private SetmealMapper setmealMapper;

    //分页查询
    @GetMapping("/page")
    public Result findByPage(SetmealPageDTO setmealPageDTO) {
        PageBean<SetmealVO> pageBean = setmealService.findByPage(setmealPageDTO);
        return Result.success(pageBean);
    }

    //新增
    @PostMapping
    public Result save(@RequestBody SetmealDTO setmealDTO) {
        redisTemplate.delete(SetmealCache.PREFIX + setmealDTO.getCategoryId());
        setmealService.save(setmealDTO);
        return Result.success();
    }

    //主键查询
    @GetMapping("/{id}")
    public Result findById(@PathVariable Long id) {
        SetmealVO setmealVO = setmealService.findById(id);
        return Result.success(setmealVO);
    }

    //修改
    @PutMapping
    public Result update(@RequestBody SetmealDTO setmealDTO) {
        redisTemplate.delete(SetmealCache.PREFIX + setmealDTO.getCategoryId());
        setmealService.update(setmealDTO);
        return Result.success();
    }

    @PostMapping("/status/{status}")
    public Result startOrStop(Long id, @PathVariable Integer status) {
        LambdaQueryWrapper<Setmeal> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Setmeal::getId,id);
        wrapper.select(Setmeal::getId,Setmeal::getCategoryId,Setmeal::getStatus);
        Setmeal setmeal = setmealMapper.selectOne(wrapper);
        if (setmeal != null && Boolean.TRUE.equals(redisTemplate.delete(SetmealCache.PREFIX +setmeal.getCategoryId()))) {
            log.info("套餐缓存删除成功");
        } else {
            log.info("套餐缓存删除失败");
        }

        setmeal.setStatus(status);
        setmealService.startOrStop(setmeal);

        return Result.success();
    }


    /**
     * 批量删除套餐
     * @param ids
     * @return
     */
    @DeleteMapping("")
    public Result deleteByIds(@RequestParam List<Long> ids) {
        setmealService.deleteByIds(ids);
        return Result.success();
    }
}
