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
    search_name  VARCHAR(255) NOT NULL COMMENT '검색어',
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
    status       VARCHAR(20) DEFAULT '준비중' CHECK (status IN ('준비중', '출고대기', '배송중', '배송완료')) COMMENT '주문 상태(준비중 / 출고대기 / 배송중 / 배송완료)',
    created_at   DATETIME    DEFAULT CURRENT_TIMESTAMP COMMENT '주문 시간',
    valid        CHAR(1)  DEFAULT 'y' CHECK (valid IN ('y', 'n')) COMMENT '유효한 주문',
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
    user_id    INT NOT NULL COMMENT '사용자가 질문을 작성한 경우',
    title      VARCHAR(100) COMMENT '질문제목',
    content    VARCHAR(400) COMMENT '질문내용',
    reply      VARCHAR(400) COMMENT '질문 답글',
    replyStatus  ENUM('답변완료', '답변준비중') DEFAULT '답변준비중' COMMENT '답변여부',
    created    TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '작성일자',
    updated    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일자',
    FOREIGN KEY (product_id) REFERENCES products (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);

-- 더미 데이터
-- 회원 테이블 더미데이터
-- 사용자 1
INSERT INTO users (email, password, name, role, profile_img_url)
VALUES ('user1@example.com', '$2a$10$5mxY/PNYCL2SASBFp6ONVuKaPwiGLpRRu4rfeT5LhT0WrRtozaT/y', '일용자', 0, 'https://figurium-s3-bucket.s3.ap-northeast-2.amazonaws.com/images/smoker-smoke.png');

-- 사용자 2
INSERT INTO users (email, password, name, role)
VALUES ('user2@example.com', '$2a$10$5mxY/PNYCL2SASBFp6ONVuKaPwiGLpRRu4rfeT5LhT0WrRtozaT/y', '이용자', 0);

-- 관리자 1
INSERT INTO users (email, password, name, role, profile_img_url)
VALUES ('admin@example.com', '$2a$10$5mxY/PNYCL2SASBFp6ONVuKaPwiGLpRRu4rfeT5LhT0WrRtozaT/y', '관리자M', 1, 'https://figurium-s3-bucket.s3.ap-northeast-2.amazonaws.com/images/tom-smoke.png');

-- 관리자 2
INSERT INTO users (email, password, name, role, profile_img_url)
VALUES ('admin1@example.com', '$2a$10$5mxY/PNYCL2SASBFp6ONVuKaPwiGLpRRu4rfeT5LhT0WrRtozaT/y', '관리자1', 1, 'https://figurium-s3-bucket.s3.ap-northeast-2.amazonaws.com/images/akainu-smoke.png');



-- 회원 상품 주문 기록
create or replace view order_history_view
as
select
    o.id as id,o.payment_type,o.user_id,o.status,o.created_at,o.valid,
    oi.price,oi.quantity,c.name,c.phone as customer_phone,
    c.email,s.recipient_name,s.phone,s.address,s.delivery_request,
    p.name as product_name, p.image_url
from orders o inner join order_items oi on o.id = oi.order_id
              inner join customers c on o.id = c.order_id
              inner join shipping_addresses s on o.id = s.order_id
              inner join products p on oi.product_id = p.id;

-- Cart에 넣는 데이터
create or replace view product_cart_view
as
select
    p.id,p.name,p.price,p.image_url,c.quantity,c.user_id
from products p inner join carts c on p.id = c.product_id;

-- Q&A 게시판 더미데이터
-- 게시글 1
INSERT INTO qa (user_id, title, content, reply)
VALUES (1, '첫 번째 게시글 제목', '여기는 첫 번째 게시글 내용입니다. 게시판 기능을 테스트하기 위한 내용입니다.', '답변 1');
-- 게시글 2
INSERT INTO qa (user_id, title, content, reply)
VALUES (2, '두 번째 게시글 제목', '이 게시글은 두 번째 게시글 내용입니다. 게시판 기능의 테스트를 위한 추가 내용입니다.', '답변 2');
-- 게시글 3
INSERT INTO qa (user_id, title, content, reply)
VALUES (1, '세 번째 게시글 제목', '여기는 세 번째 게시글의 내용입니다. 다양한 데이터를 삽입하여 테스트하는 내용입니다.', '답변 3');
-- 게시글 4
INSERT INTO qa (user_id, title, content, reply)
VALUES (3, '네 번째 게시글 제목', '네 번째 게시글의 내용입니다. 추가적인 테스트를 위해 사용되는 내용입니다.', '답변 4');
-- 게시글 5
INSERT INTO qa (user_id, title, content, reply)
VALUES (2, '다섯 번째 게시글 제목', '다섯 번째 게시글 내용으로, 여러 가지 기능을 테스트하기 위해 작성된 게시글입니다.', '답변 5');
-- 게시글 6
INSERT INTO qa (user_id, title, content, reply)
VALUES (3, '여섯 번째 게시글 제목', '여기는 여섯 번째 게시글의 내용입니다. 다양한 시나리오에 대한 테스트를 위한 게시글입니다.', '답변 6');