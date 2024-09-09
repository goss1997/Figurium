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
	<link rel="stylesheet" type="text/css" href="/css/carts.css">
</head>
<jsp:include page="../common/header.jsp"/>
<script>


	$(document).ready(function() {
		const shippingCost = 3000;

		function updateTotalPrice(item) {
			const priceElement = item.find('#productPrice');
			const quantityInput = item.find('.num-product');
			const totalPriceElement = item.find('#totalPrice');

			const price = parseInt(priceElement.text().replace(/원/g, '').replace(/,/g, ''));
			const quantity = parseInt(quantityInput.val());

			if (!isNaN(price) && !isNaN(quantity)) {
				const totalPrice = price * quantity;
				totalPriceElement.text(totalPrice.toLocaleString() + '원');
				totalPriceElement.addClass('shine');

				setTimeout(() => {
					totalPriceElement.removeClass('shine');
				}, 2000);
			}
		}

		function updateGrandTotal() {
			let grandTotal = 0;

			$('.itemCheckbox:checked').each(function() {
				const item = $(this).closest('.table_row');
				const totalPrice = parseInt(item.find('#totalPrice').text().replace(/원/g, '').replace(/,/g, ''));
				grandTotal += totalPrice;
			});

			$('#totalAmount').text(grandTotal.toLocaleString() + '원');
			const finalTotal = grandTotal + shippingCost >= 100000 ? grandTotal : grandTotal + shippingCost;

			if (grandTotal >= 100000) {
				$('.shipping_fee').text('0원'); // 배송비 0원으로 표시
			} else {
				$('.shipping_fee').text(shippingCost.toLocaleString() + '원'); // 배송비 3,000원으로 표시
			}

			$('.total .amount.highlight').text(finalTotal.toLocaleString() + '원');
		}

		$('.btn-num-product-up').on('click', function() {
			const item = $(this).closest('.table_row');
			const quantityInput = item.find('.num-product');
			quantityInput.val(parseInt(quantityInput.val()) + 1);
			updateTotalPrice(item);
			updateGrandTotal();
		});

		$('.btn-num-product-down').on('click', function() {
			const item = $(this).closest('.table_row');
			const quantityInput = item.find('.num-product');
			const currentQuantity = parseInt(quantityInput.val());
			if (currentQuantity > 1) {
				quantityInput.val(currentQuantity - 1);
			}
			updateTotalPrice(item);
			updateGrandTotal();
		});

		$('.itemCheckbox').on('change', updateGrandTotal);

		$('#selectAll').on('change', function() {
			const isChecked = $(this).is(':checked');
			$('.itemCheckbox').prop('checked', isChecked);
			updateGrandTotal();
		});

		// 초기 총 가격 계산
		$('.table_row').each(function() {
			updateTotalPrice($(this));
		});
		updateGrandTotal();
	});



</script>

<body class="animsition">

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
<form>
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
										<input id="selectAll" type="checkbox" style="margin-left: 20px;">
									</th>
									<th class="column-1">상품</th>
									<th class="column-2" style="width: 35%;">이름</th>
									<th class="column-3">가격</th>
									<th class="column-4" style="text-align: center;">수량</th>
									<th class="column-5">총 가격</th>
								</tr>


								<!-- td -->
								<c:forEach var="cart" items="${ cartsVo }">
									<input type="hidden" name="userId" value="${cart.userId}">
									<input type="hidden" name="productId[]" value="${cart.productId}">
								<tr class="table_row" style="height: 100px;">
									<td style="padding: 0px; margin: 0px; width: 1%;">
										<input class="itemCheckbox" type="checkbox" style="margin-left: 20px;">
									</td>
									<td class="column-1"  style="padding-bottom: 0px";>
										<div class="how-itemcart1" onclick="itemCartDelete(this)">
											<img src="${ cart.imageUrl }"
												 alt="${ cart.productId }">
										</div>
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
												   name="quantity[]" value="${ cart.quantity }" readonly>

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
					<span class="label">선택 상품금액</span>
					<span class="amount" id="totalAmount">0원</span>
				</div>
				<div class="item">
					<span class="label">+</span>
				</div>
				<div class="item">
					<span class="label">배송비</span>
					<span class="shipping_fee"></span>
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

			<div class="orders_btn" style="text-align: center;">
				<div style="display: inline-block;margin: auto; padding: 10px">
					<button class="flex-c-m stext-101 cl2 size-119 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer m-tb-10"
							style="width: 400px; padding: 10px; height: 50px" onclick="checkProductOrder(this.form)">
						선택상품 결제
					</button>
				</div>

				<div style="display: inline-block; margin: auto; padding: 10px">
					<button class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer"
							style="width: 400px; padding: 10px; height: 50px"
							onclick="allProductsOrder(this.form)">
						전체상품 결제
					</button>
				</div>
			</div>
		</div>
	</div>
</form>
</div>




<!-- Footer -->
<jsp:include page="../common/footer.jsp"/>


