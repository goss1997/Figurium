package com.githrd.figurium.home.controller;

import com.githrd.figurium.product.entity.Category;
import com.githrd.figurium.product.repository.CategoriesRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class HomeController {

    private final CategoriesRepository categoriesRepository;


    @GetMapping("/")
    public String home(Model model) {
        List<Category> categoriesList = categoriesRepository.findAll();
        model.addAttribute("categoriesList", categoriesList);

        return "home";
    }


}
