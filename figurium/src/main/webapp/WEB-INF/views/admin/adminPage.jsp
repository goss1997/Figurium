<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <link rel="icon" type="image/png" href="/images/FiguriumHand.png"/>
  <!-- TODO : 제목 과 스타일 영역 -->
  <style>
    .thead-light>tr>th{
    text-align: center;
    vertical-align: middle !important;
    }
    tbody>tr>td{
      text-align: center;
      vertical-align: middle !important;
    }


  </style>
</head>

<body>
<!-- NOTE : 메뉴바 -->
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>
<div id="content-wrap-area">
  <!-- TODO : 컨텐츠 영역(당신이 사용할 공간) -->

  <nav class="navbar navbar-expand-sm bg-dark navbar-dark justify-content-center">

    <!-- Links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="productInsertForm.do">상품 등록</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">사용자 결제 & 반품 승인</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="adminRefund();">배송상태 변경</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Q&A 미답변</a>
      </li>
    </ul>
  </nav>
<br><br>
  <div id="admin-view"></div>

</div>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>

<script>

  function  adminRefund(){


  }

</script>

</html>