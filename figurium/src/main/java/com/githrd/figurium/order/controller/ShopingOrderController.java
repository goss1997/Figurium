package com.githrd.figurium.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ShopingOrderController {

    @GetMapping("order/orderForm.do")
    public String orderForm() {

        return "order/order_form";
    }


}
