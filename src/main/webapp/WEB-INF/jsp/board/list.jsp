<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
  <style>
    .photo2 {
      height: 100px;
      margin: 2px;
    }
    
    .custom-select {
      height: calc(2.125rem + 2px);
      padding-top: 0.375rem;
      padding-bottom: 0.375rem;
      font-size: 75%;
      width: 120px;
    }
    
    .my-board {
    }
    
  </style>
</head>

<div id="background" class="page-header header-filter" data-parallax="true"> 
  <div class="container">
    <div class="row">
      <div class="col-md-8 ml-auto mr-auto">
        <div class="brand text-center"> 
          <c:if test="${boardTypeNo == 1}">
            <h1>공부상담</h1>
          </c:if>
          <c:if test="${boardTypeNo == 2}">
            <h1>입시상담</h1>
          </c:if>
          <c:if test="${boardTypeNo == 3}">
            <h1>문제풀이</h1>
          </c:if>
          <c:if test="${boardTypeNo == 4}">
            <h1>공지사항</h1>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="main main-raised">
  <div class="container p-3">
    <input type='hidden' name='boardTypeNo' value='${boardTypeNo}'>

    <div class="form-group row justify-content-center">
      <div class="w100" style="padding-right: 10px">
        <select class="form-control form-control-sm" name="searchType"
          id="searchType">
          <option value="titleContents">제목+내용</option>
          <option value="title">제목</option>
          <option value="writer">작성자</option>
        </select>
      </div>
      <div class="w300" style="padding-right: 10px">
        <input type="text" class="form-control form-control-sm"
          name="keyword" id="keyword" onKeypress="if(event.keyCode==13) {search();}" >
      </div>
      <div>
        <button class="btn btn-primary btn-round btn-sm"
          name="btnSearch" id="btnSearch">검색</button>
      </div>
    </div>
    
    <div class="btn-toolbar justify-content-between" role="toolbar">
      <div class="btn-group btn-group-sm" role="group">
        <c:if test="${loginUser.memberTypeNo != 4 and boardTypeNo != 4}">
          <a href="form?boardTypeNo=${boardTypeNo}"
            class="btn btn-primary">글쓰기</a>
        </c:if>
        <c:if test="${loginUser.memberTypeNo == 4}">
          <a href="form?boardTypeNo=${boardTypeNo}"
            class="btn btn-primary">관리자글쓰기</a>
        </c:if>
      </div>
      
       <div class="form-group">
        <select class="custom-select" id="pageSize">
          <option value="3">3개씩</option>
          <option value="8">8개씩</option>
          <option value="10">10개씩</option>
          <option value="20">20개씩</option>
        </select>
      </div>
      
    </div>

    <table class='table table-hover'>
      <thead>
        <tr>
          <th>번호</th>
          <th>제목</th>
          <th>작성자</th>
          <th>작성일</th>
          <th>조회수</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${boards}" var="board"
          begin="${pagination.pageSize * (pagination.curPage - 1)}"
          end="${pagination.pageSize * pagination.curPage - 1}">
          <tr class="my-board">
            <td>${board.boardNo}</td>
            <td><a href='detail?no=${board.boardNo}'>${board.title}</a></td>
            <td>${board.memberName}</td>
            <td>${board.createdDate}</td>
            <td>${board.viewCount}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <nav aria-label="Page navigation example">
      <ul class="pagination justify-content-center">
        <c:if test="${pagination.curPage ne 1}">
          <li class="page-item"><a class="page-link"
            href="list?boardTypeNo=${boardTypeNo}&pageSize=${pageSize}&amp;curPage=${pagination.prevPage}&searchType=${searchType}&keyword=${keyword}">&laquo;</a>
          </li>
        </c:if>

        <c:forEach var="pageNum" begin="${pagination.startPage }"
          end="${pagination.endPage }">
          <c:choose>
            <c:when test="${pageNum eq  pagination.curPage}">
              <li class="page-item active" aria-current="page"><a
                class="page-link"
                href="list?boardTypeNo=${boardTypeNo}&pageSize=${pageSize}&amp;curPage=${pageNum}&searchType=${searchType}&keyword=${keyword}">${pageNum}</a></li>
            </c:when>
            <c:otherwise>
              <li class="page-item"><a class="page-link"
                style="color: #000000;"
                href="list?boardTypeNo=${boardTypeNo}&pageSize=${pageSize}&amp;curPage=${pageNum}&searchType=${searchType}&keyword=${keyword}">${pageNum}</a></li>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:if
          test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
          <li class="page-item"><a class="page-link"
            href="list?boardTypeNo=${boardTypeNo}&pageSize=${pageSize}&amp;curPage=${pagination.nextPage}&searchType=${searchType}&keyword=${keyword}">&raquo;</a></li>
        </c:if>
      </ul>
    </nav>
    
  </div>
</div>

  <script>
    let boardTypeNo = $('input[name=boardTypeNo]').val();
    
    if (boardTypeNo == 4) {
      document.getElementById('background').style.backgroundImage= "url('/assets/img/bg/bg19.jpg')"
    } else { 
      document.getElementById('background').style.backgroundImage= "url('/assets/img/bg/bg10.jpg')" 
    } 
  </script>

  <script>
    $(document).on('click', '#btnSearch', function(e){
      e.preventDefault();
      search()
    })

    function search(){
    	var url = "list?boardTypeNo=" + ${boardTypeNo};
        url = url + "&pageSize=" + ${pageSize};
        url = url + "&curPage=1";
        url = url + "&searchType=" + $('#searchType').val();
        url = url + "&keyword=" + $('#keyword').val();
        location.href = url;
    }
  </script>
  
  <script>
    (function() {
  	  $('#pageSize').val('${pageSize}')
  	  $('#searchType').val('${searchType}')
  	  $('#keyword').val('${keyword}')
  	})();
  
  
  	$('#pageSize').change((e) => {
  	  location.href = "list?boardTypeNo=" + ${boardTypeNo} + "&pageSize=" + $(e.target).val()
  			  + "&curPage=1&searchType=" + $('#searchType').val() + "&keyword=" + $('#keyword').val();
  	});
  </script>
