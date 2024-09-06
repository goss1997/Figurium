package com.githrd.figurium.order.controller;

import com.githrd.figurium.order.dao.OrderMapper;
import com.githrd.figurium.order.service.RefundService;
import com.githrd.figurium.order.vo.MyOrderVo;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.io.PrintWriter;

@Controller
@Slf4j  // 로깅을 위한 log 객체를 자동으로 생성
@RequiredArgsConstructor    // 알아서 private로 지정되어있는 필드 생성자로 생성
public class PaymentController {

    private final OrderMapper orderMapper;
    // iamport를 사용하기 위해서 api를 불러온다.
    private IamportClient api;

    private RefundService refundService;

    // application.properties에 암호를 저장하여 Controller에 기록이 안되게 암호화 시킴
    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    // api를 사용하기 위해서는 apiKey와 apiSecret키를 넣어준다.
    @PostConstruct
    public void init() {
        this.api = new IamportClient(apiKey, secretKey);
        this.refundService = new RefundService();

    }


    @ResponseBody   // JSON 형태로 반환
    @RequestMapping(value="/verifyIamport/{imp_uid}")
    public IamportResponse<Payment> paymentByImpUid(@PathVariable(value="imp_uid") String imp_uid)
            throws IamportResponseException, IOException {
        // @PathVariable(value="imp_uid")로 지정된 값을 String imp_uid에 지정
        // 특졍 결제 ID(imp_uid)를 기반으로 결제 정보 조회 후 JSON으로 클라이언트에게 응답

        return api.paymentByImpUid(imp_uid);
    }

    @GetMapping("/refund.do")
    @ResponseBody
    public boolean requestRefund(Integer id, HttpServletResponse response) throws IOException {

        String accessToken = refundService.getToken(apiKey, secretKey);
        MyOrderVo myOrderVo = orderMapper.selectOneByMerchantUid(id);
        String merchantUid = myOrderVo.getMerchantId();
        String reason = "단순 변심";

        try {
            refundService.refundRequest(accessToken, merchantUid, reason);
            log.info("환불 요청 성공: 주문번호 {}", merchantUid);
            // 결제 valid n 처리
            orderMapper.updateByRefund(id);

            // response로 알림창 넘겨주기
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('환불이 성공적으로 처리되었습니다. 결제된 금액의 환불 정산에는 결제방식에 따라 최대 영업일 기준 1일 정도가 소모됩니다.'); location.href='/';</script>");
            out.flush();
            return true;
        } catch (IOException e) {
            log.error("환불 요청 실패: {}", e.getMessage());

            // response로 알림창 넘겨주기
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('환불에 실패했습니다. 관리자에게 문의바랍니다.'); location.href='/';</script>");
            out.flush();
            return false;
        }

    }
}
