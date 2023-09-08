package com.sky.test;

import com.sky.dto.CategoryDTO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;

import java.util.concurrent.TimeUnit;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class SpringDataRedisTest {

    @Autowired
    private RedisTemplate redisTemplate;
    @Test
    public void testString() {
        //0 获取操作简单kv子对象
        ValueOperations ops = redisTemplate.opsForValue();

        //1. 增加
        ops.set("1001", "zhangsan");

//        //2. 获取
//        System.out.println(ops.get("1001"));
//
//        //3. 创建的时候设置有效时间 setex
//        ops.set("1002", "李四", 300, TimeUnit.SECONDS);
//
//        //4. 添加的时候判断是否有值(没有值的时候再添加) setnx
//        System.out.println(ops.setIfAbsent("1003", "王五"));//true
//        System.out.println(ops.setIfAbsent("1003", "王五"));//false
//
//        //5. 删除 del
//        redisTemplate.delete("1003");
//
//        //6. 保存对象
//        CategoryDTO categoryDTO = CategoryDTO.builder()
//                .id(1L)
//                .type(1)
//                .name("套餐分类")
//                .status(1)
//                .build();
//        ops.set("categoty:1", categoryDTO);
//        System.out.println(ops.get("categoty:1"));
    }

}