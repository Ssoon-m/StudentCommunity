
package com.teamproject.StudentCommunity.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import com.teamproject.StudentCommunity.WebListener.SessionConfig;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import com.teamproject.StudentCommunity.dto.post.PostMemberSearchDTO;
import com.teamproject.StudentCommunity.dto.reply.ReReplyPostDTO;
import com.teamproject.StudentCommunity.dto.reply.ReplyDTO;
import com.teamproject.StudentCommunity.dto.reply.ReplyPagingDTO;
import com.teamproject.StudentCommunity.dto.reply.ReplyPostDTO;
import com.teamproject.StudentCommunity.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;
import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.MemberStatus;
import com.teamproject.StudentCommunity.dto.SuspendedHistoryDTO;
import com.teamproject.StudentCommunity.dto.University.UniversityDTO;
import com.teamproject.StudentCommunity.utils.UploadFileUtils;

import lombok.AllArgsConstructor;

@Controller
@Slf4j
@AllArgsConstructor
@RequestMapping("/member")
public class MemberController {
  

	private MemberService memberService;
	private UniversityService universityService;
	private SuspendedHistoryService suspendedHistoryService;
	private PostService postService;
	private PostDetailService postDetailService;
	private ReplyService replyService;
	private BCryptPasswordEncoder passEncoder;

   @Resource(name = "loginMemberDTO")
   @Lazy
   private MemberDTO loginMemberDTO;

   @GetMapping("/before_register")
   public String beforRegister(UniversityDTO universityDTO , Model model) {

         List<UniversityDTO> universityList = universityService.universityList();

         model.addAttribute("universityList",universityList);

          return "member/before_register";
   }

   @PostMapping("/register")
   public String register(MemberDTO memberDTO, UniversityDTO universityDTO, Model model) {

             memberDTO.setUniversityName(universityDTO.getName());   // universityDTO name값을 memberDTO에 세팅
             model.addAttribute("universityId",universityService.universityId(universityDTO.getName())); // university id 값 얻어오기

             MemberStatus memberStatus = MemberStatus.ACTIVE;
             
             model.addAttribute("memberStatus",memberStatus);
             
      return "member/register";
   }

	@PostMapping("/registration")
	public String registration(@Valid MemberDTO memberDTO, BindingResult result) {

		if (result.hasErrors()) {
			return "member/register";
		}

		if (!(memberDTO.getPassword().equals(memberDTO.getPassword2()))) {
			System.out.println("비밀번호가 일치하지 않습니다.");
			return "member/register";
		}

		// 암호화
		String inputPass = memberDTO.getPassword();
		String pass = passEncoder.encode(inputPass);
		memberDTO.setPassword(pass);

		String  fileName = "profile.jpg";
		memberDTO.setImg(File.separator + "images_profile" + File.separator + fileName);
		memberService.memberRegist(memberDTO);

		return "/member/register_success";
	}

	@GetMapping("/checkUser/{user}")
	@ResponseBody
	public String checkUser(@PathVariable String user) {
		boolean chck = memberService.checkUser(user);
		return chck + "";
	}

	@GetMapping("/login")
	public String login(@ModelAttribute("tmpLoginMemberDTO") MemberDTO tmpLoginMemberDTO,
			@RequestParam(value = "failure", defaultValue = "false") boolean failure, Model model) {

		model.addAttribute("failure", failure);

		return "member/login";
	}

