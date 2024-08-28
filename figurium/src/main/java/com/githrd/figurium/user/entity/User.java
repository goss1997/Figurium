package com.githrd.figurium.user.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "email", nullable = false, length = 200)
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Column(name = "phone", length = 15)
    private String phone;

    @Lob
    @Column(name = "address")
    private String address;

    @Column(name = "profile_img_url")
    private String profileImgUrl = "/resources/images/FiguriumHand.png";

    @Column(name = "role")
    private int role = 0;

    @Column(name = "deleted")
    private Boolean deleted = true;

    @Column(name = "created_at")
    private String createdAt = LocalDateTime.now().toString();

    @Column(name = "updated_at")
    private String updatedAt = LocalDateTime.now().toString();

    @OneToMany(mappedBy = "user")
    private Set<SocialAccount> socialAccounts = new LinkedHashSet<>();

}