package com.githrd.figurium.product.controller;

import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.service.ProductsService;
import com.githrd.figurium.reviews.service.ReviewService;
import com.githrd.figurium.reviews.vo.ReviewVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ProductsController {

    private final ProductsService productsService;
    private final ReviewService reviewService;

    @Autowired
    public ProductsController(ProductsService productsService,
                              ReviewService reviewService) {
        this.productsService = productsService;
        this.reviewService = reviewService;
    }


    @RequestMapping("/productInfo.do")
    public String list(@RequestParam(value = "id" , required = false) Integer id,
                       Model model) {


        // 해상 상품에 해당하는 ID를 받아옴
        Products selectOne = productsService.getProductById(id);
        model.addAttribute("product", selectOne);

        // 해당 상품에 대한 ID 값을 이용해 리뷰의 리스트를 가져옴
        List<ReviewVo> reviewList = reviewService.reviewsByProductId(id);
        model.addAttribute("reviewList", reviewList);

        // 해당 상품에 대한 ID 값을 이용해 리뷰의 갯수를 가져옴
        int reviewCount = reviewService.reviewCountByProductId(id);
        model.addAttribute("reviewCount", reviewCount);

        return "products/productInfo";
    }

    @GetMapping("/productInsertForm.do")
    public String productInsertForm(){
        return "products/productInsertForm";
    }

}
