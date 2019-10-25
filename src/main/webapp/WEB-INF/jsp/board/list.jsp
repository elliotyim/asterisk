<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>게시물 목록</title>
  <link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css' integrity='sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T' crossorigin='anonymous'>
  <link rel='stylesheet' href='/css/common.css'>
</head>
<body>

<jsp:include page="../header.jsp"/>

<div id='content'>
<h1>게시판</h1>
<hr>

<table class='table table-hover'>
  <tr>
    <th>번호</th>
    <th>제목</th>
    <th>작성자</th>
    <th>작성일</th>
    <th>조회수</th>
  </tr>
      <c:forEach items="${boards}" var="board">
        <tr>
          <td>${board.boardNo}</td>
          <td><a href='detail?no=${board.boardNo}'>${board.title}</a></td>
          <td>${board.memberName}</td>
          <td>${board.createdDate}</td>
          <td>${board.viewCount}</td>
        </tr>
      </c:forEach>
</table>

<c:if test="${sessionScope.memberNo != null}">
  <button onclick="location='form'">글쓰기</button>
</c:if>

</div>

<jsp:include page="../footer.jsp"/>

</body></html>

