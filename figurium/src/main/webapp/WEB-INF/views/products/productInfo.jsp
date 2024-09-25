<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../reviews/reviewList.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>상품상세</title>
    <link rel="stylesheet" type="text/css" href="/css/productInfo.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,400,0,0" />
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

    <style>
    .material-symbols-outlined {

        vertical-align: sub;
      font-variation-settings:
      'FILL' 0,
      'wght' 400,
      'GRAD' 0,
      'opsz' 20
    }
    </style>

</head>
<jsp:include page="../common/header.jsp"/>
<body>
<div style="height: 10px"></div>
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

        </div>
    </div>

    <!-- 상품에 대한 상세 이미지, 이름 등 넣을 곳 -->
    <form>
        <div class="product_title">
            <div class="product_img_box">
                <!-- 상품의 이미지가 들어 갈 곳 -->
                <div class="product_img">
                    <img src="${product.imageUrl}">
                    <!-- SOLD OUT 오버레이 이미지 -->
                    <img src="/images/soldout1.png" alt="Sold Out" class="sold-out-overlay" style="${product.quantity == 0 ? 'display: block;' : 'display: none;'}">
                </div>

            </div>

            <!-- 상품의 이름이나 가격 결제 금액 등 들어 갈 곳 -->
            <div class="product_info">
                <h3>${product.name}</h3>
                <div class="stars-container">
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
                </div>
                <h5>${product.price}￦</h5>
                <c:if test="${loginUser.role == '1'}">
            &nbsp;&nbsp;
                <div style="display: inline-block;">
                    <div class="flex-c-m  cl6  bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 product_insert btn btn-info"
                    style="display: inline-block; font-size: 12px; line-height: 1.833333;">
                        <input type="button" value="상품수정"
                               onclick="if(confirm('정말 수정하시겠습니까?')) location.href='productModifyForm.do?id=${product.id}'">
                    </div>
                    <div class="flex-c-m  cl6  bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 product_insert btn btn-danger "
                    style="display: inline-block; font-size: 12px; line-height: 1.833333;">
                        <button type="button" class="product-delete-button" data-product-id="${product.id}">상품삭제</button>
                    </div>
                </div>
            </c:if>

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
                            <div class="quantity-box">
                                <button type="button" class="quantity-btn decrease" onclick="decreaseQuantity()">-
                                </button>
                                <input type="text" id="quantity" name="quantity" value="<c:out value="1"/>" readonly>
                                <button type="button" class="quantity-btn increase" onclick="increaseQuantity()">+
                                </button>
                            </div>
                        </td>
                    </tr>
                </table>

                <hr>
               <div class="total_price_box">
                    <span class="total_price">총 결제금액</span>
                    <div class="total_price_right">
                        <p id="total_price">${product.price}</p>
                        <span class="won">원</span>

                    </div>
                </div>


                <div class="price_bye">
                    <input class="price_bye_btn" type="button" value="바로구매"
                           onclick="priceBye();">
                </div>


                <input type="hidden" name="productId" value="${product.id}">
                <div class="price_cart">
                    <input class="price_cart_btn" type="button" value="장바구니"
                           onclick="addToCart(this.form)">
                </div>

            </div>

                <div class="warning-box">
                    <img src="/images/경고문.png">
                </div>

        </div>
    </form>
    <!-- 리뷰,Q&A Tap-->

    <div class="tap_box">
        <ul class="tap_detail">
            <li class="tap_review"><a href="#reviews" onclick="switchTab(event, 'reviews')">Reviews(${reviewCount})</a></li>
            <li class="tap_qa"><a href="#qa" onclick="switchTab(event, 'qa')">Q&A(${productQaCount})</a></li>
        </ul>
    </div>

    <!-- 리뷰영역 -->
    <div id="reviews" class="tab-content">
        <div class="reviews_box">
            <form>
                <input type="hidden" name="productId" value="${product.id}">
                <span class="reviewInsert_btn_box">
                    <input class="reviewInsert_btn" type="button" value="리뷰작성" onclick="reviewInsertForm(this.form);">
                </span>
            </form>

            <c:if test="${empty reviewList}">
                <h3 style="text-align: center; color: #ff5959; margin-top: 30px">현재 작성된 리뷰가 없습니다.</h3>
            </c:if>


            <!-- 해당 상품의 리뷰의 리스트를 가져와서 출력 할 곳 -->
            <c:if test="${!empty reviewList}">
                <div id="productReviewList"></div>
            </c:if>
            <div id="pagination" style="text-align: center;"></div>
        </div>
    </div>
