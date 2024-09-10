package com.githrd.figurium.product.controller;

import com.githrd.figurium.product.entity.Category;
import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.repository.CategoriesRepository;
import com.githrd.figurium.product.service.ProductsService;
import com.githrd.figurium.product.vo.ProductsVo;
import com.githrd.figurium.productLike.service.ProductLikeService;
import com.githrd.figurium.qa.dao.QaMapper;
import com.githrd.figurium.qa.vo.QaVo;
import com.githrd.figurium.reviews.service.ReviewService;
import com.githrd.figurium.reviews.vo.ReviewVo;
import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.util.page.CommonPage;
import com.githrd.figurium.util.page.Paging;
import com.githrd.figurium.util.page.ProductQaCommonPage;
import com.githrd.figurium.util.s3.S3ImageService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class ProductsController {

    private final ProductsService productsService;
    private final ReviewService reviewService;
    private final CategoriesRepository categoriesRepository;
    private final HttpSession session;
    private final ProductLikeService productLikeService;
    private final S3ImageService s3ImageService;
    private final QaMapper qaMapper;


    @GetMapping("/productList.do")
    public String productList(@RequestParam(defaultValue = "all") String selectFilter,
                              @RequestParam(value = "name") String categoryName,
                              Model model) {
        
        // filter와 name을 같이 받아오기 위해 맵에다가 저장
        Map<String,Object> params = new HashMap<>();
        params.put("selectFilter",selectFilter);
        params.put("categoryName",categoryName);

        List<ProductsVo> productCategoriesList = productsService.categoriesList(params);
        model.addAttribute("productCategoriesList", productCategoriesList);
        model.addAttribute("categoryName", categoryName); // 필터 처리를 위해 모델에 담음
        model.addAttribute("selectFilter", selectFilter); // 현재 필터링 된 option을 보여주기 위해 모델에 담음
        return "products/productCategories";
    }

    /**
     * No Offset 페이징 처리
     */
    @GetMapping("/load-more-products")
    @ResponseBody
    public List<ProductsVo> loadMoreProducts(
            @RequestParam(value = "lastCreatedAt", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") LocalDateTime lastCreatedAt,
            @RequestParam(value = "lastId", required = false) Integer lastId) {

        List<ProductsVo> nexProductList = productsService.getNextPageByCreatedAt(lastCreatedAt, lastId);

        return nexProductList;

    }



    @RequestMapping("/productInfo.do")
    public String list(@RequestParam(value = "id" , required = false) Integer id,
                       @RequestParam(value = "page", defaultValue = "1") int page,
                       HttpSession session,
                       Model model, Map map) {

        // 해상 상품에 해당하는 ID를 받아옴
        Products selectOne = productsService.getProductById(id);
        model.addAttribute("product", selectOne);

        // 페이지 설정
        int pageSize = 5;
        int offset = (page - 1) * pageSize;


        // 리뷰 리스트 및 리뷰 개수 가져오기
        List<ReviewVo> reviewList = reviewService.getReviewsWithPagination(id, offset, pageSize);
        model.addAttribute("reviewList", reviewList);


        // 해당 상품에 대한 ID 값을 이용해 리뷰의 갯수를 가져옴
        int reviewCount = reviewService.reviewCountByProductId(id);
        model.addAttribute("reviewCount", reviewCount);

        // 페이지 관련 정보 설정
        int totalPages = (int) Math.ceil((double) reviewCount / pageSize);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);


        // 해당 상품의 평균 별점 가져오기
        int ratingAvg = reviewService.reviewRatingAvg(id);
        model.addAttribute("ratingAvg", ratingAvg);

        // 세션에서 사용자 정보 가져오기
        User user = (User) session.getAttribute("loginUser");
        if (user != null) {
            boolean isLiked = productLikeService.isProductLikedByUser(id, user.getId());
            model.addAttribute("isLiked", isLiked);
        } else {
            model.addAttribute("isLiked", false);
        }


        // Q&A 리스트와 관련된 페이징 설정
        // Q&A 관련 정보 설정
        Map<String, Object> qaMap = new HashMap<>();
        int qaStart = (page - 1) * ProductQaCommonPage.productQaList.BLOCK_LIST + 1;
        int qaEnd = qaStart + ProductQaCommonPage.productQaList.BLOCK_LIST - 1;

        qaMap.put("start", qaStart);
        qaMap.put("end", qaEnd);
        qaMap.put("productId", id);

        List<QaVo> productQaList = qaMapper.selectAllWithPagination(qaMap);
        int productQaCount = qaMapper.getProductQaCount(id);

        String qaPageMenu = Paging.getPaging("productInfo.do",
                page,
                productQaCount,
                CommonPage.qaList.BLOCK_LIST,
                CommonPage.qaList.BLOCK_PAGE);

        model.addAttribute("qaPageMenu", qaPageMenu);
        model.addAttribute("productQaList", productQaList);
        model.addAttribute("productQaCount", productQaCount);

        return "products/productInfo";
    }

    @GetMapping("/productInsertForm.do")
    public String productInsertForm(Model model){

        User loginUser = (User) session.getAttribute("loginUser");

        if(loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg","관리자만 접속이 가능합니다.");
            return "redirect:/";
        }

        List<Category> categoriesList = categoriesRepository.findAll();
        model.addAttribute("categoriesList", categoriesList);

        return "products/productInsertForm";
    }

    @RequestMapping("/productInsert.do")
    public String productInsert(ProductsVo products, @RequestParam MultipartFile productImage) {



        String save;
        if(productImage.isEmpty()){

            products.setImageUrl("/resources/images/noImage1.png");

            int res = productsService.productSave(products);

            if (res > 0) {
                System.out.println("저장실패");
                return "redirect:/"; // 저장 실패 시 리다이렉션
            } else {
                System.out.println("등록성공");
                return "redirect:/"; // 저장 성공 시 리다이렉션
            }

        }

        save = productsService.ImageSave(products, productImage);
        if (save == null) {
            System.out.println("저장실패");
            return "redirect:/"; // 저장 실패 시 리다이렉션
        } else {
            System.out.println("등록성공");
            return "redirect:/"; // 저장 성공 시 리다이렉션
        }
    }



    @RequestMapping("/productModifyForm.do")
    public String productModifyForm(@RequestParam(value = "id" , required = false) Integer id,
                                    Model model) {

        User loginUser = (User) session.getAttribute("loginUser");

        if(loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg","관리자만 접속이 가능합니다.");
            return "redirect:/";
        }

        // 해상 상품에 해당하는 ID를 받아옴
        Products selectOne = productsService.getProductById(id);
        List<Category> categoriesList = categoriesRepository.findAll();
        model.addAttribute("product", selectOne);
        model.addAttribute("categoriesList", categoriesList);

        return "products/productModifyForm";
    }

    @RequestMapping("/productModify.do")
    public String productModify(ProductsVo products, @RequestParam MultipartFile productImage) {




        Products productById = productsService.getProductById(products.getId());
        String oldImageUrl = productById.getImageUrl();
        products.setImageUrl(oldImageUrl);



        int save = productsService.updateProductsImage(products, productImage);

        if (save == 0) {
            System.out.println("저장실패");
            return "redirect:/"; // 저장 실패 시 리다이렉션
        } else {
            System.out.println("등록성공");
            return "redirect:/productInfo.do?id=" + products.getId(); // 저장 성공 시 리다이렉션
        }


    }


    @DeleteMapping("/product/{id}")
    public Object productDeleteById(@PathVariable int id){

        User loginUser = (User) session.getAttribute("loginUser");

        if(loginUser == null || loginUser.getRole() != 1) {
            session.setAttribute("alertMsg","관리자만 접속이 가능합니다.");
            return "redirect:/";
        }

        Products selectOne = productsService.getProductById(id);
        String imageUrl = selectOne.getImageUrl();

        s3ImageService.deleteImageFromS3(imageUrl);


        productsService.deleteById(id);

        return ResponseEntity.noContent().build();

    }


}


