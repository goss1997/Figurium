package com.githrd.figurium.apidata.repository;

import com.githrd.figurium.apidata.vo.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product,String> {

}
