<%--
  Created by IntelliJ IDEA.
  User: 14A
  Date: 2024-08-26
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>비밀번호 찾기</title>
    <link rel="icon" type="image/png" href="/images/FiguriumHand.png"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/js-cookie/3.0.1/js.cookie.min.js"></script>

    <!-- TODO : 제목 과 스타일 영역 -->
    <style>
        .password-find-page * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        #content-wrap-area {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fa;
            display: flex;
            justify-content: center;
            height: 100vh;
        }

        .password-find-page .container {
            background-color: #ffffff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 40px;
            width: 500px;
            margin-top: 150px;
        }

        .password-find-page .form-wrapper {
            text-align: center;
        }

        .password-find-page h2 {
            margin-bottom: 20px;
            color: #333333;
        }

        .password-find-page p {
            margin-bottom: 20px;
            color: #666666;
        }

        .password-find-page .input-group {
            margin-bottom: 20px;
        }

        .password-find-page label {
            display: block;
            text-align: left;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555555;
        }

        .password-find-page input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .password-find-page input:focus {
            border-color: #333333;
            outline: none;
        }

        .password-find-page .btn {
            width: 100%;
            padding: 12px;
            background-color: #5cb85c;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .password-find-page .btn:hover {
            background-color: #4cae4c;
        }

        .password-find-page .back-to-login a {
            display: inline-block;
            margin-top: 20px;
            color: #5cb85c;
            text-decoration: none;
        }

        .password-find-page .back-to-login a:hover {
            text-decoration: underline;
        }

        @media (max-width: 576px) {
            .container {
                max-width: 80%;
            }

        }
    </style>
</head>

<body class="animsition">
<!-- NOTE : 메뉴바 -->
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>
<div id="content-wrap-area">
    <div class="password-find-page">
        <div class="container">
            <div class="form-wrapper">
                <h2>비밀번호 찾기</h2>
                <p>인증을 위해 이메일을 입력해주세요.</p>
                <div id="status-area">
                        <div class="input-group">
                            <label for="findEmail">이메일 주소</label>
                            <input type="email" id="findEmail" name="findEmail" placeholder="example@domain.com"
                                   required>
                        </div>
                        <button type="button" class="btn" onclick="checkEmailAndSendPage();">이메일 확인</button>
                </div>
                <p class="back-to-login">
                    <a href="/">홈으로 돌아가기</a>
                </p>
            </div>
        </div>
    </div>


</div>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>

<script>

    /**
     * 이메일 확인 및 해당 이메일에 메일 전송하는 함수
     */
    function checkEmailAndSendPage() {

        let findEmail = $("#findEmail").val();

        if(findEmail == ''){
            alert('이메일을 입력해주세요!');
            return;
        }

        // 이메일 유효성 체크
        if(!emailCheck(findEmail)){
            alert('형식에 맞는 이메일을 입력해주세요!');
            return;
        }

        // 해당 이메일에 비밀번호 재설정 페이지 메일 전송
        $.ajax({
           url : "send-password-reset.do",
           method : 'post',
           data : {'findEmail':findEmail},
           success : function (result) {

               // 랜덤번호 생성
               let randomValue = Math.floor(Math.random() * 1000);
               // 쿠키에 랜던값 저장(유효기간 1시간)
               Cookies.set('verificationCode', randomValue, { expires: 1 / 24 }); // 1시간

               alert(result+' 메일을 확인해주세요!!');
               location.href="/";
           },
           error : function (xhr) {
                alert(xhr.responseText);
           }
        });

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

</script>

</body>
</html>