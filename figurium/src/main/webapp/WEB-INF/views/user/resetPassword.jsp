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
    <title>비밀번호 재설정</title>
    <link rel="icon" type="image/png" href="/images/FiguriumHand.png"/>
    <style>
        .password-reset-page * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .password-reset-page {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .password-reset-page .container {
            background-color: #ffffff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 40px;
            max-width: 400px;
            width: 100%;
        }

        .password-reset-page .form-wrapper {
            text-align: center;
        }

        .password-reset-page h2 {
            margin-bottom: 20px;
            color: #333333;
        }

        .password-reset-page p {
            margin-bottom: 20px;
            color: #666666;
        }

        .password-reset-page .input-group {
            margin-bottom: 20px;
        }

        .password-reset-page label {
            display: block;
            text-align: left;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555555;
        }

        .password-reset-page input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .password-reset-page input:focus {
            border-color: #333333;
            outline: none;
        }

        .password-reset-page .btn {
            width: 100%;
            padding: 12px;
            background-color: #5cb85c;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .password-reset-page .btn:hover {
            background-color: #4cae4c;
        }

        .password-reset-page .back-to-login a {
            display: inline-block;
            margin-top: 20px;
            color: #5cb85c;
            text-decoration: none;
        }

        .password-reset-page .back-to-login a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
<!-- NOTE : 메뉴바 -->
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>
<div id="content-wrap-area">
    <div class="password-reset-page">
        <div class="container">
            <div class="form-wrapper">
                <h2>비밀번호 재설정</h2>
                <p>새 비밀번호를 입력해 주세요.</p>
                <form action="reset-password.do" method="post">
                    <input type="hidden" name="updateEmail" value="${updateEmail}">
                    <div class="input-group">
                        <label for="newPassword">새 비밀번호</label>
                        <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required>
                    </div>
                    <div class="input-group">
                        <label for="confirmPassword">비밀번호 확인</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인" required>
                    </div>
                    <input type="button" class="btn" onclick="resetPassword(this.form);" value="비밀번호 재설정" />
                </form>
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
    function resetPassword(f) {
        let newPassword = $("#newPassword").val();
        let confirmPassword = $("#confirmPassword").val();

        if(newPassword === '') {
            alert('비밀번호를 입력해주세요!');
            return;
        }
        if(confirmPassword === '') {
            alert('비밀번호 확인란을 입력해주세요!');
            return;
        }
        // 비밀번호가 일치하지 않을경우
        if(newPassword !== confirmPassword) {
            alert('비밀번호가 일치하지 않습니다. 다시 입력해주세요.');
            return;
        }

        // 일치할 경우
        f.action = 'reset-password.do';
        f.method = 'post';
        f.submit();

    }

</script>

</body>
</html>