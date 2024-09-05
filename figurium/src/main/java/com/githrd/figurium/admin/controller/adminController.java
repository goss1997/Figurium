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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

        if (loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg", "관리자만 접속이 가능합니다.");
            return "redirect:/";
        }

        List<MyOrderVo> orderList = orderMapper.viewAllList();
        model.addAttribute("orderList", orderList);


        return "admin/adminPage";
    }

    @PostMapping("/statusChange.do")
    @ResponseBody
    public ResponseEntity<String> handleDeliveryCondition(@RequestBody Map<String, Object> data) {
        try {

            // JSON에서 전달된 id와 status 값을 추출
            String idStr = (String) data.get("id");
            String status = (String) data.get("status");

            if (idStr == null || status == null) {
                return ResponseEntity.badRequest().body("Missing required fields");
            }

            int id = Integer.parseInt(idStr);

            // id를 사용해 주문 조회
            List<MyOrderVo> selectOneById = orderMapper.selectOneById(id);

            if (selectOneById != null) {
                // status 업데이트 로직 수행
                orderMapper.updateOrderStatus(id, status);
                return ResponseEntity.ok("Success");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid Order ID");
            }
        } catch (NumberFormatException e) {
            return ResponseEntity.badRequest().body("Invalid ID format");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred");
        }
    }


}

