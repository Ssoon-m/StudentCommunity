package com.teamproject.StudentCommunity.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.StudentCommunity.dto.EmailAuthDTO;
import com.teamproject.StudentCommunity.service.EmailAuthService;
import com.teamproject.StudentCommunity.service.EmailSender;
import com.teamproject.StudentCommunity.service.MemberService;

import lombok.AllArgsConstructor;

@RestController
@Slf4j
@AllArgsConstructor
public class mailController {
   
   private EmailSender emailSender;
   
   private EmailAuthService emailAuthService;
   private MemberService memberService;
   
   @PostMapping("/CheckMail")
   public Map<String, Object> SendMail(String where, String mail, HttpServletResponse response, HttpServletRequest request) throws Exception {
       System.out.println("where = " + where);
       System.out.println("mail = " + mail);
	   Boolean checkEmail = memberService.checkEmail(mail);

		  Map<String, Object> map = new HashMap<>();

      if(where.equals("login")) {
          if(!checkEmail) {
              map.put("key", "false");
              return map;
          }
      }else if(where.equals("register")) {
          if(checkEmail) {
              map.put("key", "false");
              return map;
          }
      }
	   
     long start = System.currentTimeMillis();
      try {
         EmailAuthDTO emailAuthDTO = new EmailAuthDTO();
          
          Date date = new Date();
          SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
          Calendar cal = Calendar.getInstance();
          cal.setTime(date);
          cal.add(Calendar.MINUTE, 1);
          String min = sdformat.format(cal.getTime()); // ??????????????? 1??? ??????
          
          SimpleMailMessage message = emailSender.messageSet(mail); // ????????? ????????? ??????
          String key = emailSender.getKey(); // ????????? ????????? ?????? ??????
          
          // ????????? ?????? ???????????? ??????.
          new Thread(()->{
             try {
             emailSender.SendEmail(message);
          } catch (Exception e) {
             e.printStackTrace();
             log.error("SendEmailException",e);
          }
          }).start();
          

          emailAuthDTO.setValidity(min);
          emailAuthDTO.setEmailkey(key);
      
          
          emailAuthService.CreateValidity(emailAuthDTO); // ???????????????, ?????????????????? 1??? ?????? ????????? ??????.
          
          map.put("key",key);
          
          return map;
      }finally {
         long finish = System.currentTimeMillis();
         long timeMs = finish - start;
         System.out.println("emailAuth : " + timeMs + "ms");
      }
      
     
   }
   
   @PostMapping("/authtime")
   public void setTime() {
      
   }
   
   
   @PostMapping("/CheckEmailKey")
   public String CheckEmailKey(String key) {
      Date date = new Date();
      SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
      String min = sdformat.format(date.getTime());
      
      // ????????? ????????? ????????? ????????????. ????????? ??? ?????????
      // 
      
      System.out.println("db??? ?????????????????? ?????? : " + emailAuthService.ValidityCheck(key));
      System.out.println("?????? ?????? : " + min);
      
      
       if(emailAuthService.ValidityCheck(key).equals("false")) {
         return "false";
       }else if(emailAuthService.ValidityCheck(key).compareTo(min) >= 0){ // db???????????? ?????????????????? ??????
          return "true";
       }else {
          return "timeout";
       }
      
   }


   
   
}