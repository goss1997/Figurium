package com.githrd.figurium.exception.customException;

public class OutofStockException extends RuntimeException{
    public OutofStockException() { super("다른 사용자의 결제가 완료되어 상품의 재고가 부족합니다.");}

    public OutofStockException(String message) {
        super(message);
    }
}
