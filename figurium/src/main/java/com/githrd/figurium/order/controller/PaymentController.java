package com.githrd.figurium.order.controller;

import com.githrd.figurium.order.dao.OrderMapper;
import com.githrd.figurium.order.service.PaymentService;
import com.githrd.figurium.order.service.RefundService;
import com.githrd.figurium.order.vo.MyOrderVo;
import com.siot.IamportRestClient.IamportClient;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.Collections;

@Controller
@Slf4j  // 로깅을 위한 log 객체를 자동으로 생성
@RequiredArgsConstructor    // 알아서 private로 지정되어있는 필드 생성자로 생성
@RequestMapping("api")
public class PaymentController {

    private final OrderMapper orderMapper;
    // iamport를 사용하기 위해서 api를 불러온다.

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    private final RefundService refundService;

    private final IamportClient api;

    // application.properties에 암호를 저장하여 Controller에 기록이 안되게 암호화 시킴
    private final PaymentService paymentService;

    @ResponseBody
    @RequestMapping(value="/verifyIamport.do")
    public ResponseEntity<?> paymentByImpUid(@RequestParam(value="imp_uid") String imp_uid,
                                             @RequestParam(value="merchantUid") String merchantUid,
                                             HttpServletResponse response, HttpSession session) {
        try {
            return paymentService.verifyPayment(imp_uid, merchantUid, session);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("message", e.getMessage()));
        }
    }



//    @ResponseBody   // JSON 형태로 반환
//    @RequestMapping(value="/verifyIamport.do")
//    public ResponseEntity<?> paymentByImpUid(@RequestParam(value="imp_uid") String imp_uid,
//                                                @RequestParam(value="merchantUid") String merchantUid,
//                                                HttpServletResponse response, HttpSession session)
//            throws IamportResponseException, IOException {
//
//
//        IamportResponse<Payment> res = api.paymentByImpUid(imp_uid);
//        Payment payment = res.getResponse();
//        Integer amount = payment.getAmount().intValue();
//
//        // @PathVariable(value="imp_uid")로 지정된 값을 String imp_uid에 지정
//        // 특졍 결제 ID(imp_uid)를 기반으로 결제 정보 조회 후 JSON으로 클라이언트에게 응답
//        Integer sessionTotalPrice = (Integer) session.getAttribute("sessionTotalPrice");
//
//        if(sessionTotalPrice < 100000) {
//            sessionTotalPrice = sessionTotalPrice + 3000;
//        }
//
//        log.info("넘어온 session 가격값: {}", sessionTotalPrice);
//        log.info("iamport amount 값 {}", amount);
//
//        // 결제 검증로직
//        if(sessionTotalPrice.intValue() != amount) {
//
//            String accessToken = refundService.getToken(apiKey, secretKey);
//            String reason = "치명적 데이터 변조";
//
//            // 결제 검증 후 데이터변조 발견 시 환불
//            try {
//                refundService.refundRequest(accessToken, merchantUid, reason);
//                log.info("결제 검증 실패로 인한 환불: 주문번호 {}", merchantUid);
//                return ResponseEntity.badRequest().body(Collections.singletonMap("message", "결제 금액 불일치"));
//            } catch (IOException e) {
//                log.error("환불 요청 실패: {}", e.getMessage());
//                return ResponseEntity.badRequest().body(Collections.singletonMap("message", "결제 금액 불일치"));
//            }
//        }
//
//        // 사용자의 결제 취소
//        if(payment.getPaidAt() == null) {
//            log.error("결제 요청 실패: {}", "사용자 임의의 결제 취소");
//            return ResponseEntity.badRequest().body(Collections.singletonMap("message", "사용자의 결제 취소"));
//        }
//
//        return ResponseEntity.ok(payment);
//    }



