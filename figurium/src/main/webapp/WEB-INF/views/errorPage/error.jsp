<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오류 발생</title>
    <link rel="icon" type="image/png" href="/images/FiguriumHand.png"/>
    <style>
        .error-body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            color: #333;
            text-align: center;
            padding: 50px;
        }

        .error-container {
            max-width: 1000px;
            min-height: 300px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .error-body h1 {
            color: #e74c3c;
        }

        .error-body a {
            color: #3498db;
            text-decoration: none;
        }

        .error-body a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>
<div id="content-wrap-area">
    <div class="error-body">
        <div class="error-container">
            <img src="/images/훈이.png" alt="훈이.png" style="width: 200px; height: auto; margin-right: 20px;">
            <div>
                <h2>${errorMessage} (${statusCode})</h2>
                <p>죄송합니다. 예상치 못한 오류가 발생했습니다.</p>
                <p>잠시 후 다시 시도해 주시거나, 아래의 링크를 통해 다른 페이지로 이동해 주세요.</p>
                <a href="<c:url value='/' />">홈으로 돌아가기</a>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>
