package com.teamproject.StudentCommunity.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Lazy;
import org.springframework.web.servlet.HandlerInterceptor;

import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.MemberStatus;

public class CheckAdminInterceptor implements HandlerInterceptor{

	@Resource(name = "loginMemberDTO")
	@Lazy
	private MemberDTO loginMemberDTO;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		if(loginMemberDTO.isUserLogin() == false) {
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath + "/member/not_login");
			
			return false;
		}
		else if(!loginMemberDTO.getStatus().equals(MemberStatus.ADMIN)) {
			
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath + "/not_permission");
			
			return false;
		}
		
		return true;
	}
}
