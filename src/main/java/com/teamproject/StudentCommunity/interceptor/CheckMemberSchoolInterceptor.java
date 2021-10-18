package com.teamproject.StudentCommunity.interceptor;

import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.MemberStatus;
import com.teamproject.StudentCommunity.dto.board.BoardCategoryDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.HandlerMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Slf4j
public class CheckMemberSchoolInterceptor implements HandlerInterceptor{
	
	@Resource(name = "loginMemberDTO")
	@Lazy
	private MemberDTO loginMemberDTO;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		String contextPath = request.getContextPath();
		//인터셉터에선 @PathVariable을 쓸수 없기 때문에 이렇게 하면
		//@RequestMapping 에서의 Url 정보중 @PathVariable 에 해당하는 정보가 Map 에 담기게 된다.
		// 인터셉터에서도 동적인 url처리 가능해 진다.
		final Map<String, String> pathVariables = (Map<String, String>) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);

		if(loginMemberDTO.getStatus().equals(MemberStatus.ADMIN)){
			return true;
		}

		if(StringUtils.isEmpty(pathVariables.get("boardId"))&&loginMemberDTO.isUserLogin()){
			if(loginMemberDTO.getStatus().equals(MemberStatus.DE_ACTIVE)) {
				response.sendRedirect(contextPath + "/member/login_denied");
				return false;
			}
			else if (!loginMemberDTO.getUniversityId().toString().equals(pathVariables.get("universityId"))){
				response.sendRedirect(contextPath + "/not_permission");
				return false;
			}

			}
		else if(!StringUtils.isEmpty(pathVariables.get("boardId"))){
			if(!loginMemberDTO.isUserLogin()) {
				response.sendRedirect(contextPath + "/member/not_login");
				return false;
			}

			else {
				List<Long> checkList = loginMemberDTO.getBoardList().stream().map(BoardCategoryDto::getId).collect(Collectors.toList());
					if(!checkList.contains(Long.parseLong(pathVariables.get("boardId")))){
					response.sendRedirect(contextPath + "/not_permission");
					return false;
				}
			}

		}

		return true;
	}
}
