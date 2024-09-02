<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>장바구니</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- 우편번호 API 라이브러리 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<link rel="stylesheet" type="text/css" href="../../../resources/css/carts.css">
</head>
<jsp:include page="../common/header.jsp"/>
<script>


	document.addEventListener('DOMContentLoaded', () => {
		const items = document.querySelectorAll('.table_row');
		const totalAmountElement = document.getElementById('totalAmount');
		let grandTotal = 0;

		function updateGrandTotal() {
			grandTotal = 0;
			items.forEach(item => {
				const totalPriceElement = item.querySelector('#totalPrice');
				const totalPrice = parseInt(totalPriceElement.textContent.replace(/원/g, '').replace(/,/g, ''));
				grandTotal += totalPrice;
			});
			totalAmountElement.textContent = grandTotal.toLocaleString() + '원';

			const shippingCost = 3000;
			const finalTotalElement = document.querySelector('.total .amount.highlight');
			finalTotalElement.textContent = (grandTotal + shippingCost).toLocaleString() + '원';
		}

		items.forEach(item => {
			const priceElement = item.querySelector('#productPrice');
			const quantityInput = item.querySelector('.num-product');
			const totalPriceElement = item.querySelector('#totalPrice');

			function updateTotalPrice() {
				const price = parseInt(priceElement.textContent.replace(/원/g, '').replace(/,/g, ''));
				const quantity = parseInt(quantityInput.value);

				if (!isNaN(price) && !isNaN(quantity)) {
					const totalPrice = price * quantity;
					totalPriceElement.textContent = totalPrice.toLocaleString() + '원';
					totalPriceElement.classList.add('shine');

					setTimeout(() => {
						totalPriceElement.classList.remove('shine');
					}, 2000);

					updateGrandTotal();
				}
			}

			// 수량 증가 버튼
			item.querySelector('.btn-num-product-up').addEventListener('click', () => {
				quantityInput.value = parseInt(quantityInput.value) + 1;
				updateTotalPrice();
			});

			// 수량 감소 버튼
			item.querySelector('.btn-num-product-down').addEventListener('click', () => {
				const currentQuantity = parseInt(quantityInput.value);
				if (currentQuantity > 1) {
					quantityInput.value = currentQuantity - 1;
				}
				updateTotalPrice();
			});

			// 초기 총 가격 계산
			updateTotalPrice();
		});

		// Initial grand total calculation
		updateGrandTotal();
	});


</script>

<body class="animsition">


<!-- 장바구니 -->
<div class="wrap-header-cart js-panel-cart">
	<div class="s-full js-hide-cart"></div>

	<div class="header-cart flex-col-l p-l-65 p-r-25">
		<div class="header-cart-title flex-w flex-sb-m p-b-8">
				<span class="mtext-103 cl2">
					장바구니
				</span>

			<div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart">
				<i class="zmdi zmdi-close"></i>
			</div>
		</div>

		<!-- 장바구니 모달 -->
		<div class="header-cart-content flex-w js-pscroll">
			<ul class="header-cart-wrapitem w-full">
				<li class="header-cart-item flex-w flex-t m-b-12">
					<div class="header-cart-item-img">
						<img src="${pageContext.request.contextPath}/resources/images/example.jpg" alt="IMG">
					</div>

					<div class="header-cart-item-txt p-t-8">
						<a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
							장바구니 모달1
						</a>

						<span class="header-cart-item-info">
								1 x $19.00
							</span>
					</div>
				</li>

				<li class="header-cart-item flex-w flex-t m-b-12">
					<div class="header-cart-item-img">
						<img src="${pageContext.request.contextPath}/resources/images/example.jpg" alt="IMG">
					</div>

					<div class="header-cart-item-txt p-t-8">
						<a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
							장바구니 모달2
						</a>

						<span class="header-cart-item-info">
								1 x $39.00
							</span>
					</div>
				</li>


			</ul>

			<div class="w-full">
				<div class="header-cart-total w-full p-tb-40">
					총 가격: $75.00
				</div>

				<div class="header-cart-buttons flex-w w-full">
					<a href="shopingCart.do"
					   class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-r-8 m-b-10">
						장바구니 이동
					</a>

					<a href="#" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
						즉시 결제
					</a>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 장바구니 리스트 -->
