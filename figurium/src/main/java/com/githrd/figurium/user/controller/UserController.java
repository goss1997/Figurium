package com.githrd.figurium.user.controller;

import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.user.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final HttpSession session;
    private final HttpServletRequest request;

    @PostMapping("login.do")
    @ResponseBody
    public ResponseEntity<?> login(String email, String password) {

        User user = userService.findByEmail(email);

        if (user == null) {
            // 로그인 실패 시 HTTP 상태 코드와 메시지 반환
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("가입되지 않은 이메일입니다.");
        } else {
            if (!user.getPassword().equals(password)) {

                // 로그인 실패 시 HTTP 상태 코드와 메시지 반환
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("비밀번호가 일치하지 않습니다.");
            }
            // 로그인 성공 시
            session.setAttribute("user", user);
            return ResponseEntity.ok("Login successful");
        }
    }

    //로그아웃
    @RequestMapping("logout.do")
    public String logout() {

        session.removeAttribute("user");

        return "redirect:/";
    }


}
