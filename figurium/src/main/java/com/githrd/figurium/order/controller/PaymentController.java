package com.githrd.figurium.order.controller;

import com.githrd.figurium.order.dao.OrderMapper;
import com.githrd.figurium.order.service.PaymentService;
import com.githrd.figurium.order.service.RefundService;
import com.githrd.figurium.order.vo.MyOrderVo;
import com.githrd.figurium.product.dao.ProductsMapper;
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
    private final ProductsMapper productsMapper;
    // iamport를 사용하기 위해서 api를 불러온다.

    @Value("${imp.api.key}")
    private String apiKey;

    @Value("${imp.api.secretkey}")
    private String secretKey;

    private final RefundService refundService;

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

            // 상품 재고 그대로 다시 추가
            paymentService.refundPlusQuantity(id);

            // response로 알림창 넘겨주기
            ra.addFlashAttribute("message","결제가 정상적으로 취소되었습니다.");
            return "redirect:/";
        }

        try {
            refundService.refundRequest(accessToken, merchantUid, reason);
            log.info("환불 요청 성공: 주문번호 {}", merchantUid);
            // 결제 valid n 처리
            orderMapper.updateByRefund(id);

            // 상품 재고 그대로 다시 추가
            paymentService.refundPlusQuantity(id);

            // response로 알림창 넘겨주기
            ra.addFlashAttribute("message","환불이 성공적으로 처리되었습니다. 결제된 금액의 환불 정산에는 결제방식에 따라 최대 영업일 기준 1일 정도가 소모됩니다.");
        } catch (IOException e) {
            log.error("환불 요청 실패: {}", e.getMessage());
            ra.addFlashAttribute("error","환불이 실패하였습니다. 관리자에게 문의해주시길 바랍니다.");
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

        // 상품 재고 그대로 다시 추가
        paymentService.refundPlusQuantity(id);

        refundService.refundRequest(accessToken, merchantUid, reason);
        log.info("환불 요청 성공: 주문번호 {}", merchantUid);
        // 결제 valid n 처리
        int res = orderMapper.updateByRefund(id);

        return res;
    }

}
