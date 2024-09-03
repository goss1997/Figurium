package com.githrd.figurium.user.dao;

import com.githrd.figurium.user.vo.SocialAccountVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SocialAccountMapper {

    int insertSocialAccount(SocialAccountVo socialAccountVo);

    SocialAccountVo selectSocialAccountOne(int userId, String provider);
}
