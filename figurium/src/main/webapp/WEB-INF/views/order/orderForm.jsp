<%@ page import="com.githrd.figurium.product.entity.Products, java.util.List" %>
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


    function buyItems(price) {

      // 만약에 결제 방식을 선택하지 않았다면, return되게 한다.
      let paymentType = document.querySelector('input[name="payment"]:checked');
      if (paymentType == null) {
        alert("결제방식을 선택하고 결제를 진행해주세요.");
        return;
      }
      // 약관 동의 체크
      let agreementCheckbox = document.getElementById("agreement");
      if(!agreementCheckbox.checked) {
        alert("약관에 동의해주세요.");
        return;
      }

      console.log(productIds);
      console.log(itemQuantities);

      $.ajax({
        type : "POST",
        url : "checkProduct.do",
        data : {
          productIds : productIds,
          itemQuantities : itemQuantities
        },
        success: function(res_data){
          alert("재고가 남아있습니다.");

          IMP.request_pay({
            pg : 'kcp', // PG사 코드표에서 선택
            pay_method : 'card', // 결제 방식
            merchant_uid: 'merchant_' + new Date().getTime(), // 결제 고유 번호
            name: '피규리움 결제창',   // 상품명
            amount : price, // 가격
            buyer_email : 'cktjsdlf4636@naver.com',
            buyer_name : '피규리움 기술지원팀',
            buyer_tel : '010-1234-5678',
            buyer_addr : '서울특별시 강남구 삼성동',
            buyer_postcode : '123-456'
          }, function (rsp) { // callback
            console.log(rsp);
            // 결제검증
            $.ajax({
              type : "POST",
              url  : "/verifyIamport/" + rsp.imp_uid
            }).done(function(data){
              console.log(data);

              // 위의 rsp.paid_amount(결제 완료 후 객체 정보를 JSON으로 뽑아옴)와
              // data.response.amount(서버에서 imp_uid로 iamport에 요청된 결제 정보)를 비교한후 로직 실행
              if(rsp.paid_amount == data.response.amount) {
                alert("결제 및 결제 검증완료");  // 결제검증이 성공적으로 이뤄지면 실행되는 로직
                sil(price);

              } else {
                alert("결제에 실패했습니다. 관리자에게 문의해주세요.")  // 결제검증이 실패하면 이뤄지는 실패 로직
              }
            });
          });
        },
        error: function(err){
          alert("해당 상품의 재고가 충분하지 않습니다. 해당 상품의 재고를 문의해주세요.");
          return;
        }
      });


    }

    let paymentType = document.querySelector('input[name="payment"]:checked');

    function sil(price) {

      alert("sil 실행");

      //결제 완료된 주문 데이터 저장
      $.ajax({
        type : "POST",
        url  : "/order/inicisPay.do",
        data : {
          price : price,
          paymentType : "카드"
        },

        success: function(res_data){
          insertInformation();
        },

        error: function(err){
          alert(err.responseText);
        }
      });

    }


    function insertInformation() {

      // 주문 리스트에 저장될 값들 전부 변수로 저장

      // var itemNames = [ 아이템 이름 배열 저장 ];
      // var itemPrices = [ 아이템 가격 배열 저장 ];
      // var itemQuantities = [ 아이템 갯수 배열 저장 ];


      let loginUserId = document.getElementById("order_id").value;         // 보낸 사람 이름
      let name = document.getElementById("order_name").value;         // 보낸 사람 이름
      let phone = document.getElementById("order_phone").value;       // 보낸 사람 전화번호
      let email = document.getElementById("order_email").value;       // 이메일

      // 받는 사람 주소
      let memZipcode0 = document.getElementById('address').value;
      let memZipcode1 = document.getElementById('mem_zipcode1').value;
      let memZipcode2 = document.getElementById('mem_zipcode2').value;

      let address = memZipcode0 + ' ' + memZipcode1 + ' ' + memZipcode2;

      let recipientName = document.getElementById("shipping_name").value;         // 받는 사람 이름
      let shippingPhone = document.getElementById("shipping_phone").value;       // 받는 사람 주소
      let deliveryRequest = document.getElementById("delivery_request").value;   // 배송 요청 사항


      console.log(address);

  /*    let shipping_address = f.shipping_address.value;  // 배송지
      let shipping_name = f.shipping_name.value;        // 받는 사람
      let shipping_phone = f.shipping_phone.value;      // 받는 사람 전화번호
      let delivery_request = f.delivery_request.value;  // 배송시 요청사항*/


      $.ajax({
        type : "POST",
        url : "insertInformation.do",
        data : {
          loginUserId : loginUserId,
          name : name,
          phone : phone,
          email : email,
          address : address,
          recipientName : recipientName,
          shippingPhone : shippingPhone,
          deliveryRequest : deliveryRequest,
          productIds : productIds,
          itemPrices : itemPrices,
          itemQuantities : itemQuantities
/*          shipping_address : shipping_address,
          paymentType : paymentType,
          itemNames : itemNames,
          itemPrices : itemPrices,
          itemQuantities : itemQuantities*/
        },
        success: function(res_data){
          alert("축하드려요");
          location.href="/";
        },
        error: function(err){
          alert(err.responseText);
        }
      });


    }
  </script>


