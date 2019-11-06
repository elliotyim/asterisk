package com.ast.eom.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ast.eom.domain.MemberTeacherStudent;
import com.ast.eom.service.MemberTeacherStudentService;

@Controller
@RequestMapping("/member")
public class MemberTeacherStudentController {
  
  @Autowired private MemberTeacherStudentService memberTeacherStudentService;
  
  @GetMapping("list")
  public void list(Model model, int memberTypeNo) throws Exception {
    
    /*
     * HttpSession session = request.getSession();
     * 
     * // 전체리스트 개수 int listCnt = boardServiceImpl.selectBoardListCnt(boardVO);
     * 
     * Pagination pagination = new Pagination(listCnt, curPage);
     * 
     * boardVO.setStartIndex(pagination.getStartIndex());
     * boardVO.setCntPerPage(pagination.getPageSize()); // 전체리스트 출력 List<BoardVO> list =
     * boardServiceImpl.selectBoardList(boardVO);
     */
    
    List<MemberTeacherStudent> memberTeacher = memberTeacherStudentService.listTeacher(memberTypeNo);
    List<MemberTeacherStudent> memberTeacher2 = memberTeacherStudentService.listTeacher2();
    List<MemberTeacherStudent> memberStudents = memberTeacherStudentService.listStudent(memberTypeNo);
    for (MemberTeacherStudent memberTeacherStudent : memberTeacher) {
      System.out.println(memberTeacherStudent);
    }
    for (MemberTeacherStudent memberTeacherStudent2 : memberTeacher2) {
      System.out.println(memberTeacherStudent2);
    }
    model.addAttribute("memberTeacher", memberTeacher);
    model.addAttribute("memberTeacher2", memberTeacher2);
    model.addAttribute("memberStudents", memberStudents);
    model.addAttribute("memberTypeNo", memberTypeNo);
  }
  
  @GetMapping("detail")
  public void detail(Model model, @RequestParam("no") int no) throws Exception {
    List<MemberTeacherStudent> detailTeacher1 = memberTeacherStudentService.detailTeacher(no);
    for (MemberTeacherStudent d: detailTeacher1)
      System.out.println("tttttttttt>>>>>>>"+d);
    model.addAttribute("detailTeacher1", detailTeacher1);
  }
  
  @GetMapping("ohora")
  @ResponseBody
  public Object ohora(int boardNo) {
    MemberTeacherStudent temp = new MemberTeacherStudent();
    temp.setName("홍길동");
    return temp;
  }
}
