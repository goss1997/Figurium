package com.githrd.figurium.qa.controller;

import com.githrd.figurium.common.page.CommonPage;
import com.githrd.figurium.common.page.Paging;
import com.githrd.figurium.common.page.ProductQaCommonPage;
import com.githrd.figurium.common.page.ProductQaPaging;
import com.githrd.figurium.common.session.SessionConstants;
import com.githrd.figurium.qa.dao.QaMapper;
import com.githrd.figurium.qa.service.QaService;
import com.githrd.figurium.qa.vo.QaVo;
import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/qa")
public class QaController {

    private final QaService qaService;
    private final HttpSession session;
    private final HttpServletRequest request;
    private final QaMapper qaMapper;

    @Autowired
    public QaController(QaService qaService, HttpSession session, HttpServletRequest request, QaMapper qaMapper) {
        this.qaService = qaService;
        this.session = session;
        this.request = request;
        this.qaMapper = qaMapper;
    }

    @GetMapping("/qaList.do")
    public String list(@RequestParam(name="page", defaultValue = "1")int nowPage,
                       Model model) {



            //검색조건을 담을 맵
            Map<String, Object> map = new HashMap<String, Object>();

            //start/end
            int start = (nowPage-1) * CommonPage.qaList.BLOCK_LIST + 1;
            int end   = start+CommonPage.qaList.BLOCK_LIST - 1;


            map.put("start", start);
            map.put("end", end);

            // 총게시물수
            int rowTotal = qaService.selectRowTotal(map);

            //pageMenu만들기
            String pageMenu = Paging.getPaging("qaList.do",
                    nowPage,
                    rowTotal,
                    CommonPage.qaList.BLOCK_LIST ,
                    CommonPage.qaList.BLOCK_PAGE);

            //-------[ End :  Page Menu ]------------------------

            // 결과적으로 request binding
            model.addAttribute("pageMenu", pageMenu);
            model.addAttribute("qaList", qaService.selectAllWithPagination(map));

        return "qa/qaList";
    }

    @GetMapping("/productQaList.do")
    public String getProductQaList(@RequestParam(name = "page", defaultValue = "1") int nowPage,
                                   @RequestParam(name = "productQaId", required = false) Integer productQaId, // Integer로 변경
                                   Model model) {

        // 검색조건을 담을 맵
        Map<String, Object> map = new HashMap<>();

        // start/end
        int start = (nowPage - 1) * ProductQaCommonPage.productQaList.BLOCK_LIST + 1;
        int end = start + ProductQaCommonPage.productQaList.BLOCK_LIST - 1;

        map.put("start", start);
        map.put("end", end);
        map.put("productQaId", productQaId);

        // 총게시물수
        int rowTotal = qaService.selectRowTotal(map);

        // pageMenu 만들기
        String pageMenu = ProductQaPaging.getPaging("productQaList.do",
                nowPage,
                rowTotal,
                ProductQaCommonPage.productQaList.BLOCK_LIST,
                ProductQaCommonPage.productQaList.BLOCK_PAGE);

        //-------[ End :  Page Menu ]------------------------

        // Q&A 목록을 가져오고 변수에 저장
        List<QaVo> productQaList = qaService.selectAllWithPagination(map);

        // 결과적으로 request binding
        model.addAttribute("pageMenu", pageMenu);
        model.addAttribute("productQaList", productQaList); // 수정된 부분
        model.addAttribute("productQaId", productQaId);

        // 디버깅을 위한 출력
        System.out.println("productQaList : " + productQaList);

        return "qa/productQaList";
    }

