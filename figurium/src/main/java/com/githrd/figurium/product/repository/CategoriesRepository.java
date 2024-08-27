package com.githrd.figurium.product.repository;

import com.githrd.figurium.product.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoriesRepository extends JpaRepository<Category, Integer> {

    @Query(value = "SELECT * FROM categories" ,nativeQuery = true)
    List<Category> findAll();

}
