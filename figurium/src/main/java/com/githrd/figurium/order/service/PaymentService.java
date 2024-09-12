package com.githrd.figurium.order.service;

import com.githrd.figurium.order.dao.OrderMapper;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Collections;

@Service
@Slf4j
@RequiredArgsConstructor
public class PaymentService {

    private final OrderMapper orderMapper;

    private IamportClient api;

    private RefundService refundService;

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    @PostConstruct
    public void init() {
        this.api = new IamportClient(apiKey, secretKey);
        this.refundService = new RefundService();
    }

    public ResponseEntity<?> verifyPayment(String imp_uid, String merchantUid, HttpSession session)
            throws IamportResponseException, IOException {
        IamportResponse<Payment> res = api.paymentByImpUid(imp_uid);
        Payment payment = res.getResponse();
        Integer amount = payment.getAmount().intValue();

        Integer sessionTotalPrice = (Integer) session.getAttribute("sessionTotalPrice");

        if(sessionTotalPrice < 100000) {
            sessionTotalPrice = sessionTotalPrice + 3000;
        }

        log.info("넘어온 session 가격값: {}", sessionTotalPrice);
        log.info("iamport amount 값 {}", amount);

        if(sessionTotalPrice.intValue() != amount) {

            String accessToken = refundService.getToken(apiKey, secretKey);
            String reason = "치명적 데이터 변조";

            // 결제 검증 후 데이터변조 발견 시 환불
            try {
                refundService.refundRequest(accessToken, merchantUid, reason);
                log.info("결제 검증 실패로 인한 환불: 주문번호 {}", merchantUid);
                return ResponseEntity.badRequest().body(Collections.singletonMap("message", "결제 금액 불일치"));
            } catch (IOException e) {
                log.error("환불 요청 실패: {}", e.getMessage());
                return ResponseEntity.badRequest().body(Collections.singletonMap("message", "결제 금액 불일치"));
            }
        }

        // 사용자의 결제 취소
        if(payment.getPaidAt() == null) {
            log.error("결제 요청 실패: {}", "사용자 임의의 결제 취소");
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", "사용자의 결제 취소"));
        }

        return ResponseEntity.ok(payment);
    }


}
