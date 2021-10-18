package com.teamproject.StudentCommunity.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.StudentCommunity.dto.SuspendedHistoryDTO;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import com.teamproject.StudentCommunity.mapper.MemberDAO;
import com.teamproject.StudentCommunity.mapper.PostDAO;
import com.teamproject.StudentCommunity.mapper.SuspendedHistoryDAO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SuspendedHistoryService {
	
	private final SuspendedHistoryDAO suspendedHistoryDAO;
	private final MemberDAO memberDAO;
	private final PostDAO postDAO;
	
	public List<SuspendedHistoryDTO> getEndOn(){
		return suspendedHistoryDAO.getEndOn();
	}
	
	@Transactional
	public void setSuspendDate(SuspendedHistoryDTO suspendedHistoryDTO) {
		memberDAO.changeDeActive(suspendedHistoryDTO.getMemberId());
		suspendedHistoryDAO.setSuspendDate(suspendedHistoryDTO);
	}
	
//	public List<PostMemberDTO> getSuspendList(){
//		return suspendedHistoryDAO.getSuspendList();
//	}
	public void deleteHistory(Long memberId){
		suspendedHistoryDAO.deleteHistory(memberId);
	}

	public SuspendedHistoryDTO getSuspendedInfoByID(Long id) {
		return suspendedHistoryDAO.getSuspendedInfoByID(id);
	}

	public List<PostMemberDTO> autoSearch(){
		return suspendedHistoryDAO.autoSearch();
	}

	public List<PostMemberDTO> autoSearchMember(){
		return suspendedHistoryDAO.autoSearchMember();
	}
}
