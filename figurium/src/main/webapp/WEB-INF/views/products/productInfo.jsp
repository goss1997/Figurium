<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>상품상세</title>
    <link rel="stylesheet" type="text/css" href="/css/productInfo.css">
    <style>
        .product_insert > input {
            background-color: transparent;
        }

        .product_insert:hover > input {
            background-color: transparent;
            color: white;
        }

        .product_insert > button {
            background-color: transparent;
        }

        .product_insert:hover > button {
            background-color: transparent;
            color: white;
        }

    </style>


</head>
<jsp:include page="../common/header.jsp"/>
<body>
<div style="height: 90px"></div>
<div id="content-wrap-area">
    <div style="height: 50px;"></div>

    <div class="info_title">
        <div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
            <a href="../" class="stext-109 cl8 hov-cl1 trans-04">
                Home
                <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
            </a>

            <span class="stext-109 cl4">
                상품상세
            </span>
            <br>
            <c:if test="${loginUser.role == '1'}">
                <div style="margin-left : 60%">
                    <div class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 product_insert">
                        <input type="button" value="상품수정"
                               onclick="if(confirm('정말 수정하시겠습니까?')) location.href='productModifyForm.do?id=${product.id}'">
                    </div>
                    <div class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 product_insert">
                        <button class="product-delete-button" data-product-id="${product.id}">상품삭제</button>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- 상품에 대한 상세 이미지, 이름 등 넣을 곳 -->
    <input type="hidden" value="${product.id}">
    <div class="product_title">
        <div class="product_img_box">
            <!-- 상품의 이미지가 들어 갈 곳 -->
            <div class="product_img">
                <img src="${product.imageUrl}">
            </div>
        </div>

        <!-- 상품의 이름이나 가격 결제 금액 등 들어 갈 곳 -->
        <div class="product_info">
            <h3>${product.name}</h3>
                <div class="stars">
                    <c:forEach var="i" begin="1" end="${ratingAvg}">
                        <span class="star">&#9733;</span> <!-- 채워진 별 -->
                    </c:forEach>
                    <c:forEach var="i" begin="${ratingAvg + 1}" end="5">
                        <span class="star">&#9734;</span> <!-- 빈 별 -->
                    </c:forEach>
                </div>
            <div class="block2-txt-child2">
                <a href="#" id="product_like" class="btn-addwish-b2">
                    <img id="heart-icon" class="icon-heart"
                         src="${isLiked ? '/images/icons/icon-heart-02.png' : '/images/icons/icon-heart-01.png'}"
                         alt="Heart Icon">
                </a>
            </div>
            <h5>${product.price}￦</h5>

            <hr>
            <table class="info_table">
                <tr>
                    <th>제조사</th>
                    <td>${product.category.name}</td>
                </tr>

                <tr>
                    <th>남은재고</th>
                    <td>${product.quantity}</td>
                </tr>

                <tr>
                    <th>출고 날짜</th>
                    <td>${fun:substring(product.createdAt,0,10)}</td>
                </tr>

                <tr>
                    <th>수량</th>
                    <td>
                    <form>
                        <div class="quantity-box">
                            <button type="button" class="quantity-btn decrease" onclick="decreaseQuantity()">-
                            </button>
                            <input type="text" id="quantity" value="1" readonly>
                            <button type="button" class="quantity-btn increase" onclick="increaseQuantity()">+
                            </button>
                        </div>
                    </form>
                    </td>
                </tr>
            </table>

            <hr>
            <div class="total_price_box">
                <span class="total_price">총 결제금액</span>
                <p id="total_price">${product.price}</p>원
            </div>

            <div class="price_bye">
                <input class="price_bye_btn" type="button" value="바로구매"
                       onclick="location.href='shopingCart2.do'">
            </div>

            <div class="price_cart">
                <input class="price_cart_btn" type="button" value="장바구니"
                       onclick="addToCart(${product.id})">
            </div>
        </div>

    </div>
    <!-- 리뷰,Q&A Tap-->

    <div class="tap_box">
        <ul class="tap_detail">
            <li class="tap_review"><a href="#">Reviews(${reviewCount})</a></li>
            <li class="tap_qa"><a href="#">Q&A(0)</a></li>
        </ul>

    </div>

    <!-- 리뷰영역 -->
    <div class="reviews_box">
        <form>
            <input type="hidden" name="productId" value="${product.id}">
            <span class="reviewInsert_btn_box">
                    <input class="reviewInsert_btn" type="button" value="리뷰작성" onclick="reviewInsertForm(this.form);">
                </span>
        </form>

        <c:if test="${empty reviewList}">
            <h3 style="text-align: center; color: #ff5959">현재 작성된 리뷰가 없습니다.</h3>
        </c:if>
        <c:if test="${!empty reviewList}">
        <table class="review_table">
            <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>별점</th>
            </tr>
            </thead>
            <tbody id="reviewTable">
            <c:forEach var="review" items="${reviewList}">
                <tr>
                    <td class="review_number">${review.number}</td>
                    <td>
                        <a href="#" class="review-title" data-id="${review.id}">${review.title}</a>
                    </td>
                    <td class="review_name">${review.userName}</td>
                    <td class="review_regdate">${fun:substring(review.createdAt,0,10)} ${fun:substring(review.createdAt,11,16)}</td>
                    <td class="review_star">
                        <!-- review.rating 값에 따라 별 표시 -->
                        <c:forEach var="i" begin="1" end="${review.rating}">
                            <span class="star">&#9733;</span>
                        </c:forEach>
                        <c:forEach var="i" begin="${review.rating + 1}" end="5">
                            <span class="star">&#9734;</span>
                        </c:forEach>
                    </td>
                </tr>
                <!-- 리뷰 내용을 표시할 영역 -->
                <tr id="reviewContent-${review.id}" class="review-content" style="display:none;">
                    <td colspan="5">
                        <div id="spinner-${review.id}" class="spinner" style="display:none;">로딩 중...</div>
                        <div id="reviewText-${review.id}" class="review-text"></div>

                        <div class="review_buttons" id="reviewButtons-${review.id}" style="display:none;">
                            <form>
                                <input type="hidden" name="userId" value="${review.userId}">
                                <input type="hidden" name="id" value="${review.id}">
                                <input type="hidden" name="productId" value="${review.productId}">
                                <input type="button" class="edit_button" data-id="${review.id}" value="수정"
                                       onclick="update_review(this.form)">
                                <input type="button" class="delete_button" data-id="${review.id}" value="삭제"
                                       onclick="delete_review(this.form)">
                            </form>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </c:if>
            </tbody>
        </table>


    </div>
