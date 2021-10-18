package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.postDetail.PostDetail;
import com.teamproject.StudentCommunity.dto.reply.*;
import com.teamproject.StudentCommunity.dto.replyDetail.ReplyDetailDTO;
import com.teamproject.StudentCommunity.mapper.ReplyDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class ReplyServiceImpl implements ReplyService{

    private final ReplyDAO replyDao;

    @Override
    public List<ReplyDTO> getByReplyPaging(ReplyPagingDTO replyPagingDTO) {
        return replyDao.findByReplyPaging(replyPagingDTO);
    }

    @Override
    public int getCountByPostId(Long postId) {
        return replyDao.countByPostId(postId);
    }

    @Override
    public ReplyDTO getById(Long id) {
        return replyDao.findById(id);
    }

    @Override
    public int updateReply(ReplyUpdateDTO replyUpdateDTO) {
        //확인 멤버 확인 로직 추가
        return replyDao.updateReply(replyUpdateDTO);
    }

    @Override
    public int newReply(NewReply newReply) {
        return replyDao.newReply(newReply);
    }

    @Override
    public int deleteReply(Long id) {
        ReplyDTO replyDTO = replyDao.findById(id);
        log.info(replyDTO.toString());
        
        List<ReplyDTO> replyList = replyDao.findByParentId(id);//이 댓글 id기반으로 대댓글이 있는지 찾는다.

        if(replyDTO.getParent()!=null||replyList.size()==0){//대댓글이 없거나 대댓글이라면 바로 삭제
            replyDao.deleteReply(id);
            return 1;//삭제 성공

        }
        else {//그게 아니라면 status 만 변경
            replyDTO.setStatus(ReplyStatus.DELETED);
            replyDao.deleteReplyStatus(replyDTO);
            return -1;//상태 변경 성공
        }

    }

    @Override
    public int deleteReplyAdmin(Long id) {
        ReplyDTO replyDTO = replyDao.findById(id);
        log.info(replyDTO.toString());

        List<ReplyDTO> replyList = replyDao.findByParentId(id);//이 댓글 id기반으로 대댓글이 있는지 찾는다.

        if(replyDTO.getParent()!=null||replyList.size()==0){//대댓글이 없거나 대댓글이라면 바로 삭제
            replyDao.deleteReply(id);
            return 1;//삭제 성공
        }
        else {//그게 아니라면 status 만 변경
            replyDTO.setStatus(ReplyStatus.DELETED_ADMIN);
            replyDao.deleteReplyStatus(replyDTO);
            return -1;//상태 변경 성공
        }
    }


    @Override
    public int GoodReportCal(ReplyDetailDTO replyDetailDTO, int num) {
        //받아온 num 값으로
        //마이너스 인지 플러스 인지 체크
        if(num==1){
            log.info("플러스 실행");
            replyDao.goodReportPlus(replyDetailDTO);
            return num;
        }
        else {
            replyDao.goodReportMinus(replyDetailDTO);
            return num;
        }

    }
    
    @Override
    public void readableSettingByPostID(Long post_id) {
    	replyDao.readableSettingByPostID(post_id);
    }
    
    @Override
    public void readableSettingByMemberID(Long member_id) {
    	replyDao.readableSettingByMemberID(member_id);
    }

    @Override
    public void readableSettingByReplyID(Long reply_id){
    	replyDao.readableSettingByReplyID(reply_id);
    }
    
    @Override
    public void readableSettingByMemberIDtoReply(Long member_id) {
    	replyDao.readableSettingByMemberIDtoReply(member_id);
    }
    
    @Override
    public int getReplyMessageCount(Long member_id) {
    	return replyDao.getReplyMessageCount(member_id);
    }
    
    @Override
    public int getReReplyMessageCount(Long member_id) {
    	return replyDao.getReReplyMessageCount(member_id);
    }
    
    @Override
	public List<ReplyPostDTO> getMyPostNewReplyList(ReplyPagingDTO replyPagingDTO) {
    	return replyDao.getMyPostNewReplyList(replyPagingDTO);
    }
    
    @Override
    public List<ReReplyPostDTO> getMyReplyNewReReplyList(ReplyPagingDTO replyPagingDTO){
    	return replyDao.getMyReplyNewReReplyList(replyPagingDTO);
    }

    @Override
    public List<ReplyBoardMemberDTO> replyList(PageDTO pageDTO){
        return replyDao.replyList(pageDTO);
    }

    @Override
    public int replyListCount(PageDTO pageDTO){
        return replyDao.replyListCount(pageDTO);
    }

    @Override
    public List<ReplyBoardMemberDTO> getAllContentEmail(){
        return replyDao.getAllContentEmail();
    }
}
