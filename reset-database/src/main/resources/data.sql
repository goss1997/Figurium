-- figurium 데이터 베이스 삭제
DROP DATABASE figurium_db;

-- figurium 데이터 베이스 생성
CREATE DATABASE figurium_db;


-- 사용할 데이터베이스 지정
USE figurium_db;

-- 회원 테이블
CREATE TABLE users
(
    id              INT AUTO_INCREMENT PRIMARY KEY COMMENT '회원 고유 ID (자동 증가)',
    email           VARCHAR(200) UNIQUE NOT NULL COMMENT '회원 이메일 (유일 값)',
    password        VARCHAR(255) COMMENT '회원 비밀번호 (소셜 로그인의 경우 NULL 가능)',
    name            VARCHAR(100)        NOT NULL COMMENT '회원 이름',
    phone           VARCHAR(15) COMMENT '회원 전화번호',
    address         TEXT COMMENT '회원 주소',
    profile_img_url VARCHAR(255) COMMENT '회원 프로필 이미지 url',
    role            TINYINT(1)   DEFAULT 0 COMMENT '회원 역할 (0: 사용자, 1: 관리자)',
    deleted         TINYINT(1)   DEFAULT 0 COMMENT '삭제 여부(1: 삭제)',
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '계정 생성 시간',
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '계정 정보 수정 시간'
);

-- 소셜 회원 테이블
CREATE TABLE social_accounts
(
    id               INT AUTO_INCREMENT PRIMARY KEY COMMENT '소셜 계정 고유 ID (자동 증가)',
    user_id          INT                                                          NOT NULL COMMENT '회원 테이블과 연결된 회원 ID',
    provider         VARCHAR(20) CHECK (provider IN ('google', 'kakao', 'naver')) NOT NULL COMMENT '소셜 로그인 제공자',
    provider_user_id VARCHAR(100)                                                 NOT NULL COMMENT '소셜 제공자에 의해 부여된 사용자 고유 ID',
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '소셜 계정 생성 시간',
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    UNIQUE KEY unique_provider_user (provider, provider_user_id) COMMENT '소셜 제공자별로 고유한 사용자 ID'
);

-- 카테고리 테이블
CREATE TABLE categories
(
    name VARCHAR(60) PRIMARY KEY COMMENT '카테고리 이름'
);

-- 상품 테이블
CREATE TABLE products
(
    id          INT AUTO_INCREMENT PRIMARY KEY COMMENT '상품 고유 ID (자동 증가)',
    category_name VARCHAR(60) COMMENT '카테고리 테이블과 연결된 카테고리 ID',
    name        VARCHAR(255) NOT NULL COMMENT '상품 이름',
    price       INT          NOT NULL COMMENT '상품 가격',
    quantity    INT          NOT NULL COMMENT '상품 재고 수량',
    image_url   VARCHAR(255) COMMENT '상품 이미지 URL',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '상품 등록 시간',
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '상품 수정 시간',
    FOREIGN KEY (category_name) REFERENCES categories (name)
);

-- 상품 좋아요 테이블
CREATE TABLE product_likes
(
    id         INT AUTO_INCREMENT PRIMARY KEY COMMENT '상품 좋아요 고유 ID (자동 증가)',
    user_id    INT COMMENT '사용자 고유 번호',
    product_id INT COMMENT '상품 고유 번호',
    product_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (product_id) REFERENCES products (id)
);

-- 상품 검색어 순위
CREATE TABLE product_search_history
(
    id           INT AUTO_INCREMENT PRIMARY KEY COMMENT '상품 검색어 고유 ID (자동 증가)',
    search_name  VARCHAR(255) UNIQUE NOT NULL COMMENT '검색어',
    search_count INT       DEFAULT 0 COMMENT '해당 검색어 검색 횟수',
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '검색어 작성 시간'
);

-- 장바구니 테이블
CREATE TABLE carts
(
    id         INT PRIMARY KEY AUTO_INCREMENT COMMENT '장바구니 ID',
    user_id    INT NOT NULL COMMENT '회원 ID',
    product_id INT NOT NULL COMMENT '상품 ID',
    quantity   INT NOT NULL DEFAULT 1 COMMENT '상품 수량',
    added_time DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간',
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (product_id) REFERENCES products (id)
);

-- 주문 테이블
CREATE TABLE orders
(
    id           INT AUTO_INCREMENT PRIMARY KEY COMMENT '주문 고유 번호',
    user_id      INT         NOT NULL COMMENT '사용자 고유 번호',
    payment_type VARCHAR(50) NOT NULL COMMENT '주문 결제 방식',
    price        INT         NOT NULL COMMENT '주문한 상품 총 가격',
    status       VARCHAR(20) DEFAULT '준비중' CHECK (status IN ('입금대기', '준비중', '출고대기', '배송중', '배송완료','환불완료')) COMMENT '주문 상태(입금대기, 준비중, 출고대기, 배송중, 배송완료, 환불완료)',
    created_at   DATETIME    DEFAULT CURRENT_TIMESTAMP COMMENT '주문 시간',
    valid        CHAR(1)  DEFAULT 'y' CHECK (valid IN ('y', 'n')) COMMENT '유효한 주문',
    merchant_id  VARCHAR(200) NOT NULL COMMENT '사용자 결제 번호',
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
    FOREIGN KEY (order_id) REFERENCES orders (id)
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
    FOREIGN KEY (order_id) REFERENCES orders (id)
);

-- 환불 사유
create table rfreasons
(
    name VARCHAR(15) check (name in ('단순 변심', '제품 불량', '잘못된 주문', '오배송', '기타')) COMMENT '환불 사유',
    order_id INT COMMENT '주문 고유 번호'
);

