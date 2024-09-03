package com.githrd.figurium.exception.customException;


public class SocialAccountNotFoundException extends RuntimeException {
    public SocialAccountNotFoundException() {
        super("소셜 계정을 찾을 수 없습니다.");
    }

    public SocialAccountNotFoundException(String message) {
        super(message);
    }
}