</div>


<!-- Q&A Tap -->

<div class="tap_box">
    <ul class="tap_detail">
        <li class="tap_review"><a href="#">Reviews(${reviewCount})</a></li>
        <li class="tap_qa"><a href="#">Q&A(0)</a></li>
    </ul>

</div>
<!-- Q&A 영역 -->

<div class="reviews_box">

        <span class="reviewInsert_btn_box">
            <input class="reviewInsert_btn" type="button" value="리뷰작성">
        </span>

    <table class="review_table">
        <tr>
            <th class="review_number">번호</th>
            <th class="review_title">제목</th>
            <th class="review_name">작성자</th>
            <th class="review_regdate">작성일</th>
            <th class="review_star">상태</th>
        </tr>

        <tr>
            <td>1</td>
            <td class="review_td_title">[기타문의]입고 문의</td>
            <td>홍길동</td>
            <td>2024-08-28</td>
            <td>답변완료</td>
        </tr>

        <!-- 테이블의 더미 데이터 -->
        <tr>
            <td>1</td>
            <td class="review_td_title">[기타문의]입고 문의</td>
            <td>홍길동</td>
            <td>2024-08-28</td>
            <td>미답변</td>
        </tr>

        <tr>
            <td>1</td>
            <td class="review_td_title">[기타문의]입고 문의</td>
            <td>홍길동</td>
            <td>2024-08-28</td>
            <td>미답변</td>
        </tr>

        <tr>
            <td>1</td>
            <td class="review_td_title">[기타문의]입고 문의</td>
            <td>홍길동</td>
            <td>2024-08-28</td>
            <td>답변완료</td>
        </tr>

        <tr>
            <td>1</td>
            <td class="review_td_title">[기타문의]입고 문의</td>
            <td>홍길동</td>
            <td>2024-08-28</td>
            <td>답변완료</td>
        </tr>

    </table>
