package com.teamproject.StudentCommunity.dto.post;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.teamproject.StudentCommunity.dto.MemberStatus;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

//Post + MemberNickname;
@Data
public class PostMemberDTO {

    private Long id;
    private String title;
    private String content;
    private int good;
    private int report;
    private int views;
    private String email; // member email
    
    
    private MemberStatus status;
    
    private AnonymousStatus anonymous;
    private List<PostMemberDTO> postMemberList;

    @JsonFormat(pattern = "yy-MM-dd kk:mm")
    private LocalDateTime createdAt;
    @JsonFormat(pattern = "yy-MM-dd kk:mm")
    private LocalDateTime updatedAt;

    private String name;// nickname 추가
    private String categoryName;//추가
    private int totalReply;//댓글수


    private Long memberId;
    private Long boardId;
    private Long universityId;

}
