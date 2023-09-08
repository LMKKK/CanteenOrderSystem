package com.sky.service.impl;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.sky.dto.UserLoginDTO;
import com.sky.entity.User;
import com.sky.exception.BusinessException;
import com.sky.mapper.UserMapper;
import com.sky.properties.WeChatProperties;
import com.sky.service.UserService;
import com.sky.utils.HttpClientUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private WeChatProperties weChatProperties;

    @Override
    public User login(UserLoginDTO dto) {
        //1. 向微信官方发送请求,获取openid, 如果获取不到,直接登录失败
        //1-1 准备请求地址
        String url = "https://api.weixin.qq.com/sns/jscode2session";
        //1-2 准备请求参数
        Map<String, String> paramMap = new HashMap<>();
        paramMap.put("appid", weChatProperties.getAppid());
        paramMap.put("secret", weChatProperties.getSecret());
        paramMap.put("js_code", dto.getCode());
        paramMap.put("grant_type", "authorization_code");
        //1-3 发送请求
        String json = HttpClientUtil.doGet(url, paramMap);
        log.info("微信登录结果是{}",json);
        //1-4 将json转map
        Map map = JSON.parseObject(json, Map.class);
        //1-5 获取openid
        String openid = (String) map.get("openid");
        //1-6 判断openid是否存在,如果不存在就报错
        if (StrUtil.isEmpty(openid)) {
            throw new BusinessException("微信登录失败");
        }

        //2. 根据openid去user表查询, 如果没有就需要插入一个
        //2-1 根据openid去user表查询
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(User::getOpenid, openid);
        User user = userMapper.selectOne(wrapper);
        //2-2 如果查询不到,就保存到库里
        if (user == null){
            user = User.builder()
                    .openid(openid)
                    .createTime(LocalDateTime.now())
                    .build();
            userMapper.insert(user);
        }

        //3. 返回user对象
        return user;
    }
}
