package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.University.UniversityDTO;
import com.teamproject.StudentCommunity.mapper.UniversityDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@Slf4j
@RequiredArgsConstructor
public class UniversityServiceImpl implements UniversityService{
    private final UniversityDAO universityDAO;

  
    
    @Override
    public List<UniversityDTO> universityList() {
		List<UniversityDTO> universitylist = universityDAO.universityList();
		return universitylist;
	}
	
    @Override
	public Long universityId(String universityName) {
				
		Long universityid = universityDAO.universityId(universityName);
		
		return universityid;
	}
    
    @Override
    public String getUniversityNameByID(Long id) {
        return universityDAO.getUniversityNameByID(id);
    }
    
    @Override
    public List<UniversityDTO> getAll() {
        return universityDAO.findAll();
    }

    @Override
    public void insertUniversity(String name){
        universityDAO.insertUniversity(name);
    }

    @Override
    public void deleteUniversity(Long id){
        universityDAO.deleteUniversity(id);
    }



//	@Override
//	public UniversityDTO getID(Long id) {
//		UniversityDTO universityDTO = universityDAO.findById(id);
//		return universityDTO;
//	}
}
