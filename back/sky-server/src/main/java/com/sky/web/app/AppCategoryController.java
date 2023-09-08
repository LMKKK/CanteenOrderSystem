package com.sky.web.app;

import com.sky.entity.Category;
import com.sky.result.Result;
import com.sky.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/user/category")
public class AppCategoryController {
    @Autowired
    private CategoryService categoryService;

    //条件查询
    @GetMapping("/list")
    public Result findByStatusAndType(Integer type){
        List<Category> categoryList = categoryService.findByStatusAndType(type);
        return Result.success(categoryList);
    }
}
