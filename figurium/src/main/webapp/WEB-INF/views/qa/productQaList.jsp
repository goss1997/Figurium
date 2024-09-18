<%--
  Created by IntelliJ IDEA.
  User: mac
  Date: 9/10/24
  Time: 1:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품Q&A</title>
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
        }z
    </style>



</head>

<body>
<div id="content-wrap-area">
    <div class="container">
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
            <c:forEach var="qa" items="${productQaList}" varStatus="status">
                <tr onclick="location.href='${pageContext.request.contextPath}/qa/qaSelect.do?id=${qa.id}'" style="cursor: pointer;">
                    <td>${status.index + 1}</td>
                    <td class="truncate-title" style="text-align: left;">
                        <span style="font-size: 18px; vertical-align: -3px;" class="material-symbols-outlined">lock</span>
                            ${qa.title}
                    </td>
                    <td>${qa.replyStatus}</td>
                    <td>${qa.name}</td>
                    <td>${fun:substring(qa.created, 0, 10)} ${fun:substring(qa.created, 11, 16)}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <hr>


        <!-- 페이징 메뉴 -->
        <div style="margin-top: 30px !important;">
            ${pageMenu}
        </div>

    </div>
</div>
</body>
</html>
