package com.githrd.figurium.home.controller;

import com.githrd.figurium.product.entity.Category;
import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.repository.CategoriesRepository;
import com.githrd.figurium.product.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    private final ProductRepository productRepository;
    private final CategoriesRepository categoriesRepository;

    @Autowired
    HomeController(ProductRepository productRepository,
                   CategoriesRepository categoriesRepository) {
        this.productRepository = productRepository;
        this.categoriesRepository = categoriesRepository;
    }

    @GetMapping("/")
    public String home(Model model) {

        List<Products> productsList = productRepository.findAllByCreatedAtDesc();
        List<Category> categoriesList = categoriesRepository.findAll();
        model.addAttribute("productsList", productsList);
        model.addAttribute("categoriesList", categoriesList);

        return "home";
    }



}
