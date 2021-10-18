package com.teamproject.StudentCommunity.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.teamproject.StudentCommunity.dto.University.UniversityDTO;



@Mapper
public interface UniversityDAO {
	
	
	List<UniversityDTO> universityList();
	
	public Long universityId(String universityName);
  
    List<UniversityDTO> findAll();
	
	UniversityDTO findById(Long id);
	
	String getUniversityNameByID(Long id);

	void insertUniversity(String name);

	void deleteUniversity(Long id);
}

