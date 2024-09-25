package com.githrd.figurium.product.dao;

import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.vo.ProductsVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ProductsMapper {

    ProductsVo selectOneGetName(int productId);
    ProductsVo selectOneCheckProduct(int productId, int itemQuantity);
    int updateProductQuantity(int productId, int itemQuantity);
    int productInsert(ProductsVo vo);
    int productDeleteUpdate(Products vo);

    // 카테고리 리스트의 필터 처리
    List<ProductsVo> categoriesList(Map<String,Object> params);
    // 카테고리의 페이징 처리를 위해 갯수 가져오기
    int categoriesProductsCount(Map<String, Object> params);
    // 검색 상품 리스트의 필터 처리
    List<ProductsVo> searchProductsList(Map<String,Object> params);
    // 검색 상품의 페이징 처리를 위해 갯수 구하기
    int searchProductsCount(Map<String,Object> params);
    // 상품을 검색 했을 때 검색 히스토리를 저장
    int searchProductsNameHistory(String search);
    // 상품 검색 순위별 조회하기
    List<String> searchHistory();
    // 검색된 상품에 해당하는 상품이 존재하는지 검증
    List<ProductsVo> selectSearchProductsList(String search);
    // 환불처리 및 결제 취소된 상품 재고 추가
    int updateProductQuantityPlus(int productId, int quantity);

    List<ProductsVo> getNextPageByCreatedAt(Map<String,Object> params);

    // Test
    int getProductQuantity(int productId);

    // 상품 재고 0개 조회
    List<ProductsVo> searchProductsQuantityList();
    Integer  productQuantityUpdate(int id, int quantity);
    Integer  getQuantityCount();

}
