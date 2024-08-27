package com.githrd.figureDataInsert.apidata.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Statement;

@Repository
@RequiredArgsConstructor
public class CategoryRepository {

    private final JdbcTemplate jdbcTemplate;

    public void insertCategory(String category) {
        String sql = "INSERT INTO categories (name) VALUES (?)";
        jdbcTemplate.update(sql, category);
    }
}
