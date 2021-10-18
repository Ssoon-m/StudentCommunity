package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.reply.*;
import com.teamproject.StudentCommunity.dto.replyDetail.ReplyDetailDTO;

import java.util.List;

public interface ReplyService {
    List<ReplyDTO> getByReplyPaging(ReplyPagingDTO replyPagingDTO);

    int getCountByPostId(Long postId);

    ReplyDTO getById(Long id);

    int updateReply(ReplyUpdateDTO replyUpdateDTO);

    int newReply(NewReply newReply);

    int deleteReply(Long id);

    int GoodReportCal(ReplyDetailDTO replyDetailDTO, int num);
    
    void readableSettingByPostID(Long post_id);
    void readableSettingByMemberID(Long post_id);
    void readableSettingByReplyID(Long reply_id);
    void readableSettingByMemberIDtoReply(Long member_id);
    
    int getReplyMessageCount(Long member_id);
    int getReReplyMessageCount(Long member_id);
    
    List<ReplyPostDTO> getMyPostNewReplyList(ReplyPagingDTO replyPagingDTO);
    List<ReReplyPostDTO> getMyReplyNewReReplyList(ReplyPagingDTO replyPagingDTO);

    List<ReplyBoardMemberDTO> replyList(PageDTO pageDTO);
    int replyListCount(PageDTO pageDTO);
    public int deleteReplyAdmin(Long id);
    List<ReplyBoardMemberDTO> getAllContentEmail();
}
