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

    @GetMapping("/productInfo.do")
    public String producesList() {
        return "products/productInfo";
    }

}
