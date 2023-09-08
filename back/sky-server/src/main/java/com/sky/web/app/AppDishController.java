package com.sky.web.app;

import cn.hutool.core.collection.CollectionUtil;
import com.sky.constrant.DishCache;
import com.sky.dto.DishPageDTO;
import com.sky.result.Result;
import com.sky.service.DishService;
import com.sky.vo.DishVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/user/dish")
public class AppDishController {

    @Autowired
    private DishService dishService;
    @Autowired
    private RedisTemplate redisTemplate;

    //菜品列表
    @GetMapping("/list")
    public Result findList(Long categoryId){
        List<DishVO>  o = (List<DishVO>)redisTemplate.opsForValue().get(DishCache.PREFIX + categoryId);
        if(CollectionUtil.isNotEmpty(o)){
            return Result.success(o);
        }
        //1. 构建请求参数
        DishPageDTO dto = DishPageDTO.builder()
                .categoryId(categoryId)
                .status(1)
                .build();
        List<DishVO> voList = dishService.findList(dto);
        redisTemplate.opsForValue().set(DishCache.PREFIX + categoryId,voList);
        return Result.success(voList);
    }
}
