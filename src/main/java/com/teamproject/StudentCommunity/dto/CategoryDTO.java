package com.teamproject.StudentCommunity.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CategoryDTO {
    private Long id;
    private String name;
    private CategoryEnum description;
}
