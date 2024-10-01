package com.githrd.figurium.user.service;

import com.githrd.figurium.user.dao.SocialAccountMapper;
import com.githrd.figurium.user.vo.SocialAccountVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SocialAccountService {

    private final SocialAccountMapper socialAccountMapper;




    public int insertSocialAccount(SocialAccountVo socialAccountVo){
       return socialAccountMapper.insertSocialAccount(socialAccountVo);
    }


    public SocialAccountVo findByEmail(int userId) {
        return socialAccountMapper.findByEmail(userId);
    }
}
