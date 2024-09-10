<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>관리자 페이지</title>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>

    <link rel="icon" type="image/png" href="/images/FiguriumHand.png"/>
    <style>
        .thead-light > tr > th {
            text-align: center;
            vertical-align: middle !important;
        }

        tbody > tr > td {
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
                <a class="nav-link" href="productInsertForm.do">상품 등록</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="adminPayment" >사용자 결제 & 반품 승인</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="changeStatus">배송상태 변경</a>
            </li>
            <li class="nav-item">
                <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart"
                     id="qa-notify"
                     data-notify="0">
                    <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
                       id="viewQaList" >Q&A 미답변</a>
                </div>
            </li>
        </ul>
    </nav>

    <br><br>
    <div id="admin-view"></div>
</div>

<!-- 푸터 -->
<jsp:include page="../common/footer.jsp"/>
</body>


<script>


    function adminPayment() {
        $.ajax({
            url: 'adminPayment.do',
            type: 'POST',
            success: function (paymentList) {
                let html = `
                <table class="table table-hover" style="width: 90%; margin: auto">
                    <thead class="thead-light">
                        <tr>
                            <th class="col-3">주문번호<br>주문일자</th>
                            <th class="col-3">상품명</th>
                            <th class="col-1">결제방식</th>
                            <th class="col-1">총 결제금액</th>
                            <th class="col-1">결제상태</th>
                            <th class="col-1">주문상태</th>
                        </tr>
                    </thead>
                    <tbody>
            `;
                paymentList.forEach(function (order) {
                    html += `
                    <tr>
                        <td>\${order.id}<br>\${order.createdAt}</td>
                        <td>\${order.productName}</td>
                        <td>\${order.paymentType === 'vbank' ? '무통장입금' : '카드결제'}
                            <!-- TODO 무통장입금건 입금확인요청시 체크할 버튼필요-->

                        </td>
                        <td>\${order.price}</td>
                        <td>\${order.valid === 'y' ? '결제완료' : '환불완료'}</td>
                               <!-- TODO 환불요청시 환불처리 기능 필요 -->
                        <td>\${order.status}</td>
                        <input type="hidden" name="ordersId" value="\${order.id}">
                    </tr>
                `;
                });

                html += `
                    </tbody>
                </table>
            `;

                // 동적으로 생성한 HTML을 페이지에 삽입
                $('#admin-view').html(html);
            },
            error: function (xhr, status, error) {
                $('#admin-view').html('<p>문제가 발생했습니다. 다시 시도해주세요.</p>');
            }
        });


    }

    function adminRefund() {
        $.ajax({
            url: 'adminRefund.do',
            type: 'POST',
            success: function (orderList) {
                let html = `
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
            `;

                // orderList가 배열일 경우 각 항목을 반복
                orderList.forEach(function (order) {
                    html += `
                    <tr>
                        <td>\${order.id}<br>\${order.createdAt}</td>
                        <td>\${order.productName}</td>
                        <td>\${order.paymentType === 'vbank' ? '무통장입금' : '카드결제'}</td>
                        <td>\${order.price}</td>
                        <td>\${order.valid === 'y' ? '결제완료' : '환불완료'}</td>
                        <td>
                            <a>\${order.status}</a>&nbsp;&nbsp;
                                <input type="button" class="deliveryButton" value="상태변경" style="display: inline-block;" onclick="toggleButtons(this);">
                                <select style="margin: 0px; display: none;" class="deliveryCondition" name="deliveryCondition">
                                    <option value="준비중" \${order.status == '준비중' ? 'selected' : ''}>준비중</option>
                                    <option value="출고대기" \${order.status == '출고대기' ? 'selected' : ''}>출고대기</option>
                                    <option value="배송중" \${order.status == '배송중' ? 'selected' : ''}>배송중</option>
                                    <option value="배송완료" \${order.status == '배송완료' ? 'selected' : ''}>배송완료</option>
                                </select>
                            <input type="button" class="delivery" value="적용" style="display: none;" onclick="deliveryChange(this);">
                            <input type="hidden" name="ordersId" value="\${order.id}">
                        </td>
                    </tr>
                `;
                });

                html += `
                    </tbody>
                </table>
            `;

                // 동적으로 생성한 HTML을 페이지에 삽입
                $('#admin-view').html(html);
            },
            error: function (xhr, status, error) {
                $('#admin-view').html('<p>문제가 발생했습니다. 다시 시도해주세요.</p>');
            }
        });
    }

    function updateQaCount() {
        $.ajax({
            url: 'qaCount.do', // 컨트롤러에서 갯수를 가져오는 URL
            type: 'GET',
            dataType: 'json',
            success: function (response) {
                if (response && response.count !== undefined) {
                    $('#qa-notify').attr('data-notify', response.count);
                } else {
                    $('#qa-notify').attr('data-notify', '0'); // 갯수가 없을 경우 0으로 설정
                }
            },
            error: function (xhr, status, error) {
                console.error('QA 갯수 가져오는 데 실패했습니다.', error);
                $('#qa-notify').attr('data-notify', '0'); // 오류 발생 시 0으로 설정
            }
        });
    }

    function adminQaList() {
        $.ajax({
            url: 'adminQaList.do',
            type: 'GET',
            dataType: 'json', // 서버에서 JSON으로 응답받기를 기대
            success: function (response) {

                let html = `
                <div class="container pt-3">
                    <h1 style="margin-bottom: 15px">Q&A 게시판</h1>
                    <hr>
                    <table class="table table-hover">
                        <thead class="thead-light">
                            <tr style="text-align: center">
                                <th>번호</th>
                                <th>제목</th>
                                <th>답변여부</th>
                                <th>작성자</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <tbody style="text-align: center;">
            `;
                $.each(response, function (index, qa) {

                    html += `
                    <tr onclick="location.href='qa/qaSelect.do?id=\${qa.id}'" style="cursor: pointer;">
                        <td>\${index + 1}</td>
                        <td class="truncate-title" style="text-align: left;">
                            <span style="font-size: 18px;" class="material-symbols-outlined">lock</span>
                            \${qa.title}
                        </td>
                        <td>\${qa.replyStatus}</td>
                        <td>\${qa.name}</td>
                        <td>\${qa.created.substring(0, 10)} \${qa.created.substring(11, 16)}</td>
                    </tr>
                `;
                });
                html += `
                        </tbody>
                    </table>
                </div>
            `;
                $('#admin-view').html(html);
            },
            error: function (xhr, status, error) {
                $('#admin-view').html('<p>문제가 발생했습니다. 다시 시도해주세요.</p>');
            }
        });
    }

    $(document).ready(function () {

        updateQaCount();


        $('#adminPayment').click(function (event) {
            event.preventDefault();
            adminPayment();
        });

        $('#changeStatus').click(function (event) {
            event.preventDefault();
            adminRefund();
        });

        $('#viewQaList').click(function (event) {
            event.preventDefault();
            adminQaList();
        });
    });
</script>

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
                //location.reload();
                adminRefund();
            },
            error: function (xhr, status, error) {
                console.log('Error:', error);
                // 오류 시 처리할 내용
                alert("변경이 실패했습니다.\n잠시후 다시시도 해주세요");
            }
        });
    }


</script>

</html>