    //Q&A게시판에서 게시글 작성시
    @PostMapping("/qaInsert.do")
    public String insertForm(@RequestParam(value = "productId", required = false) Integer productId,
                             @RequestParam(value = "orderId", required = false) Integer orderId,
                             Model model) {
        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);
        // 로그인 상태를 확인
        if (loginUser == null) {
            session.setAttribute(SessionConstants.ALERT_MSG,"로그인 후 작성 가능합니다.");
            String referer = request.getHeader("Referer"); // Referer URL 가져오기

            return "redirect:" + referer;
        }
        model.addAttribute("productId", productId);
        model.addAttribute("orderId", orderId);
        // Referer 헤더 값 가져오기 / qa페이지 접근 / productInfo 접근 2가지 경우로 뒤로가기 시 이전페이지 이동진행시 필요
        String referer = request.getHeader("Referer");
        model.addAttribute("referer", referer);
        return "qa/qaInsert";
    }

    //Q&A게시판에서 게시글 작성시
    @PostMapping("/qaSave.do")
    public String save(@RequestParam("title") String title,
                       @RequestParam("content") String content,
                       @RequestParam("category") String category,
                       @RequestParam(value = "orderId", required = false) String orderId,
                       @RequestParam(value = "productId", required = false) String productId,
                       @RequestParam(value = "reply", required = false) String reply) {
        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);
        // 로그인 상태를 확인
        if (loginUser == null) {
            return "redirect:/";
        }

        // 카테고리와 제목을 처리하기 위한 코드 추가
        if (title != null && !title.startsWith("[" + category + "]")) {
            title = "[" + category + "] " + title;
        }
        QaVo qaVo = new QaVo();



        // User ID 처리
        if (loginUser.getId() != null) {
            // Integer 타입일 경우
            qaVo.setUserId(loginUser.getId());
        }


        // orderId 가져온 후 "" or null 일경우 확인 후 변경
        if (orderId != null && !orderId.isEmpty()) {
            // null or "" 가 아니라면 String -> int로 변환 후 set
            qaVo.setOrdersId(Integer.parseInt(orderId));
        } else {
            // null or "" 이라면  값을 넣는게 아닌 db에 null으로 기재
            qaVo.setOrdersId(null); // orderId가 빈 문자열이면 null로 설정
        }


        // productId 가져온 후 "" or null 일경우 확인 후 변경
        if (productId != null && !productId.isEmpty()) {
            // null or "" 가 아니라면 String -> int로 변환 후 set
            qaVo.setProductId(Integer.parseInt(productId));
        } else {
            // null or "" 이라면  값을 넣는게 아닌 db에 null으로 기재
            qaVo.setProductId(null); // orderId가 빈 문자열이면 null로 설정
        }

        qaVo.setTitle(title);
        qaVo.setContent(content);
        qaVo.setReply(reply);



        qaService.saveQa(qaVo);

        return "redirect:/qa/qaList.do";
    }

    

    @GetMapping("/qaSelect.do")
    public String select(@RequestParam("id") int id, Model model, RedirectAttributes redirectAttributes) {
        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);
        QaVo qaVo = qaService.getQaById(id);

        if (qaVo == null) {
            return "redirect:/qa/qaList.do"; // 게시글이 존재하지 않을 때
        }

        // 로그인하지 않은 상태에서 게시글을 클릭한 경우
        if (loginUser == null) {
            // 로그인 페이지로 리디렉션하며 메시지를 전달
            redirectAttributes.addFlashAttribute("alertMessage", "로그인 후 사용해 주세요.");
            return "redirect:/qa/qaList.do"; // 리스트페이지로 리다이렉트
        }


        // 관리자일 경우, 모든 게시글에 접근 가능
        if (loginUser != null && (loginUser.getRole() == 1 || qaVo.getUserId().equals(loginUser.getId()))) {
            model.addAttribute("qa", qaVo);
            return "qa/qaSelect";
        }

        // 관리자도 아니고, 작성자와 다를 경우
        if (loginUser != null && !qaVo.getUserId().equals(loginUser.getId())) {
            redirectAttributes.addFlashAttribute("message", "다른 사용자의 게시글입니다.");
            return "redirect:/qa/qaList.do"; // 경고 메시지와 함께 목록 페이지로 이동
        }

        // 로그인하지 않았거나, 작성자와 같을 경우
        model.addAttribute("qa", qaVo);
        return "qa/qaSelect";
    }


    @PostMapping("/qaReplySave.do")
    public String saveReply(@RequestParam("id") int id,
                            @RequestParam("content") String content) {
        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);
        if (loginUser == null) {
            return "redirect:/";
        }

        QaVo qaVo = qaService.getQaById(id);
        qaVo.setReply(content); // 답변 설정
        qaVo.setReplyStatus("답변완료"); // 상태 업데이트
        qaService.updateQa(qaVo);

        return "redirect:/qa/qaSelect.do?id=" + id;
    }

    @PostMapping("/qaReplyDelete.do")
    public String deleteReply(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);
        if (loginUser == null || loginUser.getRole() != 1) {
            return "redirect:/";
        }
        qaService.deleteReply(id);
        // 게시글 상세 페이지로 리다이렉트
        return "redirect:/qa/qaSelect.do?id=" + id;
    }

    @PostMapping("/qaDelete.do")
    public String delete(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
        qaService.deleteQa(id);
        return "redirect:/qa/qaList.do";
    }
    // 만약 GET 요청을 처리하려면:
    @RequestMapping(value = "/qaDelete.do", method = RequestMethod.GET)
    public String deleteQaGet(@RequestParam("id") int id) {
        // GET 요청으로 삭제 로직
        return "redirect:/qa/qaList.do";
    }



}