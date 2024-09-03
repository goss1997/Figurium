package com.githrd.figurium.reviews.controller;

import com.githrd.figurium.product.service.ProductsService;
import com.githrd.figurium.reviews.service.ReviewService;
import com.githrd.figurium.reviews.vo.ReviewVo;
import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.util.s3.S3ImageService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
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

        User loginUser = (User) session.getAttribute("loginUser");

        if(loginUser == null) {
            return "redirect:/";
        }


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

        // 현재 세션에 있는 유저의 id 값을 저장함
        reviewVo.setUserId(user.getId());

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

        System.out.println(reviewVo.getUserId());
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
    public Map<String, Object> getReviewContent(@RequestParam("id") int id, HttpSession session) {

        User user = (User) session.getAttribute("loginUser"); // 세션에서 현재 로그인한 사용자 가져오기

        ReviewVo review = reviewService.getReviewById(id); // 리뷰 ID로 리뷰 조회
        Map<String, Object> result = new HashMap<>();
        result.put("content", review.getContent()); // 리뷰 내용
        result.put("imageUrl", review.getImageUrl()); // 리뷰 이미지 URL
        result.put("reviewUserId", review.getUserId()); // 리뷰 작성자의 ID
        return result;
    }


    // 리뷰 수정 폼 이동
    @RequestMapping("/reviewUpdateForm.do")
    public String reviewUpdateForm(@RequestParam(value = "id") int id,
                                   Model model) {

        // 로그인 유저 검증
        User loginUser = (User) session.getAttribute("loginUser");

        if(loginUser == null) {
            return "redirect:/";
        }

        ReviewVo review = reviewService.getReviewById(id);
        model.addAttribute("review", review);

        System.out.println("Rating from database: " + review.getRating());

        return "reviews/reviewUpdateForm";
    }


    // 리뷰수정
    @RequestMapping("/reviewUpdate.do")
    public String reviewUpdate(ReviewVo reviewVo,
                               @RequestParam("imageFile") MultipartFile imageFile,
                               @RequestParam(value = "userId") int userId,
                               HttpSession session,
                               RedirectAttributes ra) {

        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            ra.addAttribute("reason", "not_session");
            return "redirect:/";
        }

        // 해당 리뷰의 이미지가 존재하는지 확인
        String imageUrl = reviewService.selectImageUrl(reviewVo.getId());
        // 존재하면 해당 이미지 삭제
        if (imageUrl != null && !imageUrl.isEmpty()) {
            s3ImageService.deleteImageFromS3(imageUrl);
        }

        // 업로드 시 이미지를 넣었을 경우 실행
        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                String s3ImgUrl = s3ImageService.uploadS3(imageFile);
                reviewVo.setImageUrl(s3ImgUrl);
            } catch (Exception e) {
                ra.addAttribute("reason", "image_upload_failed");
                // 이미지 업로드 실패 시 기존 이미지 유지
                reviewVo.setImageUrl(imageUrl);
                System.out.println(e.getMessage());
            }
        }else { // 이미지를 넣지 않았을 경우 유지 할 지 공백으로 할지 생각중
            reviewVo.setImageUrl("");
        }

        // 공백 전환
        String content = reviewVo.getContent().replaceAll("\n", "<br>");
        reviewVo.setContent(content);

        System.out.println("productId = " + reviewVo.getProductId());
        System.out.println("userId = " + reviewVo.getUserId());

        try {
            int success = reviewService.updateReview(reviewVo);
            // 성공 시
            if (success > 0) {
                return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
            } else {
                ra.addAttribute("reason", "review_update_failed");
                return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
            }
        } catch (Exception e) {
            ra.addAttribute("reason", "review_update_failed");
            System.out.println("Review update failed: " + e.getMessage());
            return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
        }
    }


    // 리뷰 삭제
    @RequestMapping("/reviewDelete.do")
    public String reviewDelete(ReviewVo reviewVo,
                               RedirectAttributes ra) {

        // 로그인한 사용자 확인
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/"; // 로그인되지 않은 경우 메인 페이지로 리다이렉트
        }


        // 해당 리뷰의 이미지가 존재하는지 확인
        String imageUrl = reviewService.selectImageUrl(reviewVo.getId());
        // 존재하면 해당 이미지 삭제
        if (imageUrl != null && !imageUrl.isEmpty()) {
            try {
                s3ImageService.deleteImageFromS3(imageUrl);
            } catch (Exception e) {
                ra.addAttribute("reason", "image_delete_failed");
                System.out.println("Image deletion failed: " + e.getMessage());
                return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
            }
        }

        // 리뷰 삭제 로직
        try {
            int success = reviewService.deleteReview(reviewVo);
            if (success > 0) {
                return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
            } else {
                ra.addAttribute("reason", "review_delete_failed");
                return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
            }
        } catch (Exception e) {
            ra.addAttribute("reason", "review_delete_failed");
            System.out.println("Review deletion failed: " + e.getMessage());
            return "redirect:/productInfo.do?id=" + reviewVo.getProductId();
        }
    }



}

