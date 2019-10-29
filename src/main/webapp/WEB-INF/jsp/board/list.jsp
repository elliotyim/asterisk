<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>게시물 목록</title>
<link rel='stylesheet'
  href='/node_modules/bootstrap/dist/css/bootstrap.min.css'>
<link rel='stylesheet' href='/css/common.css'>
</head>
<body>

  <jsp:include page="../header.jsp" />

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
      <c:forEach items="${boards}" var="board"
        begin="${pagination.pageSize * (pagination.curPage - 1)}"
        end="${pagination.pageSize * pagination.curPage - 1}">
        <tr>
          <td>${board.boardNo}</td>
          <td><a href='detail?no=${board.boardNo}'>${board.title}</a></td>
          <td>${board.memberName}</td>
          <td>${board.createdDate}</td>
          <td>${board.viewCount}</td>
        </tr>
      </c:forEach>
    </table>

    <div align="right">
      <c:if test="${sessionScope.memberNo != null}">
        <button class="btn btn-primary" onclick="location='form'">글쓰기</button>
      </c:if>
    </div>

    <nav aria-label="Page navigation example">
      <ul class="pagination justify-content-center">
        <c:if test="${pagination.curPage ne 1}">
          <li class="page-item"><a class="page-link"
            href="list?boardTypeNo=${boardTypeNo}&amp;curPage=${pagination.prevPage}">&laquo;</a>
          </li>
        </c:if>

        <c:forEach var="pageNum" begin="${pagination.startPage }"
          end="${pagination.endPage }">
          <c:choose>
            <c:when test="${pageNum eq  pagination.curPage}">
              <li class="page-item active" aria-current="page"><a
                class="page-link"
                href='list?boardTypeNo=${boardTypeNo}&amp;curPage=${pageNum}'>${pageNum }</a></li>
            </c:when>
            <c:otherwise>
              <li class="page-item"><a class="page-link"
                href="list?boardTypeNo=${boardTypeNo}&amp;curPage=${pageNum}">${pageNum }</a></li>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if
          test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
          <li class="page-item"><a class="page-link"
            href="list?boardTypeNo=${boardTypeNo}&amp;curPage=${pagination.nextPage}">
              &raquo;</a></li>
        </c:if>
      </ul>
    </nav>
    
    <div class="form-group row justify-content-center">
      <div class="w100" style="padding-right:10px">
        <select class="form-control form-control-sm" name="searchType" id="searchType">
          <option value="title">제목</option>
          <option value="Content">내용</option>
          <option value="reg_id">작성자</option>
        </select>
      </div>
      <div class="w300" style="padding-right:10px">
        <input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
      </div>
      <div>
        <button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch">검색</button>
      </div>
    </div>


  </div>

  <script src="/node_modules/jquery/dist/jquery.min.js"></script>
  <script src="/node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
  <script src="/node_modules/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

  <script>
    $
  </script>
  
  
  <jsp:include page="../footer.jsp" />

</body>
</html>

