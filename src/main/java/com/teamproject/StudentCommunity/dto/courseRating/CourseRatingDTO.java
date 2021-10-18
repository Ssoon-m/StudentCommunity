package com.teamproject.StudentCommunity.dto.courseRating;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class CourseRatingDTO {


		private Long id;

    private float rating;
    private String comment;
    @JsonFormat(pattern = "yy-MM-dd kk:mm")
    private LocalDateTime createdAt;
    private Long memberId;
    private Long courseId;
    private Long universityId;
    private String categoryName;
    private String courseName;
    private String email;
    private Long courseList;

    private List<CourseRatingDTO> ratingList;






    private String name;


}