</div>

<!-- Q&A 영역 -->
<div id="qa" class="tab-content">
    <div class="qa_box">
        <form>
            <input type="hidden" name="productId" value="${product.id}">
            <span class="qaInsert_btn_box">
             <input class="qaInsert_btn" type="button" value="Q&A작성" onclick="qaInsert(this.form)">
            </span>
        </form>

         <c:if test="${empty productQaList}">
                <h3 style="text-align: center; color: #ff5959; margin-top: 20px">현재 작성된 Q&A가 없습니다.</h3>
         </c:if>



        <c:if test="${!empty productQaList}">
            <div id="productQaList">
                <jsp:include page="../qa/productQaList.jsp"/>
            </div>
        </c:if>
        <div id="productQaPaging" style="text-align: center;"></div>
    </div>
</div>


<jsp:include page="../common/footer.jsp"/>


<script>

    // 탭 전환 함수
    function showTab(tabId) {
        // 모든 탭 내용을 숨깁니다
        var tabs = document.querySelectorAll('.tab-content');
        tabs.forEach(function (tab) {
            tab.style.display = 'none';
        });

        // 선택된 탭만 표시합니다
        var activeTab = document.getElementById(tabId);
        if (activeTab) {
            activeTab.style.display = 'block';
        }
    }

       // 탭 전환 시 스크롤이 이동하지 않도록 처리하는 함수
        function switchTab(event, tabId) {
            event.preventDefault(); // 기본 앵커 동작을 방지 (스크롤 이동 방지)
            showTab(tabId); // 탭 전환 함수 호출
        }



    // 페이지 로드 시 해시 값에 따라 탭을 활성화합니다
    document.addEventListener('DOMContentLoaded',
        function () {
            // URL 해시를 가져옵니다
            var hash = window.location.hash.substr(1); // '#'을 제거

            // 해시 값이 있을 경우 해당 탭을 표시합니다
            if (hash) {
                showTab(hash);
            } else {
            // 기본 탭을 활성화합니다 (예: 'qa')
                showTab('reviews');
            }
        });




    function qaInsert(f) {

        f.method = "POST"
        f.action = '/qa/qaInsert.do';
        f.submit();
    }

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
    let maxQuantity = parseInt("${product.quantity}"); // 재고 수량
    let productPrice = parseInt("${product.price}");   // 상품 가격

    function updateTotalPrice() {
        let quantityInput = document.getElementById('quantity');
        let currentQuantity = parseInt(quantityInput.value);
        let totalPrice = productPrice * currentQuantity;

        // 총 결제 금액을 업데이트
        document.getElementById('total_price').innerText = totalPrice;
    }

    function increaseQuantity() {
        let quantityInput = document.getElementById('quantity');
        let currentQuantity = parseInt(quantityInput.value);

        if (currentQuantity < maxQuantity) {
            quantityInput.value = currentQuantity + 1;
            updateTotalPrice(); // 수량 변경 시 총 결제 금액 업데이트
        } else {
            alert('재고 수량을 초과할 수 없습니다.');
        }
    }

    function decreaseQuantity() {
        let quantityInput = document.getElementById('quantity');
        let currentQuantity = parseInt(quantityInput.value);

        if (currentQuantity > 1) {
            quantityInput.value = currentQuantity - 1;
            updateTotalPrice(); // 수량 변경 시 총 결제 금액 업데이트
        }
    }

</script>

