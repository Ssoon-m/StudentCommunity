package com.teamproject.StudentCommunity.dto.reply;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ReplyPostDTO {
	private String title;
	private long boardId; 
	private long postId;
	private String postCreatedAt;
	private String content;
	private String replyCreatedAt;
}
