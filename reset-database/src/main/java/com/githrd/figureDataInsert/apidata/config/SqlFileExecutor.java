package com.githrd.figureDataInsert.apidata.config;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;

@Component
@RequiredArgsConstructor
@Slf4j
public class SqlFileExecutor {

    private final DataSource dataSource;

    public void executeSqlFile() {
        log.info(" - - - - - dummy.sql 실행");
        ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
        populator.addScript(new ClassPathResource("dummy.sql"));
        populator.execute(dataSource);

        log.info(" - - - - - dummy.sql 실행 완료");
    }

}
