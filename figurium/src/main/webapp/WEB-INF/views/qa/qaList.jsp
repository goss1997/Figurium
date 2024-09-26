<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>



<%--
  Created by IntelliJ IDEA.
  User: mac
  Date: 8/26/24
  Time: 5:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 리스트</title>
    <link rel="icon" type="image/png" href="/images/FiguriumHand.png"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>

    <style>
        /* 제목 셀의 스타일을 정의 */
        .truncate-title {
            display: block;
            max-width: 400px; /* 적절한 너비로 조정 */
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .truncate-title a {
            max-width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        /* 테이블 스타일 */
        .responsive-table {
            width: 100%; /* 테이블을 100% 너비로 설정 */
            table-layout: fixed; /* 셀의 너비를 자동으로 조정 */
        }

        .responsive-table th, .responsive-table td {
            padding: 8px; /* 패딩 추가 */
            overflow: hidden; /* 내용이 넘칠 경우 숨김 처리 */
            text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 부호 추가 */
            white-space: nowrap; /* 줄바꿈 방지 */
        }

        /* 모바일 화면 */
        @media (max-width: 576px) {
            .truncate-title {
                max-width: 200px; /* 모바일에서는 제목 너비를 줄임 */
                font-size: 14px; /* 폰트 크기 조정 */
            }

            h1 {
                font-size: 18px; /* 제목 크기 조정 */
            }

            .responsive-table th, .responsive-table td {
                font-size: 12px; /* 테이블 폰트 크기 조정 */
            }

            .btn {
                width: auto; /* 버튼 너비를 자동으로 조정 */
                margin-top: 10px; /* 마진 추가 */
                padding: 5px 10px; /* 패딩 조정 */
            }

            .paging {
                font-size: 12px; /* 페이징 아이콘 크기 조정 */
            }
        }

        /* 태블릿 화면 */
        @media (min-width: 577px) and (max-width: 768px) {
            .truncate-title {
                max-width: 300px; /* 태블릿에서는 제목 너비 조정 */
                font-size: 16px; /* 폰트 크기 조정 */
            }

            h1 {
                font-size: 22px; /* 제목 크기 조정 */
            }

            .responsive-table th, .responsive-table td {
                font-size: 14px; /* 테이블 폰트 크기 조정 */
            }

            .btn {
                padding: 6px 10px; /* 태블릿에서 패딩 조정 */
            }

            .paging {
                font-size: 13px; /* 태블릿에서 폰트 크기 조정 */
            }
        }

        /* 컴퓨터 화면 */
        @media (min-width: 769px) {
            .truncate-title {
                max-width: 400px; /* 컴퓨터에서는 제목 너비 기본값 */
                font-size: 18px; /* 폰트 크기 조정 */
            }

            h1 {
                font-size: 26px; /* 제목 크기 조정 */
            }

            .responsive-table th, .responsive-table td {
                font-size: 16px; /* 테이블 폰트 크기 조정 */
            }
            .btn {
                padding: 8px 12px; /* PC에서 패딩 조정 */
            }

            .paging {
                font-size: 14px; /* PC에서 폰트 크기 조정 */
            }
        }


    </style>

    <script type="text/javascript">
        // JSP에서 로그인 상태를 JavaScript 변수로 전달
        const isUserLoggedIn = "${sessionScope.loginUser != null ? 'true' : 'false'}";

        function qaInsert(f) {
            if (isUserLoggedIn === 'false') {
                alert("글쓰기는 로그인 후 가능합니다.");
                return;
            } else {
                // 게시글 작성 폼으로 이동
                f.method = "POST";
                f.action = "/qa/qaInsert.do";
                f.submit();
            }
        }
    </script>
    <% if (request.getAttribute("message") != null) { %>
    <script>alert("<%= request.getAttribute("message") %>");</script>
    <% } %>

    <% if (request.getAttribute("alertMessage") != null) { %>
    <script>
        alert("<%= request.getAttribute("alertMessage") %>");
        location.href = "/qa/qaList.do"; // 알림 후 리스트 페이지로 리디렉트
    </script>
    <% } %>

</head>

<body>
<jsp:include page="../common/header.jsp"/>
<div style="height: 90px"></div>


<div id="content-wrap-area">
    <div class="container pt-3">
        <h1 class="qalist-title" style="margin-bottom: 15px">Q&A 게시판</h1>
        <hr>
        <table class="responsive-table table table-hover">
            <thead class="thead-light">
            <tr style="text-align: center; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                <th style="width: 100px;">번호</th>
                <th style="width: 400px; white-space: nowrap; text-align: left; overflow: hidden; text-overflow: ellipsis;">제목</th>
                <th style="width: 150px;">답변여부</th>
                <th style="width: 230px;">작성자</th>
                <th style="width: 232px;">작성일</th>
            </tr>
            </thead>
            <tbody style="text-align: center;">
            <c:forEach var="qa" items="${qaList}" varStatus="status" >
                <tr onclick="location.href='${pageContext.request.contextPath}/qa/qaSelect.do?id=${qa.id}'" style="cursor: pointer;">
                    <td>${status.index+1}</td>
                    <td class="truncate-title" style="text-align: left; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                        <span style="font-size: 18px; vertical-align: -3px;" class="material-symbols-outlined">lock</span>
                        ${qa.title}
                    </td>
                    <td>${qa.replyStatus}</td>
                    <td>${qa.name}</td>
                    <td>${fun:substring(qa.created,0,10)} ${fun:substring(qa.created,11,16)}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <hr>
        <%--POST 로 보내기위한 더미 input 생성 후 진행--%>
        <form>
            <input type="hidden" name="dummy" value="dummy">
        <button type="button" style="margin-top: 16px !important;" class="btn btn-dark float-right" onclick="qaInsert(this.form);">글쓰기</button>
        </form>

        <!-- 페이징 메뉴 -->
        <div class="paging" style="margin-top: 30px !important;">
            ${pageMenu}
        </div>

    </div>
</div>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
</html>