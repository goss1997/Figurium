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
  <h2>Q&A게시판</h2>
 <br>
  <hr>
  <div class="row">
    <div class="col-sm-1">제목</div>
    <div class="col-sm-4">${ qa.title }</div>
    <div class="col-sm-1">작성일자</div>
    <div class="col-sm-4">${ qa.created}</div>
  </div>
  <hr>
  <div class="row">
    <div class="col-sm-1">작성자</div>
    <div class="col-sm-4">${ qa.userId }</div>
    <div class="col-sm-1">답변여부</div>
    <div class="col-sm-4">${qa.reply != null ? qa.reply : '없음'}</div>
  </div>
  <hr>
    <div class="row mt-2">
        <div class="col-sm-2"><strong>내용:</strong></div>
        <div class="col-sm-10">${qa.content}</div>
    </div>
  <hr>
  <div>
    <button type="button" class="btn btn-dark float-right"  id="btn-save" a href="${pageContext.request.contextPath}/qa/QaList.do"> 목록</button>
  </div>
  <br>
  <br>

</div>

    <div class="container">
        <hr>
    <div class="form-group">
        <textarea class="form-control col-sm-11" style="resize: none; display: inline-block;" rows="5" id="comment"></textarea>
        <button type="button" style="margin-top: 90px;" class="btn btn-light float-right" id="btn-submit">전송</button>
    </div>
    </div>

</div>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
</html>