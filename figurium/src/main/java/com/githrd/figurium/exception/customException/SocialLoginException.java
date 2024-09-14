package com.githrd.figurium.exception.customException;

public class SocialLoginException extends RuntimeException {
    public SocialLoginException() {
        super("소셜 로그인 오류가 발생했습니다.");
    }

    public SocialLoginException(String message) {
        super(message);
    }
}

