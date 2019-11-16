<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>

  <!--Google Fonts-->
  <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
  
  <!--Simple Cale Calender CSS-->
  <link rel="stylesheet" href="/css/simple-calendar.css">
  
  <!--Simple Calender Js-->
  <script src="/js/jquery.simple-calendar.js"></script>

  <style>
    #stopAndAdd {
      text-align: right;
    }
   
    #dayLessonAdd {
      display: inline-block;
    }
    
    #dayLessonStop {
      display: inline-block;
    }
    
    #myBtnDetail {
      text-align: right;
    }
    
    .modal-title {
      font-weight: bold;
    }
  </style>
  
</head>

<div class="page-header header-filter" data-parallax="true"
  style="background-image: url('assets/img/bg3.jpg')">
  <div class="container">
    <div class="row">
      <div class="col-md-8 ml-auto mr-auto">
        <div class="brand text-center">
          <h1>과외 진행현황</h1>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="main main-raised">
  <div class="container p-3">
    <!-- <div id="container" class="calendar-container p-5"></div>
    <hr> -->
    
    <div class="row">
      <div class="col">
        <div class="progress-container progress-primary">
          <span class="progress-badge">남은 일수</span>
          <div class="progress">
            <div class="progress-bar progress-bar-primary"
              role="progressbar" aria-valuenow="30" aria-valuemin="0"
              aria-valuemax="100" style="width: 30%;"></div>
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col">
        <div>
          <a href="../lesson/list?memberTypeNo=${loginUser.memberTypeNo}"
            class="btn btn-primary" id="lessonList">수업목록</a>
        </div>
      </div>
      <div class="col" id="stopAndAdd">
        <c:if test="${loginUser.memberTypeNo == 3}">
          <div id="dayLessonAdd">
            <button type="button" class="btn btn-primary"
              data-toggle="modal" data-target="#Modal"
              onclick="resetModal()">추가</button>
          </div>
        </c:if>
        <div id="dayLessonStop">
          <a href="stop_lesson_form?lessonNo=${lessonNo}&memberTypeNo=${loginUser.memberTypeNo}"
          class="btn btn-danger" id="requestLessonInterrupt">수업중단</a>
        </div>
      </div>
    </div>

    <!-- 일별 과외 진행현황 리스트 -->
    <div class="dayLessonList">
    
    </div>
    
  </div>
</div>


<!-- Modal -->
  <div class="modal fade" id="Modal" tabindex="-1"
  role="dialog" aria-labelledby="detailModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="detailModalLabel">일별 과외 진행현황</h5>
        <button type="button" class="close"
          data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <input name="dayLessonNo" type="hidden" id="modalDayLessonNo" value="">
      <form name="dayLessonInsertForm">
        <input name="lessonNo" type="hidden" id="modalLessonNo" value="${lessonNo}">
        <div class="row">
           <div class="col">
        <label for="modalLessonDate">수업일</label>
            <div class="form-group has-default bmd-form-group pt-0">
              <input name="lessonDate" id="modalLessonDate" type="date" class="form-control" placeholder="Regular" value="">
            </div>
        </div>
        </div>
        <div class="row">
          <div class="col">
            <label for="modalLessonStartHour">수업시작시간</label>
            <div class="form-group has-default bmd-form-group pt-0">
              <input name="lessonStartHour" id="modalLessonStartHour" type="time" class="form-control" placeholder="Regular" value="">
            </div>
          </div>
          <div class="col">
            <label for="modalLessonEndHour">수업종료시간</label>
            <div class="form-group has-default bmd-form-group pt-0">
              <input name="lessonEndHour" id="modalLessonEndHour" type="time" class="form-control" placeholder="Regular" value="">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <label for="lessonSummary">수업 내용 정리</label>
            <textarea id="modalLessonSummary" class="form-control"
            name="lessonSummary" rows="10" style="resize: none;"></textarea>
          </div>
        </div>
        <div class="row">
          <div class="col">
            <label for="lessonEvaluation">수업 평가</label>
            <textarea id="modalLessonEvaluation" class="form-control"
            name="lessonEvaluation" rows="5" style="resize: none;"></textarea>
          </div>
        </div>
      </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <c:if test="${loginUser.memberTypeNo == 3}">
          <button type="button" id="btnUpdate" class="btn btn-primary" data-dismiss="modal" onclick="dayLessonUpdate()">저장</button>
          <button type="button" id="btnAdd" class="btn btn-primary" name="dayLessonInsertBtn">추가</button>
          <button type="button" id="btnDelete" class="btn btn-primary" name="dayLessonDeleteBtn" onclick="dayLessonDelete()">삭제</button>
        </c:if>
      </div>
    </div>
  </div>
