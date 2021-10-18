package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.Course.CourseCategoryDTO;
import com.teamproject.StudentCommunity.dto.Course.CourseDTO;

import java.util.List;

public interface CourseService {
    List<CourseDTO> getByUniversityId(Long universityId);
   
    CourseDTO getById(Long id);

   
    List<CourseCategoryDTO> courseByUniversityId(Long universityid);

   List< CourseDTO> findCategoryName();
    List<CourseDTO> selectCourseName(Long universityId);

    List<CourseDTO> getMajorList(Long universityId);
    List<CourseDTO> getNotMajorList(Long universityId);

}
