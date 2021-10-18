package com.teamproject.StudentCommunity.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.teamproject.StudentCommunity.dto.*;
import com.teamproject.StudentCommunity.dto.Course.CourseCategoryDTO;
import com.teamproject.StudentCommunity.dto.board.BoardDto;
import com.teamproject.StudentCommunity.dto.courseRating.CourseRatingDTO;
import com.teamproject.StudentCommunity.service.*;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.teamproject.StudentCommunity.PagingService.PagingFactoryService;
import com.teamproject.StudentCommunity.PagingService.PagingFactoryServiceRating;
import com.teamproject.StudentCommunity.PagingService.PagingService;
import com.teamproject.StudentCommunity.PagingService.RatingService;
import com.teamproject.StudentCommunity.dto.University.UniversityDTO;
import com.teamproject.StudentCommunity.dto.board.BoardCategoryDto;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@AllArgsConstructor
@Slf4j
@RequestMapping("/admin")
public class AdminController {

	private final SuspendedHistoryService suspendedHistoryService;
	private final PagingFactoryService pagingFactoryService;
	private final PagingFactoryServiceRating pagingFactoryServiceRating;
	private final PostService postService;
	private final UniversityService universityService;
	private final BoardService boardService;
	private final CategoryService categoryService;
	private final MemberService memberService;
	private final CourseService courseService;
	private final CourseRatingService courseRatingService;

	@Resource(name = "loginMemberDTO")
	@Lazy
	private MemberDTO loginMemberDTO;

	@GetMapping("/admin_index")
	public String adminIndex(PageDTO pageDTO, Model model, @RequestParam(value="page", defaultValue="1") int page) {

		List<UniversityDTO> universityList =universityService.getAll();
		model.addAttribute("universityList",universityList);

		List<BoardCategoryDto> boardList = boardService.findWithCategoryByUniversityId(pageDTO.getSelectUniversity());
		model.addAttribute("boardList", boardList);

		// 현재 페이지 세팅
		pageDTO.setCurrentPage(page);
		// 팩토리 메서드 패턴을 이용해서 매개변수에 따른 객체 주입. (얘의 구현체는 BoardPagingService가 된다.)
		PagingService pagingService = pagingFactoryService.PagingFactoryMethod(pageDTO);

		//log.info(pageDTO.toString());

		List<PostMemberDTO> post = pagingService.Pagingflow(pageDTO);
		//log.info(pageDTO.toString());

		model.addAttribute("post",post);
		model.addAttribute("pageDTO",pageDTO);

		return "admin/admin_index";
	}



	@PostMapping("/admin_report")	@ResponseBody
	public String adminReport(@RequestBody Map<String, Object> map) {
		int setend = Integer.parseInt( map.get("SetendOn").toString());
		String reason = map.get("reason").toString();
		Long memberId = Long.parseLong(map.get("memberId").toString());

		System.out.println("setend : " + setend + "  reason : " + reason + "  memberId : " + memberId);

		Date date = new Date();
		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, setend); // 현재날짜에 일 더하기
		String endOn = sdformat.format(cal.getTime()); 

		System.out.println("endOn : " + endOn);

		SuspendedHistoryDTO suspendHistoryDTO = new SuspendedHistoryDTO();
		suspendHistoryDTO.setEndOn(endOn);
		suspendHistoryDTO.setReason(reason);
		suspendHistoryDTO.setMemberId(memberId);                   

		System.out.println("suspendHistoryDTO : " + suspendHistoryDTO.toString());

