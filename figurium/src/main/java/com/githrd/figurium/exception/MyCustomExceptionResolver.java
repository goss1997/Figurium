package com.githrd.figurium.exception;

import com.githrd.figurium.exception.type.ErrorType;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.io.PrintWriter;

public class MyCustomExceptionResolver implements HandlerExceptionResolver {

    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        try {
            // ContentType 설정 및 응답을 UTF-8로 인코딩
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();

            // switch문을 사용해 발생한 예외에 따라 메시지 및 리다이렉트 처리
            ErrorType errorType;
            switch (ex.getClass().getSimpleName()) {
                case "NullPointerException" -> errorType = ErrorType.NULL_POINTER_EXCEPTION;
                case "IllegalArgumentException" -> errorType = ErrorType.ILLEGAL_ARGUMENT_EXCEPTION;

                // 커스텀하게 추가할 경우 ErrorType과 해당 case를 추가하면 된다.


                default -> errorType = ErrorType.GENERAL_EXCEPTION;
            }

            // 알러창과 리다이렉트(홈으로) 처리
            out.println(getAlertScript(errorType.getMessage(), "/"));
            out.flush(); // 즉시 응답 전송
        } catch (IOException e) {
            e.printStackTrace(); // 예외 처리 중 발생한 예외를 로깅
        }

        // 예외 처리 후 별도의 뷰 반환 없이 null 반환
        return new ModelAndView("/");
    }

    // 알러창을 띄우고 리다이렉트하는 스크립트를 반환하는 메서드
    private String getAlertScript(String message, String redirectUrl) {
        return "<script>alert('" + message + "'); location.href='" + redirectUrl + "';</script>";
    }
}
