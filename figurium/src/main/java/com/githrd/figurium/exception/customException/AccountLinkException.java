package com.githrd.figurium.exception.customException;

public class AccountLinkException extends RuntimeException {
    public AccountLinkException() {
        super("계정 연동에 실패했습니다.");
    }

    public AccountLinkException(String message) {
        super(message);
    }
}
