package com.githrd.figurium.config;


import com.githrd.figurium.product.entity.Category;
import com.githrd.figurium.product.repository.CategoriesRepository;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.ServletContext;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
public class AppInitializer {

    private final CategoriesRepository categoriesRepository;
    private final ServletContext servletContext;

    // 어플리케이션 실행 시 단 한 번만 실행.
    @PostConstruct
    public void init() {

        // 카테고리 application scope에 set하기.
        List<Category> headerCategories = categoriesRepository.findAll();
        servletContext.setAttribute("headerCategories", headerCategories);
    }



}