<!-- Back to top -->
<div class="btn-back-to-top" id="myBtn">
		<span class="symbol-btn-back-to-top">
			<i class="zmdi zmdi-chevron-up"></i>
		</span>
</div>


<script>
	// 상단 체크박스 클릭 시 전체 체크박스 선택 로직
	$(document).ready(function() {
		// 상단 체크박스와 개별 체크박스들 선택
		$('#selectAll').on('change', function() {
			// 상단 체크박스의 체크 상태를 가져와서
			var isChecked = $(this).is(':checked');
			// 모든 개별 체크박스에 체크 상태를 적용
			$('.itemCheckbox').prop('checked', isChecked);
		});
	});
</script>


<script>
	// x 누른 image 카트에서 삭제되게 하기
	function itemCartDelete(element){

		let deleteImg = element.querySelector('img');
		let productId = element.querySelector('img').alt; // 해당 이미지의 alt 속성에 저장한 productId를 가져와서 사용
		let loginUserId  = "${sessionScope.loginUser.id}"

		if(confirm("장바구니 아이템을 삭제하시겠습니까?") == false) {
			return;
		}

		$.ajax({
			url 	: "CartDelete.do",
			type	: "POST",
			data	: { productId : productId,  loginUserId  :  loginUserId },
			success	: function (res_data) {
				alert("장바구니에서 상품이 삭제되었습니다.");
					location.href = "CartList.do"
			},
			error	: function (err) {
				alert("오류로 인해 장바구니에서 상품 삭제가 취소되었습니다.");
			}
		});

	}
</script>

<script>
	// 장바구니에 담긴 상품을 선택해 결제 폼으로 넘김

		function checkProductOrder(f) {

			// 선택된 체크박스 요소가 무엇이 있는지 확인한다.
			let checkedItems = Array.from(f.querySelectorAll('input.itemCheckbox:checked'));

			// 리스트를 넘겨줄 input name 태그들의 값을 배열로 받아준다.
			let productId = Array.from(f.querySelectorAll('input[name="productId[]"]')).map(input => input.value);
			let cartQuantities = Array.from(f.querySelectorAll('input[name="quantity[]"]')).map(input => input.value);


			// 체크된 항목이 없으면 경고 메시지
			if (checkedItems.length === 0) {
				alert("선택된 상품이 없습니다.");
				return;
			}

			// 중복되는 데이터 방지를 위해 기존의 hidden input 필드 제거한다.
			f.querySelectorAll('input[type="hidden"]').forEach(input => input.remove());

			// 체크된 요소들을 반복해서 돌림
			checkedItems.forEach(item => {
			// 체크박스 요소의 인덱스를 찾기 위해 전체 체크박스 요소들을 배열로 변환하며 체크된 항목의 배열 인덱스를 찾는다
				let index = Array.from(f.querySelectorAll('input.itemCheckbox')).indexOf(item);

				// 다시 체크된 요소들을 ID에 추가하고 input 태그를 생성
				let inputProductId = document.createElement('input');
				inputProductId.type = 'hidden';
				inputProductId.name = 'productId';
				inputProductId.value = productId[index];
				f.appendChild(inputProductId);

				let inputQuantity = document.createElement('input');
				inputQuantity.type = 'hidden';
				inputQuantity.name = 'cartQuantities';
				inputQuantity.value = cartQuantities[index];
				f.appendChild(inputQuantity);
			});


			if (!confirm("선택된 상품들만 결제 페이지로 이동 하시겠습니까?")) return;

			f.method = "POST";
			f.action = "order/orderForm.do";
			f.submit();
		}
</script>

<script>
	// 장바구니에 담긴 상품 전체를 결제 폼으로 넘김
	function allProductsOrder(f){
		// 리스트를 넘겨줄 값을 배열로 가져오기
		let productIds = Array.from(f.querySelectorAll('input[name="productId[]"]')).map(input => input.value);
		let cartQuantities = Array.from(f.querySelectorAll('input[name="quantity[]"]')).map(input => input.value);

		console.log("productIds = " + productIds);
		console.log("cartQuantities = " + cartQuantities);

		if (!confirm("전체상품 결제를 위해 결제 페이지로 이동 하시겠습니까?")) return;

		// productId와 quantity 필드를 폼에 추가 (이거 안하면 데이터 안넘어감)
		productIds.forEach((productId, index) => {
			let inputProductId = document.createElement('input');
			inputProductId.type = 'hidden';
			inputProductId.name = 'productId';
			inputProductId.value = productId;
			f.appendChild(inputProductId);

			let inputQuantity = document.createElement('input');
			inputQuantity.type = 'hidden';
			inputQuantity.name = 'cartQuantities';
			inputQuantity.value = cartQuantities[index] || 0; // 없는 경우 0으로 설정
			f.appendChild(inputQuantity);
		});

		f.method = "POST";
		f.action = "order/orderForm.do";
		f.submit();
	}
</script>



</body>
</html>