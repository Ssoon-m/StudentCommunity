package com.teamproject.StudentCommunity.mapper;

import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.courseRating.CourseRatingDTO;
import com.teamproject.StudentCommunity.dto.courseRating.CourseRatingPagingDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface CourseRatingDAO {

    List<CourseRatingDTO> findByCourseId (CourseRatingPagingDTO courseDTO);

    CourseRatingDTO findById (Long id);

    List<CourseRatingDTO> findNew (Long universityId);

    Optional<CourseRatingDTO> findByMemberCourseId(@Param("memberId") Long memberId, @Param("courseId") Long courseId);

    int countByCourseId(Long courseId);

    int newCourseRating(CourseRatingDTO courseRatingDTO);

    int deleteById(Long id);

    int updateCourseRating(CourseRatingDTO courseRatingDTO);
    
    List<CourseRatingDTO> getCourseId (PageDTO pageDTO);
   
    List<CourseRatingDTO> autoCourse ();
    
    
    
    Integer getCourseIdCount(PageDTO pageDTO);
    
    

}
