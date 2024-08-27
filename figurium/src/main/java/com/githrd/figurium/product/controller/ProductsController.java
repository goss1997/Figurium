package com.githrd.figurium.product.controller;

import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class ProductsController {

   /* private final ProductRepository productRepository;

    @Autowired
    ProductsController(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @GetMapping("/productsList.do")
    public String producesList(Model model) {

        List<Products> list = productRepository.findAll();
        model.addAttribute("list", list);

        return "home";
    }*/

}
