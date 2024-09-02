package com.githrd.figurium.product.repository;


import com.githrd.figurium.product.entity.Products;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Products, Integer> {

    @Query("SELECT p FROM Products p ORDER BY p.createdAt DESC, p.id ASC")
    Page<Products> findProductsWithPagination(Pageable pageable);

    Page<Products> findByCreatedAtBeforeAndIdLessThan(LocalDateTime createdAt, Integer id, Pageable pageable);

    // select one
    Products findById(int id);


    //Page<Products> findByCreatedAtBefore(LocalDateTime createdAt, Pageable pageable);

    // 선일 주문 화면에 나올 상품 List에 담길 DB
    @Query("SELECT p FROM Products p ORDER BY p.id ASC")
    List<Products> findBuyProductsTwo(Pageable pageable);
}