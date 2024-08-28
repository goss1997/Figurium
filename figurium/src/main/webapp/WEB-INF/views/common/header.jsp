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
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/FiguriumHand.png"/>
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/fonts/iconic/css/material-design-iconic-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/fonts/linearicons-v1.0.0/icon-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/vendor/animate/animate.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/vendor/css-hamburgers/hamburgers.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/vendor/animsition/css/animsition.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/vendor/select2/select2.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/vendor/daterangepicker/daterangepicker.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/vendor/slick/slick.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/vendor/MagnificPopup/magnific-popup.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/vendor/perfect-scrollbar/perfect-scrollbar.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/util.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css">
    <!--===============================================================================================-->
    <!-- bootstrap4 & jquery -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>제목</title>

    <style>
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
            height: 100%;
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

    </style>

</head>
<body>
<!-- Header -->
<header>
    <!-- Header desktop -->
    <div class="container-menu-desktop">

        <div class="wrap-menu-desktop">
            <nav class="limiter-menu-desktop container">

                <!-- Logo desktop -->
                <a href="/" class="logo">
                    <img src="${pageContext.request.contextPath}/resources/images/FiguiumLOGO3.png" alt="LOGO">
                </a>

                <!-- Menu desktop -->
                <div class="menu-desktop">
                    <ul class="main-menu">

                        <li>
                            <a href="/">Home</a>
                        </li>


                        <li <%--class="label1" data-label1="hot"--%>>
                            <a href="shopingCart.do">장바구니</a>
                        </li>

                        <li>
                            <a href="qa/list.do">Q&A</a>
                        </li>
                    </ul>
                </div>

                <!-- Icon header -->
                <div class="wrap-icon-header flex-w flex-r-m">
                    <!-- NOTE : 로그인 아이콘 -->
                    <c:if test="${empty user}">
                        <div id="loginBtn" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11">

                            <i class="zmdi zmdi-account-circle"></i>
                        </div>
                    </c:if>
                    <c:if test="${not empty user}">
                        <div class="cl2 hov-cl1 trans-04 p-l-22 p-r-11" style="font-size: 15px">
                            <a style="text-decoration: none; color: black" href="user/logout.do">${user.name}님</a>
                        </div>

                    </c:if>

                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-search">
                        <i class="zmdi zmdi-search"></i>
                    </div>

                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart"
                         data-notify="2">
                        <i class="zmdi zmdi-shopping-cart"></i>
                    </div>

                    <a href="#" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti"
                       data-notify="0">
                        <i class="zmdi zmdi-favorite-outline"></i>
                    </a>
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
                                    <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                                </div>
                                <br>
                                <input type="button" class="btn btn-secondary" value="로그인" onclick="login();" />
                                <input type="button" class="btn btn-secondary" value="회원가입" />
                        </div>

                        <div style="width: 100%">―――――― &nbsp; 간편 로그인 &nbsp; ――――――</div>
                        <br>
                        <div>
                            <!-- Google Login Button -->
                            <a href="/oauth2/authorization/google" class="login-button">
                                <img src="${pageContext.request.contextPath}/resources/images/social/google_login_btn.png" alt="Google Logo">
                            </a>

                            <!-- Naver Login Button -->
                            <a href="/oauth2/authorization/naver" class="login-button">
                                <img src="${pageContext.request.contextPath}/resources/images/social/naver_login_btn.png" alt="Naver Logo">
                            </a>

                            <!-- Kakao Login Button -->
                            <a href="/oauth2/authorization/kakao" class="login-button">
                                <img src="${pageContext.request.contextPath}/resources/images/social/kakao_login_btn.png" alt="Kakao Logo">
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
                <img src="${pageContext.request.contextPath}/resources/images/FiguiumLOGO3.png" alt="LOGO">
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
                <a href="qa/list.do">Q&A</a>
            </li>
        </ul>
    </div>

    <!-- Modal Search -->
    <div class="modal-search-header flex-c-m trans-04 js-hide-modal-search">
        <div class="container-search-header">
            <button class="flex-c-m btn-hide-modal-search trans-04 js-hide-modal-search">
                <img src="${pageContext.request.contextPath}/resources/images/icons/icon-close2.png" alt="CLOSE">
            </button>

            <form class="wrap-search-header flex-w p-l-15">
                <button class="flex-c-m trans-04">
                    <i class="zmdi zmdi-search"></i>
                </button>
                <input class="plh3" type="text" name="search" placeholder="Search...">
            </form>
        </div>
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
        if(btn) {
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
    $('#password').on('keydown', function (e) {
        if(e.key === 'Enter') {
            login();
        }
    })


    /**
     * 로그인
     */
    function login() {
        let email = $("#email").val();
        let password = $("#password").val();

        if( !(email && password) ) {
            alert("이메일 혹은 비밀번호를 입력해주세요!");
            return;
        }

        // 이메일 유효성 체크
        if(emailCheck(email)) {
            // 유효한 이메일일 경우
            // 로그인 요청
            $.ajax({
                url : 'user/login.do',
                method : 'post',
                data : { email : email, password : password },
                success : function (result) {
                    location.reload();
                },
                error: function(error) {
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
    function emailCheck(email){
        let email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
        if(!email_regex.test(email)){
            return false;
        }else{
            return true;
        }
    }

</script>
</body>
</html>
