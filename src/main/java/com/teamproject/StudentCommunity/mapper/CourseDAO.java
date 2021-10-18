package com.teamproject.StudentCommunity.mapper;

import com.teamproject.StudentCommunity.dto.Course.CourseCategoryDTO;
import com.teamproject.StudentCommunity.dto.Course.CourseDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CourseDAO {

    List<CourseDTO> findByUniversityId (Long universityId);


    CourseDTO findById (Long id);

    
    List<CourseCategoryDTO> courseByUniversityId (Long universityId);


    List<CourseDTO> findCategoryName(Long universityId);

    List<CourseDTO> selectCourseName(Long universityId);
    
    //유연주 추가
    List<CourseDTO> getMajorList(Long universityId);
    List<CourseDTO> getNotMajorList(Long universityId);

}
