package com.teamproject.StudentCommunity.PagingService;

import com.teamproject.StudentCommunity.dto.PageDTO;

public class PageCalculator {
	
	// 값 보정
	public PageCalculator(PageDTO pageDTO) {
		
		if(pageDTO.getCurrentPage() < 1) {
			pageDTO.setCurrentPage(1); // 현재 페이지
		}
		
//		if(pageDTO.getPageListCnt() < 1 || pageDTO.getPageListCnt() > 100) {
//			pageDTO.setPageListCnt(10); 
//		}
//		
//		if(pageDTO.getPaginationCnt() < 5 || pageDTO.getPaginationCnt() > 20) {
//			pageDTO.setPaginationCnt(10);	
//		}
	}
	
	public void calculation(PageDTO pageDTO) {
		
		//  (전체 게시글 수 - 1) / 한 페이지당 게시글수 + 1
		//  전체 게시글수가 페이지당 게시글수 보다 작으면 0
		//  전체 게시글수가 페이지당 게시글수랑 똑같을 경우엔(전체 게시글수 10으로 가정)
		//  (전체 게시글 수 -1) 이 붙었으므로 0 + 1
		//  나누기 성질을 이용했음.
		
		// **** 전체 페이지 수 ****
		pageDTO.setPageCount((pageDTO.getTotalCount() - 1) / pageDTO.getPageListCnt() + 1);
		if(pageDTO.getCurrentPage() > pageDTO.getPageCount()) {
			pageDTO.setCurrentPage(pageDTO.getPageCount());
		}
		
		
		
		// 페이지 리스트의 첫 번호
		// (현재 페이지 - 1 / 네비게이션 번호 ) * 네비게이션 번호 + 1
		// 현재 페이지가 11 (게시글 110)은 되어야 네비게이션 번호가 11로 늘어나서 Min의 값이 1에서 11로 넘어간다.
		pageDTO.setMin(((pageDTO.getCurrentPage() - 1) / pageDTO.getPaginationCnt()) * pageDTO.getPaginationCnt() + 1);
		
		// 페이지 리스트(네비게이션 버튼)의 마지막 번호
		pageDTO.setMax(pageDTO.getMin() + pageDTO.getPaginationCnt() - 1);
		if (pageDTO.getMax() > pageDTO.getPageCount()) {
			pageDTO.setMax(pageDTO.getPageCount());
		}

		// SQL 첫 ROWNUM    Mysql DBMS 를 이용해서 첫 ROWNUM 로직에 + 1 을 안 더해준다.
		//         			 ㄴ limit 0,? 으로해야 첫번째 record가 나온다.
		// 10 , 20 -
		pageDTO.setFirstRecordIndex((pageDTO.getCurrentPage() - 1) * pageDTO.getPageListCnt());
		// SQL 마지막 ROWNUM
		pageDTO.setLastRecordIndex(pageDTO.getCurrentPage() * pageDTO.getPageListCnt());
		// MySQL, limit 마지막 값을 위해 계산로직 추가.
		pageDTO.setLastRecordIndex(pageDTO.getLastRecordIndex() - pageDTO.getFirstRecordIndex());
		
		// 이전 페이지 존재 여부
		pageDTO.setHasPreviousPage(pageDTO.getMin() != 1);
		
		// 다음 페이지 존재 여부
		pageDTO.setHasNextPage(pageDTO.getMax() * pageDTO.getPageListCnt() < pageDTO.getTotalCount());
		
		
	    // 1 page인 경우 prePage가 0이 됨
	    // 이런 경우에는 prePage 버튼을 비활성화해 놓음
		
	    pageDTO.setPrePage(pageDTO.getCurrentPage());
	    pageDTO.setNextPage(pageDTO.getCurrentPage()); 
	    
	    // 이전페이지의 값이 최소 네비게이션 버튼보다 작아지지 않도록함
	    if(pageDTO.getPrePage() < pageDTO.getCurrentPage()) {
	    	pageDTO.setPrePage(pageDTO.getMin());
	    }
	    
	    // 다음페이지의 값이 최대 네비게이션 버튼 개수를 넘어가지 않도록 함
	    if(pageDTO.getNextPage() > pageDTO.getCurrentPage()) {
	    	 pageDTO.setNextPage(pageDTO.getMax());
	    }		
	    
		
	}

}

