package com.ast.eom.dao;

import java.util.List;
import java.util.Map;
import com.ast.eom.domain.Lesson;

public interface LessonDao {
  List<Lesson> findAllTeacherBy() throws Exception;
  List<Lesson> findAllStudentBy() throws Exception;
  Lesson findBy(int no) throws Exception;
  int insert(Lesson lesson) throws Exception;
  int updateContentsAndDays(Lesson lesson) throws Exception;
  int updateDateAndTime(Lesson lesson) throws Exception;
  int deleteContentsAndDays(int currLessonNo) throws Exception;
  int delete(int no) throws Exception;
  
  Lesson findCurrBy(int lessonNo) throws Exception;

  int addContentsAndDays(Lesson lesson) throws Exception;
  int addLesson(Lesson lesson) throws Exception;
  int addCurriculum(Lesson lesson) throws Exception;
  int findSubNo(Map<String, Object> param) throws Exception;
}
