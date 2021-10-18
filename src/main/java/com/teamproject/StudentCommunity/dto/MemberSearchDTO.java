package com.teamproject.StudentCommunity.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberSearchDTO {

    //private Long block=1L;
    private Long limit=10L;// 10개씩
    private Long pageNo=1L;
    private Long startNo;
    private Long pageSize = 5L;//한 블락은 5페이지 씩

}