	@PostMapping("/login_proc")
	public String loginProc(@ModelAttribute("tmpLoginMemberDTO") MemberDTO tmpLoginMemberDTO,
							HttpServletRequest request, HttpSession session, Model model,BindingResult result) {
		if (result.hasErrors()) {
			return "member/login";
		}

		memberService.getLoginUser(tmpLoginMemberDTO);
		model.addAttribute("universityId",loginMemberDTO.getUniversityId());

		// 암호화 후 로그인 처리
		tmpLoginMemberDTO.getPassword(); // 로그인때 입력한 원본 비번
		loginMemberDTO.getPassword(); // db에 저장되어있는 암호화 비번

		if(!passEncoder.matches(tmpLoginMemberDTO.getPassword(), loginMemberDTO.getPassword())){ //password 매칭
			System.out.println(tmpLoginMemberDTO.getPassword());
			System.out.println(loginMemberDTO.getPassword());
			System.out.println("false");
			return "member/login_failure";
		}else {
			System.out.println(tmpLoginMemberDTO.getPassword());
			System.out.println(loginMemberDTO.getPassword());
			System.out.println("success");
		}

		// 동일 브라우저일떄 바로 로그인되게
		if(session.getAttribute("login_id") != null){
			model.addAttribute("universityId",loginMemberDTO.getUniversityId());
			if(loginMemberDTO.getStatus().equals(MemberStatus.ADMIN)){
				return "redirect:/admin/admin_index";
			}
			return "member/login_success";
		}

		if (loginMemberDTO.isUserLogin()) {
			// 로그인 세션관리 !! 중복 방지하기 !!!!
			// 현재 로그인한 아이디를 session에 login_id에 저장하기 전에
			String userId = SessionConfig.getSessionidCheck("login_id", tmpLoginMemberDTO.getEmail());
			memberService.getLoginUser(tmpLoginMemberDTO); //
			System.out.println(loginMemberDTO.getEmail() + " : " +userId);
			session.setMaxInactiveInterval(60 * 60);
			session.setAttribute("login_id", tmpLoginMemberDTO.getEmail());

			if(loginMemberDTO.getStatus().equals(MemberStatus.ADMIN)) {
				//return "redirect:/university/" + loginMemberDTO.getUniversityId(); // 관리자페이지 경로 바꿔주기
				return "redirect:/admin/admin_index";
			}else if(loginMemberDTO.getStatus().equals(MemberStatus.DE_ACTIVE)) {
				return "redirect:/member/login_denied";
			}else {
				return "member/login_success";
			}

		}else{
			return "member/login_failure";
		}
	}

	@GetMapping("/logout")
	public String logout(@ModelAttribute("tmpLoginMemberDTO") MemberDTO tmpLoginMemberDTO,HttpSession session,
			@RequestParam(value = "failure", defaultValue = "false") boolean failure, Model model) {

		loginMemberDTO.setUserLogin(false);
		session.invalidate();

		return "member/logout";
	}

	@GetMapping("/myPage")
	public String myPage() {
		//기존에  loginMemberDTO 세팅 하는 부분을 확인해봐야 됨
		//다른 데이터는 정상적으로 들어오는데  img 데이터가 안들어와서 
		//임시로 id로 데이터 조회후 다시 img 세팅중
		MemberDTO myPageInfo =	memberService.findUserInfoById(loginMemberDTO.getId());
		
		loginMemberDTO.setImg(myPageInfo.getImg());
		
		return "member/myPage";
	}

	@GetMapping("/before_modify")
	public String beforeModify(@ModelAttribute("checkMemberDTO") MemberDTO checkMemberDTO) {
		return "member/before_modify";
	}

	@PostMapping("/before_modify_proc")
	   public String beforeModifyProc(@ModelAttribute("checkMemberDTO") MemberDTO checkMemberDTO,
	         @ModelAttribute("modifyMemberDTO") MemberDTO modifyMemberDTO, Model model, BindingResult result) {

	      if (! passEncoder.matches(checkMemberDTO.getPassword(),loginMemberDTO.getPassword())) {
	         return "member/before_modify_check_failure";
	      }

	      checkMemberDTO.setEmail(loginMemberDTO.getEmail());
	      modifyMemberDTO = memberService.getUserInfo(modifyMemberDTO, checkMemberDTO);
	      modifyMemberDTO.setUniversityName(loginMemberDTO.getUniversityName());

	      if (!modifyMemberDTO.getId().equals(loginMemberDTO.getId())) {
	         return "member/before_modify_check_failure";
	      }

	      model.addAttribute("password", checkMemberDTO.getPassword());
	      model.addAttribute("modifyMemberDTO", modifyMemberDTO);
	      
	      return "member/modify";
	   }

