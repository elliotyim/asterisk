package com.ast.eom.dao;

import java.util.List;
import java.util.Map;

import com.ast.eom.domain.DayLesson;
import com.ast.eom.domain.Lesson;

public interface LessonDao {
  List<Lesson> findAllTeacherBy(int memberNo) throws Exception;
  List<Lesson> findAllStudentBy(int memberNo) throws Exception;
  Lesson findBy(int no) throws Exception;
  int insert(Lesson lesson) throws Exception;
  int updateContentsAndDays(Lesson lesson) throws Exception;
  int updateDateAndTime(Lesson lesson) throws Exception;
  int deleteContentsAndDays(int currLessonNo) throws Exception;
  int delete(int no) throws Exception;
  int deleteCurrAndContsAndLesson(int lessonNo) throws Exception;
  
  Lesson findCurrBy(int lessonNo) throws Exception;

  int addContentsAndDays(Lesson lesson) throws Exception;
  int addLesson(Lesson lesson) throws Exception;
  int addCurriculum(Lesson lesson) throws Exception;
  int findSubNo(Map<String, Object> param) throws Exception;
  
  // 일별 수업 카운트 증가
  int increaseLessonDayCount(int lessonNo) throws Exception;
  
  // 일별 수업 카운트 감소
  int decreaseLessonDayCount(int lessonNo) throws Exception;
  
  // 중단 요청
  int updateInterruptionState(Map<String, Object> params) throws Exception;
  
  // 수업 상태 수정
  int updateLessonState(Map<String, Object> params) throws Exception;

  // 수업 상태 수정 (결제 페이지용)
  int updateLessonStateAndPaymentState(Map<String, Object> params) throws Exception;
  
  // 후기 작성
  int insertReview(Map<String, Object> params) throws Exception;
  
  // 일별 과외 탐색 (결제 페이지용)
  List<DayLesson> getDayLessons(int lessonNo) throws Exception;
}
