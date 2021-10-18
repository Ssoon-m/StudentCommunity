package com.teamproject.StudentCommunity.PagingService;

import java.util.List;

import org.springframework.stereotype.Service;
import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import com.teamproject.StudentCommunity.mapper.SuspendedHistoryDAO;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BoardPagingService implements PagingService{

	private final SuspendedHistoryDAO suspendedHistoryDAO;


	@Override
	public void RecordTotalCount(PageDTO pageDTO) {
		pageDTO.setTotalCount(suspendedHistoryDAO.getPostMemberCountAll(pageDTO));
		//pageDTO.setTotalCount(courseRatingDAO.getCourseIdCount(pageDTO));
	}

	@Override
	public List<PostMemberDTO> PageList(PageDTO pageDTO) {

		PageCalculator pageCalculator = new PageCalculator(pageDTO);
		pageCalculator.calculation(pageDTO);

		List<PostMemberDTO> test = suspendedHistoryDAO.getSuspendList(pageDTO);		
		return test;
	}






}
