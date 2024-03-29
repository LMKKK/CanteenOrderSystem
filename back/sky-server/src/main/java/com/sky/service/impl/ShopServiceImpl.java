package com.sky.service.impl;

import com.sky.entity.Shop;
import com.sky.mapper.ShopMapper;
import com.sky.service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShopServiceImpl implements ShopService {

    @Autowired
    private ShopMapper shopMapper;

    @Override
    public Shop findStatus() {
        return shopMapper.selectOne(null);
    }
}
