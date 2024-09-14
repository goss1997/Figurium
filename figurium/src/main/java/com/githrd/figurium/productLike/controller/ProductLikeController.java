package com.githrd.figurium.productLike.controller;

import com.githrd.figurium.productLike.service.ProductLikeService;
import com.githrd.figurium.productLike.vo.ProductLikeVo;
import com.githrd.figurium.user.entity.User;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/productLike/")
public class ProductLikeController {

    private static final Logger log = LoggerFactory.getLogger(ProductLikeController.class);
    private final ProductLikeService productLikeService;
    private final HttpSession session;

    @Autowired
    public ProductLikeController(ProductLikeService productLikeService, HttpSession session) {
        this.productLikeService = productLikeService;
        this.session = session;
    }

    @PostMapping("toggle")
    public int toggleProductLike(@RequestBody ProductLikeVo productLikeVo) {
        return productLikeService.toggleProductLike(productLikeVo);
    }

    @PostMapping("/deleteProductLike.do")
    public int deleteProductLike(ProductLikeVo productLikeVo) {

        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            return 0;
        }
        else{
            productLikeVo.setUserId(loginUser.getId());
        }

        return productLikeService.deleteProductLike(productLikeVo);
    }

}
