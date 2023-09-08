package com.sky.web.app;

import com.sky.dto.UserLoginDTO;
import com.sky.entity.User;
import com.sky.properties.JwtProperties;
import com.sky.result.Result;
import com.sky.service.UserService;
import com.sky.utils.JwtUtil;
import com.sky.vo.UserLoginVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user/user")
public class AppUserController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtProperties jwtProperties;

    @PostMapping("/login")
    public Result login(@RequestBody UserLoginDTO dto) {
        //1. 调用service登录
        User user = userService.login(dto);

        //2. 创建token
        Map<String, Object> claims = new HashMap<>();
        claims.put("userId", user.getId());//设置有效载荷
        String token = JwtUtil.createJWT(jwtProperties.getUserSecret(), jwtProperties.getUserTtl(), claims);

        //3.返回结果
        UserLoginVO userLoginVO = UserLoginVO.builder()
                .id(user.getId())
                .openid(user.getOpenid())
                .token(token)
                .build();
        return Result.success(userLoginVO);

    }
}
