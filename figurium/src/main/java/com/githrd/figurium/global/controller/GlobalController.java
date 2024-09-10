package com.githrd.figurium.global.controller;

import com.githrd.figurium.product.entity.Category;
import com.githrd.figurium.product.repository.CategoriesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice
public class GlobalController {

    private final CategoriesRepository categoriesRepository;

    @Autowired
    GlobalController(CategoriesRepository categoriesRepository) {
        this.categoriesRepository = categoriesRepository;
    }

    // header의 카테고리 name값 사용을 위한 공통 컨트롤러
    @ModelAttribute("headerCategories")
    public List<Category> headerCategories() {
        return  categoriesRepository.findAll();
    }

}
