<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Figurium</title>
    <meta charset="UTF-8">
    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

    <style>

        .product_insert > a {
            text-decoration: none;
            color: #888;
        }

        .product_insert:hover > a {
            text-decoration: none;
            color: white;
        }

        .section-slide{
        }
        .item-slick1{
            max-height: 500px;
        }
    </style>
</head>
<body class="animsition">
<jsp:include page="./common/header.jsp"/>
<div style="height: 75px;"></div>

<c:if test="${not empty message}">
    <script>
        Swal.fire({
            icon: 'success',
            title: '알림',
            text: '${message}'
        });
    </script>
</c:if>

<c:if test="${not empty error}">
    <script>
        Swal.fire({
            icon: 'error',
            title: '오류',
            text: '${error}'
        });
    </script>
</c:if>

<!-- 장바구니 모달 -->
<div class="wrap-header-cart js-panel-cart">
    <div class="s-full js-hide-cart"></div>

    <div class="header-cart flex-col-l p-l-65 p-r-25">
        <div class="header-cart-title flex-w flex-sb-m p-b-8">
				<span class="mtext-103 cl2">
					Your Cart
				</span>

            <div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart">
                <i class="zmdi zmdi-close"></i>
            </div>
        </div>

        <div class="header-cart-content flex-w js-pscroll">
            <ul class="header-cart-wrapitem w-full">
                <li class="header-cart-item flex-w flex-t m-b-12">
                    <div class="header-cart-item-img">
                        <img src="#" alt="IMG">
                    </div>

                    <div class="header-cart-item-txt p-t-8">
                        <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
                            White Shirt Pleat
                        </a>

                        <span class="header-cart-item-info">
								1 x $19.00
							</span>
                    </div>
                </li>

                <li class="header-cart-item flex-w flex-t m-b-12">
                    <div class="header-cart-item-img">
                        <img src="#" alt="IMG">
                    </div>

                    <div class="header-cart-item-txt p-t-8">
                        <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
                            Converse All Star
                        </a>

                        <span class="header-cart-item-info">
								1 x $39.00
							</span>
                    </div>
                </li>

                <li class="header-cart-item flex-w flex-t m-b-12">
                    <div class="header-cart-item-img">
                        <img src="#" alt="IMG">
                    </div>

                    <div class="header-cart-item-txt p-t-8">
                        <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
                            Nixon Porter Leather
                        </a>

                        <span class="header-cart-item-info">
								1 x $17.00
							</span>
                    </div>
                </li>
            </ul>

            <div class="w-full">
                <div class="header-cart-total w-full p-tb-40">
                    Total: $75.00
                </div>

                <div class="header-cart-buttons flex-w w-full">
                    <a href="shoping-cart.html"
                       class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-r-8 m-b-10">
                        View Cart
                    </a>

                    <a href="shoping-cart.html"
                       class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
                        Check Out
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Slider -->
<div class="container-fluid" style="padding: 0;width: 100%;">
    <section class="section-slide">
        <div class="wrap-slick1">
            <div class="slick1">
                <div class="item-slick1"
                     style="background-image: url(/images/Slider1.jpg);">
                    <div class="container">

                    </div>
                </div>

                <div class="item-slick1"
                     style="background-image: url(/images/Slider2.jpg);">
                    <div class="container">

                    </div>
                </div>

                <div class="item-slick1"
                     style="background-image: url(/images/Slider3.jpg);">
                    <div class="container">

                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<br>
<!-- Product -->
<section class="bg0 p-t-23 p-b-140">
    <div class="container">
        <div class="p-b-10">
            <h3 class="ltext-103 cl5">
                ★ Figurium New Figure ★
            </h3>
        </div>

        <!-- 카테고리 -->
        <div class="flex-w flex-sb-m p-b-52">
            <div class="flex-w flex-l-m filter-tope-group m-tb-10">
                <button class="stext-106 " data-filter="*">
                    이달의 신상품
                </button>
            </div>


        </div>

        <!-- 상품(피규어) 조회 -->
        <div id="productsList" class="row isotope-grid">

        </div>

    </div>
</section>


<!-- Footer -->
<jsp:include page="common/footer.jsp"/>


<script>
        var lastCreatedAt = null; // 마지막 생성일자 저장
        var lastId = null; // 마지막 상품 ID 저장
        var loading = false; // 데이터 로딩 중인지 상태를 저장
        var noMoreData = false; // 더 이상 데이터가 없음을 표시

    $(document).ready(function () {
        loadMore();
        // Isotope 초기화
        var $container = $('#productsList').isotope({
            itemSelector: '.isotope-item',
            layoutMode: 'fitRows'
        });


        // 무한 스크롤 이벤트 리스너 추가
        $(window).on('scroll', function () {
            // // 화면의 푸터 영역 위에 스크롤이 도달했을 경우 loadMore() 호출.
            if ($(window).scrollTop() + $(window).height() > $(document).height() - 320) {
                if (!loading && !noMoreData) {
                    loadMore();
                }
            }
        });

    });

    function loadMore() {
        // 데이터 로딩 중인 상태로 변경
        loading = true;

        // 날짜를 원하는 형식으로 포맷 옵션
        var options = {year: 'numeric', month: 'long', day: 'numeric'};

        $.ajax({
            url: '/load-more-products',
            method: 'GET',
            data: {
                'lastCreatedAt': lastCreatedAt,
                'lastId': lastId
            },
            success: function (response) {
                const products = response;

                if (products.length === 0) {
                    noMoreData = true; // 더 이상 데이터가 없음을 표시
                } else {
                    let html = '';
                    products.forEach(function (product) {
                        // JavaScript에서 날짜 문자열을 Date 객체로 변환
                        var createdAt = new Date(product.createdAt);

                        // 날짜를 원하는 형식으로 포맷
                        var formattedDate = createdAt.toLocaleDateString('ko-KR', options);
                        html += `
                            <div class='col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item \${product.categoryName}' >
                                <div class="block2">
                                    <div class="block2-pic hov-img0">
                                        <img src="\${product.imageUrl}" alt="IMG-PRODUCT">
                                        <a href="productInfo.do?id=\${product.id}"
                                           class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04">
                                            상품 상세
                                        </a>
                                    </div>
                                    <div class="block2-txt flex-w flex-t p-t-14">
                                        <div class="block2-txt-child1 flex-col-l">
                                            <a href="productInfo.do?id=\${product.id}" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                                                \${product.name}
                                            </a>
                                            <span class="stext-105 cl3">
                                                상품 가격 : \${product.price}￦
                                            </span>
                                            <span class="stext-105 cl3">
                                                상품 등록일 : \${formattedDate}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>`;
                    });

                    // 새 아이템을 추가하고 Isotope 레이아웃을 업데이트합니다.
                    const $newItems = $(html);
                    $('#productsList').append($newItems).isotope('appended', $newItems);

                    // 마지막 생성일자 및 ID 업데이트
                    lastCreatedAt = products[products.length - 1].createdAt;
                    lastId = products[products.length - 1].id;

                    // 다음 페이지가 없으면 버튼 숨김
                    if (products.length < 20) {
                        noMoreData = true; // 더 이상 데이터가 없음을 표시
                    }

                    // 데이터 로딩 상태를 완료로 변경
                    loading = false;
                }
            },
            error: function (xhr, status, error) {
                console.error('Error loading products:', error);
                loading = false; // 에러 발생 시 로딩 상태 초기화
            }
        });

    }

</script>





</body>
</html>