package com.teamproject.StudentCommunity.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.SuspendedHistoryDTO;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;

@Mapper
public interface SuspendedHistoryDAO {
	
	List<SuspendedHistoryDTO> getEndOn();
	
	void setSuspendDate(SuspendedHistoryDTO suspendedHistoryDTO);
	
	List<PostMemberDTO> getSuspendList(PageDTO pageDTO);
	
	Integer getPostMemberCountAll(PageDTO pageDTO);
	Integer getCourseIdCount(PageDTO pageDTO);
	
	
	
	
	SuspendedHistoryDTO getSuspendedInfoByID(Long id);

    List<PostMemberDTO> autoSearch();
    

	List<PostMemberDTO> autoSearchMember();

    void deleteHistory(Long memberId);
}
