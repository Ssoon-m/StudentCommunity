package com.teamproject.StudentCommunity.dto.post;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class UpdatePost {
    private String title;
    private String content;
    private LocalDateTime UpdatedAt;
    private AnonymousStatus anonymous;
    private Long postId;
}
