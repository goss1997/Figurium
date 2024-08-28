package com.githrd.figurium.product.repository;


import com.githrd.figurium.product.entity.Products;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Products, Integer> {

    @Query("SELECT p FROM Products p ORDER BY p.createdAt DESC")
    List<Products> findProductsWithPagination(Pageable pageable);

    @Query("SELECT p FROM Products p WHERE p.id > :lastId ORDER BY p.id ASC")
    List<Products> findByIdGreaterThanOrderByIdAsc(@Param("lastId") int lastId, Pageable pageable);

    // 선일 주문 화면에 나올 상품 List에 담길 DB
    @Query("SELECT p FROM Products p ORDER BY p.id ASC")
    List<Products> findBuyProductsTwo(Pageable pageable);

}
