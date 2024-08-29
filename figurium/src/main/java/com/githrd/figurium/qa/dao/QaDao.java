package com.githrd.figurium.qa.dao;

import com.githrd.figurium.qa.vo.QaVo;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface QaDao {

    @Insert("INSERT INTO qa (title, content, user_id, created) VALUES (#{title}, #{content}, #{userId}, #{created})")
    void createQa(QaVo qa);

    @Select("SELECT * FROM qa WHERE id = #{id}")
    QaVo getQaById(Integer id);

    @Select("SELECT * FROM qa")
    List<QaVo> getAllQas();

    @Update("UPDATE qa SET title = #{title}, content = #{content}, reply = #{reply} WHERE id = #{id}")
    void updateQa(QaVo qa);

    @Delete("DELETE FROM qa WHERE id = #{id}")
    void deleteQa(Integer id);
}
