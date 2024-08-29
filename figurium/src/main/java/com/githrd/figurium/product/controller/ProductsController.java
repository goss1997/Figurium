package com.githrd.figurium.product.controller;

import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.service.ProductsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProductsController {

    private final ProductsService productsService;

    @Autowired
    public ProductsController(ProductsService productsService) {
        this.productsService = productsService;
    }


    @GetMapping("/productInfo.do")
    public String producesList(@RequestParam(value = "id", required = false) Integer id, Model model) {

        Products selectOne = productsService.getProductById(id);
        model.addAttribute("product", selectOne);

        return "products/productInfo";
    }

}
