package com.githrd.figurium.util;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface S3ImageService {

    /**
     * S3 Service
     */
    // S3에 이미지 단일 업로드(image)
    String uploadS3(MultipartFile image);

    // S3에 이미지 다중 업로드(images)
    List<String> uploadS3(List<MultipartFile> images);

    // S3에 이미지 삭제(imageUrl)
    void deleteImageFromS3(String imageUrl);

}
