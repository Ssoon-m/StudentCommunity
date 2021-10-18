package com.teamproject.StudentCommunity.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.teamproject.StudentCommunity.dto.EmailAuthDTO;

@Mapper
public interface EmailAuthDAO {
	
	void CreateValidity(EmailAuthDTO emailAuthDTO);
	
	String ValidityCheck(String emailkey);

}