</div>

<script src="/js/jquery.simple-calendar.js"></script>

<script>
/*  $(document).ready(function(){
	  
	$("#container").simpleCalendar();

	});

  $("#container").simpleCalendar({
      months: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
      days: ['일','월','화','수','목','금','토']
  });
 */
</script>

<script>
	
  var lessonNo = '${lessonNo}';
  
  // 일별 과외 진행현황 등록 버튼 클릭시 
  $('[name=dayLessonInsertBtn]').click(function() {
    var modalLessonDate = document.querySelector('#modalLessonDate');
    var modalLessonStartHour = document.querySelector('#modalLessonStartHour');
    var modalLessonEndHour = document.querySelector('#modalLessonEndHour');
    var modalLessonSummary = document.querySelector('#modalLessonSummary');
    var modalLessonEvaluation = document.querySelector('#modalLessonEvaluation');
    
    if (modalLessonDate.value.length > 0 &&
    		modalLessonStartHour.value.length > 0 &&
    		modalLessonEndHour.value.length > 0 &&
    		modalLessonSummary.value.length > 0 &&
    		modalLessonEvaluation.value.length > 0) {
      var insertData = $('[name=dayLessonInsertForm]').serialize();
      dayLessonInsert(insertData);
    } else {
      swal("모두 입력하세요.");
    }
  });
  
  // 일별 과외 진행현황 리스트
	function dayLessonList() { 
    $.ajax({
        url : 'dayLesson/list',
        type : 'get',
        data : {
          'lessonNo' : lessonNo
        },
        success : function(data) {
          var a = '';
  
          var tempdayLessonNo = '';
          var tempSummary = '';
          var tempEvaluation = '';
  
          var thisNode = '';
          
          $.each(
                  data,
                  function(key, value) {
                    a='';
                  	a += '<div class="card">';
                  	a += '<div class="card-body">';
                  	a += "<input type='hidden' id='dayLessonNo_" + value.dayLessonNo + "' value='" + value.dayLessonNo + "'>";
                  	a += '<div class="row">';
              			a += '수업일 : <div class="col" id="lessonDate_' + value.dayLessonNo + '">' + value.lessonDate + '</div>';
              			a += '수업시작시간 : <div class="col" id="lessonStartHour_' + value.dayLessonNo + '">' + value.lessonStartHour + '</div>';
              			a += '수업종료시간 : <div class="col" id="lessonEndHour_' + value.dayLessonNo + '">' + value.lessonEndHour + '</div>';
              			a += '</div>';
            				a += '<hr>';
          					a += '<div class="row">';
        						a += '<div class="col" id="lessonSummary_' + value.dayLessonNo + '"></div>';
        						a += "<input type='hidden' id='lessonEvaluation_" + value.dayLessonNo + "' value=''>";
        						a += '</div>';
      							a += '<div class="row" id="myBtnDetail">';
    								a += '<div class="col">';
  									a += '<button type="button" class="btn btn-primary btn-sm .modal-param" data-toggle="modal" data-target="#Modal" data-unique="' + value.dayLessonNo + '"' +  'onclick="setModal(' + value.dayLessonNo + ')">상세보기 </button>';
  									a += '</div>';
  									a += '</div>';
  									a += '</div>';
                    a += '</div>';
  
                    $(".dayLessonList").append(a);
  
                    thisNode = document.getElementById('dayLessonNo_'+value.dayLessonNo);
                    thisNode.setAttribute('value', value.dayLessonNo);
                    thisNode = document.getElementById('lessonSummary_'+value.dayLessonNo);
                    thisNode.innerHTML = value.lessonSummary;
                    thisNode = document.getElementById('lessonEvaluation_'+value.dayLessonNo);
                    thisNode.setAttribute('value', value.lessonEvaluation);
  
                  });
  
        }
    });
  }
  
  // 일별 과외 진행현황 추가
    function dayLessonInsert(insertData) {
  	$.ajax({
			url : 'dayLesson/add',
			type : 'post',
			data : insertData,
			success : function(data) {
				if (data == 1) {
/* 					$('#Modal').modal('hide');
					dayLessonList(); */
					location.href = "list?lessonNo=" + lessonNo;
				}
			}
		});
	}

	// 일별 과외 진행현황 수정
	function dayLessonUpdate() {
		var dayLessonNo = $("#modalDayLessonNo").val();
		var updateLessonDate = $("#modalLessonDate").val();
		var updateLessonStartHour = $("#modalLessonStartHour").val();
		var updateLessonEndHour = $("#modalLessonEndHour").val();
		var updateLessonSummary = $("#modalLessonSummary").val();
		var updateLessonEvaluation = $("#modalLessonEvaluation").val();

		$.ajax({
			url : 'dayLesson/update',
			type : 'post',
			data : {
				'dayLessonNo' : dayLessonNo,
				'lessonDate' : updateLessonDate,
				'lessonStartHour' : updateLessonStartHour,
				'lessonEndHour' : updateLessonEndHour,
				'lessonSummary' : updateLessonSummary,
				'lessonEvaluation' : updateLessonEvaluation
			},
			success : function(data) {
				if (data == 1)
					/* dayLessonList(lessonNo); */
					location.href = "list?lessonNo=" + lessonNo;
			}
		});
	}
	
	// 일별 과외 진행현황 삭제
    function dayLessonDelete() {
    	var dayLessonNo = $("#modalDayLessonNo").val();
      $.ajax({
        url : 'dayLesson/delete/' + dayLessonNo,
        type : 'post',
        data : {
    			'dayLessonNo' : dayLessonNo,
    		},
        success : function(data) {
          if (data == 1)
        	  location.href = "list?lessonNo=" + lessonNo;
        }
      });
    }

	$(document).ready(function() {
		dayLessonList();
	});
