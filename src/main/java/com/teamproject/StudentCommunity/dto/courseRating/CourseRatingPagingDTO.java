package com.teamproject.StudentCommunity.dto.courseRating;

import lombok.Data;

@Data
public class CourseRatingPagingDTO {
    
		private Long limit=2L;
    private Long pageNo=1L;
    private Long startNo;
    private Long courseId;
    private Long memberId;
}
