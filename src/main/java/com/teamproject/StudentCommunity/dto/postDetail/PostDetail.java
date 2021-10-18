package com.teamproject.StudentCommunity.dto.postDetail;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
public class PostDetail {
    private Long id;
    private LocalDateTime createdAt;
    private PostDetailStatus status;
    private Long postId;
    private Long memberId;


}

