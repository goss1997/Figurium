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
      <th class="col-2">주문상태</th>
    </tr>
    </thead>

    <tbody>
    <c:forEach var="orderList" items="${orderList}">
      <tr>
        <td>${orderList.id}<br>${orderList.createdAt}</td>
        <td>${orderList.productName}</td>
        <td>
          <c:if test="${orderList.paymentType == 'vbank'}">
            무통장입금
          </c:if>
          <c:if test="${orderList.valid == 'card'}">
            카드결제
          </c:if>
            </td>
        <td>${orderList.price}</td>
        <td>
          <c:if test="${orderList.valid == 'y'}">
            결제완료
          </c:if>
          <c:if test="${orderList.valid == 'n'}">
            환불완료
          </c:if>
        </td>
        <td>
          <a>${orderList.status}</a>&nbsp;&nbsp;
          <input type="button" class="deliveryButton" value="상태변경" style="display: inline-block;" onclick="toggleButtons(this);">
          <select style="margin: 0px; display: none;" class="deliveryCondition" name="deliveryCondition">
            <option>준비중</option>
            <option>출고대기</option>
            <option>배송중</option>
            <option>배송완료</option>
          </select>
          <input type="button" class="delivery" value="적용" style="display: none;" onclick="deliveryChange(this);">
          <input type="hidden" name="ordersId" value="${orderList.id}">
        </td>
      </tr>
    </c:forEach>
    </tbody>


  </table>


</div>
</body>
<script>
  function toggleButtons(button) {
    // 클릭한 버튼의 부모 tr을 찾습니다
    const row = button.closest('tr');

    // 각 요소를 해당 tr 내에서 찾습니다
    const deliveryButton = row.querySelector('.deliveryButton');
    const deliveryCondition = row.querySelector('.deliveryCondition');
    const delivery = row.querySelector('.delivery');
    const ordersId = row.querySelector('input[name="ordersId"]').value;

    // 버튼의 표시 상태를 업데이트합니다
    deliveryButton.style.display = 'none';
    deliveryCondition.style.display = 'inline-block';
    delivery.style.display = 'inline-block';

    // 주문 ID를 저장
    row.dataset.ordersId = ordersId;
  }

  function deliveryChange(button) {
    // 클릭한 버튼의 부모 tr을 찾습니다
    const row = button.closest('tr');

    // 각 요소를 해당 tr 내에서 찾습니다
    const deliveryButton = row.querySelector('.deliveryButton');
    const deliveryCondition = row.querySelector('.deliveryCondition');
    const delivery = row.querySelector('.delivery');
    const ordersId = row.dataset.ordersId;
    const deliveryConditionValue = deliveryCondition.value;

    // 버튼의 표시 상태를 업데이트합니다
    deliveryButton.style.display = 'inline-block';
    deliveryCondition.style.display = 'none';
    delivery.style.display = 'none';

    // AJAX 요청으로 컨트롤러에 값 전달 (jQuery 사용)
    $.ajax({
      type: 'POST',
      url: '/statusChange.do',  // 컨트롤러의 URL
      contentType: 'application/json',  // 요청의 타입
      data: JSON.stringify({ id: ordersId, status: deliveryConditionValue }),  // JSON 형식으로 데이터 전송
      success: function(response) {
        console.log('Success:', response);
        // 성공 시 처리할 내용
        alert("배송상태 변경 성공");
        location.reload();
      },
      error: function(xhr, status, error) {
        console.log('Error:', error);
        // 오류 시 처리할 내용
        alert("변경이 실패했습니다.\n잠시후 다시시도 해주세요");
      }
    });
  }



</script>
</html>