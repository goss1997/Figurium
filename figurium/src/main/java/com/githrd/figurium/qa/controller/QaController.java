package com.githrd.figurium.qa.controller;

import com.githrd.figurium.qa.service.QaService;
import com.githrd.figurium.qa.vo.QaVo;
import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.util.page.CommonPage;
import com.githrd.figurium.util.page.Paging;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/qa")
public class QaController {

    private final QaService qaService;
    private final HttpSession session;

    @Autowired
    public QaController(QaService qaService, HttpSession session) {
        this.qaService = qaService;
        this.session = session;
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



    @GetMapping("/qaInsert.do")
    public String insertForm(Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        // 로그인 상태를 확인
        if (loginUser == null) {
            return "redirect:/";
        }
        return "qa/qaInsert";
    }

    @PostMapping("/qaSave.do")
    public String save(@RequestParam("title") String title,
                       @RequestParam("content") String content,
                       @RequestParam("category") String category,
                       @RequestParam(value = "reply", required = false) String reply) {
        User loginUser = (User) session.getAttribute("loginUser");
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

        qaVo.setTitle(title);
        qaVo.setContent(content);
        qaVo.setReply(reply);
        qaService.saveQa(qaVo);

        return "redirect:/qa/qaList.do";
    }

    @GetMapping("/qaSelect.do")
    public String select(@RequestParam("id") int id, Model model, RedirectAttributes redirectAttributes) {
        User loginUser = (User) session.getAttribute("loginUser");
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
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/";
        }

        QaVo qaVo = qaService.getQaById(id);
        qaVo.setReply(content); // 답변 설정
        qaVo.setReplyStatus("답변완료"); // 상태 업데이트
        qaService.updateQa(qaVo);

        return "redirect:/qa/qaSelect.do?id=" + id;
    }

    @PostMapping("/qaDelete.do")
    public String delete(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
        qaService.deleteQa(id);
        redirectAttributes.addFlashAttribute("msg", "게시글이 삭제되었습니다.");
        return "redirect:/qa/qaList.do";
    }

    @PostMapping("/qaReplyDelete.do")
    public String deleteReply(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
        qaService.deleteReply(id);
        redirectAttributes.addFlashAttribute("msg", "답변이 삭제되었습니다.");
        return "redirect:/qa/qaSelect.do";
    }



}