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
  <title>Title</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <!-- TODO : 제목 과 스타일 영역 -->
  <style>

  </style>
</head>

<body>
<!-- NOTE : 메뉴바 -->
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>


<div id="content-wrap-area">
  <!-- TODO : 컨텐츠 영역(당신이 사용할 공간) -->
    <div class="container mt-5">
        <h2>${qa.title}</h2>
        <hr>
        <div class="row">
            <div class="col-sm-2">작성일자</div>
            <div class="col-sm-10">${fn:formatDate(qa.created, 'yyyy-MM-dd HH:mm:ss')}</div>
        </div>
        <div class="row">
            <div class="col-sm-2">작성자</div>
            <div class="col-sm-10">${qa.userId}</div>
        </div>
        <div class="row">
            <div class="col-sm-2">답변여부</div>
            <div class="col-sm-10">${qa.reply != null ? qa.reply : '없음'}</div>
        </div>
        <hr>
        <div class="row">
            <div class="col-sm-2"><strong>내용:</strong></div>
            <div class="col-sm-10">${qa.content}</div>
        </div>
        <hr>
        <div class="text-right">
            <button type="button" class="btn btn-dark" onclick="location.href='${pageContext.request.contextPath}/qa/list'">목록</button>
            <c:if test="${sessionScope.userId != null && sessionScope.userId == qa.userId}">
                <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/qa/edit/${qa.id}'">수정</button>
                <button type="button" class="btn btn-danger" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/qa/delete/${qa.id}'">삭제</button>
            </c:if>
        </div>
    </div>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
</html>