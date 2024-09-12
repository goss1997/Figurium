package com.githrd.figurium.admin.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.githrd.figurium.order.dao.OrderMapper;
import com.githrd.figurium.order.vo.MyOrderVo;
import com.githrd.figurium.qa.service.QaService;
import com.githrd.figurium.qa.vo.QaVo;
import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class adminController {

    private final HttpSession session;
    private final OrderMapper orderMapper;
    private final QaService qaService;



    @GetMapping("/admin.do")
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

    @GetMapping("/adminPayment.do")
    public String adminPayment(Model model) {

        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg", "관리자만 접속이 가능합니다.");
            return "redirect:/";
        }

        // 취소요청 목록을 가져오기
        List<MyOrderVo> paymentList = orderMapper.selectListByPayment();

        model.addAttribute("paymentList", paymentList);


        // orderList를 JSON 형태로 반환
        return "admin/adminPayment";
    }

    @PostMapping("/ordersRefund.do")
    @ResponseBody
    public int ordersRefund(int id) {

        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg", "관리자만 접속이 가능합니다.");

        }

        int response = orderMapper.updateByRefund(id);

        return response;
    }





    @PostMapping("/statusChange.do")
    @ResponseBody
    public ResponseEntity<String> handleDeliveryCondition(@RequestBody Map<String, Object> data) {

        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg", "관리자만 접속이 가능합니다.");

        }
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


    @GetMapping("/adminQaList.do")
    public String adminQaList(Model model) {

        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg", "관리자만 접속이 가능합니다.");
            return "redirect:/";
        }

            List<QaVo> qaList = qaService.replyQaList();


            model.addAttribute("qaList" , qaList);

            return "admin/adminQaList";

    }

    @GetMapping("/adminRefund.do")
    public String changeStatus(Model model) {

        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg", "관리자만 접속이 가능합니다.");
            return "redirect:/";
        }
        List<MyOrderVo> orderList = orderMapper.viewAllList();

        model.addAttribute("orderList" , orderList);

        return "admin/adminRefund";
    }

    @GetMapping("/qaCount.do")
    @ResponseBody
    public ResponseEntity<Map<String, Integer>> getQaCount() {

        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg", "관리자만 접속이 가능합니다.");

        }
        try {
            int count = qaService.getQaCount();
            Map<String, Integer> response = new HashMap<>();
            response.put("count", count);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @GetMapping("/adminReturns.do")
    public String adminReturns(Model model) {

        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg", "관리자만 접속이 가능합니다.");
            return "redirect:/";
        }

        List<MyOrderVo> listReturns = orderMapper.selectListByRetrun();

        model.addAttribute("listReturns" , listReturns);

        return "admin/adminReturns";
    }




}