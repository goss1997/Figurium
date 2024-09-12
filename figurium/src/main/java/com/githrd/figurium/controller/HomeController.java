package com.githrd.figurium.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {

        return "home";
    }

    @GetMapping("/home.do")
    public String home2() {
        return "home";
    }


}
