package com.teamproject.StudentCommunity.mapper;

import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.reply.*;
import com.teamproject.StudentCommunity.dto.replyDetail.ReplyDetailDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReplyDAO {

    List<ReplyDTO> findByReplyPaging(ReplyPagingDTO replyPagingDTO);

    ReplyDTO findById(Long id);

    int countByPostId(Long postId);


    int newReply(NewReply newReply);

    int goodReportMinus(ReplyDetailDTO replyDetailDTO);
    int goodReportPlus(ReplyDetailDTO replyDetailDTO);

    int updateReply(ReplyUpdateDTO replyUpdateDTO);


    List<ReplyDTO> findByParentId(Long parentId);

    int deleteReplyStatus(ReplyDTO replyDTO);

    int deleteReply(Long id);
    int deleteReplyAdmin(Long id);
    
    void readableSettingByPostID(Long post_id);
    void readableSettingByMemberID(Long member_id);
    void readableSettingByReplyID(Long reply_id);
    void readableSettingByMemberIDtoReply(Long member_id);
    
    int getReplyMessageCount(Long member_id);
    int getReReplyMessageCount(Long member_id);
    
    List<ReplyPostDTO> getMyPostNewReplyList(ReplyPagingDTO replyPagingDTO);
    List<ReReplyPostDTO> getMyReplyNewReReplyList(ReplyPagingDTO replyPagingDTO);
    
    List<ReplyBoardMemberDTO> replyList(PageDTO pageDTO);

    int replyListCount(PageDTO pageDTO);

    List<ReplyBoardMemberDTO> getAllContentEmail();
}
