package com.sky.web.app;

import com.sky.entity.Shop;
import com.sky.result.Result;
import com.sky.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user/shop")
public class AppShopController {

    @Autowired
    private ShopService shopService;
    @Autowired
    private RedisTemplate redisTemplate;
    //获取营业状态
    @GetMapping("/status")
    public Result findStatus(){
//        //1. 调用service查询
//        Shop shop = shopService.findStatus();
        //2. 返回结果
//        return Result.success(shop.getStatus());
        Integer shop_status = (Integer)redisTemplate.opsForValue().get("shop_status");
        if (shop_status==null){
            Shop shop = shopService.findStatus();
            shop_status = shop.getStatus();
        }
        return Result.success(shop_status);

    }
}
