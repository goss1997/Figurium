package com.githrd.figurium.interceptor;

import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.PrintWriter;

public class LoginInterceptor implements HandlerInterceptor {

    private final static String LOGIN_USER = "loginUser";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute(LOGIN_USER);

        // session에 loginUser가 없을 경우
        if (loginUser == null) {
            // 클라이언트에 alert 창을 띄우고, 메인 페이지로 리다이렉트
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인이 필요한 페이지입니다.'); location.href='/';</script>");
            out.flush();    // 응답이 바로 전송되도록 버퍼 비우기
            return false;  // 요청 처리를 중단
        }

        return true;
    }
}