<div class="bg0 p-t-75 p-b-85">

	<div class="cart_list" style="margin: 20px;">
		<!-- breadcrumb -->
		<div class="container">
			<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
				<a href="../" class="stext-109 cl8 hov-cl1 trans-04">
					Home
					<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
				</a>

				<span class="stext-109 cl4">
					장바구니
				</span>
			</div>
		</div>
	</div>

	<div>
		<h1>장바구니</h1>
		<div class="container">
			<div class="row">
				<div class="col-lg-11 col-xl-11 m-lr-auto m-b-50">
					<div class="m-l-25 m-r--38 m-lr-0-xl">
						<div class="wrap-table-shopping-cart">
							<table class="table-shopping-cart">

								<!-- th -->
								<tr class="table_head">
									<th style="padding: 0px; margin: 0px; width: 1%;">
										<input type="checkbox" style="margin-left: 20px;">
									</th>
									<th class="column-1">상품</th>
									<th class="column-2" style="width: 35%;">이름</th>
									<th class="column-3">가격</th>
									<th class="column-4" style="text-align: center;">수량</th>
									<th class="column-5">총 가격</th>
								</tr>


								<!-- td -->
								<c:forEach var="cart" items="${ requestScope.cartsVo }">

								<tr class="table_row" style="height: 100px;">
									<td style="padding: 0px; margin: 0px; width: 1%;">
										<input type="checkbox" style="margin-left: 20px;">
									</td>
									<td class="column-1" style="padding-bottom: 0px";>
										<div class="how-itemcart1" onclick="itemCartDelete(this)">
											<img src="${pageContext.request.contextPath}${ cart.imageUrl }"
												 alt="${ cart.id }">
										</div>
										<script>
											// x 누른 image 카트에서 삭제되게 하기
											function itemCartDelete(element){

												if(confirm("장바구니 아이템을 삭제하시겠습니까?") == false) {
													return;
												}

												let deleteImg = element.querySelector('img');
												let productId = deleteImg.alt;
												let loginUser = '${ loginUser.id }';

												$.ajax({
													url 	: "CartDelete.do",
													type	: "POST",
													data	: { productId : productId,
																loginUser : loginUser
													},
													success	: function (res_data) {
														alert("장바구니에서 상품이 삭제되었습니다.");
														location.href="CartList.do?loginUser=" + loginUser;
													},
													error	: function (err) {
														alert("오류로 인해 장바구니에서 상품 삭제가 취소되었습니다.");
													}
												});

											}



										</script>
									</td>
									<td class="column-2" style="padding-bottom: 0px;">${ cart.name }</td>
									<td class="column-3" style="padding-bottom: 0px;">
										<span id="productPrice">${ cart.price }원</span>
									</td>
									<td class="column-4" style="text-align: center; padding-bottom: 0px">
										<div class="wrap-num-product flex-w m-auto">
											<div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
												<i class="fs-16 zmdi zmdi-minus"></i>
											</div>

											<input class="mtext-104 cl3 txt-center num-product" type="number"
												   name="num-product1" value="${ cart.quantity }">

											<div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
												<i class="fs-16 zmdi zmdi-plus"></i>
											</div>
										</div>
									</td>
									<td class="column-5" style="padding-bottom: 0px";>
										<span id="totalPrice">${ cart.price * cart.quantity }</span>
									</td>
								</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>

			<hr>

			<div class="total-container">
				<div class="item">
					<span class="label">총상품금액</span>
					<span class="amount" id="totalAmount">0원</span>
				</div>
				<div class="item">
					<span class="label">+</span>
				</div>
				<div class="item">
					<span class="label">총배송비</span>
					<span class="amount">3,000원</span>
				</div>
				<div class="item">
					<span class="label">=</span>
				</div>
				<div class="item total">
					<span class="label">TOTAL</span>
					<span class="amount highlight">3,000원</span>
					<span class="extra">FIGU</span>
				</div>
			</div>

			<hr>

			<!-- 장바구니 리스트의 결제 -->

			<script>
				function processOrder() {
					// quantity 값을 넣어줄 배열 생성
					var quantities = [];
					//
					var inputs = document.getElementsByName('num-product1');
					for (var i = 0; i < inputs.length; i++) {
						quantities.push(inputs[i].value);
					}

					var queryString = quantities.map(function(qty, index) {
						return 'quantities=' + encodeURIComponent(qty);
					}).join('&');

					window.location.href = 'order/orderForm.do?' + queryString + '&loginUserId=' + ${ loginUser.id };
				}
			</script>

			<div class="orders_btn" style="text-align: center;">
				<div style="display: inline-block;margin: auto; padding: 10px">
					<button class="flex-c-m stext-101 cl2 size-119 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer m-tb-10"
							style="width: 400px; padding: 10px; height: 50px" onclick="processOrder()">
						선택상품 결제
					</button>
				</div>

				<div style="display: inline-block; margin: auto; padding: 10px">
					<button class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer"
							style="width: 400px; padding: 10px; height: 50px"
							onclick="processOrder()">
						전체상품 결제
					</button>
				</div>
			</div>

		</div>
	</div>
</div>


<!-- Footer -->
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
	$(".js-select2").each(function () {
		$(this).select2({
			minimumResultsForSearch: 20,
			dropdownParent: $(this).next('.dropDownSelect2')
		});
	})
</script>

<script>

	// 우편번호 API
	function send_zipcode() {

		new daum.Postcode({
			oncomplete: function (data) {
				// input 태그에 넣는 것이니 value 값을 넣어야 한다.
				$("#zipcode").val(data.zonecode);
				$("#address").val(data.address);
			}
		}).open();
	}// end:send_zipcode()

</script>

<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
<script>
	$('.js-pscroll').each(function () {
		$(this).css('position', 'relative');
		$(this).css('overflow', 'hidden');
		var ps = new PerfectScrollbar(this, {
			wheelSpeed: 1,
			scrollingThreshold: 1000,
			wheelPropagation: false,
		});

		$(window).on('resize', function () {
			ps.update();
		})
	});
</script>
<!--===============================================================================================-->
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

</body>
</html>