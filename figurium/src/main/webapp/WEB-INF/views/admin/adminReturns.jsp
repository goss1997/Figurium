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
    <title>반품승인</title>
    <!-- TODO : 제목 과 스타일 영역 -->
    <style>
        .thead-light > tr > th {
            text-align: center;
            vertical-align: middle !important;
        }

        tbody > tr > td {
            text-align: center;
            vertical-align: middle !important;
        }

        .nav-link:hover {
            cursor: pointer;
        }
        .navbar-nav > li {
            line-height: 1;
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
                <div class=" cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti">
                    <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
                       href="adminSlideChange.do">메인 슬라이드 변경</a>
                </div>
            </li>

            <li class="nav-item">
                <div class=" cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti">
                    <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
                       href="productInsertForm.do">상품 등록</a>
                </div>
            </li>

            <li class="nav-item">
                <div class=" cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti">
                    <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
                       href="admin.do">주문조회</a>
                </div>
            </li>

            <li class="nav-item">
                <div class=" cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti">
                    <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
                       id="changeStatus" href="adminRefund.do">배송상태 변경</a>
                </div>
            </li>

            <li class="nav-item">
                <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
                     id="quantity-notify"
                     data-notify="0">
                    <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
                       href="adminQuantity.do">상품 재고수정</a>
                </div>
            </li>

            <li class="nav-item">
                <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
                     id="payment-notify"
                     data-notify="0">
                    <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
                       href="adminPayment.do">결제취소</a>
                </div>
            </li>

            <li class="nav-item">
                <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti"
                     id="retrun-notify"
                     data-notify="0">
                    <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;"
                       href="adminReturns.do">반품승인</a>
                </div>
            </li>

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
            <th class="col-2">주문번호<br>주문일자</th>
            <th class="col-3">상품명</th>
            <th class="col-1">결제방식</th>
            <th class="col-1">총 결제금액</th>
            <th class="col-1">결제상태</th>
            <th class="col-1">주문상태</th>
            <th class="col-1">반품처리</th>
        </tr>
        </thead>
        <tbody><%--중복 ID 미노출되도록 하는 set 코드--%>
        <c:set var="prevId" value="" />
        <c:forEach var="listReturns" items="${listReturns}">
        <c:if test="${listReturns.id ne prevId}">
            <tr>
                <td>${listReturns.id}<br>${listReturns.createdAt}</td>
                <td>${listReturns.productName}</td>
                <td>${listReturns.paymentType == 'vbank' ? '무통장입금' : '카드결제'}</td>
                <td>${listReturns.price}원</td>
                <td>${listReturns.valid == 'y' ? '결제완료' : '환불완료'}</td>
                <td>${listReturns.status}</td>
                <td>
                    <c:if test="${listReturns.status ne '환불완료'}">
                        <input class="btn btn-light" type="button" value="환불처리" onclick="ordersReturns(this);">
                    </c:if>
                </td>
                <input type="hidden" name="returnsId" value="${listReturns.id}">
                <input type="hidden" name="qaId" value="${listReturns.qaId}">
            </tr>
            <c:set var="prevId" value="${listReturns.id}" />
        </c:if>
        </c:forEach>
        </tbody>
    </table>

</div>
<!-- 푸터 -->
<jsp:include page="../common/footer.jsp"/>
</body>

<script>

    function ordersReturns(button) {

        // 클릭된 버튼의 부모 tr 설정
        const row = $(button).closest('tr');

        // ordersId 값을 가져오기
        const returnsId = row.find('input[name="returnsId"]').val();
        const qaId = row.find('input[name="qaId"]').val();

        $.ajax({
            url: 'api/refundAdmin.do', // 컨트롤러에서 갯수를 가져오는 URL
            type: 'POST',
            data: {id: returnsId},
            dataType: 'json',
            success: function (response) {
                if (response > 0) {

                    if (confirm("반품처리에 성공했습니다.\n반품하신 상품의 QA문의에 답글 작성하시겠습니까?") == true) {
                        window.location.href = "qa/qaSelect.do?id=" + qaId; // 페이지 이동
                    } else {
                        location.reload();
                    }
                }
            },
            error: function (xhr, status, error) {
                alert("반품 처리에 실패했습니다.");
            }
        });
    }

    function updateCount() {
        $.ajax({
            url: 'count.do', // 컨트롤러에서 갯수를 가져오는 URL
            type: 'GET',
            dataType: 'json',
            success: function (response) {
                console.log(response);
                if (response.quantityCount !== undefined) {
                    $('#quantity-notify').attr('data-notify', response.quantityCount);
                    if (response.quantityCount == 0) {
                        $('#quantity-notify').removeClass('admin-icon-header-item');
                    } else {
                        $('#quantity-notify').addClass('admin-icon-header-item');
                        $(".admin-icon-header-item").addClass('has-notifications');
                    }
                } else {
                    $('#quantity-notify').attr('data-notify', '0').removeClass('admin-icon-header-item');
                }

                if (response.paymentCount !== undefined) {
                    $('#payment-notify').attr('data-notify', response.paymentCount);
                    if (response.paymentCount == 0) {
                        $('#payment-notify').removeClass('admin-icon-header-item');
                    } else {
                        $('#payment-notify').addClass('admin-icon-header-item');
                        $(".admin-icon-header-item").addClass('has-notifications');
                    }
                } else {
                    $('#payment-notify').attr('data-notify', '0').removeClass('admin-icon-header-item');
                }

                if (response.retrunCount !== undefined) {
                    $('#retrun-notify').attr('data-notify', response.retrunCount);
                    if (response.retrunCount == 0) {
                        $('#retrun-notify').removeClass('admin-icon-header-item');
                    } else {
                        $('#retrun-notify').addClass('admin-icon-header-item');
                        $(".admin-icon-header-item").addClass('has-notifications');
                    }
                } else {
                    $('#retrun-notify').attr('data-notify', '0').removeClass('admin-icon-header-item');
                }

                if (response.qaCount !== undefined) {
                    $('#qa-notify').attr('data-notify', response.qaCount);
                    if (response.qaCount == 0) {
                        $('#qa-notify').removeClass('admin-icon-header-item');
                    } else {
                        $('#qa-notify').addClass('admin-icon-header-item');
                        $(".admin-icon-header-item").addClass('has-notifications');
                    }
                } else {
                    $('#qa-notify').attr('data-notify', '0').removeClass('admin-icon-header-item');
                }
            },
            error: function (xhr, status, error) {
                console.error('count 가져오는 데 실패했습니다.', error);
                $('#quantity-notify').attr('data-notify', '0').removeClass('admin-icon-header-item'); // 오류 발생 시 0으로 설정
                $('#payment-notify').attr('data-notify', '0').removeClass('admin-icon-header-item'); // 오류 발생 시 0으로 설정
                $('#retrun-notify').attr('data-notify', '0').removeClass('admin-icon-header-item'); // 오류 발생 시 0으로 설정
                $('#qa-notify').attr('data-notify', '0').removeClass('admin-icon-header-item'); // 오류 발생 시 0으로 설정
            }
        });
    }


    $(document).ready(function () {

        updateCount();

    });
</script>

</script>
</html>