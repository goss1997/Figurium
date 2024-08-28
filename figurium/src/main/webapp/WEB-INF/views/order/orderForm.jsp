<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>장바구니</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/orderForm.css">
  <%-- 자바스크립트 경로 --%>
  <script src="${pageContext.request.contextPath}/resources/js/orderForm.js"></script>

  <%-- 결제 API --%>
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script type="text/javascript"	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
  <%-- 주소 API --%>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>


    // 결제 api js 파일로 분리해놓으면 IMP 못읽어오는 현상이 있어서, 부득이하게 jsp 내부에 js 작성
    // 관리자 계정 정보 (결제 api 사용에 필요함)
    var IMP = window.IMP;
    IMP.init("imp25608413");


    function buyItems(item_price) {

      // 만약에 결제 방식을 선택하지 않았다면, return되게 한다.
      let selectedOption = document.querySelector('input[name="payment"]:checked');
      if (selectedOption == null) {
        alert("결제방식을 선택하고 결제를 진행해주세요.");
        return;
      }

      // var mem_name = "${sessionScope.user.mem_name}";

      // 주문 리스트에 저장될 값들 전부 변수로 저장

      let order_name = f.order_name.value;              // 보낸 사람 이름
      let order_phone = f.order_phone.value;            // 보낸 사람 전화번호
      let order_email = f.order_email.value;            // 이메일

      let shipping_address = f.shipping_address.value;  // 배송지
      let shipping_name = f.shipping_name.value;        // 받는 사람
      let shipping_phone = f.shipping_phone.value;      // 받는 사람 전화번호
      let delivery_request = f.delivery_request.value;  // 배송시 요청사항

      // var itemNames = [ 아이템 이름 배열 저장 ];
      // var itemPrices = [ 아이템 가격 배열 저장 ];
      // var itemQuantities = [ 아이템 갯수 배열 저장 ];


      IMP.request_pay({
        pg: 'html5_inicis',
        pay_method: selectedOption, // card(신용카드), trans(실시간계좌이체), vbank(가상계좌), 또는 phone(휴대폰소액결제)
        merchant_uid: 'merchant_' + new Date().getTime(),
        name: '피규리움 결제창',   // 상품명
        amount: item_price,  // 상품 가격
        buyer_email: "",    // 구매자 이메일
        buyer_name: item_price   // 구매자 이름
      }, function(rsp) {
        console.log(rsp);

        // 결제 성공 시
        if(rsp.success) {
          var msg = "결제가 완료되었습니다.";

          $.ajax({
            type : "GET",
            url : "order/inicisPay.do",
            data : {
              item_price : item_price,
              mem_name : mem_name,
              order_name : order_name,
              order_phone : order_phone,
              order_email : order_email,
              shipping_address : shipping_address,
              shipping_name : shipping_name,
              shipping_phone : shipping_phone,
              delivery_request : delivery_request,
              itemNames : itemNames,
              itemPrices : itemPrices,
              itemQuantities : itemQuantities
            },
            success: function(res_data){
              location.href="/";
            },
            error: function(err){
              alert(err.responseText);
            }
          });
        }else {
          var msg = "결제에 실패했습니다.";
          msg += '에러내용 : ' + rsp.error_msg;
        }
        alert(msg);
      });
    };
  </script>


</head>
<body class="animsition">
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>










<%-- Content --%>

<div id="content_title">
  <h1>주문서</h1>

<%-- 상단 아이템 주문 리스트 --%>
    <%--  장바구니 예시 테이블 : 0828 --%>
  <div class="item_list">
    <table class="table item_list_table table-hover">
      <thead>
      <tr class="table-light">
        <th id="item_list_table_name">상품명</th>
        <th>가격</th>
        <th>수량</th>
        <th>총 금액</th>
      </tr>
      </thead>
      <tbody>
      <tr class="table_content">
        <td id="table_content_img"><img src="${pageContext.request.contextPath}/resources/images/example.jpg" alt="IMG">
        [25년2월입고] 최애의 아이 2기 반프레스토 아쿠아 토우키ver
        </td>
        <td>10,000원</td>
        <td>1</td>
        <td>10,000원</td>
      </tr>
      </tbody>
    </table>


    <%-- form 시작 지점 --%>
    <form>

    <%-- 만약에 장바구니에 담겼던 item 값이 넘어왔다면 list에 호출 : 0828 --%>
    <%-- itemNames라는 배열을 생성해서 for문안에 넣어 이름을 추가 --%>
    <c:if test="${ itemList != null }">
      <script type="text/javascript">
        var itemNames = [];
        var itemPrices = [];
        var itemQuantities = [];
      </script>

      <c:forEach var="item" items="${ requestScope.cartsList }">
      <scirpt type="text/javascript">
        itemNames.push("${ item.name }");
        itemPrices.push("${ item.price }");
        itemQuantities.push("${ item.quantity }");
      </scirpt>

        <table class="table item_list_table table-hover">
          <thead>
          <tr class="table-light">
            <th id="item_list_table_name">상품명</th>
            <th>가격</th>
            <th>수량</th>
            <th>총 금액</th>
          </tr>
          </thead>
          <tbody>
          <tr class="table_content">
            <td id="table_content_img"><img src="${pageContext.request.contextPath}${ item.imageUrl }" alt="IMG">
            ${ item.name }
            </td>
            <td>${ item.price }원</td>
            <td>${ item.quantity }</td>
            <td>${ item.price * item.quantity }원</td>
          </tr>
          </tbody>
        </table>
      </c:forEach>
    </c:if>



