package com.githrd.figureDataInsert.apidata.repository;

import com.githrd.figureDataInsert.apidata.vo.Category;
import lombok.RequiredArgsConstructor;
import org.springframework.data.jpa.repository.JpaRepository;
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

    public int insertCategory(String categoryName) {
        String sql = "INSERT INTO categories (name) VALUES (?)";

        // KeyHolder를 이용해 삽입된 레코드의 자동 생성된 ID를 얻음
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, categoryName);
            return ps;
        }, keyHolder);

        // 삽입된 ID 반환
        if (keyHolder.getKey() != null) {
            return keyHolder.getKey().intValue(); // 자동 생성된 ID를 반환
        } else {
            throw new RuntimeException("Failed to retrieve generated key.");
        }
    }
}
