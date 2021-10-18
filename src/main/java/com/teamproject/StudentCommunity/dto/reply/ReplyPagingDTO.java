package com.teamproject.StudentCommunity.dto.reply;

import lombok.Data;

@Data
public class ReplyPagingDTO {
    private Long limit=10L;
    private Long pageNo=1L;
    private Long startNo;

    private Long postId;
    private Long memberId;

}
