<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: 14A
  Date: 2024-08-26
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
<html>
<head>
  <title>배송상태 변경</title>
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
    .nav-link:hover{
      cursor: pointer;
    }

  </style>
</head>

<body>
<!-- 메뉴바 -->
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>
<div id="content-wrap-area">

  <nav class="navbar navbar-expand-sm bg-dark navbar-dark justify-content-center">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" style="font-size: 16px; vertical-align: middle !important;"
           href="productInsertForm.do">상품 등록</a>
      </li>
      &nbsp;&nbsp;
      <li class="nav-item">
        <a class="nav-link" href="admin.do">주문조회</a>
      </li>
      &nbsp;&nbsp;

      <li class="nav-item">
        <a class="nav-link" id="changeStatus" href="adminRefund.do">배송상태 변경</a>
      </li>
      <li class="nav-item">
        <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
             id="quantity-notify"
             data-notify="0">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             href="adminQuantity.do">상품 재고수정</a>
        </div>
      </li>
      &nbsp;&nbsp;
      <li class="nav-item">
        <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
             id="payment-notify"
             data-notify="0">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             href="adminPayment.do">결제취소</a>
        </div>
      </li>
      &nbsp;&nbsp;
      <li class="nav-item">
        <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
             id="retrun-notify"
             data-notify="0">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             href="adminReturns.do">반품승인</a>
        </div>
      </li>
      &nbsp;&nbsp;
      <li class="nav-item">
        <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
             id="qa-notify"
             data-notify="0">
          <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
             id="viewQaList" href="adminQaList.do" >Q&A 미답변</a>
        </div>
      </li>
    </ul>
  </nav>

  <br><br>

  <table class="table table-hover" style="width: 90%; margin: auto">
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
      <c:forEach var="order" items="${orderList}">
    <tr>
      <td>${order.id}<br>${order.createdAt}</td>
      <td>${order.productName}</td>
      <td>${order.paymentType == 'vbank' ? '무통장입금' : '카드결제'}</td>
      <td>${order.price}원</td>
      <td>${order.valid == 'y' ? '결제완료' : '환불완료'}</td>
      <td>
        <a>${order.status}</a>&nbsp;&nbsp;
        <c:if test="${order.status ne '환불완료'}">
        <input type="button" class="deliveryButton" value="상태변경" style="display: inline-block;" onclick="toggleButtons(this);">
        <select style="margin: 0px; display: none;" class="deliveryCondition" name="deliveryCondition">
          <option value="준비중" ${order.status == '준비중' ? 'selected' : ''}>준비중</option>
          <option value="출고대기" ${order.status == '출고대기' ? 'selected' : ''}>출고대기</option>
          <option value="배송중" ${order.status == '배송중' ? 'selected' : ''}>배송중</option>
          <option value="배송완료" ${order.status == '배송완료' ? 'selected' : ''}>배송완료</option>
        </select>
        <input type="button" class="delivery" value="적용" style="display: none;" onclick="deliveryChange(this);">
        </c:if>
        <input type="hidden" name="ordersId" value="${order.id}">
      </td>
    </tr>
    </c:forEach>
    </tbody>
  </table>

</div>
<!-- 푸터 -->
<jsp:include page="../common/footer.jsp"/>
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
      data: JSON.stringify({id: ordersId, status: deliveryConditionValue}),  // JSON 형식으로 데이터 전송
      success: function (response) {
        console.log('Success:', response);
        // 성공 시 처리할 내용
        alert("배송상태 변경 성공");
        location.reload();

      },
      error: function (xhr, status, error) {
        console.log('Error:', error);
        // 오류 시 처리할 내용
        alert("변경이 실패했습니다.\n잠시후 다시시도 해주세요");
      }
    });
  }


</script>

<script>


  function updateCount() {
    $.ajax({
      url: 'count.do', // 컨트롤러에서 갯수를 가져오는 URL
      type: 'GET',
      dataType: 'json',
      success: function (response) {
        if (response.quantityCount !== undefined) {
          $('#quantity-notify').attr('data-notify', response.count);
        } else {
          $('#quantity-notify').attr('data-notify', '0'); // 갯수가 없을 경우 0으로 설정
        }
        if (response.paymentCount !== undefined) {
          $('#payment-notify').attr('data-notify', response.count);
        } else {
          $('#payment-notify').attr('data-notify', '0'); // 갯수가 없을 경우 0으로 설정
        }
        if (response.retrunCount !== undefined) {
          $('#retrun-notify').attr('data-notify', response.count);
        } else {
          $('#retrun-notify').attr('data-notify', '0'); // 갯수가 없을 경우 0으로 설정
        }
        if (response.qaCount !== undefined) {
          $('#qa-notify').attr('data-notify', response.count);
        } else {
          $('#qa-notify').attr('data-notify', '0'); // 갯수가 없을 경우 0으로 설정
        }

      },
      error: function (xhr, status, error) {
        console.error('count 가져오는 데 실패했습니다.', error);
        $('#quantity-notify').attr('data-notify', '0'); // 오류 발생 시 0으로 설정
        $('#payment-notify').attr('data-notify', '0'); // 오류 발생 시 0으로 설정
        $('#retrun-notify').attr('data-notify', '0'); // 오류 발생 시 0으로 설정
        $('#qa-notify').attr('data-notify', '0'); // 오류 발생 시 0으로 설정
      }
    });
  }


  $(document).ready(function () {

    updateCount();

  });
</script>

</script>
</html>