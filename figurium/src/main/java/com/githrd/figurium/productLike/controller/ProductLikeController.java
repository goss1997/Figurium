package com.githrd.figurium.productLike.controller;

import com.githrd.figurium.productLike.service.ProductLikeService;
import com.githrd.figurium.productLike.vo.ProductLikeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/productLike/")
public class ProductLikeController {

    private final ProductLikeService productLikeService;

    @Autowired
    public ProductLikeController(ProductLikeService productLikeService) {
        this.productLikeService = productLikeService;
    }

    @PostMapping("toggle")
    public int toggleProductLike(@RequestBody ProductLikeVo productLikeVo) {
        return productLikeService.toggleProductLike(productLikeVo);
    }

}