</script>

<script>
	function resetModal() {
		if (${loginUser.memberTypeNo == 3}) {
  		var updateButton = document.querySelector('#btnUpdate');
  		updateButton.style.display = 'none';
  		var addButton = document.querySelector('#btnAdd');
  		addButton.style.display = 'inline';
  		var addButton = document.querySelector('#btnDelete');
  		addButton.style.display = 'none';
    }
		
    $("#modalDayLessonNo").val('');
    $("#modalLessonDate").val('');
    $("#modalLessonStartHour").val('');
    $("#modalLessonEndHour").val('');
    $("#modalLessonSummary").val('');
    $("#modalLessonEvaluation").val('');
  }
  
	function setModal(key) {
		if (${loginUser.memberTypeNo == 3}) {
  		var addButton = document.querySelector('#btnAdd');
  		addButton.style.display = 'none';
  		var updateButton = document.querySelector('#btnUpdate');
  		updateButton.style.display = 'inline';
  		var addButton = document.querySelector('#btnDelete');
  		addButton.style.display = 'inline';
		} else {
			var sdt = document.querySelector('#modalLessonDate');
			sdt.readOnly = true;
			var sh = document.querySelector('#modalLessonStartHour');
			sh.readOnly = true;
      var eh = document.querySelector('#modalLessonEndHour');
      eh.readOnly = true;
      var summary = document.querySelector('#modalLessonSummary');
      summary.readOnly = true;
      var ev = document.querySelector('#modalLessonEvaluation');
      ev.readOnly = true;
    }
		
	  var daylessonNo = $("#dayLessonNo_" + key).val();
	  $("#modalDayLessonNo").val(daylessonNo);
	    
	  var lessonDate = $("#lessonDate_" + key).text();
	  $("#modalLessonDate").val(lessonDate);
	    
    var lessonStartHour = $("#lessonStartHour_" + key).text();
    $("#modalLessonStartHour").val(lessonStartHour);
    
    var lessonEndHour = $("#lessonEndHour_" + key).text();
    $("#modalLessonEndHour").val(lessonEndHour);
    
    var lessonSummary = $("#lessonSummary_" + key).text();
    $("#modalLessonSummary").val(lessonSummary);
    
    var lessonEvaluation = $("#lessonEvaluation_" + key).val();
    $("#modalLessonEvaluation").val(lessonEvaluation);
  }
</script>

