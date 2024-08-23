@echo off
REM 애플리케이션의 JAR 파일 경로를 설정합니다.
set JAR_FILE=figure-data-insert-0.0.1-SNAPSHOT.jar

REM 애플리케이션을 실행합니다.
java -jar %JAR_FILE%

REM 실행 후 종료를 기다립니다.
pause