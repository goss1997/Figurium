package com.githrd.figurium.product1.repository;


import com.githrd.figurium.product1.entity.Products1;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository1 extends JpaRepository<Products1, Integer> {



}
