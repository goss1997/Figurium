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

        .product-category a {
            color : black;
            text-decoration: none;
            font-size: 18px;
            height: 30px;
        }

        .sort_box {
            justify-content: space-between;
            align-items: center;  /* 수직 중앙 정렬 */
            margin-bottom: 30px;
        }


        .select_filter {
            padding: 5px;       /* 선택 박스의 패딩 */
            border-radius: 5px; /* 선택 박스의 둥근 모서리 */
        }

        /* 필터 박스 스타일 */
        .filter_box {
            display: flex;
            justify-content: flex-end; /* 오른쪽 정렬 */
            margin: 20px; /* 여백 추가 */
        }

        /* 선택 컨테이너 스타일 */
        .select_container {
            position: relative;
            display: inline-block;
        }

        /* 드롭다운 스타일 */
        .select_filter {
            font-size: 16px;
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-bottom-right-radius: 5px;
            border-bottom-left-radius: 5px;
            background-color: #fff;
            color: #333;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .select_filter:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 2px rgba(38, 143, 255, 0.2);
        }

        .select_filter option {
            padding: 10px;
        }

        #product-price {
            text-align: center;
        }

        /*Sold Out*/
        .block2-pic {
            position: relative;
            display: inline-block;
        }

        .block2-pic img {
            display: block;
            width: 100%;
            height: auto;
        }

        .sold-out-overlay {
            position: absolute;
            width: 525px;
            height: 525px;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 0, 0, 0.5); /* 흐림 효과를 위한 배경 */
            color: red; /* SOLD OUT 텍스트 색상 */
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
            text-transform: uppercase;
            z-index: 10; /* 이미지 위에 표시되도록 설정 */
            opacity: 0; /* 흐림 효과 */
            pointer-events: none; /* 오버레이가 클릭되지 않도록 설정 */
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
    <div class="container" style="max-width: 1230px !important;">
        <div class="p-b-10">
            <h3 class="ltext-103 cl5">
                ★ Figurium New Figure ★
            </h3>
        </div>
        <br>
        <!-- 카테고리 -->
            <div class="flex-w flex-l-m filter-tope-group m-tb-10">
                <ul class="nav justify-content-center">
                    <li class="nav-item product-category">
                        <a class="nav-link" href="javascript:void(0);">전체</a>
                    </li>
                <c:forEach var="category" items="${figureCategories}">
                    <li class="nav-item product-category">
                        <a class="nav-link" href="javascript:void(0);">${category.name}</a>
                    </li>
                </ul>
                </c:forEach>
            </div>
        <div class="sort_box">
            <!-- Filter -->
            <div class="filter_box">
                <select class="select_filter">
                    <option value="newProducts">최신순</option>
                    <option value="bestProducts">추천★상품</option>
                    <option value="highPrice">높은 가격순</option>
                    <option value="lowPrice">낮은 가격순</option>
                </select>
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
    var lastPrice = null; // 마지막 상품 가격 저장
    var lastLikeCount = null; // 마지막 좋아요 수 저장
    var categoryName = '전체'; // 조회할 카테고리 이름(기본값:전체)
    var selectFilter = 'newProducts'; // 정렬 옵션(기본값:newProducts)
    var loading = false; // 데이터 로딩 중인지 상태를 저장
    var noMoreData = false; // 더 이상 데이터가 없음을 표시

    // 카테고리 a 태그 클릭 시 실행할 함수
    $('.product-category > a').click(function () {
        // 카테고리 이름 변수에 할당.
        categoryName = $(this).text();
        // 해당 카테고리 css 변경.
        $('.product-category > a').css('font-weight','');
        $(this).css('font-weight','bold');
        // 정렬 옵션 기본값(최신순)으로 초기화.
        $('.select_filter').val('newProducts').selected;


        // 마지막 생성일자, 가격, 좋아요 수, 상품 ID 값 초기화
        lastCreatedAt = null;
        lastPrice = null;
        lastLikeCount = null;
        lastId = null;

        // 리스트 뿌릴 div 비우기.
        $('#productsList').empty();

        // 템플릿 Isotope 초기화.
        $container = $('#productsList').isotope({
            itemSelector: '.isotope-item',
            layoutMode: 'fitRows'
        });

        loadMore();
    });

    // select태그 option 선택 시 호출하는 함수
    $('.select_filter').on('change', function (){
       selectFilter = $(this).val(); // 선택한 옵션 할당.
        // categoryName을 제외한  나머지 초기화.
        lastCreatedAt = null;
        lastPrice = null;
        lastLikeCount = null;
        lastId = null;

        // 리스트 뿌릴 div 비우기.
        $('#productsList').empty();

        // 템플릿 Isotope 초기화.
        $container = $('#productsList').isotope({
            itemSelector: '.isotope-item',
            layoutMode: 'fitRows'
        });

        loadMore();
    });



    $(document).ready(function () {

        loadMore();

        // 리스트 뿌릴 div 비우기.
        $('#productsList').empty();

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
                'lastId': lastId,
                'lastPrice':lastPrice,
                'categoryName': categoryName,
                'selectFilter' : selectFilter,
                "lastLikeCount" : lastLikeCount
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
                        var options = {
                            year: 'numeric',
                            month: '2-digit',
                            day: '2-digit',
                        };

                        // 날짜를 가져와서 .으로 구분된 형식으로 변환
                        var formattedDate = createdAt.toLocaleDateString('ko-KR', options).replace(/\//g, '.');
                        html += `
                            <div class='col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item \${product.categoryName}' style='margin-top:30px;' >
                                <div class="block2">
                                    <div class="block2-pic hov-img0">
                                        <img src="\${product.imageUrl}" alt="IMG-PRODUCT">
                                        <img src="/images/soldout3.png" alt="Sold Out" class="sold-out-overlay" id="sold-out-img" style=" \${product.quantity == 0 ? 'display: block;' : 'display: none;'}">
                                        <a href="productInfo.do?id=\${product.id}"
                                           class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04">
                                            상품 상세
                                        </a>
                                    </div>
                                    <div class="block2-txt flex-w flex-t p-t-14">
                                        <div class="block2-txt-child1 flex-col-l" id="product-name" style="display: flex; flex-direction: column; align-items: center; text-align: center;">
                                            <a href="productInfo.do?id=\${product.id}" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                                               [\${product.categoryName}]  \${product.name}
                                            </a>
                                            <span class="stext-105 cl3" id="product-price" style="font-weight: bold; font-size: 16px;">
                                                \${product.price}￦
                                            </span>
                                    <div style="display: flex; width: 100%; justify-content: space-between; align-items: center; margin-top: 10px;">
                                        <span class="stext-105 cl3" style="margin-right: 5px;">
                                            \${formattedDate}
                                        </span>
                                        <span class="stext-105 cl3" id="product-like" style="font-weight: bold;">
                                            💖\${product.likeCount}
                                        </span>
                                    </div>

                                        </div>

                                    </div>
                                </div>
                            </div>`;
                    });

                    // 새 아이템을 추가하고 Isotope 레이아웃을 업데이트합니다.
                    const $newItems = $(html);
                    $('#productsList').append($newItems).isotope('appended', $newItems);

                    // 마지막 생성일자 or 마지막 가격 or 마지막 좋아요 수 or 상품 ID 업데이트
                    lastCreatedAt = products[products.length - 1].createdAt;
                    lastPrice = products[products.length - 1].price;
                    lastLikeCount = products[products.length - 1].likeCount;
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