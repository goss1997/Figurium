package com.githrd.figurium.product.service;

import com.githrd.figurium.product.entity.Products;
import com.githrd.figurium.product.repository.ProductRepository;
import com.githrd.figurium.util.S3ImageService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service

public class ProductsService {

    private final ProductRepository productRepository;
    private final S3ImageService s3ImageService;


    ProductsService(ProductRepository productRepository, S3ImageService s3ImageService) {
        this.productRepository = productRepository;
        this.s3ImageService = s3ImageService;
    }

    public Products getProductById(int id) {
        return productRepository.findById(id);
    }

    public Products save(Products Products, MultipartFile ProductImage) {

        // s3에 해당 이미지 업로드 후 user에 set하고 db에 저장하기.
        if(!ProductImage.isEmpty()) {
            String profileImgUrl = s3ImageService.uploadS3(ProductImage);
            Products.setImageUrl(profileImgUrl);
        }

        return productRepository.save(Products);
    }

    // 업로드된 프로필 이미지 수정
    public Products updateProfileImage(Products Products, MultipartFile ProductImage) {

        // s3에서 사용자의 프로필 이미지 제거.
        s3ImageService.deleteImageFromS3(Products.getImageUrl());

        // s3에 수정할 이미지 업로드 후 유저에 set하기.
        Products.setImageUrl(s3ImageService.uploadS3(ProductImage));

        return productRepository.save(Products);
    }

}
