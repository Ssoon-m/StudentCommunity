package com.teamproject.StudentCommunity.dto.post;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

@Data
public class NewPost {

    private Long id;
    private String title;
    private String content;

    private AnonymousStatus anonymous;


    @DateTimeFormat(pattern = "yyyy-MM-dd kk:mm:ss")
    private LocalDateTime createdAt;

    private Long memberId;
    private Long boardId;

}
