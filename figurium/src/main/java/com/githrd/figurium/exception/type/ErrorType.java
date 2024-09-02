package com.githrd.figurium.exception.type;

public enum ErrorType {

    /**
     * 예외 처리를 관리하기 위한 enum
     */

    NULL_POINTER_EXCEPTION("NullPointerException 발생!"),
    ILLEGAL_ARGUMENT_EXCEPTION("잘못된 인자가 전달되었습니다."),
    GENERAL_EXCEPTION("서버 내부 오류가 발생했습니다.");



    private final String message;

    ErrorType(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}