	   @PostMapping("/modify_proc")
	   public String modifyProc(@ModelAttribute("modifyMemberDTO") MemberDTO modifyMemberDTO,
	                      @RequestParam("files") MultipartFile file, HttpServletRequest request,BindingResult result) throws IOException, Exception {
		   System.out.println("modifyMemberDTO.isCheckUser() = " + modifyMemberDTO.isCheckUser());
			// valid 를 넣으면 검증이 안된다. DTO에 modifyMemberDTO에서 넣어주지 않는 값들이 있기 때문에
		   // 어떠한 값을 넣어도 오류를 뱉음.. 그래서 modify에서 넘겨주는 값만 가지고있는 DTO를 만들던지 해야할듯 !!
	      if(result.hasErrors()) {
	         return "member/modify";
	      }
	      String uploadPath = request.getSession().getServletContext().getRealPath("/")+"resources";
	      String imgUploadPath = uploadPath + File.separator + "images_profile";

	      log.info(imgUploadPath);

	      String fileName = null;


	      MemberDTO oldInfo =   memberService.findUserInfoById(modifyMemberDTO.getId());

	      File oldFile = new File(uploadPath + File.separator+oldInfo.getImg());
	      modifyMemberDTO.setImg(oldInfo.getImg());
	      if(!file.isEmpty()){
	         fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes());
	         modifyMemberDTO.setImg(File.separator + "images_profile" + File.separator + fileName);
	         if(oldFile.exists()) {
	            if(!"\\images_profile\\profile.jpg".equals(oldInfo.getImg())) {
	               oldFile.delete();
	            }
	         }
	      }else {
	         if(!oldFile.exists()) {
	            fileName = "profile.jpg";
	            /*
	             * if(!loginMemberDTO.getImg().equals("/images_profile/" + fileName)) {
	             * modifyMemberDTO.setImg(loginMemberDTO.getImg()); }
	             */
	            modifyMemberDTO.setImg(File.separator + "images_profile" + File.separator + fileName);
	         }
	      }

	      //그리고 입력된 정보로 업데이트
	      modifyMemberDTO.setPassword(passEncoder.encode(modifyMemberDTO.getPassword()));
	      modifyMemberDTO.setName(modifyMemberDTO.getName());
	      memberService.updateMemberInfo(modifyMemberDTO);

	      return "member/re_login";

	      /* return myPage(); */
	}
	
	  @GetMapping("/before_memberdelete")
	   public String beforeMemberdelete(@ModelAttribute("checkDelMemberDTO") MemberDTO checkDelMemberDTO) {
	      return "member/before_memberdelete";
	   }

	  @PostMapping("/before_memberdelete_proc")
	   public String beforeMemberdeleteProc(@ModelAttribute("checkDelMemberDTO") MemberDTO checkDelMemberDTO,
	                               @ModelAttribute("deleteMemberDTO") MemberDTO deleteMemberDTO, BindingResult result) {

	      if(!passEncoder.matches(checkDelMemberDTO.getPassword(), loginMemberDTO.getPassword())){ //password 매칭
	         return "member/before_memberdelete_check_failure";
	      }

	      checkDelMemberDTO.setEmail(loginMemberDTO.getEmail());

	      memberService.getUserDel(deleteMemberDTO, checkDelMemberDTO);

	      if (!deleteMemberDTO.getId().equals(loginMemberDTO.getId())) {
	         return "member/before_memberdelete_check_failure";
	      }
	      
	      return "member/memberdelete";
	   }
	      
	   @PostMapping("/after_memberdelete_proc")
	   public String afterMemberdeleteProc(@ModelAttribute("checkDelMemberDTO") MemberDTO checkDelMemberDTO,
	       @ModelAttribute("deleteMemberDTO") MemberDTO deleteMemberDTO, BindingResult result, HttpSession session) {

	      checkDelMemberDTO.setEmail(loginMemberDTO.getEmail());
	      memberService.getUserDel(deleteMemberDTO, checkDelMemberDTO);

	       if (!deleteMemberDTO.getId().equals(loginMemberDTO.getId())) {
	         return "member/before_memberdelete_check_failure";
	      }

	      if(!passEncoder.matches(checkDelMemberDTO.getPassword(), loginMemberDTO.getPassword())){ //password 매칭
	         return "member/before_memberdelete_check_failure";
	      }

	     memberService.deleteMemberInfo(deleteMemberDTO);
	     session.invalidate();

	     return "redirect:/";
	   }
	
	
	
