package com.sky.web.app;

import com.sky.entity.ShoppingCart;
import com.sky.result.Result;
import com.sky.service.ShoppingCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user/shoppingCart")
public class AppShoppingCartController {

    @Autowired
    private ShoppingCartService shoppingCartService;

    //添加购物车
    @PostMapping("/add")
    public Result save(@RequestBody ShoppingCart shoppingCart){
        shoppingCartService.save(shoppingCart);
        return Result.success();

    }
    @GetMapping("/list")
    public Result findList(){
        List<ShoppingCart> list = shoppingCartService.findList();
        return Result.success(list);
    }
    @DeleteMapping("/clean")
    public Result clean(){
        shoppingCartService.clean();
        return Result.success();
    }
    @PostMapping("/sub")
    public Result update(@RequestBody ShoppingCart shoppingCartPram) {
        shoppingCartService.update(shoppingCartPram);
        return Result.success();
    }
}
