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
    <title>Account Linking</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/FiguriumHand.png"/>
    <!-- TODO : 제목 과 스타일 영역 -->
    <style>

    </style>
</head>

<body>
<!-- NOTE : 메뉴바 -->
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>
<div id="content-wrap-area">
    <div class="container pt-3">
        <h1>계정 연동</h1>
        <p>안녕하세요, <span style="font-weight: bold">${userProfile.name}</span>님!</p>
        <p>이미 <span style="font-weight: bold">${userProfile.email}</span>로 가입된 계정이 있습니다. 소셜 계정(<span style="font-weight: bold">${userProfile.provider}</span>)과 연동하시겠습니까?</p>

        <form action="${pageContext.request.contextPath}/link-account" method="POST">
            <button class="btn btn-secondary" type="submit">계정 연동</button>
            <button class="btn btn-warning" type="button" onclick="cancelLink();">취소</button>
        </form>
    </div>
</div>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>

<script>
    $(function(){
        if(${ not empty loginUser }){
            history.back();
        }
    })

    function cancelLink() {
        alert('홈페이지로 이동합니다.');
        location.href = "/";
    }
</script>

</body>
</html>