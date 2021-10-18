package com.teamproject.StudentCommunity.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SuspendedHistoryDTO {
	
	private Long id;
	private String endOn;
	private String reason;
	private Long memberId;
	
}
