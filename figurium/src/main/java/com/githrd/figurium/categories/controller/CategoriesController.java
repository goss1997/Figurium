
package com.githrd.figurium.categories.controller;

import com.githrd.figurium.product.repository.CategoriesRepository;
import com.githrd.figurium.product.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CategoriesController {

    CategoriesRepository categoriesRepository;



    @RequestMapping("/categoriesList.do")
    public String categoriesList() {


        return "products/productCategories";

    }



}

