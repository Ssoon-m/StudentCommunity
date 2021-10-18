package com.teamproject.StudentCommunity.dto.reply;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.teamproject.StudentCommunity.dto.MemberStatus;
import com.teamproject.StudentCommunity.dto.post.AnonymousStatus;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ReplyBoardMemberDTO {
    private Long id;
    private String content;
    private int good;
    private int report;
    private String email;
    @JsonFormat(pattern = "MM-dd kk:mm")
    private LocalDateTime createdAt;
    private MemberStatus status;
    private Long universityId;
    private Long categoryId;
    private Long parent;//댓글 계층 구조

    @Override
    public String toString() {
        return "ReplyBoardMemberDTO{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", good=" + good +
                ", report=" + report +
                ", createdAt=" + createdAt +
                ", status=" + status +
                ", universityId=" + universityId +
                ", categoryId=" + categoryId +
                ", parent=" + parent +
                '}';
    }
}
