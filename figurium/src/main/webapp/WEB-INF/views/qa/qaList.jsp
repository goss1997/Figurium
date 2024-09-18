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
            <c:forEach var="qa" items="${qaList}" varStatus="status" >
                <tr onclick="location.href='${pageContext.request.contextPath}/qa/qaSelect.do?id=${qa.id}'" style="cursor: pointer;">
                    <td>${status.index+1}</td>
                    <td class="truncate-title" style="text-align: left;">
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
        <div style="margin-top: 30px !important;">
            ${pageMenu}
        </div>

    </div>
</div>
<!-- NOTE : 푸터바 -->
<jsp:include page="../common/footer.jsp"/>
</body>
</html>