<script>
    // 바로 구매 클릭 시 실행될 함수
    function priceBye() {
      if($('#quantity').val() > ${product.quantity}) {
          alert('수량이 남은 재고를 초과할 수 없습니다!');
          $('#quantity').val(1);
          return;
      }
      location.href='/order/orderFormRight.do?quantity='+ $('#quantity').val() + '&productId=' + ${product.id}

    }


    // 장바구니에 상품 추가 함수
    function addToCart(f) {
        let quantity = f.quantity.value;  // 해당 상품의 수량 가져오기
        let productId = f.productId.value;
        let productQuantity = "${product.quantity}";

        console.log(quantity);

        let user = "${sessionScope.loginUser.id}";

        if (user === "null" || user === "") {
            alert("로그인이 필요한 서비스 입니다.");
            return;
        }

        if (productQuantity <= 0) {
            alert("현재 상품은 품절 되었습니다.\n상품 입고까지 조금만 기다려주세요.");
            return;
        }

        $.ajax({
            url: "checkCartItem",
            type: "POST",
            dataType: "json",
            data: {
                productId: productId,
                user: user,
                productQuantity: quantity // 여기에 장바구니에 추가하려는 수량을 전송
            },
            success: function (response) {
                // 현재 장바구니에 상품이 존재하면 호출
                if (response.selectProductsCart) {

                    // 해당 상품의 재고 수량을 초과할 경우
                    if (response.selectProductsQuantity) {
                        alert(response.message); // 재고초과 불가능 메시지 띄우기
                        return;
                    }

                    // 같은 상품이 있으면 수량 업데이트
                    if (confirm("해당 상품은 이미 장바구니에 등록되어 있습니다. \n수량을 추가 하시겠습니까?\n") === false) {
                        return;
                    }


                    // 장바구니 업데이트
                    f.action = "shoppingCart.do";
                    f.method = "POST";
                    f.submit();

                }
                // 같은 상품이 없을 시 반환
                else if (response.selectProductsQuantity === false) {

                    if (confirm("해당 상품을 장바구니에 추가 하시겠습니까?") === false) {
                        return;
                    }

                    // 장바구니 업데이트
                    f.action = "shoppingCart.do";
                    f.method = "POST";
                    f.submit();
                }
            },
            error: function (err) {
                alert("상품이 담기는 도중 에러가 발생 하였습니다.")
            }
        });
    }
</script>



<script>
    // 리뷰의 페이징 처리
    $(document).ready(function () {
        function loadReviews(page) {
            const productId = "${product.id}";  // 현재 페이지의 상품 ID
            $.ajax({
                url: '/reviewsPaging',
                type: 'GET',
                data: {
                    productId: productId,
                    page: page,
                    size: 5  // 한 페이지에 보여줄 리뷰 수
                },
                success: function (data) {
                    $('#productReviewList').html(generateReviewsHtml(data.reviews));
                    $('#pagination').html(generatePaginationHtml(data.startPage, data.endPage, data.currentPage, data.totalPages, data.hasPrevious, data.hasNext));
                },
                error: function (xhr, status, error) {
                    console.error("에러 발생:", error);
                }
            });
        }

        // 리뷰 목록을 HTML 형식으로 생성하는 함수
        function generateReviewsHtml(reviews) {
            let html = '<table class="review_table">';
            html += '<thead><tr><th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>별점</th></tr></thead><tbody>';

            // 각 리뷰를 테이블의 행으로 추가
            reviews.forEach(review => {
                html += '<tr>';
                html += '<td class="review_number">' + review.number + '</td>';
                html += '<td class="review_title">';

                // 이미지 아이콘 추가 (a 태그 바깥)
                if (review.imageUrl) {
                    html += '<span class="material-symbols-outlined">image</span> ';
                }

               // 제목을 a 태그로 감싸기
                html += '<a href="#" class="review-title" data-id="' + review.id + '">' + review.title + '</a>';

                html += '</td>';
                html += '<td class="review_name">' + review.userName + '</td>';
                html += '<td class="review_regdate">' + review.createdAt.substring(0, 10) + ' ' + review.createdAt.substring(11, 16) + '</td>';
                html += '<td class="review_star">';

               // 별점 출력
                for (let i = 0; i < review.rating; i++) {
                    html += '<span class="star">&#9733;</span>'; // 별점 표시
                }
                for (let i = review.rating; i < 5; i++) {
                    html += '<span class="star">&#9734;</span>'; // 빈 별 표시
                }
                html += '</td></tr>';

                // 리뷰 내용과 버튼을 포함하는 행 추가
                html += '<tr id="reviewContent-' + review.id + '" class="review-content" style="display:none;">';
                html += '<td colspan="5"><div id="spinner-' + review.id + '" class="spinner" style="display:none;">로딩 중...</div>';
                html += '<div id="reviewText-' + review.id + '" class="review-text"></div>';
                html += '<div class="review_buttons" id="reviewButtons-' + review.id + '" style="display:none;">';
                html += '<form><input type="hidden" name="userId" value="' + review.userId + '">';
                html += '<input type="hidden" name="id" value="' + review.id + '">';
                html += '<input type="hidden" name="productId" value="' + review.productId + '">';
                html += '<input type="button" class="edit_button" data-id="' + review.id + '" value="수정" onclick="update_review(this.form)">';
                html += '<input type="button" class="delete_button" data-id="' + review.id + '" value="삭제" onclick="delete_review(this.form)"></form></div></td></tr>';

                });
                html += '</tbody></table>';
                return html;
            }

        // 페이지 버튼을 HTML 형식으로 생성하는 함수
        function generatePaginationHtml(startPage, endPage, currentPage, totalPages, hasPrevious, hasNext) {
            let html = '<div class="pagination">';

            // 이전 페이지 버튼 추가
            if (hasPrevious) {
                html += '<a href="#" class="pagination-button" data-page="' + (currentPage - 1) + '">이전</a>';
            }

            // 페이지 번호 버튼 추가
            for (let i = startPage; i <= endPage; i++) {
                html += '<a href="#" class="pagination-button' + (i === currentPage ? ' active' : '') + '" data-page="' + i + '">' + i + '</a>';
            }

            // 다음 페이지 버튼 추가
            if (hasNext) {
                html += '<a href="#" class="pagination-button" data-page="' + (currentPage + 1) + '">다음</a>';
            }

            html += '</div>';
            return html;
        }

        // 페이지 버튼 클릭 시 이벤트 처리
        $(document).on('click', '.pagination-button', function (e) {
            e.preventDefault(); // 링크 클릭 기본 동작 방지
            const page = $(this).data('page'); // 클릭된 버튼의 페이지 번호
            loadReviews(page); // 해당 페이지의 리뷰를 로드
        });

        // 페이지가 로드될 때 맨처음 5개의 리스트 출력
        loadReviews(1);
    });
