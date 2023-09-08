package com.sky.web.app;

import cn.hutool.core.collection.CollectionUtil;
import com.sky.constrant.SetmealCache;
import com.sky.dto.DishPageDTO;
import com.sky.entity.Setmeal;
import com.sky.result.Result;
import com.sky.service.SetmealService;
import com.sky.vo.DishVO;
import com.sky.vo.SetmealVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/user/setmeal")
public class AppSetmealController {

    @Autowired
    private SetmealService setmealService;
    @Autowired
    private RedisTemplate redisTemplate;

    //查询套餐列表
    @GetMapping("/list")
    public Result findList(Long categoryId) {
        List<SetmealVO>  o = (List<SetmealVO>)redisTemplate.opsForValue().get(SetmealCache.PREFIX + categoryId);
        if(CollectionUtil.isNotEmpty(o)){
            return Result.success(o);
        }
        List<Setmeal> setmealList = setmealService.findList(categoryId);
        redisTemplate.opsForValue().set(SetmealCache.PREFIX + categoryId,setmealList);
        return Result.success(setmealList);
    }
}
