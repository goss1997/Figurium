package com.githrd.figurium.product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CartsController {

    @GetMapping("/shopingCart.do")
        public String shopingCart(){




        return "products/shopingCart";
        }




}
