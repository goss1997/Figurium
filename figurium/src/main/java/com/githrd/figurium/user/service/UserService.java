package com.githrd.figurium.user.service;

import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.user.repository.UserRepository;
import com.githrd.figurium.util.S3ImageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final S3ImageService s3ImageService;

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);

    }

    public User save(User user, MultipartFile profileImage) {

        // s3에 해당 이미지 업로드 후 user에 set하고 db에 저장하기.
        if(!profileImage.isEmpty()) {
            String profileImgUrl = s3ImageService.uploadS3(profileImage);
            user.setProfileImgUrl(profileImgUrl);
        }

        return userRepository.save(user);
    }

    // 업로드된 프로필 이미지 수정
    public User updateProfileImage(User user, MultipartFile profileImage) {

        // s3에서 사용자의 프로필 이미지 제거.
        s3ImageService.deleteImageFromS3(user.getProfileImgUrl());

        // s3에 수정할 이미지 업로드 후 유저에 set하기.
        user.setProfileImgUrl(s3ImageService.uploadS3(profileImage));

        return userRepository.save(user);
    }

    public User findUserById(int id) {
        return userRepository.findUserById(id);
    }
}
