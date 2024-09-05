package com.githrd.figurium.admin.controller;

import com.githrd.figurium.order.dao.OrderMapper;
import com.githrd.figurium.order.service.OrderService;
import com.githrd.figurium.order.service.OrderServiceImpl;
import com.githrd.figurium.order.vo.MyOrderVo;
import com.githrd.figurium.product.entity.Category;
import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.repository.CategoriesRepository;
import com.githrd.figurium.product.repository.ProductRepository;
import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@AllArgsConstructor
public class adminController {

    private final ProductRepository productRepository;
    private final CategoriesRepository categoriesRepository;
    private final HttpSession session;
    private final OrderServiceImpl orderServiceImpl;
    private final OrderService orderService;
    private final OrderMapper orderMapper;


    @GetMapping("/admin")
    public String admin(Model model) {

        User loginUser = (User) session.getAttribute("loginUser");

        if(loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg","관리자만 접속이 가능합니다.");
            return "redirect:/";
        }

        List<MyOrderVo> orderList = orderMapper.viewAllList();
        model.addAttribute("orderList" , orderList);
        System.out.println(orderList);


        return "admin/adminPage";
    }

}
