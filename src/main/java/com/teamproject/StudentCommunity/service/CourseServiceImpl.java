package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.Course.CourseCategoryDTO;
import com.teamproject.StudentCommunity.dto.Course.CourseDTO;
import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.mapper.CourseDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Slf4j
@Service
@Transactional
@RequiredArgsConstructor
public class CourseServiceImpl implements CourseService{
    private final CourseDAO courseDAO;

    @Resource(name = "loginMemberDTO")
    @Lazy
    private MemberDTO loginMemberDTO;

    @Override
    public List<CourseDTO> getByUniversityId(Long universityId) {
        return courseDAO.findByUniversityId(universityId);
    }

    @Override
    public CourseDTO getById(Long id) {
        return courseDAO.findById(id);
    }

  	
  	@Override
  	public List<CourseCategoryDTO> courseByUniversityId(Long universityId) {
  		
  		return courseDAO.courseByUniversityId(universityId);
  	}

  	

    

    @Override
    public List<CourseDTO> findCategoryName(){
        return courseDAO.findCategoryName(loginMemberDTO.getUniversityId());
    }

    @Override
    public List<CourseDTO> selectCourseName(Long universityId){
     return courseDAO.selectCourseName(universityId);
    }

    //유연주 추가
    @Override
    public List<CourseDTO> getMajorList(Long universityId){
    	return courseDAO.getMajorList(universityId);
    }
    
    @Override
    public List<CourseDTO> getNotMajorList(Long universityId){
    	return courseDAO.getNotMajorList(universityId);
    }

}