//    @ResponseBody   // JSON 형태로 반환
//    @RequestMapping(value="/verifyIamport")
//    public IamportResponse<Payment> paymentByImpUid(@RequestParam(value="imp_uid") String imp_uid,
//                                                    @RequestParam(value="merchantUid") String merchantUid,
//                                                    HttpServletResponse response, HttpSession session)
//            throws IamportResponseException, IOException {
//
//
//        IamportResponse<Payment> res = api.paymentByImpUid(imp_uid);
//        Payment payment = res.getResponse();
//        Integer amount = payment.getAmount().intValue();
//
//        // @PathVariable(value="imp_uid")로 지정된 값을 String imp_uid에 지정
//        // 특졍 결제 ID(imp_uid)를 기반으로 결제 정보 조회 후 JSON으로 클라이언트에게 응답
//        Integer sessionTotalPrice = (Integer) session.getAttribute("sessionTotalPrice");
//
//        log.info("넘어온 session 가격값: {}", sessionTotalPrice);
//        log.info("iamport amount 값 {}", amount);
//
//        // 결제 검증로직
//        if(sessionTotalPrice != amount) {
//
//            String accessToken = refundService.getToken(apiKey, secretKey);
//            String reason = "치명적 데이터 변조";
//
//            // 결제 검증 후 데이터변조 발견 시 환불
//            try {
//                refundService.refundRequest(accessToken, merchantUid, reason);
//                log.info("결제 검증 실패로 인한 환불: 주문번호 {}", merchantUid);
//                response.setContentType("text/html; charset=UTF-8");
//                PrintWriter out = response.getWriter();
//                out.println("<script>alert('결제 데이터 변조로 인하여 초기 화면으로 되돌아갑니다.'); location.href='/';</script>");
//                out.flush();
//                return api.paymentByImpUid(imp_uid);
//            } catch (IOException e) {
//                log.error("환불 요청 실패: {}", e.getMessage());
//
//                // response로 알림창 넘겨주기
//                response.setContentType("text/html; charset=UTF-8");
//                PrintWriter out = response.getWriter();
//                out.println("<script>alert('환불에 실패했습니다. 관리자에게 문의바랍니다.'); location.href='/';</script>");
//                out.flush();
//                return api.paymentByImpUid(imp_uid);
//            }
//        }
//
//            return api.paymentByImpUid(imp_uid);
//    }


    /**
     * 
     * @param id
     * @param ra
     * @return
     * @throws IOException
     * 소비자 환불처리
     */
    @GetMapping("/refund.do")
    public String requestRefund(Integer id, RedirectAttributes ra) throws IOException {

        String accessToken = refundService.getToken(apiKey, secretKey);
        MyOrderVo myOrderVo = orderMapper.selectOneByMerchantUid(id);
        String merchantUid = myOrderVo.getMerchantId();
        String reason = "단순 변심";

        // 무통장입금으로 확인될 시에는 환불로직이 거치지 않고 결제취소 처리만 해줌
        String status = orderMapper.selectOneByStatus(id);

        if(status.equals("입금대기")) {
            int res = orderMapper.updateByRefund(id);
            
            // response로 알림창 넘겨주기
            ra.addFlashAttribute("message","결제가 정상적으로 취소되었습니다.");
            return "redirect:/";
        }

        try {
            refundService.refundRequest(accessToken, merchantUid, reason);
            log.info("환불 요청 성공: 주문번호 {}", merchantUid);
            // 결제 valid n 처리
            orderMapper.updateByRefund(id);

            // response로 알림창 넘겨주기
            ra.addFlashAttribute("message","환불이 성공적으로 처리되었습니다. 결제된 금액의 환불 정산에는 결제방식에 따라 최대 영업일 기준 1일 정도가 소모됩니다.");
        } catch (IOException e) {
            log.error("환불 요청 실패: {}", e.getMessage());
            ra.addFlashAttribute("error","환불이 성공적으로 처리되었습니다. 결제된 금액의 환불 정산에는 결제방식에 따라 최대 영업일 기준 1일 정도가 소모됩니다.");
        }
        return "redirect:/";
    }

    /**
     *
     * @param id
     * @return 관리자 페이지 : ajax로 돌려주는 값
     * @throws IOException
     * 관리자 환불처리
     */
    @PostMapping("/refundAdmin.do")
    @ResponseBody
    public int requestAdminRefund(Integer id) throws IOException {

        String accessToken = refundService.getToken(apiKey, secretKey);
        MyOrderVo myOrderVo = orderMapper.selectOneByMerchantUid(id);
        String merchantUid = myOrderVo.getMerchantId();
        String reason = "단순 변심";

        // 무통장입금으로 확인될 시에는 환불로직이 거치지 않고 결제취소 처리만 해줌
        String status = orderMapper.selectOneByStatus(id);

        refundService.refundRequest(accessToken, merchantUid, reason);
        log.info("환불 요청 성공: 주문번호 {}", merchantUid);
        // 결제 valid n 처리
        int res = orderMapper.updateByRefund(id);

        return res;
    }

//    @GetMapping("/refund.do")
//    public String requestRefund(Integer id, RedirectAttributes ra) throws IOException {
//
//        String accessToken = refundService.getToken(apiKey, secretKey);
//        MyOrderVo myOrderVo = orderMapper.selectOneByMerchantUid(id);
//        String merchantUid = myOrderVo.getMerchantId();
//        String reason = "단순 변심";
//
//        try {
//            refundService.refundRequest(accessToken, merchantUid, reason);
//            log.info("환불 요청 성공: 주문번호 {}", merchantUid);
//            // 결제 valid n 처리
//            orderMapper.updateByRefund(id);
//
//            // response로 알림창 넘겨주기
//            ra.addFlashAttribute("message","결제취소가 성공적으로 처리되었습니다. 결제된 금액의 환불 정산에는 결제방식에 따라 최대 영업일 기준 1일 정도가 소모됩니다.");
//        } catch (IOException e) {
//            log.error("환불 요청 실패: {}", e.getMessage());
//            ra.addFlashAttribute("error","결제취소가 실패했습니다..");
//        }
//        return "redirect:/";
//    }
}
