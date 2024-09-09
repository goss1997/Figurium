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
                <a class="nav-link" href="#">사용자 결제 & 반품 승인</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="changeStatus" href="#">배송상태 변경</a>
            </li>
            <li class="nav-item">
                <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart"
                     id="qa-notify"
                     data-notify="0">
                    <a class="nav-link" style="font-size: 16px; vertical-align: middle !important; margin-top: 3px;" id="viewQaList" href="#">Q&A 미답변</a>
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


    function adminRefund() {
        $.ajax({
            url: 'adminRefund.do',
            type: 'GET',
            success: function (response) {

                $('#admin-view').html(response);
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

</html>