		suspendedHistoryService.setSuspendDate(suspendHistoryDTO);
		return "1";
	}


	@PostMapping("/admin_delete")
	@ResponseBody
	public Object adminDelete(@RequestParam(value="id[]") List<Long> id ) {

		for(Long postId : id) {
			postService.deleteList(postId);
		}
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("code", "OK");
		retVal.put("message", "삭제에 성공 하였습니다.");
		return retVal;
	}


	@GetMapping("/admin_universityCategory")
	public String universityCategory(PageDTO pageDTO, Model model){

		List<UniversityDTO> universityList =universityService.getAll();
		model.addAttribute("universityList",universityList);

		List<BoardCategoryDto> boardList = boardService.findWithCategoryByUniversityId(pageDTO.getSelectUniversity());
		model.addAttribute("boardListSize",boardList.size());
		model.addAttribute("boardList", boardList);

		log.info(pageDTO.toString());
		return "admin/admin_universityCategory";
	}

	@PostMapping("/insertUniversity")
	public String insertUniversity(@RequestParam String name){
		universityService.insertUniversity(name);
		return "redirect:/admin/admin_universityCategory";
	}

	@PostMapping("/deleteUniversity")
	@ResponseBody
	public Object deleteUniversity(@RequestParam Long id){
		universityService.deleteUniversity(id);
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("code", "OK");
		retVal.put("message", "삭제에 성공 하였습니다.");
		return retVal;
	}



	@PostMapping("/admin_insertCategory")
	@ResponseBody
	public String insertCategory(@RequestBody Map<String,Object> map) {
		CategoryDTO categoryDTO = new CategoryDTO();
		BoardDto boardDto = new BoardDto();
		String categoryName = map.get("categoryName").toString();
		categoryDTO.setName(categoryName);
		String description = map.get("description").toString();

		if(description.equals(CategoryEnum.UNIQUE.toString())) {
			categoryDTO.setDescription(CategoryEnum.UNIQUE);
		}else if(description.equals(CategoryEnum.BASIC.toString())) {
			categoryDTO.setDescription(CategoryEnum.BASIC);
		}else if(description.equals(CategoryEnum.ETC.toString())){
			categoryDTO.setDescription(CategoryEnum.ETC);
		}


		Long selectUniversityId = Long.parseLong(map.get("selectUniversity").toString());
		categoryService.insertCategory(categoryDTO);

		Long categoryId = categoryDTO.getId();
		boardDto.setCategoryId(categoryId);
		boardDto.setUniversityId(selectUniversityId);
		boardService.insertBoard(boardDto);
		return "1";
	}

	@PostMapping("/category_delete")
	@ResponseBody
	public Object categoryDelete(@RequestParam(value="id[]") List<Long> id ) {
		for(Long Id : id) {
			categoryService.deleteCategory(Id);
		}
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("code", "OK");
		retVal.put("message", "삭제에 성공 하였습니다.");
		return retVal;
	}

	////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
	@GetMapping("/admin_member")
	public String admin(PageDTO pageDTO, Model model, @RequestParam(value="page", defaultValue="1") int page){

		pageDTO.setShowType(2);
		// 현재 페이지 세팅
		pageDTO.setCurrentPage(page);
		// 팩토리 메서드 패턴을 이용해서 매개변수에 따른 객체 주입.
		PagingService pagingService = pagingFactoryService.PagingFactoryMethod(pageDTO);
		log.info(pageDTO.toString());

		List<PostMemberDTO> memberList = pagingService.Pagingflow(pageDTO);
		log.info(pageDTO.toString());

		model.addAttribute("memberList",memberList);
		model.addAttribute("pageDTO",pageDTO);

		return "admin/admin_member";
	}

	@PostMapping("/member_delete")
	@ResponseBody
	public String memberDelete(@RequestParam Long id){
		System.out.println("AdminController.memberDelete");
		System.out.println("id = " + id);
		memberService.deleteMember(id);
		return "1";
	}

	@PostMapping("/member_ChangeActive")
	@ResponseBody
	public String memberChangeActive(@RequestParam Long memberId){
		memberService.changeActive(memberId);
		return "1";
	}

	@GetMapping("/autocomplete")
	@ResponseBody
	public List<PostMemberDTO> auto() {

		List<PostMemberDTO> postSearch = suspendedHistoryService.autoSearch();


		return postSearch;

	}

	// 어드민 수강평
	@GetMapping("/admin_courseRating")

	public String adminCourseRating(PageDTO pageDTO, Model model,@RequestParam(value="page", defaultValue="1") int page) {

		List<UniversityDTO> universityList =universityService.getAll();		
		model.addAttribute("universityList",universityList);

		List<CourseCategoryDTO> courseList = courseService.courseByUniversityId(pageDTO.getSelectUniversity());
		model.addAttribute("courseList", courseList);


		// 현재 페이지 세팅
		pageDTO.setCurrentPage(page);
		// 팩토리 메서드 패턴을 이용해서 매개변수에 따른 객체 주입. 
		RatingService pagingService = pagingFactoryServiceRating.PagingFactoryMethod(pageDTO);

		//	log.info(pageDTO.toString());

		List<CourseRatingDTO> ratingList = pagingService.Pagingflow(pageDTO);

		//log.info(pageDTO.toString());		
		model.addAttribute("ratingList",ratingList);
		model.addAttribute("pageDTO",pageDTO);


		//	log.info(pageDTO.toString());

		return "admin/admin_courseRating";
	}





	@PostMapping("/courseRating_delete")
	@ResponseBody
	public Object courseRatingdelete(@RequestParam(value="id[]") List<Long> id ) {

		for(Long postId : id) {
			courseRatingService.deleteById(postId);
		}
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("code", "OK");
		retVal.put("message", "삭제에 성공 하였습니다.");
		return retVal;



	}


	@GetMapping("/courseAutoSearch")
	@ResponseBody

	public List<CourseRatingDTO> courseAutoSearch (){

		List<CourseRatingDTO> courseSearch = courseRatingService.autoCourse();

		return courseSearch;

	}






}






