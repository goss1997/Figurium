package com.githrd.figurium.qa.repository;

import com.githrd.figurium.qa.entity.QaEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QaRepository extends JpaRepository<QaEntity, Integer> {



}
