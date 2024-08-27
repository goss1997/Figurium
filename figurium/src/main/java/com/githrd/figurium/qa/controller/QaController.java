package com.githrd.figurium.qa.controller;

import com.githrd.figurium.qa.entity.QaEntity;
import com.githrd.figurium.qa.repository.QaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

//홈화면 배너에서 (Q&A를 클릭할시)
@Controller
public class QaController {
    private final QaRepository qaRepository;

    @Autowired
    QaController(QaRepository qaRepository) {

        this.qaRepository = qaRepository;
    }

    @GetMapping("/qa/list.do")
    public String qaList(Model model) {

        List<QaEntity> qaList = qaRepository.findAll();
        model.addAttribute("qaList", qaList);

        return "qa/QaList";
    }

    @GetMapping("/qa/QaInsert.do")
    public String insert() {

        return "qa/QaInsert";
    }
}



