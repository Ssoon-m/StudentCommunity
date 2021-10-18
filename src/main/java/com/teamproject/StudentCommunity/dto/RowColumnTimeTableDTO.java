package com.teamproject.StudentCommunity.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class RowColumnTimeTableDTO {
	private Long id;
	private String rowColumn;
	private Long subjectId;
}