</div>



<div class="order_box_both">


<%-- 주문 테이블 customers --%>
<div class="order_box_l mt-3">
  <div class="form_container">
    <table class="table table-hover">
      <thead>
      <th>
        <h2>주문자 입력</h2>
      </th>
      </thead>
      <tbody>
      <tr>
        <td class="td_title">주문하시는 분</td>
        <td><input type="text" class="form-control" id="order_name" placeholder="주문하시는 분" name="order_name"></td>
      </tr>
      <tr>
        <td class="td_title">전화번호</td>
        <td><input type="text" class="form-control" id="order_phone" placeholder="전화번호" name="order_phone"></td>
      </tr>
      <tr>
        <td class="td_title">이메일</td>
        <td><input type="email" class="form-control" id="order_email" placeholder="이메일" name="order_email"></td>
      </tr>
      </tbody>
    </table>
  </div>

  <%-- 주문 테이블 shipping_address --%>
  <div class="form_container">
    <table class="table table-hover">
      <thead>
      <th>
        <h2>배송지 정보</h2>
      </th>
      </thead>
      <tbody>
      <tr>
        <td class="td_title">기존 배송지</td>
        <td><input type="text" class="form-control" id="shipping_address" placeholder="기본 배송지" name="shipping_address"></td>
      </tr>
      <tr>
        <td class="td_title">받으시는 분</td>
        <td><input type="text" class="form-control" id="shipping_name" placeholder="받으시는 분" name="shipping_name"></td>
      </tr>
      <tr>
        <td class="td_title">전화번호</td>
        <td><input type="email" class="form-control" id="shipping_phone" placeholder="전화번호" name="shipping_phone"></td>
      </tr>


      <tr>
        <td class="td_title">주소</td>
        <td>
          <div class="address-container">
            <div class="address-inputs">
              <input type="text" class="form-control" id="address" placeholder="우편번호" name="address">
              <button id="a_search" type="button" onclick="find_addr();">우편번호 찾기</button>
            </div>
            <div class="zipcode-container">
              <input type="text" class="form-control addr_text" name="mem_zipcode" id="mem_zipcode1" placeholder="주소">
              <input type="text" class="form-control addr_text" name="mem_zipcode" id="mem_zipcode2" placeholder="상세주소">
            </div>
          </div>
        </td>
      </tr>


      <tr>
        <td class="td_title">배송시요청사항</td>
        <td><input type="text" class="form-control" id="delivery_request" placeholder="배송시 요청사항" name="delivery_request"></td>
      </tr>
      </tbody>
    </table>
  </div>
</div>
</form>
<%-- form end 지점 --%>

  <div id="order_box">

      <div class="payment-title">결제 정보</div>

      <div class="payment-info">
        <span>상품 합계</span>
        <span class="payment-info-price">10,000원</span>
      </div>

      <div class="payment-info">
        <span>배송료</span>
        <span class="payment-info-price">(+)3,000원</span>
      </div>

      <div class="payment-info" id="payment-info-bottom">
        <span>총 결제 금액</span>
        <span class="payment-info-price-red">13,000원</span>
      </div>

    <hr id="hr1">

    <%--  결제 수단 정렬  --%>
    <div class="payment-method">
      <div class="payment-method-title">결제 수단</div>

      <div class="payment-option">
        <input type="radio" id="paynow" name="payment" value="paynow">
        <label for="paynow">Paynow</label>
      </div>

      <div class="payment-option">
        <input type="radio" id="credit_card" name="payment" value="credit_card">
        <label for="credit_card">신용카드</label>
      </div>

      <div class="payment-option">
        <input type="radio" id="bank_transfer" name="payment" value="bank_transfer">
        <label for="bank_transfer">실시간 계좌이체</label>
      </div>

      <div class="payment-option">
        <input type="radio" id="virtual_account" name="payment" value="bank_transfer">
        <label for="bank_transfer">에스크로 가상계좌</label>
      </div>

      <div class="payment-option">
        <input type="radio" id="depositor" name="payment" value="bank_transfer">
        <label for="bank_transfer">무통장 입금</label>
      </div>

      <div class="payment-option">
        <input type="radio" id="phone_transfer" name="payment" value="bank_transfer">
        <label for="bank_transfer">휴대폰 결제</label>
      </div>

    </div>

    <hr id="hr2">

    <div class="agreement">
      <input type="checkbox" id="agreement" name="agreement">
      <p>결제 정보를 확인하였으며,<br>구매 진행에 동의합니다.</p>
    </div>

    <%--  결제버튼  --%>
    <button class="order-button" onclick="buyItems(100);">주문하기</button>

  </div>

</div>



















<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>


<!-- Back to top -->
<div class="btn-back-to-top" id="myBtn">
		<span class="symbol-btn-back-to-top">
			<i class="zmdi zmdi-chevron-up"></i>
		</span>
</div>

<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/select2/select2.min.js"></script>
<script>
  $(".js-select2").each(function(){
    $(this).select2({
      minimumResultsForSearch: 20,
      dropdownParent: $(this).next('.dropDownSelect2')
    });
  })
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script>
  $('.js-pscroll').each(function(){
    $(this).css('position','relative');
    $(this).css('overflow','hidden');
    var ps = new PerfectScrollbar(this, {
      wheelSpeed: 1,
      scrollingThreshold: 1000,
      wheelPropagation: false,
    });

    $(window).on('resize', function(){
      ps.update();
    })
  });
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

</body>
</html>