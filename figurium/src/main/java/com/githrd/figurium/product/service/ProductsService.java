package com.githrd.figurium.product.service;

import com.githrd.figurium.product.dao.ProductsMapper;
import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.repository.ProductRepository;
import com.githrd.figurium.product.vo.ProductsVo;
import com.githrd.figurium.util.s3.S3ImageService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@Service

public class ProductsService {

    private final ProductRepository productRepository;
    private final S3ImageService s3ImageService;
    private final ProductsMapper productsMapper;



    @Autowired
    ProductsService(ProductRepository productRepository, S3ImageService s3ImageService, ProductsMapper productsMapper) {
        this.productRepository = productRepository;
        this.s3ImageService = s3ImageService;
        this.productsMapper = productsMapper;
    }



    public Products getProductById(int id) {
        return productRepository.findById(id);
    }


    @Transactional
    public String ImageSave(ProductsVo products, MultipartFile productImage) {

        // s3에 해당 이미지 업로드 후  set하고 db에 저장하기.
        if(!productImage.isEmpty()) {
            String profileImgUrl = s3ImageService.uploadS3(productImage);
            products.setImageUrl(profileImgUrl);
            int result = productsMapper.productInsert(products);

            if(result > 0){
                return "/";
            }
        }


        return "";
    }

    // 업로드된 프로필 이미지 수정
    public int updateProductsImage(ProductsVo products, MultipartFile productImage) {
        return 0;
    }

    public void deleteById(int id) {
        if (productRepository.existsById(id)) {
            productRepository.deleteById(id);
        } else {
            throw new EntityNotFoundException("Entity with id " + id + " not found");
        }
    }


    public int productSave(ProductsVo products) {
        return productsMapper.productInsert(products);
    }


    // 상품 카테고리 리스트의 동적 쿼리
    public List<ProductsVo> categoriesList(Map<String,Object> params ,int page, int pageSize){
        return productsMapper.categoriesList(params);
    }
    // 상품 카테고리의 페이징 처리를 위한 갯수 가져오기
    public int categoriesProductsCount(Map<String,Object> params){
        return productsMapper.categoriesProductsCount(params);
    }
    // 검색 상품의 동적쿼리
    public List<ProductsVo> searchProductsList(Map<String,Object> params, int page, int pageSize){
        return productsMapper.searchProductsList(params);
    }
    // 검색 상품의 페이지 처리를 위한 갯수
    public int searchProductCount(Map<String, Object> params) {
        return productsMapper.searchProductsCount(params);
    }
    // 검색 상품의 히스토리 저장
    public int searchProductsNameHistory(String search){
        return productsMapper.searchProductsNameHistory(search);
    }



    public List<ProductsVo> getNextPageByCreatedAt(Map<String,Object> params) {
        return productsMapper.getNextPageByCreatedAt(params);
    }

}
