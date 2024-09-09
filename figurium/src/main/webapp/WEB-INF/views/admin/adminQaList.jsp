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
  <title>Title</title>
  <!-- TODO : 제목 과 스타일 영역 -->
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
</head>

<body>
<div id="content-wrap-area">
  <!-- TODO : 컨텐츠 영역(당신이 사용할 공간) -->


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
          <td>${fn:substring(qa.created,0,10)} ${fn:substring(qa.created,11,16)}</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
    <hr>
    <button type="button" style="margin-top: 16px !important;" class="btn btn-dark float-right" onclick="qaInsert()">글쓰기</button>


    <!-- 페이징 메뉴 -->
    <div style="margin-top: 30px !important;">
      ${pageMenu}
    </div>

  </div>


</div>
</body>

</html>