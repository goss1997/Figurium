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
            z-index: 1; /* Sit on top */
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

        #profileImg {
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

                <!-- Menu desktop -->
                <div class="menu-desktop">
                    <ul class="main-menu">

                        <li>
                            <a href="/">Home</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/productList.do?name=전체 상품">카테고리</a>
                            <ul class="sub-menu">
                                <c:forEach var="category" items="${headerCategories}">
                                    <li><a href="${pageContext.request.contextPath}/productList.do?name=${category.name}">${category.name}</a></li>
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
                        <div id="loginBtn" class="cl2 hov-cl1 trans-04 p-l-22 p-r-11">

                            <i class="zmdi zmdi-account-circle"></i>
                        </div>
                    </c:if>
                    <c:if test="${not empty loginUser}">
                        <div class="cl2 hov-cl1 trans-04 p-l-22 p-r-11" style="font-size: 15px; text-align: center;">
                            <div>
                                <div style="display: inline-block">
                                    <img id="profileImg"
                                         src="${loginUser.profileImgUrl == null ? '/images/default-user-image.png' : loginUser.profileImgUrl }"
                                         width="40px;">
                                    <img class="usercard-grade" src="/images/star6.gif">
                                </div>
                                <div style="display: inline-block">
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


                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-cart"
                    >
                        <i class="zmdi zmdi-shopping-cart"></i>
                    </div>

                    <a href="#" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11"
                    >
                        <i class="zmdi zmdi-favorite-outline"></i>
                    </a>

                    <%--알림 버튼 --%>
                    <div>
                        <div style="display: inline-block">
                            <ul class="main-menu">
                                <li style="padding : 0;">
                                    <div class="icon-header-item cl2 hov-c12 trans-04 p-l-22 p-r-11">
                                        <i class="zmdi zmdi-notifications"></i>
                                    </div>
                                    <ul id="notification"
                                        style="margin-top: 15px; max-width: 800px!important; width: 500px !important; max-height: 600px !important; overflow: scroll !important; height: 600px !important; border-radius: 15px;"
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

                        <div style="width: 100%;">――――― 간편 로그인 ―――――</div>
                        <br>
                        <div>
                            <!-- Google Login Button -->
                            <a href="/oauth2/authorization/google" class="login-button">
                                <img src="/images/social/google_login_btn.png" alt="Google Logo">
                            </a>

                            <!-- Naver Login Button -->
                            <a href="/oauth2/authorization/naver" class="login-button">
                                <img src="/images/social/naver_login_btn.png" alt="Naver Logo">
                            </a>

                            <!-- Kakao Login Button -->
                            <a href="/oauth2/authorization/kakao" class="login-button">
                                <img src="/images/social/kakao_login_btn.png" alt="Kakao Logo">
                            </a>
                        </div>
                        <br>
                    </div>
                </div>
            </nav>
        </div>
    </div>

    <!-- Header Mobile -->
    <div class="wrap-header-mobile">
        <!-- Logo moblie -->
        <div class="logo-mobile">
            <a href="#" class="logo">
                <img src="/images/FiguiumLOGO3.png" alt="LOGO">
            </a>
        </div>

        <!-- Icon header -->
        <div class="wrap-icon-header flex-w flex-r-m m-r-15">
            <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11">
                <i class="zmdi zmdi-account-circle"></i>
            </div>

            <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 js-show-modal-search">
                <i class="zmdi zmdi-search"></i>
            </div>

            <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart"
                 data-notify="2">
                <i class="zmdi zmdi-shopping-cart"></i>
            </div>

            <a href="#" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
               data-notify="0">
                <i class="zmdi zmdi-favorite-outline"></i>
            </a>
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


            <li>
                <a href="shopingCart.do">장바구니</a>
            </li>

            <li>
                <a href=${pageContext.request.contextPath}qaList.do">Q&A</a>
            </li>
        </ul>
    </div>

</header>


<script>
    /**
     * 로그인 모달 띄우기
     */
    document.addEventListener('DOMContentLoaded', () => {
        const modal = document.getElementById('loginModal');
        const btn = document.getElementById('loginBtn');
        const span = document.getElementsByClassName('login-modal-close')[0];

        // Open the modal
        if (btn) {
            btn.onclick = function () {
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
            url: '/save-url',  // 서버의 URL (예: 서블릿 매핑)
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
        $(function(){
            $.ajax({
               url : '/api/notifications/user/${loginUser.id}',
               method : 'GET',
               success : function (notifications) {
                    if(notifications.length === 0) {
                        $("#notification-list-area").prepend('<h4 style="text-align: center;">알림이 없습니다.</h4>');
                    } else {
                        let appendForm;
                            console.log(notifications[0]);
                            console.log(notifications[1]);
                            console.log(notifications[2]);
                            console.log(notifications[3]);
                            console.log(notifications[4]);
                        for (const notification of notifications ) {
                            appendForm = '<li style="font-size: 18px; cursor: pointer;" onclick="location.href=\'' + notification.url + '\'">' +
                                        '<i class="zmdi zmdi-comment-alert" style="font-size: 18px; margin-left: 10px;"> ' +
                                        notification.message + '</i>' +
                                        '</li>';
                            // 알림 객체 알림 모달 맨위에 추가.
                            $("#notification-list-area").append(appendForm);
                        }

                    }
               },
               error: function(xhr, status, error) {
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

            let appendForm = '<li style="font-size: 18px; cursor: pointer;" onclick="location.href=\'' + notification.url + '\'">' +
                '<i class="zmdi zmdi-comment-alert" style="font-size: 18px; margin-left: 10px;"> ' +
                notification.message + '</i>' +
                '</li>';

            // 알림 객체 알림 모달 맨위에 추가.
            $("#notification-list-area").prepend(appendForm);

        });


    </script>
</c:if>


<%--<script>--%>

<%--   eventSource.addEventListener('DOMContentLoaded', function() {--%>
<%--            const notificationContainer = document.getElementById('notification');--%>

<%--            // SSE 연결 설정--%>
<%--            const eventSource = new EventSource('/api/notifications/subscribe');--%>

<%--            eventSource.onmessage = function(event) {--%>
<%--                const notification = JSON.parse(event.data);--%>

<%--                // 새로운 알림 항목 생성--%>
<%--                const notificationItem = document.createElement('li');--%>
<%--                notificationItem.style.fontSize = '18px';--%>
<%--                notificationItem.innerHTML = `<i class="zmdi zmdi-comment-alert" style="font-size: 18px; margin-left: 10px;">--%>
<%--                    ${notification.message} ${notification.createdAt.substring(0, 10)} ${notification.createdAt.substring(11, 16)}--%>
<%--                </i>`;--%>

<%--                notificationContainer.appendChild(notificationItem);--%>
<%--            };--%>

<%--            // 모든 알림 삭제 처리--%>
<%--            document.getElementById('deleteAllNotifications').addEventListener('click', function() {--%>
<%--                fetch('/api/notifications/deleteAll', { method: 'DELETE' })--%>
<%--                    .then(response => response.text())--%>
<%--                    .then(result => {--%>
<%--                        alert(result);--%>
<%--                        notificationContainer.innerHTML = ''; // 알림 목록 비우기--%>
<%--                    });--%>
<%--            });--%>
<%--        });--%>
<%--</script>--%>

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


</body>
</html>
