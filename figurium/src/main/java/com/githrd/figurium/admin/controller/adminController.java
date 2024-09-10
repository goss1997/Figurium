package com.githrd.figurium.admin.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.githrd.figurium.order.dao.OrderMapper;
import com.githrd.figurium.order.vo.MyOrderVo;
import com.githrd.figurium.qa.service.QaService;
import com.githrd.figurium.qa.vo.QaVo;
import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.util.page.CommonPage;
import com.githrd.figurium.util.page.Paging;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class adminController {

    private final HttpSession session;
    private final OrderMapper orderMapper;
    private final QaService qaService;
    private final ObjectMapper objectMapper;


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



    @PostMapping("/adminRefund.do")
    @ResponseBody
    public List<MyOrderVo> adminRefund() {
        // 주문 목록을 가져오기
        List<MyOrderVo> orderList = orderMapper.viewAllList();

        // orderList를 JSON 형태로 반환
        return orderList;
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


    @GetMapping("/adminQaList.do")
    @ResponseBody
    public ResponseEntity<String> adminQaList() {
        try {
            List<QaVo> qaList = qaService.replyQaList();
            // qaList를 JSON으로 변환
            String json = objectMapper.writeValueAsString(qaList);
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(json);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred");
        }
    }

    @GetMapping("/qaCount.do")
    @ResponseBody
    public ResponseEntity<Map<String, Integer>> getQaCount() {
        try {
            int count = qaService.getQaCount();
            System.out.println("답변준비중인 게시글 수: " + count);
            Map<String, Integer> response = new HashMap<>();
            response.put("count", count);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

}