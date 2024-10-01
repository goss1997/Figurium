package com.githrd.figurium.user.controller;

import com.githrd.figurium.common.page.Paging;
import com.githrd.figurium.common.session.SessionConstants;
import com.githrd.figurium.exception.customException.FailDeleteUserException;
import com.githrd.figurium.mail.service.EmailService;
import com.githrd.figurium.order.dao.OrderMapper;
import com.githrd.figurium.order.service.OrderService;
import com.githrd.figurium.order.vo.MyOrderVo;
import com.githrd.figurium.product.vo.ProductsVo;
import com.githrd.figurium.user.entity.SocialAccount;
import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.user.service.SocialAccountService;
import com.githrd.figurium.user.service.UserService;
import com.githrd.figurium.user.vo.SocialAccountVo;
import com.githrd.figurium.user.vo.UserVo;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import net.minidev.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    private static final int PAGE_SIZE = 5;    // 페이지 사이즈

    private final UserService userService;
    private final SocialAccountService socialAccountService;
    private final HttpSession session;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final OrderService orderService;
    private final OrderMapper orderMapper;
    private final EmailService emailService;

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

        // 가입 x : user == null / 소셜 회원 : password == null
        if (user == null || user.getPassword() == null) {
            // 로그인 실패 시 HTTP 상태 코드와 메시지 반환
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("가입되지 않은 이메일입니다.");
        } else {
            if (user.getDeleted()) {
                // 탈퇴한 회원일 경우 HTTP 상태 코드와 메시지 반환
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("탈퇴한 계정입니다.");
            }
            // 입력한 비밀번호가 db에 암호화된 비밀번호와 일치하지 않을 경우
            if (!bCryptPasswordEncoder.matches(password, user.getPassword())) {

                // 로그인 실패 시 HTTP 상태 코드와 메시지 반환
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("비밀번호가 일치하지 않습니다.");
            }
            // 로그인 성공 시
            session.setAttribute(SessionConstants.LOGIN_USER, user);

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
        session.removeAttribute(SessionConstants.LOGIN_USER);

        String referer = request.getHeader("Referer"); // 헤더에서 이전 페이지를 읽는다.
        return "redirect:" + (referer == null ? "/" : referer); // 이전 페이지로 리다이렉트
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
        String provider = "";
        if(isUsed){
            User user = userService.findByEmail(email);
            SocialAccountVo socialAccount = socialAccountService.findByEmail(user.getId());
            if(socialAccount != null) {
                provider = socialAccount.getProvider();
            }
        }
        
        JSONObject json = new JSONObject();
        json.put("isUsed", isUsed);
        json.put("provider",provider);

        return json.toString();

    }

    /**
     * 회원가입
     */
    @PostMapping("sign-up.do")
    public String signup(UserVo user,
                         @RequestParam(value = "profileImage", required = false) MultipartFile profileImage) {

        // 비밀번호 암호화
        String encPwd = bCryptPasswordEncoder.encode(user.getPassword());
        user.setPassword(encPwd);

        int result = userService.signup(user, profileImage);

        if (result > 0) {
            session.setAttribute(SessionConstants.ALERT_MSG, "회원가입 완료!");
            return "redirect:/";
        } else {
            return "redirect:/user/login.do";
        }
    }

    /**
     * 마이페이지
     */
    @GetMapping("my-page.do")
    public String myPage(Model model) {

        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);

        if (loginUser != null) {

            User user = userService.findUserById(loginUser.getId());

            model.addAttribute("user", user);

            return "user/myPage";
        } else {
            session.setAttribute(SessionConstants.ALERT_MSG, "로그인 후 이용 가능합니다.");
            return "redirect:/";
        }

    }

    /**
     * 사용자 프로필 이미지 수정
     */
    @PostMapping("update-profile-image.do")
    @ResponseBody
    public ResponseEntity<?> updateProfileImage(@RequestParam MultipartFile file) {
        User user = (User) session.getAttribute(SessionConstants.LOGIN_USER);
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

    /**
     * 사용자 정보 수정
     */
    @PostMapping("update.do")
    public String updateUser(String name, String phone, String address, String detailAddress) {

        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);

        if (loginUser == null) {
            return "redirect:/";
        }

        User updatedUser = userService.updateUser(name, phone, address, detailAddress);
        session.setAttribute(SessionConstants.LOGIN_USER, updatedUser);

        session.setAttribute(SessionConstants.ALERT_MSG, "수정 완료!");
        return "redirect:/user/my-page.do";
    }

    /**
     * 비밀번호 찾기 페이지
     */
    @GetMapping("find-password-form.do")
    public String findPasswordForm() {
        return "user/findPassword";
    }

    /**
     * 비밀번호 재설정을 위한 메일 보내기
     */
    @PostMapping("send-password-reset.do")
    @ResponseBody
    public ResponseEntity<?> sendPasswordResetUrl(String findEmail) throws MessagingException {

        // 입력한 이메일이 존재하지 않을 경우
        if (userService.findByEmailAndDeletedFalse(findEmail) == 0) {
            return ResponseEntity.status(400).body("회원 가입하지 않거나 탈퇴한 이메일입니다.");
        } else {
            // 존재할 경우 메일 보내기
            boolean isSended = emailService.sendPasswordResetUrl(findEmail);
            if (isSended) {
                // send 성공 시
                return ResponseEntity.ok("인증되었습니다.");
            } else {
                // send 실패 시
                return ResponseEntity.status(400).body("메일 전송에 실패하였습니다.");
            }
        }
    }

    /**
     * 비밀번호 재설정 페이지
     */
    @PostMapping("reset-password-form.do")
    public String resetPasswordForm(String updateEmail, HttpServletRequest request , Model model) {

        // 쿠키에서 verificationCode 추출
        String verificationCode = getVerificationCodeByCookie(request);
        // 세선에 verificationCode 저장
        session.setAttribute("verificationCode", verificationCode);

        model.addAttribute("updateEmail", updateEmail);
        return "user/resetPassword";
    }

    /**
     * 비밀번호 재설정
     */
    @PostMapping("reset-password.do")
    public String resetPassword(String updateEmail, String newPassword,
                                HttpServletRequest request, HttpServletResponse response) {

        // 쿠키와 세션에서 verificationCode 가져오기

        String verificationCode = getVerificationCodeByCookie(request);
        if(verificationCode == null) {
            session.setAttribute(SessionConstants.ALERT_MSG, "인증되지 않은 접근입니다.");
            return "redirect:/";
        }

        if(session.getAttribute("verificationCode") == null) {
            session.setAttribute(SessionConstants.ALERT_MSG, "인증되지 않은 접근입니다.");
            return "redirect:/";
        }

        String sessionVerificationCode = session.getAttribute("verificationCode").toString();

        // 쿠키의 값과 세션의 값이 같지 않을 경우 (찾을 사람과 재설정하는 사람이 다를 경우)
        if(!verificationCode.equals(sessionVerificationCode)) {
            session.setAttribute(SessionConstants.ALERT_MSG, "인증되지 않은 접근입니다.");
            return "redirect:/";
        }

        // 해당 이메일이 탈퇴했거나 없을 경우
        if (userService.findByEmailAndDeletedFalse(updateEmail) == 0) {
            session.setAttribute(SessionConstants.ALERT_MSG, "탈퇴했거나 없는 계정입니다.");
            return "redirect:/";
        }

        User user = userService.findByEmail(updateEmail);
        // 비밀번호 암호화
        String encPwd = bCryptPasswordEncoder.encode(newPassword);

        // 비밀번호 수정.
        int result = userService.updateUserPassword(user.getId(), encPwd);

        if (result > 0) {
            // 재설정 완료 시 쿠키와 세션에서 verificationCode 제거
            removeVerificationCodeByCookie(request,response);
            session.removeAttribute("verificationCode");

            session.setAttribute(SessionConstants.ALERT_MSG, "비밀번호가 재설정되었습니다. 홈으로 이동합니다.");
            return "redirect:/";
        } else {
            session.setAttribute(SessionConstants.ALERT_MSG, "비밀번호 재설정 실패!");
            return "redirect:/";
        }
    }


    /**
     * 내 주문 내역 조회
     */
    @GetMapping("order-list.do")
    public String myOrderList(Model model) {
        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);

        if (loginUser == null) {
            return "redirect:/";
        }

        int userId = loginUser.getId();

        List<MyOrderVo> myOrdersList = orderService.selectListByUserId(userId);

        model.addAttribute("myOrdersList", myOrdersList);

        return "user/myOrderList";
    }

    /**
     * 내 주문 상세 조회
     */
    @GetMapping("orderDetail.do")
    public String myOrderDetail(Model model, Integer myOrderId) {

        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);

        int userId = loginUser.getId();

        List<MyOrderVo> myOrderDetailList = orderMapper.selectListByDetailOrder(myOrderId, userId);
        MyOrderVo myOrderInfo = orderMapper.selectOneOrderInfo(myOrderId, userId);

        model.addAttribute("myOrderDetailList", myOrderDetailList);
        model.addAttribute("myOrderInfo", myOrderInfo);
        return "user/myOrderDetail";
    }

    /**
     * 회원 탈퇴 페이지
     */
    @GetMapping("deleteForm.do")
    public String deleteForm() {
        return "user/userDeleteForm";
    }

    /**
     * 자체 회원 탈퇴
     */
    @PostMapping("delete.do")
    public ResponseEntity<?> delete(String password) {

        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);

        User user = userService.findByEmail(loginUser.getEmail());

        // 입력한 비밀번호가 db에 암호화된 비밀번호와 일치하지 않을 경우
        if (!bCryptPasswordEncoder.matches(password, user.getPassword())) {

            // 로그인 실패 시 HTTP 상태 코드와 메시지 반환
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("비밀번호가 일치하지 않습니다.");
        }

        // 비밀번호가 일치할 경우 softDelete / 소셜 계정이 존재할 경우 hardDelete
        int result = userService.softDelete(user.getId());

        if (result <= 0) {
            // 커스텀 예외 처리
            throw new FailDeleteUserException();
        }
        session.removeAttribute(SessionConstants.LOGIN_USER);
        return ResponseEntity.ok("탈퇴 완료!! 홈으로 이동합니다!");
    }

    /**
     * 소셜 회원 탈퇴
     */
    @PostMapping("deleteSocial.do")
    public ResponseEntity<?> deleteSocial() {

        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);
        int result = userService.deleteSocialAccount(loginUser.getId());

        if (result > 0) {
            session.removeAttribute(SessionConstants.LOGIN_USER);
            return ResponseEntity.ok("탈퇴 완료!! 홈으로 이동합니다!");
        } else {
            throw new FailDeleteUserException();
        }
    }

    /**
     * 좋아요한 상품 리스트 페이징 조회
     */
    @GetMapping("refundReasonResult.do")
    public String refundReasonResult(@RequestParam int orderId, @RequestParam String name) {

        Map<String, Object> map = new HashMap<>();

        map.put("name",name);
        map.put("orderId",orderId);


        int res = orderMapper.insertRfreasons(map);

        return "redirect:order-list.do";
    }

    /**
     * 좋아요한 상품 리스트 페이징 조회
     */
    @GetMapping("myProductLikeList.do")
    public String myProductLikeListAll(@RequestParam(defaultValue = "1") int page, Model model) {

        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);

        int userId = loginUser.getId();

        int totalPages = userService.getTotalPagesByUserId(userId);
        String pageView = Paging.getPaging("", page, totalPages, 5, 5);
        int offset = (page - 1) * PAGE_SIZE;

        List<ProductsVo> myProductLikeList = userService.selectMyProductLikeList(userId, PAGE_SIZE, offset);


        model.addAttribute("pageView", pageView);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("myProductLikeList", myProductLikeList);

        return "user/myProductLikesForm";
    }


    /**
     * 쿠키에서 verificationCode 값 가져오는 메소드
     * @param request
     * @return
     */
    private String getVerificationCodeByCookie(HttpServletRequest request) {

        // 쿠키 배열 가져오기
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("verificationCode")) {
                    // 쿠키에서 verificationCode를 추출해 리턴하기
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    /**
     * 쿠키에서 verificationCode 제거하는 메소드
     */
    private void removeVerificationCodeByCookie(HttpServletRequest request, HttpServletResponse response) {
        // 쿠키 배열 가져오기
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("verificationCode")) {
                    // 해당 쿠키 제거를 위해 동일한 이름의 쿠키 생성하고 즉시 만료시키기.
                    Cookie removeCookie = new Cookie("verificationCode", null);
                    removeCookie.setMaxAge(0);
                    removeCookie.setPath("/");
                    response.addCookie(removeCookie);
                }
            }
        }
    }

}
