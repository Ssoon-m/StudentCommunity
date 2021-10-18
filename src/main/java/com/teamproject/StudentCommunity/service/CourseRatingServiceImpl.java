package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.University.UniversityDTO;
import com.teamproject.StudentCommunity.dto.courseRating.CourseRatingDTO;
import com.teamproject.StudentCommunity.dto.courseRating.CourseRatingPagingDTO;
import com.teamproject.StudentCommunity.mapper.CourseRatingDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class CourseRatingServiceImpl implements CourseRatingService{

    private final CourseRatingDAO courseRatingDAO;

    @Override
    public List<CourseRatingDTO> getByCourseId(CourseRatingPagingDTO courseDTO) {
        return courseRatingDAO.findByCourseId(courseDTO);
    }

    @Override
    public CourseRatingDTO getById(Long id) {
        return courseRatingDAO.findById(id);
    }

    @Override
    public List<CourseRatingDTO> getNew(Long universityId) {
        return courseRatingDAO.findNew(universityId);
    }

    @Override
    public Optional<CourseRatingDTO> getByMemberCourseId(Long memberId, Long courseId) {
        return courseRatingDAO.findByMemberCourseId(memberId,courseId);
    }


    @Override
    public int countByCourseId(Long courseId) {
        return courseRatingDAO.countByCourseId(courseId);
    }

    @Override
    public int newCourseRating(CourseRatingDTO courseRatingDTO) {
        return courseRatingDAO.newCourseRating(courseRatingDTO);
    }

    @Override
    public int deleteById(Long id) {
        return courseRatingDAO.deleteById(id);
    }

    @Override
    public int updateCourseRating(CourseRatingDTO courseRatingDTO) {
        return courseRatingDAO.updateCourseRating(courseRatingDTO);
    }
    

  	@Override
  	public List<CourseRatingDTO> getCourseId(PageDTO pageDTO) {
  		
  		return courseRatingDAO.getCourseId(pageDTO);
  	}
  	
  	@Override
  	public List<CourseRatingDTO> autoCourse() {
  		
  		return courseRatingDAO.autoCourse();
  	}
  

}