</head>
<body class="animsition">
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>










<%-- Content --%>

<div id="content_title">

  <div class="cart_list" style="margin: 20px;">
    <!-- breadcrumb -->
    <div class="container">
      <div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
        <a href="../" class="stext-109 cl8 hov-cl1 trans-04">
          Home
          <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
        </a>

        <a href="CartList.do?loginUser=${ loginUser.id }" class="stext-109 cl8 hov-cl1 trans-04">
          장바구니
          <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
        </a>

        <span class="stext-109 cl4">
          주문/결제
        </span>
      </div>
    </div>
  </div>

  <h1>주문서</h1>

<%-- 상단 아이템 주문 리스트 --%>
    <%--  장바구니 예시 테이블 : 0828 --%>
  <c:if test="${ cartsList == null }">
  <div class="item_list">
    <table class="table item_list_table table-hover">
      <thead id="thead">
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
  </c:if>

    <%-- form 시작 지점 --%>
    <form>

    <%-- 만약에 장바구니에 담겼던 item 값이 넘어왔다면 list에 호출 : 0828 --%>
    <%-- itemNames라는 배열을 생성해서 for문안에 넣어 이름을 추가 --%>
    <c:if test="${ cartsList != null }">
      <script type="text/javascript">
        let productIds = [];
        let itemPrices = [];
        let itemQuantities = [];

        <c:forEach var="item" items="${ requestScope.cartsList }">
          productIds.push("${ item.id }");
          itemPrices.push("${ item.price }");
          itemQuantities.push("${ item.quantity }");
        </c:forEach>
      </script>



      <table class="table item_list_table">
          <thead>
          <tr class="table-light">
            <th id="item_list_table_name">상품명</th>
            <th>가격</th>
            <th>수량</th>
            <th>총 금액</th>
          </tr>
          </thead>

        <tbody>
        <c:forEach var="item" items="${ requestScope.cartsList }">
          <tr class="table_content">
            <td id="table_content_img"><img src="${pageContext.request.contextPath}${ item.imageUrl }" alt="IMG">
              <span id="table_content_img_text">${ item.name }</span>
            </td>
            <td><fmt:formatNumber type="currency" value="${ item.price }" currencySymbol=""/>원</td>
            <td>${ item.quantity }</td>
            <td><fmt:formatNumber type="currency" value="${ item.price * item.quantity }" currencySymbol=""/>원</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>

    </c:if>



</div>



<div class="order_box_both">
  <input type="hidden" value="${ sessionScope.loginUser.id }" id="order_id">

