package com.teamproject.StudentCommunity.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.StudentCommunity.dto.EmailAuthDTO;
import com.teamproject.StudentCommunity.mapper.EmailAuthDAO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
@Transactional
public class EmailAuthService {
	
	EmailAuthDAO emailAuthDAO;
	
	public void CreateValidity(EmailAuthDTO emailAuthDTO) {    //  인증코드 유효 시간 생성.
		emailAuthDAO.CreateValidity(emailAuthDTO);
	}
	
	public String ValidityCheck(String emailkey) { 
		
		String keyTime = emailAuthDAO.ValidityCheck(emailkey);	// 이메일 키값을 넘겼다. 거기에 해당하는 시간이 없으면 false
		
		if(keyTime == null) {
			return "false";
		}else {
			return keyTime;
		}
		
	}
	

}
