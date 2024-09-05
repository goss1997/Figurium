package com.githrd.figurium.exception.customException;

public class FailDeleteUserException extends RuntimeException {
    public FailDeleteUserException() {
        super("회원 탈퇴에 실패하였습니다.");
    }

    public FailDeleteUserException(String message) {
        super(message);
    }
}