<%-- 주문 테이블 customers --%>
<div class="order_box_l mt-3">
  <div class="form_container">
    <table class="table">
      <thead>
      <th>
        <h2>주문자 입력</h2>
      </th>
      </thead>
      <tbody>
      <tr>
        <td class="td_title">주문하시는 분</td>
        <td><input type="text" class="form-control" value="${ sessionScope.loginUser.name }" id="order_name" placeholder="주문하시는 분" name="order_name"></td>
      </tr>
      <tr>
        <td class="td_title">전화번호</td>
        <td><input type="text" class="form-control" value="${ sessionScope.loginUser.phone }" id="order_phone" placeholder="전화번호" name="order_phone"></td>
      </tr>
      <tr>
        <td class="td_title">이메일</td>
        <td><input type="email" class="form-control" value="${ sessionScope.loginUser.email }" id="order_email" placeholder="이메일" name="order_email"></td>
      </tr>
      </tbody>
    </table>
  </div>

  <div id="table_under_box">
    <span>회원정보가 변경되셨다면 다음 버튼을 누르고 수정해주세요.</span>
    <input type="button" class="form-control" id="user_change_btn" value="회원정보수정">
  </div>

  <%-- 주문 테이블 shipping_address --%>
  <div class="form_container">
    <table class="table">
      <thead>
      <th>
        <h2>배송지 정보</h2>
      </th>
      </thead>
      <tbody>
      <tr>
        <td class="td_title">기존 배송지</td>
        <td><input type="text" class="form-control" value="${ sessionScope.loginUser.address }" id="shipping_address" placeholder="기본 배송지" name="shipping_address"></td>
      </tr>
      <tr>
        <td class="td_title">받으시는 분</td>
        <td><input type="text" class="form-control" value="${ sessionScope.loginUser.name }" id="shipping_name" placeholder="받으시는 분" name="shipping_name"></td>
      </tr>
      <tr>
        <td class="td_title">전화번호</td>
        <td><input type="email" class="form-control" value="${ sessionScope.loginUser.phone }" id="shipping_phone" placeholder="전화번호" name="shipping_phone"></td>
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
        <td>
          <textarea class="form-control" rows="5" id="delivery_request" placeholder="배송시 요청사항" placeholer="배송시 요청사항을 적어주세요."></textarea>
        </td>
        <%--<td><textarea class="form-control" id="delivery_request" placeholder="배송시 요청사항" name="delivery_request"></td>--%>
      </tr>
      </tbody>
    </table>
  </div>
</div>

  </form>
  <%-- form end 지점 --%>

  <div id="order_box">

      <div class="payment-title">결제 정보</div>

      <%-- 상품가격 + 배송비 계산 항목 : 0828 --%>
      <c:if test="${ itemList == null }">
      <div class="payment-info">
        <span>상품 합계</span>
        <span class="payment-info-price">0원</span>
      </div>

      <div class="payment-info">
        <span>배송료</span>
        <span class="payment-info-price">(+)0원</span>
      </div>

      <div class="payment-info" id="payment-info-bottom">
        <span>총 결제 금액</span>
        <span class="payment-info-price-red">0원</span>
      </div>
    </c:if>

    <c:if test="${ cartsList != null }">
      <div class="payment-info">
        <span>상품 합계</span>
        <span class="payment-info-price">
          <fmt:formatNumber type="currency" value="${ totalPrice }" currencySymbol=""/>원
        </span>
      </div>

      <div class="payment-info">
        <span>배송료</span>
        <span class="payment-info-price">(+)3,000원</span>
      </div>

      <div class="payment-info" id="payment-info-bottom">
        <span>총 결제 금액</span>

        <span class="payment-info-price-red">
          <fmt:formatNumber type="currency" value="${ totalPrice + 3000 }" currencySymbol=""/>원
        </span>
      </div>
    </c:if>

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
      <input type="checkbox" id="agreement">
      <p>결제 정보를 확인하였으며,<br>구매 진행에 동의합니다.</p>
    </div>

    <%--  결제버튼  --%>
    <button class="order-button" onclick="sil(100);">주문하기</button>

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