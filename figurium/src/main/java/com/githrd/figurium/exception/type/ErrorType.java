package com.githrd.figurium.exception.type;

public enum ErrorType {

    /**
     * 예외 처리를 관리하기 위한 enum
     */

    USER_NOT_FOUND("사용자를 찾을 수 없습니다."),
    SOCIAL_ACCOUNT_NOT_FOUND("소셜 계정을 찾을 수 없습니다."),
    NULL_POINTER_EXCEPTION("널 포인터 예외가 발생했습니다."),
    ILLEGAL_ARGUMENT_EXCEPTION("잘못된 인자가 전달되었습니다."),
    REDIRECT_ERROR("이전 페이지로 리다이렉트하는데 실패했습니다."),
    ACCOUNT_LINK_ERROR("계정 연동에 실패했습니다."),
    SOCIAL_LOGIN_ERROR("소셜 로그인 오류가 발생했습니다."),
    REDIRECT_EXCEPTION("리다이렉트할 수 없습니다."),
    GENERAL_EXCEPTION("서버 내부 오류가 발생했습니다."),
    FAIL_DELETE_USER_EXCEPTION("회원 탈퇴에 실패했습니다."),
    NO_RESOURCE_FOUND_EXCEPTION("요청하신 페이지를 찾을 수 없습니다.")
    ;


    private final String message;

    ErrorType(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}

