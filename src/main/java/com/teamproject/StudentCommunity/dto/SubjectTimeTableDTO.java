package com.teamproject.StudentCommunity.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SubjectTimeTableDTO {
	private Long id;
	private Long timeTableId;
	private String subjectName;
	private String color;
	private Long courseId;
}
