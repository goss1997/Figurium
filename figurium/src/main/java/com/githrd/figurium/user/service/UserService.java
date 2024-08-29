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
}
