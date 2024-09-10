package com.githrd.figurium.home.controller;

import com.githrd.figurium.product.dao.ProductsMapper;
import com.githrd.figurium.product.entity.Category;
import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.repository.CategoriesRepository;
import com.githrd.figurium.product.repository.ProductRepository;
import com.githrd.figurium.product.service.ProductsService;
import com.githrd.figurium.product.vo.ProductsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class HomeController {

    private final ProductRepository productRepository;
    private final CategoriesRepository categoriesRepository;
    private final ProductsService productsService;

    @Autowired
    HomeController(ProductRepository productRepository,
                   CategoriesRepository categoriesRepository,  ProductsService productsService) {
        this.productRepository = productRepository;
        this.categoriesRepository = categoriesRepository;
        this.productsService = productsService;
    }

    @GetMapping("/")
    public String home(Model model) {
        // 페이지 초기 로딩 시, 첫 페이지 로드
        Pageable pageable = PageRequest.of(0, 40, Sort.by(Sort.Order.desc("createdAt"), Sort.Order.asc("id")));
        Page<Products> productsPage = productRepository.findProductsWithPagination(pageable);
        List<Category> categoriesList = categoriesRepository.findAll();
        model.addAttribute("productsList", productsPage.getContent());
        model.addAttribute("categoriesList", categoriesList);


        return "home";
    }


    @GetMapping("/load-more-products")
    public ResponseEntity<?> loadMoreProducts(
            @RequestParam(value = "lastCreatedAt", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime lastCreatedAt,
            @RequestParam(value = "lastId", required = false) Integer lastId) {

        int pageSize = 20;
        Pageable pageable;
        if (lastCreatedAt != null) {
            // `lastCreatedAt` 및 `lastId`을 기준으로 페이지 요청
            pageable = PageRequest.of(0, pageSize, Sort.by(Sort.Order.desc("createdAt"), Sort.Order.asc("id")));
            // lastCreatedAt 이전의 상품을 가져오기
            Page<Products> productsPage = productRepository.findByCreatedAtBeforeAndIdLessThan(lastCreatedAt, lastId, pageable);
            return buildResponse(productsPage);
        } else {
            // 첫 페이지 로딩 시
            pageable = PageRequest.of(1, pageSize, Sort.by(Sort.Order.desc("createdAt"), Sort.Order.asc("id")));
            Page<Products> productsPage = productRepository.findProductsWithPagination(pageable);
            return buildResponse(productsPage);
        }
    }

    private ResponseEntity<?> buildResponse(Page<Products> productsPage) {
        Map<String, Object> response = new HashMap<>();
        response.put("products", productsPage.getContent()); // 현재 페이지의 상품 목록
        response.put("hasNext", productsPage.hasNext()); // 다음 페이지가 있는지 여부
        return ResponseEntity.ok(response);
    }





}
