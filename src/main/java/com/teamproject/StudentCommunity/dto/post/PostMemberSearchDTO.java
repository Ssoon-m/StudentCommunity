package com.teamproject.StudentCommunity.dto.post;

import lombok.Data;

@Data
public class PostMemberSearchDTO {
    private Long memberId;
    private Long block=1L;
    private Long limit=5L;//다섯개씩 출력
    private Long pageNo=1L;
    private Long startNo;
    private Long pageSize = 5L;//한 블락은 5페이지 씩
}
