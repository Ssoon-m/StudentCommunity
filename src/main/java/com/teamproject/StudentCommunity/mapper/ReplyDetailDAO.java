package com.teamproject.StudentCommunity.mapper;

import com.teamproject.StudentCommunity.dto.replyDetail.ReplyDetailDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Optional;

@Mapper
public interface ReplyDetailDAO {

    Optional<ReplyDetailDTO> findByMemberReplyId(ReplyDetailDTO replyDetailDTO);

    int insertReplyDetail(ReplyDetailDTO replyDetailDTO);

    int deleteById(Long id);

}
