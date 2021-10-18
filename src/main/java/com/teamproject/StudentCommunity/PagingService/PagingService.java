package com.teamproject.StudentCommunity.PagingService;

import java.util.List;

import com.teamproject.StudentCommunity.dto.PageDTO;

import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;

public interface PagingService {
	
	default public List<PostMemberDTO> Pagingflow(PageDTO pageDTO){
		RecordTotalCount(pageDTO);
		
		List<PostMemberDTO> test = PageList(pageDTO);
		
		return test;
	}
	
	public void RecordTotalCount(PageDTO pageDTO);
	
	public List<PostMemberDTO> PageList(PageDTO pageDTO);

	
	
	
	
	
	
	
}