-- 리뷰 테이블
CREATE TABLE reviews
(
    id         INT AUTO_INCREMENT PRIMARY KEY COMMENT '리뷰 고유 ID (자동 증가)',
    user_id    INT COMMENT '회원 테이블과 연결된 회원 ID',
    product_id INT COMMENT '상품 테이블과 연결된 상품 ID',
    rating     INT CHECK (rating BETWEEN 1 AND 5) COMMENT '별점 (1~5 사이)',
    title      TEXT NOT NULL COMMENT '리뷰 제목',
    content    TEXT NOT NULL COMMENT '리뷰 내용',
    image_url  VARCHAR(255) COMMENT '리뷰 할 상품 이미지 URL',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '리뷰 작성 시간',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT '리뷰 수정 시간',
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);


CREATE TABLE qa
(
    id         INT AUTO_INCREMENT PRIMARY KEY COMMENT 'Q&A 게시물 IDX',
    product_id INT COMMENT '상품 ID',
    orders_id  INT COMMENT '주문 ID',
    user_id    INT NOT NULL COMMENT '사용자가 질문을 작성한 경우',
    title      VARCHAR(100) COMMENT '질문제목',
    content    VARCHAR(400) COMMENT '질문내용',
    reply      VARCHAR(400) COMMENT '질문 답글',
    replyStatus  ENUM('답변완료', '답변준비중') DEFAULT '답변준비중' COMMENT '답변여부',
    created    TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '작성일자',
    updated    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
    FOREIGN KEY (product_id) REFERENCES products (id),
    FOREIGN KEY (orders_id) REFERENCES orders (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE notifications (
   id INT AUTO_INCREMENT PRIMARY KEY COMMENT '알림 ID (Primary Key, 자동 증가)',
   user_id INT NOT NULL COMMENT '알림을 받는 사용자 ID',
   message TEXT NOT NULL COMMENT '알림 내용',
   url VARCHAR(255) COMMENT '알림 클릭 시 이동할 URL',
   isRead BOOLEAN DEFAULT FALSE COMMENT '알림 읽음 여부',
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '알림 생성 시간',
   FOREIGN KEY (user_id) REFERENCES users(id)
);



-- 더미 데이터
-- 회원 테이블 더미데이터
-- 사용자 1
INSERT INTO users (email, password, name, role, profile_img_url, phone, address)
VALUES ('user1@example.com', '$2a$10$5mxY/PNYCL2SASBFp6ONVuKaPwiGLpRRu4rfeT5LhT0WrRtozaT/y', '일용자', 0, 'https://figurium-s3-bucket.s3.ap-northeast-2.amazonaws.com/images/smoker-smoke.png', '01015641895', '13484 경기 성남시 분당구 판교로 30');

-- 사용자 2
INSERT INTO users (email, password, name, role, profile_img_url, phone, address)
VALUES ('user2@example.com', '$2a$10$5mxY/PNYCL2SASBFp6ONVuKaPwiGLpRRu4rfeT5LhT0WrRtozaT/y', '이용자', 0,'/images/default-user-image.png', '01015641895', '13484 경기 성남시 분당구 판교로 30');

-- 관리자 1
INSERT INTO users (email, password, name, role, profile_img_url, phone, address)
VALUES ('admin@example.com', '$2a$10$5mxY/PNYCL2SASBFp6ONVuKaPwiGLpRRu4rfeT5LhT0WrRtozaT/y', '관리자M', 1, 'https://figurium-s3-bucket.s3.ap-northeast-2.amazonaws.com/images/tom-smoke.png', '01015641895', '13484 경기 성남시 분당구 판교로 30');

-- 관리자 2
INSERT INTO users (email, password, name, role, profile_img_url, phone, address)
VALUES ('admin1@example.com', '$2a$10$5mxY/PNYCL2SASBFp6ONVuKaPwiGLpRRu4rfeT5LhT0WrRtozaT/y', '관리자1', 1, 'https://figurium-s3-bucket.s3.ap-northeast-2.amazonaws.com/images/akainu-smoke.png', '01015641895', '13484 경기 성남시 분당구 판교로 30');



-- 회원 상품 주문 기록
create or replace view order_history_view
as
select
    o.id as id,o.payment_type,o.user_id,o.status,o.created_at,o.valid,o.merchant_id,
    oi.price,oi.quantity,c.name,c.phone as customer_phone,
    c.email,s.recipient_name,s.phone,s.address,s.delivery_request,
    p.name as product_name, p.image_url, p.id as p_id
from orders o inner join order_items oi on o.id = oi.order_id
              inner join customers c on o.id = c.order_id
              inner join shipping_addresses s on o.id = s.order_id
              inner join products p on oi.product_id = p.id;

-- 환불 사유 추가 view
create or replace view order_history_refund_view
as
select
    o.id as id,o.payment_type,o.user_id,o.status,o.created_at,o.valid,o.merchant_id,
    oi.price,oi.quantity,c.name,c.phone as customer_phone,
    c.email,s.recipient_name,s.phone,s.address,s.delivery_request,
    p.name as product_name, p.image_url, p.id as p_id, r.name as refund_reason
from orders o inner join order_items oi on o.id = oi.order_id
              inner join customers c on o.id = c.order_id
              inner join shipping_addresses s on o.id = s.order_id
              inner join products p on oi.product_id = p.id
              left  join rfreasons r on o.id = r.order_id;

-- Cart에 넣는 데이터
create or replace view product_cart_view
as
select
    p.id,p.name,p.price,p.image_url,c.quantity,c.user_id
from products p inner join carts c on p.id = c.product_id;





