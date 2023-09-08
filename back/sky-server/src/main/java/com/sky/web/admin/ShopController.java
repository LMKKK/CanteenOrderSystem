package com.sky.web.admin;

import com.sky.constrant.ShopCache;
import com.sky.result.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin/shop")
public class ShopController {
    @Autowired
    private RedisTemplate redisTemplate;
    @PutMapping("{status}")
    public Result setstatus(@PathVariable Integer status){
        redisTemplate.opsForValue().set(ShopCache.SHOP_STATUS,status);
        return Result.success();
    }

    @GetMapping("/status")
    public Result getstatus(){
        Integer shop_status = (Integer)redisTemplate.opsForValue().get(ShopCache.SHOP_STATUS);
        if (shop_status==null){
            shop_status=0;
        }
        // 放入缓存
        redisTemplate.opsForValue().set(ShopCache.SHOP_STATUS, shop_status);

        return Result.success(shop_status);
    }


}
