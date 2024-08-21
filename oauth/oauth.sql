
-- test9 계정 생성
CREATE USER test9 IDENTIFIED BY test9;
GRANT CONNECT, resource TO test9;

-- 소셜 & 자체 회원 테이블

-- 시퀀스 생성
-- create members sequence
CREATE SEQUENCE members_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20;
   
-- create users sequence   
CREATE SEQUENCE users_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20;

-- 테이블 생성
-- 자체 회원 members
CREATE TABLE members (
    member_id NUMBER PRIMARY KEY,
    email VARCHAR2(100) NOT NULL UNIQUE,
    password VARCHAR2(100) NOT NULL,
    nickname VARCHAR2(255),
    address varchar2(200),
    phone varchar2(100),
    profile_img varchar2(255)
--    refresh_token VARCHAR2(255)
);

-- 소셜 회원 users
CREATE TABLE users (
	user_id number PRIMARY key,
	email varchar2(255) NOT NULL,
	username varchar2(100) NOT NULL,
	provider varchar2(100) NOT NULL
);
	

 
SELECT * FROM members;

INSERT INTO members values(members_seq.nextval,'goss1313@test.com','{noop}1234','고테스터','주소주소','010-1111-1242','iiiiiiiii');
SELECT * FROM users;

COMMIT;