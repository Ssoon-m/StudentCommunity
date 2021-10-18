package com.teamproject.StudentCommunity.PagingService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.courseRating.CourseRatingDTO;
import com.teamproject.StudentCommunity.mapper.CourseRatingDAO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class RatingPagingSerivce implements RatingService {
	 
	private final CourseRatingDAO courseRatingDAO;

	@Override
	public void RecordTotalCount(PageDTO pageDTO) {
       pageDTO.setTotalCount(courseRatingDAO.getCourseIdCount(pageDTO));
       System.out.println("pageDTO.getTotalCount() : " + pageDTO.getTotalCount());
   }
 	
@Override
	public List<CourseRatingDTO> RatingList(PageDTO pageDTO) {
	
		PageCalculator pageCalculator = new PageCalculator(pageDTO);
		pageCalculator.calculation(pageDTO);
		
		List<CourseRatingDTO> rating = courseRatingDAO.getCourseId(pageDTO);
		
		
		return rating;
	}
}
