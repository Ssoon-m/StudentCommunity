package com.teamproject.StudentCommunity.dto.replyDetail;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ReplyDetailDTO {

    private Long id;
    private ReplyDetailStatus status;
    private LocalDateTime createdAt;
    private Long replyId;
    private Long memberId;


}
