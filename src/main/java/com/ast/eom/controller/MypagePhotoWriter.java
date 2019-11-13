package com.ast.eom.controller;

import java.io.File;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import com.ast.eom.dao.TeacherPhotoDao;
import com.ast.eom.domain.Member;
import com.ast.eom.domain.TeacherPhoto;

@Controller
public class MypagePhotoWriter {
  
  Member loginUser;

  @Autowired
  TeacherPhotoDao teacherPhotoDao;
  
  String profileUploadDir;
  String teacherPhotosUploadDir;
  
  
  public MypagePhotoWriter(ServletContext sc) {
    profileUploadDir = sc.getRealPath("/upload/join");
    teacherPhotosUploadDir = sc.getRealPath("/upload/teacher_photo");
  }
  
  private void uploadProfilePhoto(MultipartFile profilePhoto) throws Exception {
    // 프로필 사진 업로드 구현 완료
    if (!profilePhoto.isEmpty()) {
      String filename = UUID.randomUUID().toString();
      profilePhoto.transferTo(new File(profileUploadDir +"/"+ filename));
      
      loginUser.setProfilePhoto(filename);
    }
  }

  private void uploadTeacherPhotos(
      MultipartFile[] teacherPhotoFiles,
      String[] teacherPhotoNames,
      HttpSession session) throws Exception {
    
    if (teacherPhotoFiles == null)
      return;
    
    int teacherNo = loginUser.getMemberNo();
    teacherPhotoDao.eraseAllPhotosInAdvanceRelatedTo(teacherNo);
    
    for (int i = 0; i < teacherPhotoFiles.length; i++) {
      TeacherPhoto teacherPhoto = new TeacherPhoto();
      teacherPhoto.setTeacherNo(teacherNo);
      
      if (teacherPhotoFiles[i].isEmpty()) {
        teacherPhoto.setTeacherPhoto(teacherPhotoNames[i]);
        teacherPhotoDao.insert(teacherPhoto);
        continue;
      }
      
      String filename = UUID.randomUUID().toString();
      teacherPhotoFiles[i].transferTo(new File(teacherPhotosUploadDir + "/" + filename));
      
      teacherPhoto.setTeacherPhoto(filename);
      teacherPhotoDao.insert(teacherPhoto);
    }
    
  }

  public void upload(
      MultipartFile profilePhoto,
      MultipartFile[] teacherPhotoFiles,
      String[] teacherPhotoNames,
      Member loginUser, HttpSession session) throws Exception {
    
    this.loginUser = loginUser;
    
    uploadProfilePhoto(profilePhoto);
    uploadTeacherPhotos(teacherPhotoFiles, teacherPhotoNames,session);
  }

}
