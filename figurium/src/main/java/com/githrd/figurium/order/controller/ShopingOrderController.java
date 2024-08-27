package com.githrd.figurium.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ShopingOrderController {

    @GetMapping("order/orderForm.do")
    public String orderForm() {

        return "order/order_form";
    }

    // inicis 결제 요청 처리하기
    @RequestMapping("order/inicis_pay.do")
    @ResponseBody
    public String inicis_pay() {

        return "";
    }




}
