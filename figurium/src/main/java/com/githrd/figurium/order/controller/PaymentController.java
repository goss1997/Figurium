package com.githrd.figurium.order.controller;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.util.Locale;

@Controller
public class PaymentController {

    // iamport를 사용하기 위해서 api를 불러온다.
    private IamportClient api;

    // api를 사용하기 위해서는 apiKey와 apiSecret키를 넣어준다.
    public PaymentController() {
        this.api = new IamportClient("1108573077381870",
                "p7w48z3iVEeq6QO8vBA5sOPevweFp7LmcApW5ZFePYX3vJSt7dyyIZdsYs3KfEjztvMy9FlqhPmY0zgn");
    }

    @ResponseBody   // JSON 형태로 반환
    @RequestMapping(value="/verifyIamport/{imp_uid}")
    public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session,
                                                    @PathVariable(value="imp_uid") String imp_uid)
            throws IamportResponseException, IOException {
        // @PathVariable(value="imp_uid")로 지정된 값을 String imp_uid에 지정
        // 특졍 결제 ID(imp_uid)를 기반으로 결제 정보 조회 후 JSON으로 클라이언트에게 응답
        return api.paymentByImpUid(imp_uid);
    }
}
