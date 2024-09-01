package com.githrd.figurium.user.controller;

import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.user.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import net.minidev.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final HttpSession session;


    /**
     * 로그인
     *
     * @param email    : 이메일
     * @param password : 비밀번호
     * @return : ResponseEntity
     */
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
            session.setAttribute("loginUser", user);
            return ResponseEntity.ok("Login successful");
        }
    }


    /**
     * 로그아웃
     *
     * @return : 메인 페이지
     */
    @GetMapping("logout.do")
    public String logout(HttpServletRequest request) {

        // session에 사용자의 정보 제거.
        session.removeAttribute("loginUser");

        String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
        return "redirect:" + referer; // 이전 페이지로 리다이렉트
    }


    /**
     * 회원가입 페이지
     */
    @GetMapping("signup-form.do")
    public String signUpForm() {
        return "user/signUpForm";
    }


    /**
     * 이메일 확인
     *
     * @param email : 가입 이메일
     * @return : json
     */
    @RequestMapping(value = "check_email.do", produces = "application/json; charset=utf-8;")
    @ResponseBody
    public String checkEmail(String email) {


        // null이 아니면 사용중인 이메일 > isUsed = true
        boolean isUsed = (userService.findByEmail(email) != null);

        System.out.println("isUsed = " + isUsed);

        JSONObject json = new JSONObject();
        json.put("isUsed", isUsed);

        return json.toString();

    }

    /**
     * 회원가입
     */
    @PostMapping("sign-up.do")
    public String signup(User user, @RequestParam MultipartFile profileImage) {

        User save = userService.signup(user, profileImage);

        if (save == null) {
            return "redirect:/user/login.do";
        } else {
            return "redirect:/";
        }
    }

    /**
     * 마이페이지
     */
    @GetMapping("my-page.do")
    public String myPage(Model model) {

        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser != null) {

            User user = userService.findUserById(loginUser.getId());

            model.addAttribute("user", user);

            return "user/myPage";
        } else {
            return "redirect:/";
        }

    }

    /**
     * 사용자 프로필 이미지 수정
     */
    @PostMapping("update-profile-image.do")
    @ResponseBody
    public ResponseEntity<?> updateProfileImage(@RequestParam MultipartFile file) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인한 사용자만 요청 가능합니다.");
        }

        User updateUser = userService.updateProfileImage(user, file);
        if (updateUser == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("해당 이미지를 수정할 수 없습니다.");
        } else {
            return ResponseEntity.ok("update profile image successful");
        }
    }

    @PostMapping("update.do")
    public String updateUser(String name, String phone, String address) {

        User updatedUser = userService.updateUser(name, phone, address);
        session.setAttribute("loginUser", updatedUser);

        return "redirect:/user/my-page.do";
    }


}
