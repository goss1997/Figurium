package com.githrd.figurium.user.service;

import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.user.repository.UserRepository;
import com.githrd.figurium.util.S3ImageService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final S3ImageService s3ImageService;
    private final HttpSession session;

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);

    }

    @Transactional
    public User signup(User user, MultipartFile profileImage) {

        // s3에 해당 이미지 업로드 후 user에 set하고 db에 저장하기.
        if(!profileImage.isEmpty()) {
            String profileImgUrl = s3ImageService.uploadS3(profileImage);
            user.setProfileImgUrl(profileImgUrl);
        }

        return userRepository.save(user);
    }

    // 업로드된 프로필 이미지 수정
    @Transactional
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

    @Transactional
    public User updateUser(String name, String phone, String address) {

        User loginUser = (User) session.getAttribute("loginUser");

        loginUser.setName(name);
        loginUser.setPhone(phone);
        loginUser.setAddress(address);

        return userRepository.save(loginUser);
    }
}
