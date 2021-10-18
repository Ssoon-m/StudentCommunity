package com.teamproject.StudentCommunity.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.web.servlet.HandlerInterceptor;

import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.service.ReplyService;

public class TopMenuInterceptor implements HandlerInterceptor{
	
	@Resource(name = "loginMemberDTO")
	@Lazy
	private MemberDTO loginMemberDTO;
	
	@Autowired
	private ReplyService replyService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		int messageNum = replyService.getReplyMessageCount(loginMemberDTO.getId()) + replyService.getReReplyMessageCount(loginMemberDTO.getId());
		
		request.setAttribute("loginMemberDTO", loginMemberDTO);
		request.setAttribute("messageNum", messageNum);
		
		return true;
	}
	

}
