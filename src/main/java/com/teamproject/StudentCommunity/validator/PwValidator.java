package com.teamproject.StudentCommunity.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.teamproject.StudentCommunity.dto.MemberDTO;

public class PwValidator implements Validator{

	
	@Override
	public boolean supports(Class<?> clazz) {
		return MemberDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		MemberDTO memberDTO = (MemberDTO)target;
		
		String beanName = errors.getObjectName();
		
		if(beanName.equals("memberDTO")) {
			if(memberDTO.getPassword().equals(memberDTO.getPassword2()) == false) {
				errors.rejectValue("user_pw", "NotEquals");
				//errors.rejectValue("user_pw2", "NotEquals");
			}
		}
		
	}
	
	

}
