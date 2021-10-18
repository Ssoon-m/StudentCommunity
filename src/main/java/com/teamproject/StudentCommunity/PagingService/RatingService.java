package com.teamproject.StudentCommunity.PagingService;

import java.util.List;

import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.courseRating.CourseRatingDTO;

public interface RatingService {


	default public List<CourseRatingDTO> Pagingflow(PageDTO pageDTO){
		RecordTotalCount(pageDTO);
		
		List<CourseRatingDTO> test = RatingList(pageDTO);
		
		return test;
	}

	public void RecordTotalCount(PageDTO pageDTO);

	public List<CourseRatingDTO> RatingList(PageDTO pageDTO);
}
