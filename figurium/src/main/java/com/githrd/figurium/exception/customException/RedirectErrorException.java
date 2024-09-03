package com.githrd.figurium.exception.customException;

public class RedirectErrorException extends RuntimeException {
    public RedirectErrorException() {
        super("리다이렉트 오류가 발생했습니다.");
    }

    public RedirectErrorException(String message) {
        super(message);
    }
}
