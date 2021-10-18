package com.teamproject.StudentCommunity.dto.reply;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ReReplyPostDTO {
	private long postId;
	private long replyId;
	private long reReplyId;
	private long boardId;
	private String title;
	private String reply;
	private String reReply;
	private String postCreatedAt;
	private String replyCreatedAt;
	private String reReplyCreatedAt;
	private long replyMemberId;
	private long reReplyMemberId;
}
