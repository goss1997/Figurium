package com.githrd.figurium.exception;

import com.githrd.figurium.exception.customException.*;
import com.githrd.figurium.exception.type.ErrorType;
import lombok.extern.slf4j.Slf4j;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.http.client.RedirectException;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
public class MyCustomExceptionResolver implements HandlerExceptionResolver {

    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        // 예외에 대한 로그 기록
        ErrorType errorType = determineErrorType(ex);
        log.error("오류 발생: {} - 요청 URL: {}", errorType.getMessage(), request.getRequestURI(), ex);

        // 클라이언트에게는 기본 에러 페이지를 반환
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

        // 예외 처리 후 별도의 뷰 반환 (기본 에러 페이지)
        return new ModelAndView("errorPage/error");
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
        }
        // 기본적으로 일반 예외로 처리
        return ErrorType.GENERAL_EXCEPTION;
    }
}
