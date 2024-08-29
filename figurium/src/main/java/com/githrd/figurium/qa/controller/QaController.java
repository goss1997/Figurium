package com.githrd.figurium.qa.controller;

import com.githrd.figurium.qa.service.QaService;
import com.githrd.figurium.qa.vo.QaVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/qa")
public class QaController {

    @Autowired
    private QaService qaService;

    @GetMapping("/QaList.do")
    public String getAllQas(Model model) {
        List<QaVo> qaList = qaService.getAllQas();
        model.addAttribute("qaList", qaList);
        return "qaList";  // qaList.jsp
    }

    @GetMapping("/QaInsert.do")
    public String showQaInsertForm() {
        return "qaInsert";  // qaInsert.jsp
    }

    @PostMapping("/QaSave.do")
    public String saveQa(@ModelAttribute QaVo qa) {
        if (qa.getTitle() == null || qa.getContent() == null) {
            return "redirect:/qa/QaInsert.do";  // 유효성 검사 실패 시 폼으로 리다이렉트
        }
        qaService.createQa(qa);
        return "redirect:/qa/QaList.do";  // 저장 후 목록 페이지로 리다이렉트
    }

    @GetMapping("/QaSelect.do")
    public String viewQa(@RequestParam Integer id, Model model) {
        QaVo qa = qaService.getQaById(id);
        if (qa == null) {
            return "error";  // 에러 페이지로 이동 (찾을 수 없는 경우)
        }
        model.addAttribute("qa", qa);
        return "qaSelect";  // qaSelect.jsp
    }

    @PostMapping("/QaUpdate.do")
    public String updateQa(@ModelAttribute QaVo qa) {
        if (qa.getId() == null) {
            return "redirect:/qa/QaList.do";  // 유효성 검사 실패 시 목록 페이지로 리다이렉트
        }
        qaService.updateQa(qa);
        return "redirect:/qa/QaList.do";  // 업데이트 후 목록 페이지로 리다이렉트
    }

    @GetMapping("/QaDelete.do")
    public String deleteQa(@RequestParam Integer id) {
        qaService.deleteQa(id);
        return "redirect:/qa/QaList.do";  // 삭제 후 목록 페이지로 리다이렉트
    }
}
