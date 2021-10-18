package com.teamproject.StudentCommunity.dto.reply;

import com.teamproject.StudentCommunity.dto.post.AnonymousStatus;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class NewReply {

    private String content;

    private LocalDateTime createdAt;

    private AnonymousStatus anonymous;

    private Long parent;

    private Long memberId;
    private Long postId;

}
