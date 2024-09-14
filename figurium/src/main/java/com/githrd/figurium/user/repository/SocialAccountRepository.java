package com.githrd.figurium.user.repository;

import com.githrd.figurium.user.entity.SocialAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SocialAccountRepository extends JpaRepository<SocialAccount,Long> {


    SocialAccount findByUserId(int userId);
}
