package com.teamproject.StudentCommunity.dto.reply;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ReplyUpdateDTO {
    private Long id;
    private String content;
    private LocalDateTime updatedAt;

}
