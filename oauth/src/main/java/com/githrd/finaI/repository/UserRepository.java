package com.githrd.finaI.repository;


import com.githrd.finaI.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findUserByEmailAndProvider(String email, String provider);

}