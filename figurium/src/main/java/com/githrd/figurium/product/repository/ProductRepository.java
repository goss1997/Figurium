package com.githrd.figurium.product.repository;


import com.githrd.figurium.product.entity.Products;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Products, Integer> {

    @Query(value = "SELECT * FROM products ORDER BY created_at DESC LIMIT 80", nativeQuery = true)
    List<Products> findAllByCreatedAtDesc();


}