</script>


<script>
    // 리뷰작성 버튼 클릭 시 로그인 검증
    function reviewInsertForm(f) {

        let productId = f.productId.value;

        let userId = "${sessionScope.loginUser.id}";

        if (userId === "null" || userId === "") {
            alert("로그인이 필요한 서비스 입니다.");
            return;
        }

        $.ajax({
            url     :   "reviewValid",
            type    :   "POST",
            data    :   {productId : productId , userId : userId},
            success :   function (response){

                    if (response.reviewSuccess){

                        if (confirm("해당 상품의 리뷰를 작성 하시겠습니까?")){

                            f.action = 'reviewInsertForm.do';
                            f.method = "POST";
                            f.submit();

                        }


                    } else {
                        alert("상품의 리뷰 작성은 해당 상품을 구입하거나 배송이 완료되야 작성 가능합니다.")
                        return false;
                    }
                },
            error     :   function (error){
                alert("현재 상품정보를 읽어오는 도중 에러가 발생 했습니다.");
            }

        });







    }

</script>


<script>
    $(document).ready(function () {
        // 리뷰 제목 클릭시 발생 할 이벤트와 Ajax
        $(document).on('click', '.review-title', function (e) {
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

                    var loginUserId = parseInt("${sessionScope.loginUser.id}");

                    if (data.reviewUserId === loginUserId) {
                        reviewButtons.show();
                    } else {
                        reviewButtons.hide();
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

    $('.product-delete-button').on('click', function () {

        var productId = $(this).data('product-id');
        console.log("상품 ID : " + productId);
        if (confirm('정말 삭제하시겠습니까?')) {
            $.ajax({
                url: "productDelete.do",
                type: 'POST',
                data : {id : productId},
/*                headers: {
                    'Content-Type': 'application/json',
                },*/
                success: function (response) {
                    console.log(response);
                    // 삭제 성공 후 홈으로 이동
                    location.href = "/";
                },
                error: function (error) {
                    alert('상품 삭제에 실패했습니다.');
                    console.error('Error:', error);
                }
            });
        }
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