package com.githrd.figurium.reviews.controller;

import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.service.ProductsService;
import com.githrd.figurium.reviews.dao.ReviewDao;
import com.githrd.figurium.reviews.service.ReviewService;
import com.githrd.figurium.reviews.vo.ReviewVo;
import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.util.S3ImageService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ReviewsController {

    private final ReviewService reviewService;      // Service를 주입받음
    private final HttpServletRequest request;
    private final HttpSession session;
    private final S3ImageService s3ImageService;    // S3를 구현한 인터페이스를 주입
    private final ProductsService productsService;

    // Constructor Injection
    @Autowired
    ReviewsController(ReviewService reviewService,
                      HttpServletRequest request,
                      HttpSession session,
                      S3ImageService s3ImageService,
                      ProductsService productsService) {
        this.reviewService = reviewService;
        this.request = request;
        this.session = session;
        this.s3ImageService = s3ImageService;
        this.productsService = productsService;
    }






    // 리뷰 작성 폼 이동
    @RequestMapping("/reviewInsertForm.do")
    public String reviewInsert(RedirectAttributes ra,
                               @RequestParam(value = "productId") Integer productId,
                               Model model) {

        model.addAttribute("productId", productId);

        return "reviews/reviewInsertForm";
    }




    /*
    * 리뷰 작성 로직
    */
    @PostMapping("/sendReview.do")
    public String sendReview(ReviewVo reviewVo,
                             // 매핑 에러를 피하기 위해 param명을 view에서 다르게 주어서 받아온다.
                             @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                             HttpSession session,
                             RedirectAttributes ra) {

        User user = (User) session.getAttribute("loginUser");

        if (user == null) {
            ra.addAttribute("reason", "not_session");
            return "redirect:/";
        }

        // 이미지 업로드 처리 로직
        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                // S3에 파일 업로드
                String s3ImgUrl = s3ImageService.uploadS3(imageFile);
                // view에서 설정한 param명을 받아와서 imageUrl에 넣어준다.
                reviewVo.setImageUrl(s3ImgUrl); // 업로드된 이미지의 URL을 reviewVo에 설정
            } catch (Exception e) {
                ra.addAttribute("reason", "image_upload_failed");
                return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
            }
        } else {
            // 이미지가 없을 경우 빈 문자열 처리
            reviewVo.setImageUrl(""); // imageUrl 필드가 문자열이므로 빈 값으로 처리합니다.
        }

        // 공백 전환
        String content = reviewVo.getContent().replaceAll("\n", "<br>");
        reviewVo.setContent(content);

        // 리뷰 저장
        int success = reviewService.insertReview(reviewVo);

        if (success > 0) {
            return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
        } else {
            ra.addAttribute("reason", "review_insert_failed");
            return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
        }
    }







    // 리뷰 1건에 해당하는 리뷰를 조회
    @RequestMapping("/getReviewContent")
    @ResponseBody
    public Map<String, Object> getReviewContent(@RequestParam("id") int id) {
        ReviewVo review = reviewService.getReviewById(id);
        Map<String, Object> result = new HashMap<>();
        result.put("content", review.getContent());
        result.put("imageUrl", review.getImageUrl());
        return result;
    }


}
