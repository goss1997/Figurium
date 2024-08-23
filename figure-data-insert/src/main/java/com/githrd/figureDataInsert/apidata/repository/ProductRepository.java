package com.githrd.figureDataInsert.apidata.repository;


import com.githrd.figureDataInsert.apidata.vo.Product;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, String> {

}
