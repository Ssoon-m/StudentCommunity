package com.teamproject.StudentCommunity.dto.board;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class BoardDto {
    private Long id;
    private Long universityId;
    private Long categoryId;

    private String categoryName;

}