</div>


<jsp:include page="../common/footer.jsp"/>





<script>
    $(document).ready(function () {
        // 서버에서 전달된 하트 상태를 기반으로 초기화
        var isLiked = "${isLiked}" === 'true';  // JSP에서 'true' 또는 'false'로 전달됨
        var userId = "${sessionScope.loginUser.id}" // 현재 로그인 유저 ID
        var productId = "${product.id}";  // 현재 보고 있는 상품 ID
        var contextPath = "";

        // 하트 아이콘 상태 초기화
        if (isLiked) {
            $('#heart-icon').attr('src', contextPath + '/images/icons/icon-heart-02.png');  // 좋아요 상태일 때 하트 채움
        } else {
            $('#heart-icon').attr('src', contextPath + '/images/icons/icon-heart-01.png');  // 기본값 또는 하트 빈 상태
        }

        $('#heart-icon').click(function (e) {
            e.preventDefault();

            let user = "${sessionScope.loginUser}";

            if (user === "null" || user === "") {
                alert("로그인이 필요한 서비스 입니다.");
                return;
            }

            // Ajax를 이용해 서버에 하트 클릭 상태를 전송
            $.ajax({
                url: contextPath + '/productLike/toggle',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    userId: userId,
                    productId: productId
                }),
                success: function (result) {
                    if (result === 1) {
                        $('#heart-icon').attr('src', contextPath + '/images/icons/icon-heart-02.png');
                        alert("해당 상품을 추천 했습니다.");
                    } else if (result === 0) {
                        $('#heart-icon').attr('src', contextPath + '/images/icons/icon-heart-01.png');
                        alert("해당 상품의 추천을 취소 했습니다.");
                    }
                    isLiked = !isLiked;  // 상태 토글
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });
    });
</script>


<script>
    // 주문 할 상품의 수량 선택
    var maxQuantity = "${product.quantity}"; // 재고 수량
    function increaseQuantity() {
        var quantityInput = document.getElementById('quantity');
        var currentQuantity = parseInt(quantityInput.value);
        if (currentQuantity < maxQuantity) {
            quantityInput.value = currentQuantity + 1;

        } else {
            alert('재고 수량을 초과할 수 없습니다.');
        }
    }

    function decreaseQuantity() {
        var quantityInput = document.getElementById('quantity');
        var currentQuantity = parseInt(quantityInput.value);
        if (currentQuantity > 1) {
            quantityInput.value = currentQuantity - 1;
        }
    }

    // 장바구니에 상품 추가 함수
    function addToCart(productId) {
        let quantity = $("#quantity").val();  // 수량 가져오기
        quantity = parseInt(quantity, 10);  // 수량을 숫자로 변환 (10진법)

        if (isNaN(quantity) || quantity <= 0) {
            alert("올바른 수량을 입력해주세요.");
            return;
        }

        // 장바구니 페이지로 리다이렉트
        location.href = "shopingCart.do?productId=" + encodeURIComponent(productId) + "&quantity=" + encodeURIComponent(quantity);
    }

</script>



<script>
    // 리뷰작성 버튼 클릭 시 로그인 검증
    function reviewInsertForm(f) {

        let productId = f.productId.value;

        let user = "${sessionScope.loginUser}";

        if (user === "null" || user === "") {
            alert("로그인이 필요한 서비스 입니다.");
            return;
        }

        f.action = 'reviewInsertForm.do';
        f.method = "POST";
        f.submit();

    }

</script>


<script>
    // 리뷰 제목 클릭시 발생 할 이벤트와 Ajax
    $(document).ready(function () {

        $('.review-title').on('click', function (e) {
            e.preventDefault();

            var reviewId = $(this).data('id');
            var contentRow = $('#reviewContent-' + reviewId);
            var spinner = $('#spinner-' + reviewId);
            var reviewText = $('#reviewText-' + reviewId);
            var reviewButtons = $('#reviewButtons-' + reviewId);

            if (contentRow.is(':visible')) {
                contentRow.hide();
                return;
            }

            $('.review-content').hide();
            spinner.show();

            $.ajax({
                url: 'getReviewContent',
                type: 'GET',
                data: {id: reviewId},
                success: function (data) {
                    var contentHtml = '<div class="review-text-left">' + data.content + '</div>';

                    if (data.imageUrl) {
                        contentHtml += '<img src="' + data.imageUrl + '" alt="Review Image">';
                    }

                    reviewText.html(contentHtml);

                    console.log("리뷰 작성자 id = " + data.reviewUserId)
                    console.log("현재 로그인한 유저 id = " + "${sessionScope.loginUser.id}")

                    // 문자열을 반환 하기 때문에 parseInt를 해주어야 한다.
                    var loginUserId = parseInt("${sessionScope.loginUser.id}")

                    // 작성자가 로그인한 사용자와 일치하면 버튼을 표시
                    if (data.reviewUserId === loginUserId) {
                        reviewButtons.show();
                    } else {
                        reviewButtons.hide(); // 버튼 숨기기
                    }

                    contentRow.show();
                    spinner.hide();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    var errorMessage = '리뷰 내용을 불러오는 데 실패했습니다.';

                    if (jqXHR.status) {
                        errorMessage += ' 상태 코드: ' + jqXHR.status;
                    }
                    if (errorThrown) {
                        errorMessage += ', 오류 메시지: ' + errorThrown;
                    }

                    alert(errorMessage);
                    spinner.hide();
                }
            });
        });
    });

</script>

<script>
    // 리뷰 수정 버튼 클릭
    function update_review(f) {

        let userId = f.userId.value;
        let productId = f.productId.value;
        let reviewId = f.id.value;

        f.action = "reviewUpdateForm.do";
        f.method = "POST";
        f.submit();
    }

    // 리뷰 삭제 버튼 클릭
    function delete_review(f) {

        let userId = f.userId.value;
        let productId = f.productId.value;
        let reviewId = f.id.value;

        if (confirm("정말 삭제 하시겠습니까?") == false) {
            return;
        }

        f.action = "reviewDelete.do";
        f.method = "POST";
        f.submit();
    }

</script>


<script>

    $(document).ready(function () {
        $('.product-delete-button').on('click', function () {
            var productId = $(this).data('product-id');

            if (confirm('정말 삭제하시겠습니까?')) {
                $.ajax({
                    url: "/product/" + productId,
                    type: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    success: function (response) {
                        // 삭제 성공 후 페이지 새로 고침
                        window.location.href = "/";
                    },
                    error: function (error) {
                        alert('상품 삭제에 실패했습니다.');
                        console.error('Error:', error);
                    }
                });
            }
        });
    });


</script>

<script>
        // 리뷰 삭제시 Ajax 처리를 하지 않았기에 redirect전 스크롤을 기억 후 redirect 후 스크롤로 이동
        addEventListener('beforeunload', function () {
        localStorage.setItem('scrollPosition', scrollY);
    });

        addEventListener('DOMContentLoaded', function () {
        let scrollPosition = localStorage.getItem('scrollPosition');
        if (scrollPosition) {
        scrollTo(0, parseInt(scrollPosition));
        localStorage.removeItem('scrollPosition'); // 스크롤 위치가 한번만 저장되도록 삭제
    }
    });
</script>
</body>

</html>