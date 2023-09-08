package com.sky.service;

import com.sky.entity.ShoppingCart;

import java.util.List;

public interface ShoppingCartService {
    void save(ShoppingCart shoppingCart);

    List<ShoppingCart> findList();

    void clean();

    void update(ShoppingCart shoppingCartPram);
}
