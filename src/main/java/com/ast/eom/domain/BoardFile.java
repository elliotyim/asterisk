package com.ast.eom.domain;

public class BoardFile {

  private int fileNo;
  private String fileName;
  private int boardNo;
  
  @Override
  public String toString() {
    return "BoardFile [fileNo=" + fileNo + ", fileName=" + fileName + ", boardNo=" + boardNo
        + "]";
  }
  public int getFileNo() {
    return fileNo;
  }
  public void setFileNo(int fileNo) {
    this.fileNo = fileNo;
  }
  public String getFileName() {
    return fileName;
  }
  public void setFileName(String fileName) {
    this.fileName = fileName;
  }
  public int getBoardNo() {
    return boardNo;
  }
  public void setBoardNo(int boardNo) {
    this.boardNo = boardNo;
  }
}