//	//삭제

	
	@PostMapping("/imgDelete")
	@ResponseBody
  public MemberDTO imgDelete(String id, String path,HttpServletRequest request, Model model) throws Exception {
		

		String defaultPath = "\\images_profile\\profile.jpg";
		String uploadPath = request.getSession().getServletContext().getRealPath("/")+"resources";
		// 이 앞에 부분 defaultPath 여기들어오는 친구가 null이면 안됨
		// "" 공백은 괜찮은데null이들어오면 에러가 남
		if(!defaultPath.equals(path)) {
			File file1 = new File(uploadPath+path);
			if(file1.exists()) {
				file1.delete();
		  }
			System.out.println(uploadPath);
//		그다음에 받은 멤버의 아이디로 이미지 경로를 디폴트 이미지경로로 update
//		/images_profile/default_image.png
			MemberDTO pathUpdate = new MemberDTO();
			pathUpdate.setId(Long.parseLong(id));
			pathUpdate.setImg(defaultPath);
			memberService.updateImage(pathUpdate);
			//여기에 나옴
		}
	
		System.out.println("uploadPath : " + uploadPath);
    
		
		
		MemberDTO returnDTO = memberService.findUserInfoById(Long.parseLong(id));
	
		return returnDTO;
  }


	@GetMapping("/login_overlap")
	public String loginOverlap() {
		return "member/login_overlap";
	}
	
	@GetMapping("/not_login")
	public String notLogin() {
		return "member/not_login";
	}
	
	@GetMapping("/forgot_password")
	public String forgotPassword(@ModelAttribute("forgotMemberDTO") MemberDTO forgotMemberDTO) {
		return "member/forgot_password";
	}

	@PostMapping("/change_password")
	public String changePassword(@ModelAttribute("forgotMemberDTO") MemberDTO forgotMemberDTO) {
		forgotMemberDTO.setEmail(forgotMemberDTO.getEmail()+"@"+forgotMemberDTO.getDomain());
		forgotMemberDTO.setPassword(passEncoder.encode(forgotMemberDTO.getPassword()));
		memberService.updatePassword(forgotMemberDTO);
		return "member/password_change_success";

	}
	
	@GetMapping("/login_denied")
	public String loginDenied(Model model) {
		
		SuspendedHistoryDTO suspendedHistoryDTO = suspendedHistoryService.getSuspendedInfoByID(loginMemberDTO.getId());
		
		model.addAttribute("endOn", suspendedHistoryDTO.getEndOn());
		model.addAttribute("reason", suspendedHistoryDTO.getReason());
		
		return "member/login_denied";
	}




	//멤버가 쓴글 paging
	@GetMapping("/{memberId}/post")
	@ResponseBody
	public List<PostMemberDTO> memberPostList(@ModelAttribute PostMemberSearchDTO postDto){
		log.info(postDto.toString());
		postDto.setStartNo((postDto.getPageNo()-1)*postDto.getLimit());
		return postService.getByMemberId(postDto);
	}

	@GetMapping("/{memberId}/post_count")
	@ResponseBody
	public int countMemberPost(@PathVariable Long memberId){
		return postService.getCountMemberPost(memberId);
	}

	@GetMapping("/{memberId}/post/good")
	@ResponseBody
	public List<PostMemberDTO> memberGoodPostList(@ModelAttribute PostMemberSearchDTO postDto){
		log.info(postDto.toString());
		postDto.setStartNo((postDto.getPageNo()-1)*postDto.getLimit());
		return postDetailService.getGoodPost(postDto);
	}

	@GetMapping("/{memberId}/post/good_count")
	@ResponseBody
	public int countMemberGoodPost(@PathVariable Long memberId){
		return postDetailService.getCountGoodPost(memberId);
	}

	@GetMapping("/myNote")
	public String myNote(Model model) {
		int newReplyMessageCount = replyService.getReplyMessageCount(loginMemberDTO.getId());
		int newReReplyMessageCount = replyService.getReReplyMessageCount(loginMemberDTO.getId());
		
		model.addAttribute("replyNoteNum", newReplyMessageCount);
		model.addAttribute("reReplyNoteNum", newReReplyMessageCount);
		
		return "member/myNote";
	}

	@GetMapping("/myPostWithNewReply")
	@ResponseBody
	public HashMap<Long, List<ReplyPostDTO>> myPostWithNewReply(@ModelAttribute ReplyPagingDTO replyPagingDTO){
		System.out.println("myPostWithNewReply called");
		replyPagingDTO.setMemberId(loginMemberDTO.getId());
		replyPagingDTO.setStartNo((replyPagingDTO.getPageNo()-1)*replyPagingDTO.getLimit());

		//내가 쓴 글에 new 댓글 리스트
		List<ReplyPostDTO> replyOnMyPostDTOList = replyService.getMyPostNewReplyList(replyPagingDTO);

		HashMap<Long, List<ReplyPostDTO>> map = new HashMap<>();

		for(ReplyPostDTO replyPostDTO : replyOnMyPostDTOList) {
			if(map.containsKey(replyPostDTO.getPostId())) {
				List<ReplyPostDTO> tempList = map.get(replyPostDTO.getPostId());
				tempList.add(replyPostDTO);
				map.put(replyPostDTO.getPostId(), tempList);
			}
			else {
				List<ReplyPostDTO> tempList = new ArrayList<>();
				tempList.add(replyPostDTO);
				map.put(replyPostDTO.getPostId(), tempList);
			}
		}
		return map;
	}
	
	@GetMapping("/myReplyWithNewReReply")
	@ResponseBody
	public HashMap<Long, List<ReReplyPostDTO>> myReplyWithNewReReply(@ModelAttribute ReplyPagingDTO replyPagingDTO){
		System.out.println("myReplyWithNewReReply called");
		replyPagingDTO.setMemberId(loginMemberDTO.getId());
		replyPagingDTO.setStartNo((replyPagingDTO.getPageNo()-1)*replyPagingDTO.getLimit());

		//내가 쓴 댓글에 new 대댓글 리스트
		List<ReReplyPostDTO> reReplyOnMyReplyPostDTOList = replyService.getMyReplyNewReReplyList(replyPagingDTO);

		HashMap<Long, List<ReReplyPostDTO>> map = new HashMap<>();

		for(ReReplyPostDTO reReplyPostDTO : reReplyOnMyReplyPostDTOList) {
			if(map.containsKey(reReplyPostDTO.getPostId())) {
				List<ReReplyPostDTO> tempList = map.get(reReplyPostDTO.getPostId());
				tempList.add(reReplyPostDTO);
				map.put(reReplyPostDTO.getPostId(), tempList);
			}
			else {
				List<ReReplyPostDTO> tempList = new ArrayList<>();
				tempList.add(reReplyPostDTO);
				map.put(reReplyPostDTO.getPostId(), tempList);
			}
		}
		
		return map;
	}
}
