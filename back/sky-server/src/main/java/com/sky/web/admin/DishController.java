package com.sky.web.admin;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sky.constrant.DishCache;
import com.sky.dto.DishDTO;
import com.sky.dto.DishPageDTO;
import com.sky.entity.Dish;
import com.sky.mapper.DishMapper;
import com.sky.result.PageBean;
import com.sky.result.Result;
import com.sky.service.DishService;
import com.sky.vo.DishVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;

//菜品
@RestController
@RequestMapping("/admin/dish")
@Slf4j
public class DishController {

    @Autowired
    private DishService dishService;
    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private DishMapper dishMapper;

    //分页查询
    @GetMapping("/page")
    public Result findByPage(DishPageDTO dto) {
        PageBean pageBean = dishService.findByPage(dto);
        return Result.success(pageBean);
    }

    //菜品保存
    @PostMapping()
    public Result save(@RequestBody DishDTO dto) {
        log.info("新增菜品的信息{}",dto);
        if (Boolean.TRUE.equals(redisTemplate.delete(DishCache.PREFIX + dto.getCategoryId()))) {
            log.info("删除菜品分类缓存成功success");
        }else{
            log.info("删除菜品分类缓存失败false");
        }
        dishService.save(dto);
        return Result.success();
    }

    //菜品回显
    @GetMapping("/{id}")
    public Result findById(@PathVariable Long id) {
        DishVO dishVO = dishService.findById(id);
        return Result.success(dishVO);
    }

    //修改菜品
    @PutMapping()
    public Result update(@RequestBody DishDTO dto) {
        redisTemplate.delete(DishCache.PREFIX + dto.getCategoryId());
        dishService.update(dto);
        return Result.success();
    }

    //当使用集合接收参数的时候,需要添加@RequestParam注解
    //删除菜品
    @DeleteMapping("")
    public Result deleteByIds(@RequestParam List<Long> ids) {
        dishService.deleteByIds(ids);
        return Result.success();
    }

    //根据name\categoryId\status查询
    @GetMapping("/list")
    public Result findList(DishPageDTO dto) {
        List<DishVO> dishList = dishService.findList(dto);
        return Result.success(dishList);
    }

    @PostMapping("/status/{status}")
    public Result startOrStop(Long id, @PathVariable Integer status) {
        LambdaQueryWrapper<Dish> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Dish::getId, id)
                .select(Dish::getId,Dish::getCategoryId);
        Dish dish = dishMapper.selectOne(wrapper);
        // 必须是先修改数据库、再删除缓存，步骤不可以改变
        dish.setStatus(status);
        dishService.startOrStop(dish);
        if (dish != null && Boolean.TRUE.equals(redisTemplate.delete(DishCache.PREFIX+ dish.getCategoryId()))) {
            log.info("清楚菜品分类缓存成功");
        } else {
            log.info("清除菜品分类缓存失败");
        }

        return Result.success();
    }

}
