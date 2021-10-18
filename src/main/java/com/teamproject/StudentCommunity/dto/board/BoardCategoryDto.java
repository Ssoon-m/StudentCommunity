package com.teamproject.StudentCommunity.dto.board;

import com.teamproject.StudentCommunity.dto.CategoryEnum;
import lombok.Data;

@Data
public class BoardCategoryDto {
    private Long id;
    private String name;
    private Long universityId;
    private Long categoryId;
    private CategoryEnum description;
    private int totalPost;
}
