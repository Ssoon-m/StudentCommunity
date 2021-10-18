package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.courseRating.CourseRatingDTO;
import com.teamproject.StudentCommunity.dto.courseRating.CourseRatingPagingDTO;

import java.util.List;
import java.util.Optional;

public interface CourseRatingService {

    List<CourseRatingDTO> getByCourseId (CourseRatingPagingDTO courseDTO);

    CourseRatingDTO getById(Long id);

    List<CourseRatingDTO>
    getNew(Long universityId);

    Optional<CourseRatingDTO> getByMemberCourseId(Long memberId, Long courseId);

    int countByCourseId(Long courseId);

    int newCourseRating(CourseRatingDTO courseRatingDTO);

    int deleteById(Long id);

    int updateCourseRating(CourseRatingDTO courseRatingDTO);
    
    List<CourseRatingDTO> getCourseId (PageDTO pageDTO);
   
    List<CourseRatingDTO> autoCourse ();
    
    



}
