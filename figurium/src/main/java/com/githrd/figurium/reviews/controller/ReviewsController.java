package com.githrd.figurium.reviews.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReviewsController {

    @GetMapping("/reviewInsert.do")
    public String reviewInsert(){

        return "reviews/reviewInsert";
    }


}
