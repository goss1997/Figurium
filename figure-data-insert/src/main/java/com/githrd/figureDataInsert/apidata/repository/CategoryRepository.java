package com.githrd.figureDataInsert.apidata.repository;

import com.githrd.figureDataInsert.apidata.vo.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category,String> {

}
