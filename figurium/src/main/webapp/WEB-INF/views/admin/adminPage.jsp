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
        <a class="nav-link" href="#">배송상태 변경</a>
      </li>
    </ul>
  </nav>
<br><br>
  <table class="table table-hover " style="width: 90%;  margin: auto">
    <thead class="thead-light">
    <tr>
      <th class="col-3">주문번호<br>주문일자</th>
      <th class="col-3">상품명</th>
      <th class="col-1">결제방식</th>
      <th class="col-1">총 결제금액</th>
      <th class="col-1">결제상태</th>
      <th class="col-2">배송상태</th>
    </tr>
    </thead>

    <tbody>
      <tr>
        <td>순번</td>
        <td>럭키비키~</td>
        <td>신용카드</td>
        <td>30000원</td>
        <td>결제대기</td>
        <td><a>준비중</a>&nbsp;&nbsp;<input type="button" id="deliveryButton" class="deliveryButton" value="상태변경" onclick="toggleButtons();"
        style="display: inline-block;">
          <select style="margin: 0px; display: none;" id="deliveryCondition" class="delivery" >
          <option>준비중</option>
          <option>출고대기</option>
          <option>배송중</option>
          <option>배송완료</option>
          </select>
          <input type="button" id="delivery" class="delivery" value="적용" onclick="deliveryChange();"
                 style="display: none;">
        </td>
      </tr>
    </tbody>
  </table>


</div>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
<script>
  function toggleButtons(){

    const deliveryButton = document.getElementById('deliveryButton');
    const deliveryCondition = document.getElementById('deliveryCondition');
    const delivery = document.getElementById('delivery');

    // 첫 번째 버튼 숨기기
    deliveryButton.style.display = 'none';

    // 두 번째 버튼 보이기
    deliveryCondition.style.display = 'inline-block';
    delivery.style.display = 'inline-block';

  }

  function deliveryChange(){

    const deliveryButton = document.getElementById('deliveryButton');
    const deliveryCondition = document.getElementById('deliveryCondition');
    const delivery = document.getElementById('delivery');

    // 첫 번째 버튼 숨기기
    deliveryButton.style.display = 'inline-block';

    // 두 번째 버튼 보이기
    deliveryCondition.style.display = 'none';
    delivery.style.display = 'none';

  }
</script>
</html>