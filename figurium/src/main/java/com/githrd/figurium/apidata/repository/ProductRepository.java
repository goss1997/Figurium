package com.githrd.figurium.apidata.repository;

import com.githrd.figurium.apidata.vo.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, String> {


}
