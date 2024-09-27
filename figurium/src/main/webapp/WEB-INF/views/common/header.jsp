<%--
  Created by IntelliJ IDEA.
  User: 14A
  Date: 2024-08-26
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="/images/FiguriumHand.png"/>
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="/vendor/bootstrap/css/bootstrap.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="/fonts/iconic/css/material-design-iconic-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="/fonts/linearicons-v1.0.0/icon-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="/vendor/animate/animate.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="/vendor/css-hamburgers/hamburgers.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="/vendor/animsition/css/animsition.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="/vendor/select2/select2.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="/vendor/daterangepicker/daterangepicker.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/vendor/slick/slick.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="/vendor/MagnificPopup/magnific-popup.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="/vendor/perfect-scrollbar/perfect-scrollbar.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/css/util.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <!--===============================================================================================-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'>
    <!--===============================================================================================-->
    <!-- bootstrap4 & jquery -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>제목</title>

    <style>
        #content-wrap-area {
            min-height: 1000px;
        }

        .categori {
            cursor: pointer;
        }

        .categori {
            color: #0056b3;
        }

        /* The Modal (background) */
        .login-modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 2000; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: hidden; /* Enable scroll if needed */
            background-color: rgb(0, 0, 0); /* Fallback color */
            background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .login-modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 28%; /* Could be more or less, depending on screen size */
            text-align: center;
            border-radius: 10px;
        }

        /* The Close Button */
        .login-modal-close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .login-modal-close:hover,
        .login-modal-close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }


        .login-button {
            margin: 10px;
            width: 10%;
            cursor: pointer;
            text-decoration: none;
        }

        .login-button img {
            width: 10%;
            aspect-ratio: 1 / 1;
        }

        .login-button img:hover {
            transform: scale(1.2);
        }

        .login-form {
            margin-bottom: 20px;

        }

        .login-form input {
            margin: auto;
            padding: 10px;
            border: 1px solid #dddddd;
            border-radius: 5px;
        }

        .login-input-area input {
            margin-bottom: 5px;
            width: 70%;

        }

        .login-form button {
            margin-top: 10px;
            padding: 10px;
            width: 20%;
            background-color: #4CAF50;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }

        .login-form button:hover {
            background-color: #45a049;
        }

        .profileImg {
            width: 35px;
            height: 35px;
            object-fit: cover;
            border-radius: 50%;
        }

        .usercard-grade {
            width: 20px;
            height: 20px;
            object-fit: cover;

            margin-right: -15px;
            margin-bottom: 5px;
        }

        .find-password {
            text-align: right;
            font-size: 12px;
            margin-right: 15%;
            height: 24px;
            margin-top: 5px;
            margin-bottom: 5px;
        }

        .find-password a {
            color: black;
        }

        .find-password a:hover {
            font-weight: bold;
            font-size: 13px;
        }

        #notification-list-area i:hover {
            font-weight: bold;

        }

        .cart-container {
            position: relative;
            display: inline-block;
        }

        .cart-item-count {
            display: none;
            position: absolute;
            top: -6px; /* 아이콘 위쪽 */
            right: -5px; /* 아이콘 오른쪽 */
            background-color: red; /* 배경색 */
            color: white; /* 글자색 */
            border-radius: 50%; /* 동그란 모양 */
            width: 16px; /* 너비 */
            height: 16px; /* 높이 */
            text-align: center; /* 가운데 정렬 */
            line-height: 14px; /* 가운데 정렬 */
            font-size: 14px; /* 폰트 크기 */
        }

        .cartImage {
            margin-left: 10px;
            margin-top: 2px;
            filter: brightness(0) invert(0.2); /* #333색상 흉내 */
            transition: filter 0.3s ease, transform 0.3s ease;
        }

        a:hover .cartImage {
            filter: brightness(0) saturate(100%) hue-rotate(180deg) brightness(1.2); /* #157ab3 색상 흉내 */
            transform: scale(1.1); /* 아이콘 크기 확대 */
        }

    /* 반응형 스타일 추가 */
    @media only screen and (max-width: 1200px) {
        .login-modal-content {
            width: 40%; /* Large screens */
        }
    }

    @media only screen and (max-width: 992px) {
        .login-modal-content {
            width: 50%; /* Medium screens */
        }
        .login-input-area input {
            width: 80%; /* Adjust input size */
        }
        .login-form button {
            width: 30%; /* Adjust button size */
        }
    }

    @media only screen and (max-width: 768px) {
        .login-modal-content {
            width: 70%; /* Small screens */
        }
        .login-input-area input {
            width: 90%; /* Adjust input size */
        }
        .login-form button {
            width: 40%; /* Adjust button size */
        }
    }

    @media only screen and (max-width: 576px) {
        .login-modal-content {
            width: 90%; /* Extra small screens */
        }
        .login-input-area input {
            width: 100%; /* Full width input */
        }
        .login-form button {
            width: 50%; /* Adjust button size */
        }
        .login-button img {
            width: 30px; /* Adjust login button size */
        }
    }

    /* 카테고리 드롭다운 */
    .dropdown-categories {
    display: none; /* 기본적으로 숨기기 */
    }

    .dropdown_categories li > a {
        margin-left: 20px;
        display: block; /* 블록 요소로 설정하여 간격을 조정 */
        padding: 10px; /* 위아래 간격 */
        padding-left: 20px;
        color: white; /* 글자 색을 흰색으로 설정 */
        text-decoration: none; /* 밑줄 없애기 */
    }

    .dropdown_categories li:hover {
        text-decoration: underline; /* 마우스 오버 시 밑줄 추가 */
        font-weight: bold; /* 마우스를 가져다 대면 글씨를 볼드체로 설정 */
    }

    /* 모바일 검색기능 모달 */
    #search-modal {
        display: none; /* 기본적으로 숨김 */
        position: fixed; /* 스크롤 해도 고정 */
        z-index: 1000; /* 가장 위에 표시 */
        left: 0;
        top: 0;
        width: 100%; /* 전체 너비 */
        height: 100%; /* 전체 높이 */
        background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
    }

    .modal-content {
        background-color: white; /* 모달 배경 색 */
        margin: 15% auto; /* 화면 중앙에 위치 */
        padding: 20px;
        border: 1px solid #888;
        width: 80%; /* 모달 너비 */
        text-align: center; /* 가운데 정렬 */
    }

    .close-button {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close-button:hover,
    .close-button:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    .mobile_search {
        border: 1px solid #c3c3c3;
        width: 100%;
        height: 50px;
        padding-left: 10px;
        border-radius: 5px 0 0 5px; /* 좌측 모서리 둥글게 */
    }

    .mobile_search_btn {
        border: 1px solid black;
        width: 80px; /* 버튼 너비 조정 */
        height: 50px; /* 버튼 높이 조정 */
        margin-left: -5px; /* 검색 필드와 버튼의 경계 겹치기 */
        background-color: black; /* 배경색 */
        color: white; /* 글자색 */
        border-radius: 0 5px 5px 0; /* 우측 모서리 둥글게 */
        cursor: pointer; /* 커서 변경 */
    }

    .mobile_search_btn:hover {
        background-color: #444; /* 마우스 오버 시 색상 변경 */
    }

    .search-modal {
        display: none; /* 기본적으로 숨김 */
        position: fixed; /* 화면에 고정 */
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
        justify-content: center;
        align-items: center;
    }

    .modal-content {
        background-color: white; /* 모달 배경색 */
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    }


    </style>


</head>
<c:if test="${not empty alertMsg}">

    <script>
        // 0.1초 (100 밀리초) 후에 alert을 실행
        setTimeout(function () {
            alert('${alertMsg}');
        }, 100);
    </script>
    <c:remove var="alertMsg"/>
</c:if>
<body>
<!-- Header -->
<header>
    <!-- Header desktop -->
    <div class="container-menu-desktop">

        <div class="wrap-menu-desktop">
            <nav class="limiter-menu-desktop container">

                <!-- Logo desktop -->
                <a href="/" class="logo" style="margin-left: -40px;">
                    <img src="/images/FiguiumLOGO3.png" alt="LOGO">
                </a>
                <script>
                    $(function () {
                        $('a[href="/"]').click(function () {
                            // sessionStorage 초기화
                            sessionStorage.clear();
                        });
                    });
                </script>
                <!-- Menu desktop -->
                <div class="menu-desktop">
                    <ul class="main-menu">

                        <li>
                            <a href="/">Home</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/productList.do?name=전체 상품">카테고리</a>
                            <ul class="sub-menu">
                                <c:forEach var="category" items="${figureCategories}">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/productList.do?name=${category.name}">${category.name}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>

                        <li <%--class="label1" data-label1="hot"--%>>
                            <a href="${pageContext.request.contextPath}/CartList.do">장바구니</a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/qa/qaList.do">Q&A</a>
                        </li>
                    </ul>
                </div>

                <!-- Icon header -->
                <div class="wrap-icon-header flex-w flex-r-m">
                    <!-- NOTE : 로그인 아이콘 -->
                    <c:if test="${empty loginUser}">
                        <div id="loginBtn" class="cl2 hov-cl1 trans-04 p-l-22 p-r-11" style="margin-top: 6px;">

                            <i class="zmdi zmdi-account-circle"></i>
                        </div>
                    </c:if>
                    <c:if test="${not empty loginUser}">
                        <div class="cl2 hov-cl1 trans-04 p-l-22 p-r-11" style="font-size: 15px; text-align: center;">
                            <div>
                                <div style="display: inline-block">
                                    <img class="profileImg"
                                         src="${loginUser.profileImgUrl == null ? '/images/default-user-image.png' : loginUser.profileImgUrl }"
                                         width="40px;">
                                    <img class="usercard-grade" src="/images/star6.gif">
                                </div>
                                <div style="display: inline-block; ">
                                    <ul class="main-menu">
                                        <li style="padding : 0;">
                                            <a href="#">${loginUser.name}</a>
                                            <ul style="margin-top: 15px;" class="sub-menu">
                                                <c:if test="${loginUser.role == '1'}">
                                                    <li><a href="/admin.do">관리자페이지</a></li>
                                                </c:if>
                                                <li><a href="/user/my-page.do">마이페이지</a></li>
                                                <li><a href="/user/myProductLikeList.do">관심 상품</a></li>
                                                <li><a href="/user/order-list.do">주문 내역</a></li>
                                                <li><a href="#">반품 내역</a></li>
                                                <li style="font-weight: bold;"><a href="/user/logout.do">로그아웃</a></li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- 장바구니 상품갯수 출력 -->
                    <div class="cart-container">
                        <a href="#" onclick="cartList();">
                            <img class="cartImage" src="/images/icons/cartLogo.png" alt="Shopping Cart Icon"
                                 style="width: 24px; height: 24px;">
                        </a>
                        <span id="cart-item-count" class="cart-item-count"></span>
                    </div>

                    <script>
                        function cartList() {

                            let user = "${sessionScope.loginUser}";

                            if (user === "null" || user === "") {
                                alert("로그인이 필요한 서비스 입니다.");
                                return;
                            }


                            if (confirm("장바구니로 이동 하시겠습니까?")) {
                                location.href = "${pageContext.request.contextPath}/CartList.do";
                            }
                        }

                    </script>


                    <%--알림 버튼 --%>
                    <c:if test="${not empty loginUser}">
                    <div>
                        <div style="display: inline-block">
                            <ul class="main-menu">
                                <li style="padding : 0;">
                                    <div class="icon-header-item cl2 hov-c12 trans-04 p-l-2 p-r-11">
                                        <i class="zmdi zmdi-notifications"></i>
                                    </div>
                                    <ul id="notification"
                                        style="margin-top: 15px; max-width: 800px!important; width: 600px !important; max-height: 600px !important; overflow-y: scroll !important; height: 600px !important; border-radius: 15px;"
                                        class="sub-menu">
                                        <h2 style="text-align: center;">Notification</h2>
                                        <hr>
                                        <div id="notification-list-area">

                                        </div>
                                        <li style="color: #ff5f5f; text-align: center; font-size: 20px;" onclick="">모든 알림 삭제</li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    </c:if>

                    <!-- 상품 검색 -->
                    <div class="search_box">
                        <form>
                            </ul>
                            <input id="search_products_box" class="search_products_box" type="text" name="search"
                                   placeholder="Search.." autocomplete="off">
                            <button class="search_btn" style="display: inline-block;"
                                    onclick="searchProduct(this.form)">
                                <i class="zmdi zmdi-search"></i>
                            </button>
                        </form>
                        <!-- 인기 검색어 드롭다운 메뉴 -->
                        <ul id="popularSearches" class="dropdown-menu" style="display:none;"></ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>

    <!-- Header Mobile -->
    <div class="wrap-header-mobile">
        <!-- Logo moblie -->
        <div class="logo-mobile">
            <a href="${pageContext.request.contextPath}/" class="logo">
                <img src="/images/FiguiumLOGO3.png" alt="LOGO">
            </a>
        </div>



        <!-- Icon header -->
        <div class="wrap-icon-header flex-w flex-r-m m-r-15">

        <!-- NOTE : 로그인 아이콘 -->
        <c:if test="${empty loginUser}">
            <div id="mobileLoginBtn" class="cl2 hov-cl1 trans-04 p-l-22 p-r-11" style=" font-size: 24px;">
                <i class="zmdi zmdi-account-circle"></i>
            </div>
        </c:if>
        <c:if test="${not empty loginUser}">
            <div class="cl2 hov-cl1 trans-04 p-l-22 p-r-11" style="font-size: 15px; text-align: center;">
                <div>
                    <div style="display: inline-block">
                        <img class="profileImg"
                             src="${loginUser.profileImgUrl == null ? '/images/default-user-image.png' : loginUser.profileImgUrl }"
                             width="40px;">
                        <img class="usercard-grade" src="/images/star6.gif">
                    </div>
                    <div style="display: inline-block">
                        <ul class="main-menu" style="position: relative; z-index: 1050;">
                            <li style="padding : 0;">
                                <a href="#">${loginUser.name}</a>
                                <ul style="margin-top: 15px;" class="sub-menu">
                                    <c:if test="${loginUser.role == '1'}">
                                        <li><a href="/admin.do">관리자페이지</a></li>
                                    </c:if>
                                    <li><a href="/user/my-page.do">마이페이지</a></li>
                                    <li><a href="/user/myProductLikeList.do">관심 상품</a></li>
                                    <li><a href="/user/order-list.do">주문 내역</a></li>
                                    <li style="font-weight: bold;"><a href="/user/logout.do">로그아웃</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>

            <!-- 검색 기능 -->
            <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 search_products">
                <i class="zmdi zmdi-search"></i>
            </div>

            <!-- 검색 모달 -->
           <div class="search-modal" id="search-modal" style="display: none;">
               <form>
                    <div class="modal-content" style="border-radius: 10px; padding: 20px;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <h2>상품 검색</h2>
                            <span class="close-button" style="cursor: pointer;">&times;</span>
                        </div>
                        <div style="display: flex; margin-top: 20px;">
                            <input class="mobile_search" type="text" placeholder="Search..." name="search"  />
                            <input type="button" class="mobile_search_btn" value="Search" onclick="searchProduct(this.form)">
                        </div>
                    </div>
                </form>
            </div>




             <!-- 장바구니 아이콘 -->
                    <div class="cart-container">
                        <a href="#" onclick="cartList();">
                            <img class="cartImage" src="/images/icons/cartLogo.png" alt="Shopping Cart Icon"
                                 style="width: 24px; height: 24px;">
                        </a>
                    </div>

        </div>

        <!-- Button show menu -->
        <div class="btn-show-menu-mobile hamburger hamburger--squeeze">
				<span class="hamburger-box">
					<span class="hamburger-inner"></span>
				</span>
        </div>
    </div>


    <!-- Menu Mobile -->
    <div class="menu-mobile">
        <ul class="main-menu-m">
            <li>
                <a href="/">Home</a>
            </li>
            <li class="dropdown_categories">
                <a href="#" class="categories-toggle">카테고리</a>
                <ul class="dropdown-categories">
                    <li class="dropdown_subcategories">
                        <a href="${pageContext.request.contextPath}/productList.do?name=전체 상품">전체 상품</a>
                    </li>
                    <li class="dropdown_subcategories">
                        <a href="${pageContext.request.contextPath}/productList.do?name=메가하우스">메가하우스</a>
                    </li>
                    <li class="dropdown_subcategories">
                        <a href="${pageContext.request.contextPath}/productList.do?name=반다이">반다이</a>
                    </li>
                    <li class="dropdown_subcategories">
                        <a href="${pageContext.request.contextPath}/productList.do?name=반프레스토">반프레스토</a>
                    </li>
                    <li class="dropdown_subcategories">
                        <a href="${pageContext.request.contextPath}/productList.do?name=세가">세가</a>
                    </li>
                    <li class="dropdown_subcategories">
                        <a href="${pageContext.request.contextPath}/productList.do?name=후류">후류</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/CartList.do">장바구니</a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/qa/qaList.do">Q&A</a>
            </li>
        </ul>
    </div>

    <script>
    $(document).ready(function() {
    // 카테고리 메뉴 클릭 시 드롭다운 토글
    $('.categories-toggle').click(function(event) {
        event.preventDefault(); // 기본 링크 동작 방지
        $(this).siblings('.dropdown-categories').slideToggle(); // 서브 메뉴 토글
    });
});

</script>



    <!-- Login Modal Structure -->
    <div id="loginModal" class="login-modal">
        <div class="login-modal-content">
            <span class="login-modal-close">&times;</span>

            <h2>Login</h2>
            <br>
            <!-- 개인 회원 로그인 폼 -->
            <div class="login-form">
                <div class="login-input-area">
                    <input type="email" class="form-control" id="email" name="email" placeholder="Email"
                           required>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="Password" required>
                </div>
                <div class="find-password">
                    <a href="/user/find-password-form.do">비밀번호 찾기</a>
                </div>
                <input type="button" class="btn btn-secondary" value="로그인" onclick="login();"/>
                <input type="button" class="btn btn-secondary" value="회원가입"
                       onclick="location.href='/user/signup-form.do';"/>
            </div>

            <hr>
            <br>
            <div>
                <!-- Google Login Button -->
                <a href="${pageContext.request.contextPath}/oauth2/authorization/google" class="login-button">
                    <img src="/images/social/google_login_btn.png" alt="Google Logo">
                </a>

                <!-- Naver Login Button -->
                <a href="${pageContext.request.contextPath}/oauth2/authorization/naver" class="login-button">
                    <img src="/images/social/naver_login_btn.png" alt="Naver Logo">
                </a>

                <!-- Kakao Login Button -->
                <a href="${pageContext.request.contextPath}/oauth2/authorization/kakao" class="login-button">
                    <img src="/images/social/kakao_login_btn.png" alt="Kakao Logo">
                </a>
            </div>
            <br>
        </div>
    </div>
</header>


<script>
    // 장바구니에 담겨있는 상품 수 나타내기
    $(document).ready(function () {


        $.ajax({
            url: "${pageContext.request.contextPath}/cartItemCount",
            method: 'GET',
            success: function (data) {

                if (data > 0) {
                    $('#cart-item-count').text(data);
                    $('#cart-item-count').show();
                } else {
                    $('#cart-item-count').hide();
                }
            },
            error: function (err) {
                alert("에러 발생");
            }
        });
    });
</script>

<script>
    /**
     * 로그인 모달 띄우기
     */
    document.addEventListener('DOMContentLoaded', () => {
        const modal = document.getElementById('loginModal');
        const btn = document.getElementById('loginBtn');
        const mobileLoginBtn = document.getElementById('mobileLoginBtn');
        const span = document.getElementsByClassName('login-modal-close')[0];

        // Open the modal Desktop
        if (btn) {
            btn.onclick = function () {
                modal.style.display = 'block';
            }
        }

        // Open the modal Mobile
        if (mobileLoginBtn) {
            mobileLoginBtn.onclick = function () {
                modal.style.display = 'block';
            }
        }

        // Close the modal when the user clicks on <span> (x)
        span.onclick = function () {
            modal.style.display = 'none';
        }

        // Close the modal when the user clicks anywhere outside of the modal
        window.onclick = function (event) {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        }

    });

    /**
     * Enter 키 press 시 로그인 함수 실행.
     */
    // 로그인 모달이 켜신 상태에서만 엔터키로 로그인하기.
    $('#password').on('keydown', function (e) {
        if (e.key === 'Enter') {
            if (!$("#loginModal").hidden) {
                console.log('모달 숨었니? : ' + $("#loginModal").hidden);
                login();
            }
        }
    });


    /**
     * 로그인
     */
    function login() {
        let email = $("#email").val();
        let password = $("#password").val();

        if (!(email && password)) {
            alert("이메일 혹은 비밀번호를 입력해주세요!");
            return;
        }

        // 이메일 유효성 체크
        if (emailCheck(email)) {
            // 유효한 이메일일 경우

            // 로그인 요청 ajax
            $.ajax({
                url: '/user/login.do',
                method: 'post',
                data: {email: email, password: password},
                success: function (result) {
                    location.reload();
                },
                error: function (error) {
                    // 에러가 발생하면 서버로부터 응답 메시지를 받아 alert 창 띄우기
                    alert(error.responseText);  // 서버에서 전송한 에러 메시지를 alert로 출력
                }
            });


        } else {
            alert("유효하지 않은 이메일 주소입니다.");
        }

    }

    /**
     * 이메일 유효성 체크 함수
     */
    function emailCheck(email) {
        let email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
        if (!email_regex.test(email)) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 소셜 로그인 버튼 클릭 시 현재 url을 session에 저장
     */
    $('.login-button').click(function () {

        const currentUrl = window.location.href;
        // 서버로 AJAX 요청 보내기
        $.ajax({
            url: '/url',  // 서버의 URL (예: 서블릿 매핑)
            type: 'POST',
            data: {url: currentUrl},  // URL을 데이터로 전송
            success: function () {
                console.log('URL이 서버 세션에 저장되었습니다.');
            },
            error: function (xhr, status, error) {
                console.error('URL 저장 실패:', error);
            }
        });

    });


</script>

<c:if test="${loginUser != null}">
    <script>
        /**
         * 사용자 알림 리스트 가져오기
         */
        $(function () {
            $.ajax({
                url: '/api/notifications/user/${loginUser.id}',
                method: 'GET',
                success: function (notifications) {
                              // 알림이 없으면
                    if (notifications.length === 0) {
                        $("#notification-list-area").prepend('<h4 style="text-align: center;">알림이 없습니다.</h4>');
                        $(".icon-header-item").removeClass('has-notifications');
                    } else {
                        // 알림이 있는 경우
                        let hasUnread = notifications.some(notification => notification.isRead == 0);
                        if (hasUnread) {
                            $(".icon-header-item").addClass('has-notifications'); // 안 읽은 알림이 있을 시 점 표시
                        } else {
                            $(".icon-header-item").removeClass('has-notifications'); // 모든 알림이 읽음
                        }
                        let appendForm;
                        for (const notification of notifications) {


                            if (notification.isRead == 0){

                            // 알림 객체를 li로 이쁘게 변환하는 함수
                            appendForm = transNotification(notification);
                            }else if (notification.isRead == 1){
                                appendForm =  transReadNotification(notification);
                            }

                            // 알림 객체 알림 모달 맨위에 추가.
                            $("#notification-list-area").append(appendForm);

                        }

                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error fetching data:', error);
                }
            });
        });

        /**
         * 로그인한 사용자면 SSE 연결
         */
            // EventSource 생성 후 SSE 연결하는 함수.
        const eventSource = new EventSource('/api/notifications/subscribe');
        eventSource.addEventListener('SSE-Connect', event => {
            console.log(event.data);
        });

        // 알림 이벤트 읽는 함수(message용)
        eventSource.addEventListener('message', event => {
            // JSON 파싱
            console.log('[단순 메세지 알림]');
            console.log(event.data);
        });

        // 알림 이벤트 읽는 함수(Notification 객체용)
        eventSource.addEventListener('notification', event => {
            console.log('[알림]');
            // JSON 파싱
            const notification = JSON.parse(event.data);
            console.log(notification.url);
            console.log(notification.message);

            // 알림 객체를 li로 이쁘게 변환하는 함수

            let appendForm = transNotification(notification);

            // 알림 객체 알림 모달 맨위에 추가.
            $("#notification-list-area").prepend(appendForm);

            $(".icon-header-item").addClass('has-notifications');

        });


        /**
         * 알림의 isRead를 true로 바꾸기(ajax) + 해당 url로 이동시키기
         */
        function isReadTrue(notification) {

            // ', ' 기준으로 왼쪽과 오른쪽 분리
            const parts = notification.split(',');

            // 왼쪽 부분 (id: ?)
            const id = parts[0].trim();

            // 오른쪽 부분 (/qa/qaSelect.do?id=?)
            const url = parts[1].trim();

            $.ajax({
                url: '/api/notifications/read/' + id, // 알림 읽음 처리 URL
                method: 'PUT', // PUT 메서드 사용
                success: function () {
                    $(".icon-header-item").removeClass('has-notifications');
                    // 성공 시 해당 url로 이동
                    location.href = url;
                },
                error: function (xhr, status, error) {
                    console.error('알림을 읽음으로 표시하는 중 오류가 발생했습니다.', error);
                }
            });
        }

        /**
         * 알림 객체를 li로 변환하는 함수
         */
        /* 알람을 읽었을때  isRead  false*/
        function transNotification(notification) {

            const createdAt = new Date(notification.createdAt);
            const date = createdAt.toISOString().substring(0, 10); // yyyy-mm-dd
            const time = createdAt.toTimeString().substring(0, 5); // hh:mm
            const id =  notification.id;
            const url = notification.url;


            let appendForm = '<li style="font-size: 18px; cursor: pointer;" onclick="isReadTrue(\'' + id + ',' + url + '\');">' +
                '<i class="zmdi zmdi-comment-alert" style="font-size: 18px; margin-left: 10px;"> ' +
                notification.message + '</i>' +
                '<span style="font-size:14px; color:gray;">' + date + ' ' + time + '</span>' +
                '</li>';

            return appendForm;
        }

        /* 알람을 읽었을때  isRead  true*/
        function transReadNotification(notification) {
            const createdAt = new Date(notification.createdAt);
            const date = createdAt.toISOString().substring(0, 10);
            const time = createdAt.toTimeString().substring(0, 5);
            const id =  notification.id;
            const url = notification.url;

            return'<li class="dropdown-item dropdown-item-style read" style="cursor: pointer; width: calc(100%); position: relative; background-color: lightgray;" onclick="isReadTrue(\'' + id + ',' + url + '\');">' +
    '<div class="d-flex align-items-center" style="width: 100%;">' +
        '<i class="zmdi zmdi-check-circle" style="font-size: 18px; margin-right: 10px;"></i>' +
        '<div class="flex-grow-1">' +
            '<span class="highlight-notification" style="font-size: 18px;">' + notification.message + '</span>' +
            '<small class="text-muted" style="font-size: 12px; color: lightgray;">' + date + ' ' + time + '</small>' +
        '</div>' +
        '<i class="zmdi zmdi-close" style="cursor: pointer; position: absolute; right: 15px; top: 50%; transform: translateY(-50%);" onclick="event.stopPropagation(); deleteNotification(this)"></i>' +
    '</div>' +
'</li>';
}


    function deleteNotification(element) {
         const li = element.closest('li'); // li 요소 찾기
        if (li) {
            li.remove();
        }
    }
</script>
</c:if>


<script>
    function searchProduct(f) {

        let search = f.search.value;

        if (search === "") {
            alert("검색하실 상품을 입력해 주세요")
            return false;
        }

        if (search === " ") {
            alert("공백은 입력하실 수 없습니다.")
            return false;
        }

        f.method = "GET";
        f.action = "searchProductsList.do?search=" + search;
        f.submit();


    }
</script>

<script>
    // 검색어 입력 필드를 클릭했을 때 인기 검색어를 불러오는 AJAX 요청
    $(document).ready(function () {
        $('.search_products_box').on('focus', function () {
            // AJAX로 인기 검색어 가져오기
            $.ajax({
                url: '/searchRank',
                method: 'GET',
                success: function (data) {
                    var searchList = $('#popularSearches');
                    var searchHtml = ''; // HTML을 담을 변수

                    if (data.length > 0) {
                        // 인기 검색어 리스트의 헤더를 추가
                        searchHtml += '<li class="dropdown-header" style="text-align: center; font-weight: bold; font-size: 17px;">★ 인기 검색어 순위 ★</li>';

                        // 각 인기 검색어에 대한 항목을 HTML로 생성
                        $.each(data, function (index, searchTerm) {
                            searchHtml += '<li style="margin-left: 15px"><a href="/searchProductsList.do?search=' + encodeURIComponent(searchTerm) + '">' + (index + 1) + '. ' + searchTerm + '</a></li>';
                        });
                    } else {
                        // 인기 검색어가 없을 경우
                        searchHtml += '<li>인기 검색어가 없습니다.</li>';
                    }

                    // 완성된 HTML을 드롭다운 메뉴에 삽입
                    searchList.html(searchHtml);
                    searchList.show(); // 드롭다운 메뉴 보이기
                }
            });
        });

        // 검색어 입력 필드 밖을 클릭하면 드롭다운 메뉴 숨기기
        $(document).on('click', function (event) {
            if (!$(event.target).closest('.search_box').length) {
                $('#popularSearches').hide();
            }
        });
    });
</script>

<script>
    // 검색 기능 모달
    $(document).ready(function() {
        $(".search_products").on("click", function() {
            $("#search-modal").show(); // 모달 보여주기
        });

        $(".close-button").on("click", function() {
            $("#search-modal").hide(); // 모달 닫기
        });

        $(window).on("click", function(event) {
            if (event.target.id === "search-modal") {
                $("#search-modal").hide();
            }
        });
    });



</script>

</body>
</html>
