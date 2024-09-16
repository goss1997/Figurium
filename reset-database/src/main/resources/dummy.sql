
-- 사용할 데이터베이스 지정
USE figurium_db;

-- 회원1(일용자)의 좋아요한 상품 더미 데이터
INSERT INTO product_likes VALUES (null,1,12,default);
INSERT INTO product_likes VALUES (null,1,22,default);
INSERT INTO product_likes VALUES (null,1,32,default);
INSERT INTO product_likes VALUES (null,1,3,default);
INSERT INTO product_likes VALUES (null,1,33,default);
INSERT INTO product_likes VALUES (null,1,13,default);
INSERT INTO product_likes VALUES (null,1,4,default);
INSERT INTO product_likes VALUES (null,1,44,default);
INSERT INTO product_likes VALUES (null,1,24,default);
INSERT INTO product_likes VALUES (null,1,5,default);
INSERT INTO product_likes VALUES (null,1,55,default);
INSERT INTO product_likes VALUES (null,1,6,default);
INSERT INTO product_likes VALUES (null,1,16,default);
INSERT INTO product_likes VALUES (null,1,26,default);
INSERT INTO product_likes VALUES (null,1,36,default);
INSERT INTO product_likes VALUES (null,1,46,default);
INSERT INTO product_likes VALUES (null,1,56,default);
INSERT INTO product_likes VALUES (null,1,7,default);
INSERT INTO product_likes VALUES (null,1,17,default);
INSERT INTO product_likes VALUES (null,1,27,default);
INSERT INTO product_likes VALUES (null,1,37,default);
INSERT INTO product_likes VALUES (null,1,47,default);
INSERT INTO product_likes VALUES (null,1,57,default);
INSERT INTO product_likes VALUES (null,1,60,default);
INSERT INTO product_likes VALUES (null,1,61,default);
INSERT INTO product_likes VALUES (null,1,62,default);
INSERT INTO product_likes VALUES (null,1,63,default);
INSERT INTO product_likes VALUES (null,1,64,default);
INSERT INTO product_likes VALUES (null,1,65,default);
INSERT INTO product_likes VALUES (null,1,66,default);
INSERT INTO product_likes VALUES (null,1,67,default);
INSERT INTO product_likes VALUES (null,1,68,default);
INSERT INTO product_likes VALUES (null,1,69,default);

-- 회원2(이용자)의 좋아요한 상품 더미 데이터
INSERT INTO product_likes VALUES (null,2,47,default);
INSERT INTO product_likes VALUES (null,2,57,default);
INSERT INTO product_likes VALUES (null,2,61,default);
INSERT INTO product_likes VALUES (null,2,62,default);
INSERT INTO product_likes VALUES (null,2,60,default);
INSERT INTO product_likes VALUES (null,2,63,default);
INSERT INTO product_likes VALUES (null,2,64,default);
INSERT INTO product_likes VALUES (null,2,65,default);
INSERT INTO product_likes VALUES (null,2,66,default);
INSERT INTO product_likes VALUES (null,2,67,default);
INSERT INTO product_likes VALUES (null,2,68,default);
INSERT INTO product_likes VALUES (null,2,69,default);

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

-- 회원1(일용자)의 알림 더미 데이터
insert into notifications (id, user_id, message, url)
values (1, 1, '관리자가 회원님의 게시물의 답변을 남겼습니다.','/qa/qaSelect.do?id=3');
insert into notifications (id, user_id, message, url)
values (2, 1, '관리자가 회원님의 게시물의 답변을 남겼습니다.','/qa/qaSelect.do?id=1');
