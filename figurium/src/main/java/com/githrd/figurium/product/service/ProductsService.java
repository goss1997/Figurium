package com.githrd.figurium.product.service;

import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductsService {

    private final ProductRepository productRepository;

    @Autowired
    ProductsService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public Products getProductById(int id) {
        return productRepository.findById(id);
    }

}
