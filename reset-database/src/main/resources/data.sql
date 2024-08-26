-- figurium 데이터 베이스 삭제
DROP DATABASE figurium_db;

-- figurium 데이터 베이스 생성
CREATE DATABASE figurium_db;

-- 사용할 데이터베이스 지정
USE figurium_db;

-- 회원 테이블
CREATE TABLE users
(
    id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '회원 고유 ID (자동 증가)',
    email       VARCHAR(200) UNIQUE NOT NULL COMMENT '회원 이메일 (유일 값)',
    password    VARCHAR(255) COMMENT '회원 비밀번호 (소셜 로그인의 경우 NULL 가능)',
    name        VARCHAR(100) NOT NULL COMMENT '회원 이름',
    phone       VARCHAR(15) COMMENT '회원 전화번호',
    address     TEXT COMMENT '회원 주소',
    profile_img VARCHAR(255) COMMENT '회원 프로필 이미지',
    role        TINYINT DEFAULT 0 COMMENT '회원 역할 (0: 사용자, 1: 관리자)',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '계정 생성 시간',
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '계정 정보 수정 시간'
);

-- 소셜 회원 테이블
CREATE TABLE social_accounts
(
    id               INT AUTO_INCREMENT PRIMARY KEY COMMENT '소셜 계정 고유 ID (자동 증가)',
    user_id          INT NOT NULL COMMENT '회원 테이블과 연결된 회원 ID',
    provider         VARCHAR(20) CHECK (provider IN ('google', 'kakao', 'naver')) NOT NULL COMMENT '소셜 로그인 제공자',
    provider_user_id VARCHAR(100) NOT NULL COMMENT '소셜 제공자에 의해 부여된 사용자 고유 ID',
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '소셜 계정 생성 시간',
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    UNIQUE KEY unique_provider_user (provider, provider_user_id) COMMENT '소셜 제공자별로 고유한 사용자 ID'
);

-- 카테고리 테이블
CREATE TABLE categories
(
    id   INT AUTO_INCREMENT PRIMARY KEY COMMENT '카테고리 고유 ID (자동 증가)',
    name VARCHAR(60) NOT NULL COMMENT '카테고리 이름'
);

-- 상품 테이블
CREATE TABLE products
(
    id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '상품 고유 ID (자동 증가)',
    category_id INT COMMENT '카테고리 테이블과 연결된 카테고리 ID',
    name        VARCHAR(255) NOT NULL COMMENT '상품 이름',
    price       INT NOT NULL COMMENT '상품 가격',
    quantity    INT NOT NULL COMMENT '상품 재고 수량',
    image_url   VARCHAR(255) COMMENT '상품 이미지 URL',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '상품 등록 시간',
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '상품 수정 시간',
    FOREIGN KEY (category_id) REFERENCES categories (id),
    INDEX (name) COMMENT '상품 이름에 대한 인덱스를 추가해 조회기능 향상'
);

-- 상품 좋아요 테이블
CREATE TABLE product_likes
(
    id         INT AUTO_INCREMENT PRIMARY KEY COMMENT '상품 좋아요 고유 ID (자동 증가)',
    user_id    INT COMMENT '사용자 고유 번호',
    product_id INT COMMENT '상품 고유 번호',
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (product_id) REFERENCES products (id)
);

-- 상품 검색어 순위
CREATE TABLE search_product
(
    id           INT AUTO_INCREMENT PRIMARY KEY COMMENT '상품 검색어 고유 ID (자동 증가)',
    search_name  VARCHAR(255) NOT NULL COMMENT '검색어',
    search_count INT DEFAULT 0 COMMENT '해당 검색어 검색 횟수',
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '검색어 작성 시간',
    INDEX (search_name) COMMENT '검색어에 대한 인덱스 추가로 검색 기능 향상'
);

-- 장바구니 테이블
CREATE TABLE carts
(
    id         INT PRIMARY KEY AUTO_INCREMENT COMMENT '장바구니 ID',
    user_id    INT NOT NULL COMMENT '회원 ID',
    product_id INT NOT NULL COMMENT '상품 ID',
    quantity   INT NOT NULL DEFAULT 1 COMMENT '상품 수량',
    added_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간',
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (product_id) REFERENCES products (id)
);

-- 주문 테이블
CREATE TABLE orders
(
    id           INT AUTO_INCREMENT PRIMARY KEY COMMENT '주문 고유 번호',
    user_id      INT NOT NULL COMMENT '사용자 고유 번호',
    payment_type VARCHAR(50) NOT NULL COMMENT '주문 결제 방식',
    status       VARCHAR(20) DEFAULT '준비중' CHECK (status IN ('준비중', '출고대기', '배송중', '배송완료')) COMMENT '주문 상태(준비중 / 출고대기 / 배송중 / 배송완료)',
    order_time   DATETIME DEFAULT NOW() COMMENT '주문 시간',
    FOREIGN KEY (user_id) REFERENCES users (id)
);

-- 주문 상품 테이블
CREATE TABLE order_items
(
    id         INT AUTO_INCREMENT PRIMARY KEY COMMENT '주문 상품 고유 번호',
    order_id   INT COMMENT '주문 고유 번호',
    product_id INT COMMENT '상품 ID',
    price      INT NOT NULL COMMENT '주문한 상품 가격',
    quantity   INT NOT NULL COMMENT '갯수',
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (product_id) REFERENCES products (id)
);

-- 주문자 정보
CREATE TABLE customers
(
    id       INT AUTO_INCREMENT PRIMARY KEY COMMENT '주문자 고유 번호',
    order_id INT COMMENT '주문 고유 번호',
    name     VARCHAR(15) COMMENT '주문자 이름',
    phone    VARCHAR(20) NOT NULL COMMENT '주문자 전화번호',
    email    VARCHAR(50) COMMENT '주문자 이메일',
    FOREIGN KEY (order_id) REFERENCES order_items (id)
);

-- 배송지 정보
CREATE TABLE shipping_addresses
(
    id               INT AUTO_INCREMENT PRIMARY KEY COMMENT '배송지 고유 번호',
    order_id         INT COMMENT '주문 고유 번호',
    recipient_name   VARCHAR(15) COMMENT '수령인 이름',
    phone            VARCHAR(20) COMMENT '수령인 전화번호',
    address          VARCHAR(100) COMMENT '배송 주소',
    delivery_request VARCHAR(200) COMMENT '배송 요청 사항',
    FOREIGN KEY (order_id) REFERENCES order_items (id)
);

-- 리뷰 테이블
CREATE TABLE reviews
(
    id         INT AUTO_INCREMENT PRIMARY KEY COMMENT '리뷰 고유 ID (자동 증가)',
    user_id    INT COMMENT '회원 테이블과 연결된 회원 ID',
    product_id INT COMMENT '상품 테이블과 연결된 상품 ID',
    rating     INT CHECK (rating BETWEEN 1 AND 5) COMMENT '별점 (1~5 사이)',
    content    TEXT COMMENT '리뷰 내용',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '리뷰 작성 시간',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '리뷰 수정 시간',
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

-- 상품 Q&A 통합 테이블
CREATE TABLE qa
(
    id         INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Q&A 게시물 IDX',
    product_id INT COMMENT '상품 ID',
    user_id    INT NOT NULL COMMENT '사용자가 질문을 작성한 경우',
    content    VARCHAR(400) COMMENT '질문내용',
    recontent  VARCHAR(400) COMMENT '질문 답글',
    created    DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '작성일자',
    updated    DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
    FOREIGN KEY (product_id) REFERENCES products (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);
