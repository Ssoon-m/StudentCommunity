package com.teamproject.StudentCommunity.mapper;

import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.MemberSearchDTO;
import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MemberDAO {
	
	void memberRegist(MemberDTO memberDTO);
	
	String checkUser(String name);

	MemberDTO getLoginUser(MemberDTO memberDTO);
	
	MemberDTO getUserInfo(MemberDTO checkMemberDTO);
	
	void updateMemberInfo(MemberDTO modifyMemberDTO);
	
	void changeActive(Long memberId);
	
	void changeDeActive(Long memberId);
	
	MemberDTO getUserDel(MemberDTO checkDelMemberDTO);
	
	void deleteMemberInfo(MemberDTO deleteMemberDTO);
	   
	String checkEmail(String email);
	


	void updateImage(MemberDTO pathUpdate);
	void updatePassword(MemberDTO memberDTO);
	void updateName(MemberDTO memberDTO);
	
  	MemberDTO findUserInfoById(Long id);
  
  	MemberDTO findUniversityNameByID(String universityName);

	List<PostMemberDTO> findAllMember(PageDTO pageDTO);

	void deleteMember(Long id);

	Integer getTotalCountMember(PageDTO pageDTO);

    List<MemberDTO> getMemberNameEmail();

	
}
