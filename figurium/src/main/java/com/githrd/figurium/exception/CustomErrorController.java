package com.githrd.figurium.exception;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError() {
        // 에러 페이지를 반환
        return "errorPage/error"; // /WEB-INF/views/errorPage/error.jsp 파일로 매핑됩니다.
    }

}
