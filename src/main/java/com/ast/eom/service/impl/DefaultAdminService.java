package com.ast.eom.service.impl;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ast.eom.dao.AdminDao;
import com.ast.eom.dao.MypageDao;
import com.ast.eom.domain.Member;
import com.ast.eom.domain.Parents;
import com.ast.eom.domain.Student;
import com.ast.eom.service.AdminService;

@Service
public class DefaultAdminService implements AdminService {
  
  @Autowired
  AdminDao adminDao;
  @Autowired
  MypageDao mypageDao;
  
  HttpSession session;
  
  public DefaultAdminService(HttpSession session) {
    this.session = session;
  }
  
  private void prepareBasicMemberInfoMapOf(
      int memberTypeNo, Map<String, Object> memberInfoMapForAdmin) throws Exception {
    
    List<Member> memberList = adminDao.getBasicMemberInfo(memberTypeNo);
    List<Integer> memberAge = new ArrayList<>();
    
    int thisYear, memberYear, age;
    String todayStr;
    
    for (Member member : memberList) {
      todayStr = String.valueOf(new Date(System.currentTimeMillis()));
      thisYear = Integer.parseInt(todayStr.substring(0,4));
      
      memberYear = Integer.parseInt(
          String.valueOf(member.getDateOfBirth()).substring(0,4));
      
      age = thisYear - memberYear + 1;
      memberAge.add(age);
    }
    
    memberInfoMapForAdmin.put("memberList", memberList);
    memberInfoMapForAdmin.put("memberAge", memberAge);
    
  }
  
  @Override
  public Object loadMemberInfoMapOf(int memberTypeNo) throws Exception {
    
    Map<String, Object> memberInfoMapForAdmin = new HashMap<>();
    
    if (memberTypeNo == 1) {
      prepareBasicMemberInfoMapOf(memberTypeNo, memberInfoMapForAdmin);
      return memberInfoMapForAdmin;
      
    } else if (memberTypeNo == 2) {
      prepareBasicMemberInfoMapOf(memberTypeNo, memberInfoMapForAdmin);
      return memberInfoMapForAdmin;
      
    } else if (memberTypeNo == 3) {
      prepareBasicMemberInfoMapOf(memberTypeNo, memberInfoMapForAdmin);
      return memberInfoMapForAdmin;
      
    } else if (memberTypeNo == 99) {
      return memberInfoMapForAdmin;
      
    } else {
      throw new Exception("잘못된 방식의 요청입니다!");
      
    }
    
  }
  
  @Override
  public Map<String, Object> getInfoMap(
      int memberNo,
      int memberTypeNo) throws Exception {
    
    Member thisMember = adminDao.getMember(memberNo);
    thisMember.setMemberTypeNo(thisMember.getMemberType().getMemberTypeNo());
    session.setAttribute("thisMember", thisMember);

    String[] memberEmail = thisMember.getEmail().split("@");
    session.setAttribute("memberEmail", memberEmail);
    
    Map<String, Object> memberInfoMapForDetail = new HashMap<>();
    
    if (memberTypeNo == 1) {
      memberInfoMapForDetail.put("student", mypageDao.getStudent(memberNo));
      memberInfoMapForDetail.put("wantedLessons", mypageDao.getWantedLessons(memberNo));
      memberInfoMapForDetail.put("studentLessons", mypageDao.getLessonsForStudent(memberNo));
      
    } else if (memberTypeNo == 2) {
      Parents parents = mypageDao.getParents(memberNo);
      List<Student> children = parents.getStudents();
      List<Integer> childrenNo = new ArrayList<>();
      for (Student child : children) {
        childrenNo.add(child.getStudentNo());
      }
      
      List<Member> member = mypageDao.getChildrenIdAndName(childrenNo);
      if (member.size() > 0) {
        for (int i = 0; i < children.size(); i++) {
          children.get(i).setId(member.get(i).getId());
          children.get(i).setName(member.get(i).getName());
        }
        parents.setStudents(children);
      }
      
      memberInfoMapForDetail.put("parents", parents);
      
    } else if (memberTypeNo == 3) {
      memberInfoMapForDetail.put("teacher", mypageDao.getTeacher(memberNo));
      memberInfoMapForDetail.put("teacherLessons", mypageDao.getLessonsForTeacher(memberNo));
      memberInfoMapForDetail.put("lessonSubjects", mypageDao.getLessonSubjects(memberNo));
      memberInfoMapForDetail.put("teacherPhotos", mypageDao.getTeacherPhotos(memberNo));
    }
    System.out.println(thisMember);
    for (Object m : memberInfoMapForDetail.keySet())
      System.out.println(memberInfoMapForDetail.get(m));
    return memberInfoMapForDetail;
  }
  
}