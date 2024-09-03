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

        if(loginUser == null){
            log.warn("LoginInterceptor : 비회원 접근 불가!");
            response.sendRedirect(request.getContextPath());
            return false;
        }

        return true;
    }
}
