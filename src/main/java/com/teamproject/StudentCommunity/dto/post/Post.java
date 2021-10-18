package com.teamproject.StudentCommunity.dto.post;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Post {

    private Long id;
    private String title;
    private String content;
    private int good;
    private int report;
    private int views;

    private AnonymousStatus anonymous;

    private String name;
    private String img;

    @JsonFormat(pattern = "yy-MM-dd kk:mm")
    private LocalDateTime createdAt;
    @JsonFormat(pattern = "yy-MM-dd kk:mm")
    private LocalDateTime updatedAt;

    private Long memberId;
    private Long boardId;

}
