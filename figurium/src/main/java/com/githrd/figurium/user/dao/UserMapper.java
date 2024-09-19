package com.githrd.figurium.user.dao;

import com.githrd.figurium.auth.dto.UserProfile;
import com.githrd.figurium.product.vo.ProductsVo;
import com.githrd.figurium.user.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {

    int insert(UserVo user);

    int insertSocialUser(UserProfile userProfile);

    UserVo selectByEmail(String email);

    int softDelete(int userId);

    int deleteSocialAccountByUserId(int userId);

    int deleteByUserId(int userId);

    int findByEmailAndDeletedFalse(String findEmail);

    int updateUserPassword(int userId, String encPwd);

    List<ProductsVo> selectMyProductLikeList(int userId, int pageSize, int offset);

    int getTotalCountByUserId(int userId);

    List<UserVo> findByRoleAdmin();
}
