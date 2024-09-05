package com.githrd.figurium.interceptor;

import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;

@Slf4j
public class LoginInterceptor implements HandlerInterceptor {

    private final static String LOGIN_USER = "loginUser";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute(LOGIN_USER);

        if(loginUser == null) {

            log.warn("LoginInterceptor : 비회원 접근 불가!");
            session.setAttribute("alertMsg","Figurium : 로그인 후 이용가능합니다.");

            // request header에서 이전 페이지 가져오기.
            String referer = request.getHeader("Referer");

            // 이전 페이지가 없으면 홈으로 있으면 이전 페이지로 리다이렉트.
            response.sendRedirect(referer == null ? "/" : referer);
            return false;
        }

        return true;
    }
}
