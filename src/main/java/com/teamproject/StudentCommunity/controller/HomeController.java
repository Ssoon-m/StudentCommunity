package com.teamproject.StudentCommunity.controller;


import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.MemberStatus;
import com.teamproject.StudentCommunity.dto.University.UniversityDTO;
import com.teamproject.StudentCommunity.service.UniversityService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.List;


@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {

	private final UniversityService universityService;
	@Resource(name = "loginMemberDTO")
	@Lazy
	private MemberDTO loginMemberDTO;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main( Model model, HttpSession session, HttpServletRequest request){

		if(session.getAttribute("login_id") != null){
			model.addAttribute("universityId",loginMemberDTO.getUniversityId());
			if(loginMemberDTO.getStatus().equals(MemberStatus.ADMIN)){
				return "redirect:/admin/admin_index";
			}
			return "member/login_success";
		}

		List<UniversityDTO> universityList =universityService.getAll();
		model.addAttribute("universityList",universityList);
		return "main";
	}

	@GetMapping("/course")
	public String course(){
		return "courseRating/course";
	}

	
	@GetMapping("not_permission")
	public String notAdmain() {
		return "not_permission";
	}
	
}
