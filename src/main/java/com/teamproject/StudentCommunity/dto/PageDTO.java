package com.teamproject.StudentCommunity.dto;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageDTO {	

   private int showType;
   
   // 전체 게시글 개수
   private int totalCount;
   
   // 전체 페이지 개수
   private int pageCount;
   
   // 현재 페이지 번호
   private int currentPage;
   
   // 보여줄 페이지 당 게시물 수 
   private int pageListCnt;
   
   // 페이지 네비게이션 수, 페이지의 번호 개수
   private int paginationCnt;
   
   // 현재 페이지의 첫 번째 번호  
   private int min;
   
   // 현재 페이지의 마지막 번호
   private int max;
   
   // 다음 페이지 존재 여부
   private boolean hasNextPage;
   
   // 이전 페이지 존재 여부
   private boolean hasPreviousPage;
   
   // SQL 1~10 , 11~20 페이징을 위한 iv
   private int firstRecordIndex;
   
   private int lastRecordIndex;
   
   
   // 이전 버튼 누르면 이동하는 페이지 번호
   private int prePage;
   
   // 다음 버튼 누르면 이동하는 페이지 번호
   private int nextPage;

/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////   
//////////////////// 동적 쿼리에 필요한 필드 /////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////   
   // 날짜 검색에 필요한 필드									////////////
   private String date1;								////////////	
   private String date2;								////////////
   														////////////
   // 좋아요순, 신고횟수순, 작성날짜순							////////////
   private int likeRank;								////////////
   private int suspendRank;								////////////
   private int regDateRank;								////////////			
   // 정지회원 글 보기										////////////
   private int showSuspend;								////////////
   														////////////
   // 검색기능 사용 유무										////////////
   private String input;								////////////
   // 검색 키워드											////////////		
   private String select;

   // 대학교 id값
   private Long selectUniversity;
   private Long category;
   private String universityName;

   
   private String courseList;
   


   // 대댓글 여부
   private int reply;

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
   
   public PageDTO() {
	   
	   this.showType = 1;
	   this.pageListCnt = 10;
	   this.paginationCnt = 10;
	   this.currentPage = 1;
	}

    @Override
    public String toString() {
        return "PageDTO{" +
                "showType=" + showType +
                ", totalCount=" + totalCount +
                ", pageCount=" + pageCount +
                ", currentPage=" + currentPage +
                ", pageListCnt=" + pageListCnt +
                ", paginationCnt=" + paginationCnt +
                ", min=" + min +
                ", max=" + max +
                ", hasNextPage=" + hasNextPage +
                ", hasPreviousPage=" + hasPreviousPage +
                ", firstRecordIndex=" + firstRecordIndex +
                ", lastRecordIndex=" + lastRecordIndex +
                ", prePage=" + prePage +
                ", nextPage=" + nextPage +
                ", date1='" + date1 + '\'' +
                ", date2='" + date2 + '\'' +
                ", likeRank=" + likeRank +
                ", suspendRank=" + suspendRank +
                ", regDateRank=" + regDateRank +
                ", showSuspend=" + showSuspend +
                ", input='" + input + '\'' +
                ", select='" + select + '\'' +
                ", selectUniversity=" + selectUniversity +
                ", category=" + category +
                ", universityName='" + universityName + '\'' +
                '}';
    }
}








