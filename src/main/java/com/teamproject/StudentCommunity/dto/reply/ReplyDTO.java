package com.teamproject.StudentCommunity.dto.reply;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.teamproject.StudentCommunity.dto.post.AnonymousStatus;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ReplyDTO {
    private Long id;
    private Long memberId;

    private Long parentMemberId;

    private String content;
    private int good;
    private int report;

    private Long parent;//댓글 계층 구조
    private ReplyStatus status;//삭제 됐는지 아닌지
    private AnonymousStatus anonymous;//익명으로 댓글인지 아닌지


    @JsonFormat(pattern = "MM-dd kk:mm")
    private LocalDateTime createdAt;
    @JsonFormat(pattern = "MM-dd kk:mm")
    private LocalDateTime updatedAt;

    private String img;

    private String name;
    private Long postId;
    private String readable;
}
