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
        return "qa/qaList";  // 이 이름이 JSP 파일과 일치해야 합니다.
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
        qaVo.setUserId(loginUser.getId()); // 로그인한 사용자의 ID를 사용
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
        return "qaSelect";
    }
}