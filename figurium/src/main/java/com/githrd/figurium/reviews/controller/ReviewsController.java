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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

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
                               @RequestParam(value = "productId") Integer id,
                               Model model) {
        Products selectOne = productsService.getProductById(id);
        model.addAttribute("productId", id);

        return "reviews/reviewInsertForm";
    }



    /*
    * 리뷰 작성 로직
    */
    @PostMapping("/sendReview.do")
    public String sendReview(ReviewVo reviewVo,
                             MultipartFile imageUrl,
                             HttpSession session,
                             RedirectAttributes ra) {

        User user = (User) session.getAttribute("loginUser"); // 현제 로그인한 유저의 세션을 가져옴

        // 현재 로그인 정보가 비어 있으면 처리
        if (user == null) {
            ra.addAttribute("reason","not_session");
            return "redirect:../";
        }

        // 이미지 업로드 처리 로직
        if (imageUrl != null && !imageUrl.isEmpty()) { // 이미지가 업로드되었을 경우

            try {
                String s3ImgUrl = s3ImageService.uploadS3(imageUrl);
                reviewVo.setImageUrl(s3ImgUrl); // 업로드된 이미지의 URL을 reviewVo에 설정

            } catch (Exception e) { // 업로드 실패시 처리
                ra.addAttribute("reason", "image_upload_failed");
                return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
            }


        } else {
            // 이미지는 선택 사항 이므로 만약에 이미지를 넣고 싶지 않으면 null이거나 공백을 빈 문자열로 처리하는 로직
            reviewVo.setImageUrl("");
        }

        // 성공시 숫자 1을 반환
        int success = reviewService.insertReview(reviewVo);

        // 성공시와 실패시 처리 로직
        if(success > 0) {
            return "redirect:/productInfo.do?id=" + reviewVo.getProductId();

        } else {
            ra.addAttribute("reason","review_insert_failed");
            return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
        }


    }


}
