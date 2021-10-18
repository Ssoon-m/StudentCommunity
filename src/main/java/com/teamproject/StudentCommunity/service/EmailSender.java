package com.teamproject.StudentCommunity.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.teamproject.StudentCommunity.emailCalcul.CodeCalculator;

@Service
public class EmailSender{
	
	@Autowired
    protected JavaMailSender mailSender;
	
	private String key;
	
	public void setKey(String key) {
		this.key = key;
	}
	public String getKey() {
		return key;
	}
    
    
   public SimpleMailMessage messageSet(String mail) { 	
    	
    	SimpleMailMessage message = new SimpleMailMessage();
    	
    	CodeCalculator cal = new CodeCalculator();
    	
        setKey(cal.codeCalculator());
		
		try {
			message.setTo(mail);
			message.setSubject("인증번호 입력을 위한 메일 전송");
			message.setText("인증 번호 : " + getKey());
			
		}catch(NullPointerException e) {
			e.printStackTrace();
		}
		
		return message;
    }
   
   
   
	
    
    public void SendEmail(SimpleMailMessage mail) throws Exception{

		 try{
	            mailSender.send(mail);
	     }catch(MailException e){
	            e.printStackTrace(); 
	     }
		 
    }

    
}
