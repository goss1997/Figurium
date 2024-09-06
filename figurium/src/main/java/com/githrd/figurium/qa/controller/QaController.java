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