package com.githrd.figurium.qa.controller;

import com.githrd.figurium.qa.service.QaService;
import com.githrd.figurium.qa.vo.QaVo;
import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/qa")
public class QaController {

    @Autowired
    private QaService qaService;

    @Autowired
    private HttpSession session;

    @GetMapping("/qaList.do")
    public String list(Model model) {
        model.addAttribute("qaList", qaService.getAllQa());
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
                       @RequestParam(value = "reply", required = false) String reply) {
        User loginUser = (User) session.getAttribute("loginUser");
        // 로그인 상태를 확인
        if (loginUser == null) {
            return "redirect:/";
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
    public String select(@RequestParam("id") int id, Model model) {
        QaVo qaVo = qaService.getQaById(id);
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


    // 게시글 삭제 메서드 추가
    @GetMapping("/qaDelete.do")
    public String delete(@RequestParam("id") int id) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/";
        }

        // 게시글 삭제
        qaService.deleteQa(id);

        return "redirect:/qa/qaList.do";
    }
}