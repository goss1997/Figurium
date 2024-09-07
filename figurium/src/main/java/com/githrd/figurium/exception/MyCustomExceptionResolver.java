package com.githrd.figurium.exception;

import com.githrd.figurium.exception.customException.*;
import com.githrd.figurium.exception.type.ErrorType;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.client.RedirectException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.resource.NoResourceFoundException;

@Slf4j
public class MyCustomExceptionResolver implements HandlerExceptionResolver {

    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        // 예외에 대한 로그 기록
        ErrorType errorType = determineErrorType(ex);
        log.error("오류 발생: {} - 요청 URL: {}", errorType.getMessage(), request.getRequestURI(), ex);

        // 상태 코드 가져오기 (기본값으로 500 설정)
        int statusCode = HttpServletResponse.SC_INTERNAL_SERVER_ERROR;

        // 예외에 따라 상태 코드 설정
        if (ex instanceof NoHandlerFoundException || ex instanceof NoResourceFoundException) {
            statusCode = HttpServletResponse.SC_NOT_FOUND; // 404 Not Found
        } else if (ex instanceof HttpRequestMethodNotSupportedException) {
            statusCode = HttpServletResponse.SC_METHOD_NOT_ALLOWED; // 405 Method Not Allowed
        }

        System.out.println("statusCode = " + statusCode);
        // 예외에 따라 적절한 상태 코드와 에러 페이지 설정
            ModelAndView mv = new ModelAndView();
            mv.addObject("errorMessage", errorType.getMessage());
            mv.addObject("statusCode",statusCode);
            mv.setViewName("errorPage/error");

            return mv;
        }




    // 예외 유형에 따라 ErrorType을 결정하는 메서드
    private ErrorType determineErrorType(Exception ex) {
        if (ex instanceof NullPointerException) {
            return ErrorType.NULL_POINTER_EXCEPTION;
        } else if (ex instanceof IllegalArgumentException) {
            return ErrorType.ILLEGAL_ARGUMENT_EXCEPTION;
        } else if (ex instanceof UserNotFoundException) {
            return ErrorType.USER_NOT_FOUND;
        } else if (ex instanceof SocialAccountNotFoundException) {
            return ErrorType.SOCIAL_ACCOUNT_NOT_FOUND;
        } else if (ex instanceof RedirectException) {
            return ErrorType.REDIRECT_EXCEPTION;
        } else if (ex instanceof AccountLinkException) {
            return ErrorType.ACCOUNT_LINK_ERROR;
        } else if (ex instanceof SocialLoginException) {
            return ErrorType.SOCIAL_LOGIN_ERROR;
        } else if (ex instanceof RedirectErrorException) {
            return ErrorType.REDIRECT_ERROR;
        } else if (ex instanceof FailDeleteUserException) {
            return ErrorType.FAIL_DELETE_USER_EXCEPTION;
        } else if (ex instanceof NoResourceFoundException) {
            return ErrorType.NO_RESOURCE_FOUND_EXCEPTION;
        }

        // 기본적으로 일반 예외로 처리
        return ErrorType.GENERAL_EXCEPTION;
    }
}

