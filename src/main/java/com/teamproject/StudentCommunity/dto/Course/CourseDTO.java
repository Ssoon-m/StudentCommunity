package com.teamproject.StudentCommunity.dto.Course;

import lombok.Data;

@Data
public class CourseDTO {
    private Long id;
    private String name;
    private int credit;
    private Long universityMajorId;
    private Long universityId;
    private float avgRating;
    private int totalCount;
    private String categoryName;


}
