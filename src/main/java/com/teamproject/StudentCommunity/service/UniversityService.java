package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.University.UniversityDTO;

import java.util.List;

public interface UniversityService {

    List<UniversityDTO> getAll();
    
    List<UniversityDTO> universityList();
    
   // UniversityDTO getID(Long id);
	
	Long universityId(String universityName);
	
	String getUniversityNameByID(Long id);

	void insertUniversity(String name);

    void deleteUniversity(Long id);
}
