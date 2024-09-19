package com.githrd.figurium.user.service;

import com.githrd.figurium.auth.dto.UserProfile;
import com.githrd.figurium.common.s3.S3ImageService;
import com.githrd.figurium.common.session.SessionConstants;
import com.githrd.figurium.product.vo.ProductsVo;
import com.githrd.figurium.user.dao.SocialAccountMapper;
import com.githrd.figurium.user.dao.UserMapper;
import com.githrd.figurium.user.entity.User;
import com.githrd.figurium.user.repository.UserRepository;
import com.githrd.figurium.user.vo.SocialAccountVo;
import com.githrd.figurium.user.vo.UserVo;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final UserMapper userMapper;
    private final SocialAccountMapper socialAccountMapper;
    private final S3ImageService s3ImageService;
    private final HttpSession session;

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);

    }

    @Transactional
    public int signup(UserVo user, MultipartFile profileImage) {

        // s3에 해당 이미지 업로드 후 user에 set하고 db에 저장하기.
        if (!profileImage.isEmpty()) {
            String profileImgUrl = s3ImageService.upload(profileImage);
            user.setProfileImgUrl(profileImgUrl);
        }else{
            user.setProfileImgUrl("/images/default-user-image.png");
        }

        return userMapper.insert(user);
    }

    // 업로드된 프로필 이미지 수정
    @Transactional
    public User updateProfileImage(User user, MultipartFile profileImage) {

        // s3에서 사용자의 프로필 이미지 제거.
        s3ImageService.deleteImageFromS3(user.getProfileImgUrl());

        // s3에 수정할 이미지 업로드 후 유저에 set하기.
        user.setProfileImgUrl(s3ImageService.upload(profileImage));

        return userRepository.save(user);
    }

    public User findUserById(int id) {
        return userRepository.findUserById(id);
    }

    @Transactional
    public User updateUser(String name, String phone, String address) {

        User loginUser = (User) session.getAttribute(SessionConstants.LOGIN_USER);

        loginUser.setName(name);
        loginUser.setPhone(phone);
        loginUser.setAddress(address);

        return userRepository.save(loginUser);
    }

    @Transactional
    public User createSocialAccount(UserProfile userProfile) {

        UserVo userVo = userMapper.selectByEmail(userProfile.getEmail());

        //  가입 안 한 소셜 이메일인 경우
        if (userVo == null) {

            int userInsertResult = userMapper.insertSocialUser(userProfile);

            // 자동 증가된 id
            int userId = userProfile.getId();

            SocialAccountVo socialAccountVo = SocialAccountVo.getInstance();
            socialAccountVo.setSocialAccountInfo(userId, userProfile.getProvider(), userProfile.getProviderUserId());

            socialAccountMapper.insertSocialAccount(socialAccountVo);

            return userRepository.findUserById(userId);
        }

        return null;
    }

    @Transactional
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    // 유저id와 provider로 소셜 회원 조회
    public SocialAccountVo selectSocialAccountOne(int userId, String provider) {
        return socialAccountMapper.selectSocialAccountOne(userId, provider);
    }

    @Transactional
    public int softDelete(int userId) {
        int result = 0;

        result = userMapper.softDelete(userId);

        if (result > 0) {
            // 사용자가 소셜 로그인 계정이 있을 경우
            if (socialAccountMapper.existsByUserId(userId) > 0) {
                // 연동된 소셜 계정 제거.
                result = userMapper.deleteSocialAccountByUserId(userId);
            }
        }

        // 모든 로직 성공 시 result = 1
        return result;
    }

    @Transactional
    public int deleteSocialAccount(int userId) {
        return userMapper.deleteByUserId(userId);
    }


    public int findByEmailAndDeletedFalse(String findEmail) {
        return userMapper.findByEmailAndDeletedFalse(findEmail);
    }

    @Transactional
    public int updateUserPassword(int userId, String encPwd) {
        return userMapper.updateUserPassword(userId,encPwd);
    }

    public List<ProductsVo> selectMyProductLikeList(int userId, int pageSize,int offset) {

        return userMapper.selectMyProductLikeList(userId, pageSize,offset);
    }

    public int getTotalPagesByUserId(int userId) {
        return userMapper.getTotalCountByUserId(userId);
    }

    public List<UserVo> findByRoleAdmin() {
        return userMapper.findByRoleAdmin();
    }
}
