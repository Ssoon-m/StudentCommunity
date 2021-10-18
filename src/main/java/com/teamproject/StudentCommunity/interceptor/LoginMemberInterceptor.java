package com.teamproject.StudentCommunity.interceptor;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Lazy;
import org.springframework.web.servlet.HandlerInterceptor;

import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.MemberStatus;

public class LoginMemberInterceptor implements HandlerInterceptor{

	@Resource(name = "loginMemberDTO")
	@Lazy
	private MemberDTO loginMemberDTO;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		final HttpSession session = request.getSession();

		if(session.getAttribute("login_id") == null) {   // 중복 로그인 방지!!
			String contextPath = request.getContextPath();
			System.out.println("중복 로그인 방지 인터셉터 동작");
			response.sendRedirect(contextPath + "/member/login_overlap");
			return false;
		}

		if(loginMemberDTO.isUserLogin() == false) { //세션 로그인이 없으면 리다이렉트 처리
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath + "/member/not_login");
			
			return false;
		}else if(loginMemberDTO.getStatus().equals(MemberStatus.DE_ACTIVE)) {
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath + "/member/login_denied");
			
			return false;
		}
		
		return true;
	}
}
