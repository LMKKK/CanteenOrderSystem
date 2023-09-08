package com.sky.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sky.context.UserHolder;
import com.sky.entity.Setmeal;
import com.sky.entity.ShoppingCart;
import com.sky.mapper.DishMapper;
import com.sky.mapper.SetmealMapper;
import com.sky.mapper.ShoppingCartMapper;
import com.sky.service.ShoppingCartService;
import com.sky.vo.DishVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {

    @Autowired
    private ShoppingCartMapper shoppingCartMapper;

    @Autowired
    private SetmealMapper setmealMapper;

    @Autowired
    private DishMapper dishMapper;

    @Override
    public void save(ShoppingCart shoppingCart) {
        //1. 根据当前用户查询是否点过当前菜品或者是套餐
        // 补全参数
        shoppingCart.setUserId(UserHolder.get());//设置用户id

        LambdaQueryWrapper<ShoppingCart> wrapper = new LambdaQueryWrapper<>();
        // 获取该用户此菜品的数量
        wrapper.eq(shoppingCart.getSetmealId() != null, ShoppingCart::getSetmealId, shoppingCart.getSetmealId());
        wrapper.eq(shoppingCart.getDishId() != null, ShoppingCart::getDishId, shoppingCart.getDishId());
        wrapper.eq(shoppingCart.getUserId() != null, ShoppingCart::getUserId, shoppingCart.getUserId());
        ShoppingCart shoppingCartFromDB = shoppingCartMapper.selectOne(wrapper);

        //2. 判断
        if (shoppingCartFromDB != null) {
            //3-1. 点过,数量+1
            shoppingCartFromDB.setNumber(shoppingCartFromDB.getNumber() + 1);//数量+1
            //3-2. 更新
            shoppingCartMapper.updateById(shoppingCartFromDB);
        } else {
            //4 没点过,先判断,添加到底是菜品还是套餐
            if (shoppingCart.getSetmealId() != null) {
                //套餐
                //4-1 先根据套餐id,查询套餐基本信息
                Setmeal setmeal = setmealMapper.selectById(shoppingCart.getSetmealId());
                //4-2 补齐对象参数
                shoppingCart.setName(setmeal.getName());
                shoppingCart.setImage(setmeal.getImage());
                shoppingCart.setNumber(1);
                shoppingCart.setAmount(setmeal.getPrice());
                shoppingCart.setCreateTime(LocalDateTime.now());
                //4-3 保存
                shoppingCartMapper.insert(shoppingCart);
            } else {
                //5菜品
                //5-1 先根据菜品id,查询菜品基本信息
                DishVO dishVO = dishMapper.findById(shoppingCart.getDishId());
                //5-2 补齐对象参数
                shoppingCart.setName(dishVO.getName());
                shoppingCart.setImage(dishVO.getImage());
                shoppingCart.setNumber(1);
                shoppingCart.setAmount(dishVO.getPrice());
                shoppingCart.setCreateTime(LocalDateTime.now());
                //5-3 保存
                shoppingCartMapper.insert(shoppingCart);
            }
        }
    }


    @Override
    public List<ShoppingCart> findList() {
        //1. 获取用户id
        Long userId = UserHolder.get();

        //2. 根据用户id查询
        LambdaQueryWrapper<ShoppingCart> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ShoppingCart::getUserId,userId);
        return shoppingCartMapper.selectList(wrapper);
    }

    @Override
    public void clean() {
        LambdaQueryWrapper<ShoppingCart> shoppingCartLambdaQueryWrapper = new LambdaQueryWrapper<>();
        shoppingCartLambdaQueryWrapper.eq(ShoppingCart::getUserId,UserHolder.get());
        shoppingCartMapper.delete(shoppingCartLambdaQueryWrapper);


    }

    @Override
    public void update(ShoppingCart shoppingCartPram) {
        LambdaQueryWrapper<ShoppingCart> shoppingCartLambdaQueryWrapper = new LambdaQueryWrapper<>();
        shoppingCartLambdaQueryWrapper.eq(ShoppingCart::getUserId,UserHolder.get())
                .eq(shoppingCartPram.getDishId()!=null,ShoppingCart::getDishId,shoppingCartPram.getDishId())
                .eq(shoppingCartPram.getSetmealId()!=null,ShoppingCart::getSetmealId,shoppingCartPram.getSetmealId());
        ShoppingCart shoppingCart = shoppingCartMapper.selectOne(shoppingCartLambdaQueryWrapper);
        if(shoppingCart!=null){
            shoppingCart.setNumber(shoppingCart.getNumber()-1);
            if (shoppingCart.getNumber()<=0){
                shoppingCartMapper.deleteById(shoppingCart);
            }else{
                shoppingCartMapper.updateById(shoppingCart);
            }
        }
    }
}

