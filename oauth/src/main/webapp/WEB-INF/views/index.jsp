<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>index.jsp</title>
    <style>
        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0, 0, 0); /* Fallback color */
            background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 20%; /* Could be more or less, depending on screen size */
            text-align: center;
            border-radius: 10px;
        }

        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }


        .login-button {
            margin: 10px;
            width: 40px;
            cursor: pointer;
            text-decoration: none;
        }

        .login-button img {
            width: 40px;
            height: 100%;
        }

        .login-button img:hover {
            transform: scale(1.2);
        }

        .login-form {
            margin-bottom: 20px;
        }

        .login-form input {
            margin: 5px 0;
            padding: 10px;
            width: 250px;
            border: 1px solid #dddddd;
            border-radius: 5px;
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

        #loginBtn {
            margin-top: 10px;
            padding: 10px;
            width: 250px;
            background-color: #4CAF50;
            border: none;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }

    </style>
    <!-- ajax & jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- Trigger Button -->
<button id="loginBtn" style="display: none;">로그인</button>

<!-- Modal Structure -->
<div id="loginModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>

        <h2>Login</h2>

        <!-- 개인 회원 로그인 폼 -->
        <div class="login-form">
            <form id="signInForm">
                <input type="email" id="email" name="email" placeholder="Email" required>
                <br>
                <input type="password" id="password" name="password" placeholder="Password" required>
                <br>
                <button type="submit">로그인</button>
                <button type="button">회원가입</button>
            </form>
        </div>

        <div>――――――― &nbsp; 간편 로그인 &nbsp; ―――――――</div>
        <br>
        <div>
            <!-- Google Login Button -->
            <a href="/oauth2/authorization/google" class="login-button">
                <img src="${pageContext.request.contextPath}/resources/images/google_login_btn.png" alt="Google Logo">
            </a>

            <!-- Naver Login Button -->
            <a href="/oauth2/authorization/naver" class="login-button">
                <img src="${pageContext.request.contextPath}/resources/images/naver_login_btn.png" alt="Naver Logo">
            </a>

            <!-- Kakao Login Button -->
            <a href="/oauth2/authorization/kakao" class="login-button">
                <img src="${pageContext.request.contextPath}/resources/images/kakao_login_btn.png" alt="Kakao Logo">
            </a>
        </div>
    </div>
</div>

<div id="loginUserInfo">


</div>
<div>
    <input id="logoutBtn" type="button" value="로그아웃" style="display: none" onclick="logout();">
</div>

<script>

    /**
     * 로그인 모달 띄우기
     */
    document.addEventListener('DOMContentLoaded', () => {
        const modal = document.getElementById('loginModal');
        const btn = document.getElementById('loginBtn');
        const span = document.getElementsByClassName('close')[0];

        // Open the modal
        btn.onclick = function () {
            modal.style.display = 'block';
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
     * 자체 회원 로그인.
     */
    document.getElementById('signInForm').addEventListener('submit', function(event) {
        event.preventDefault(); // 폼 제출 방지

        // 폼 필드 값 가져오기
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        // 요청 데이터 준비
        const requestData = {
            email: email,
            password: password
        };

        // 서버로 POST 요청 보내기
        fetch('members/sign-in', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify(requestData)
        })
            .then(response => response.json())
            .then(data => {
                // JWT 토큰 로컬 스토리지에 저장
                localStorage.setItem('accessToken', data.accessToken);
                localStorage.setItem('refreshToken', data.refreshToken);

                console.log('Signed in successfully');
                console.log('Access Token:', data.accessToken);
                console.log('Refresh Token:', data.refreshToken);

                // 로그인 버튼 숨기기.
                $("#loginBtn").hide();

                // 모달 끄기.
                document.getElementById('loginModal').style.display = 'none';

                // 사용자 정보 가져오는 함수 호출.
                getLoginInfo();

            })
            .catch(error => {
                console.error('Error signing in:', error);
            });
    });

    /**
     * 로그아웃
     */
    function logout() {
        // 로컬 스토리지의 토큰 없애기
        localStorage.removeItem('accessToken');
        localStorage.removeItem('refreshToken');

        // 새로고침
        location.reload();
    }

    /**
     * dom 렌더링 후 바로 실행할 함수
     */
    $(function(){
        // 로컬 스토리지에 토큰이 존재할 경우(로그인된 상태)
        if(localStorage.getItem('accessToken')){

            // 로그인 버튼 숨기기.
            $("#loginBtn").hide();

            // 사용자 정보 가져오는 함수 호출.
            getLoginInfo();

        }else {

            // 소셜 로그인한 경우
            if('${jwt}') {
                let accessToken = '${jwt.accessToken}';
                let refreshToken = '${jwt.refreshToken}';

                // JWT 토큰 로컬 스토리지에 저장
                localStorage.setItem('accessToken', accessToken);
                localStorage.setItem('refreshToken', refreshToken);

                // 로그인 버튼 숨기기.
                $("#loginBtn").hide();

                // 모달 끄기.
                document.getElementById('loginModal').style.display = 'none';

                // 사용자 정보 가져오는 함수 호출.
                getLoginInfo();

            } else {
                // 비로그인 상태
                $("#loginBtn").show();
            }
        }

    });

    /**
     * JWT의 payload에서 사용자의 정보 추출하는 함수
     */
    function getLoginInfo() {

        // JWT를 로컬 스토리지에서 가져오기.
        const token = localStorage.getItem('accessToken');

        if (token) {

            // JWT에서 페이로드 추출 및 디코딩
            const payload = token.split('.')[1]; // JWT의 두 번째 부분은 페이로드
            const decodedPayload = base64ToUtf8(payload); // Base64 디코딩
            const userInfo = JSON.parse(decodedPayload); // JSON 파싱

            console.log('User Info:', userInfo); // 사용자 정보 출력
            console.log('User nickName:',   userInfo.nickName);
            console.log('User ProfileImg', userInfo.profileImg);

            $("#loginUserInfo").append('<image src='+userInfo.profileImg+' width=40px>');
            $("#loginUserInfo").append('<span>'+ userInfo.nickName+'님 환영합니다.</span>');
            $("#logoutBtn").show();


        }else {
            console.log("No token found in localStorage");
        }

    };

    /**
     * Base64 문자열을 디코딩하여 UTF-8 문자열로 변환하는 함수
     */
    function base64ToUtf8(base64) {
        // Base64 디코딩
        const decodedString = atob(base64);

        // 디코딩된 문자열을 UTF-8로 변환
        const utf8Bytes = new Uint8Array(decodedString.length);
        for (let i = 0; i < decodedString.length; i++) {
            utf8Bytes[i] = decodedString.charCodeAt(i);
        }

        // UTF-8 문자열로 변환
        return new TextDecoder().decode(utf8Bytes);
    }

</script>
</body>
</html>