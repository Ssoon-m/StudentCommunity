package com.teamproject.StudentCommunity.dto.post;

import lombok.Data;

@Data
public class PostSearch {

    private Long boardId;
    private Long memberId;

    private String select;
    private String input;

    private int block=1;
    private int limit=10;
    private int pageNo=1;
    private int startNo=0;
    private int pageSize = 5;//한 블락은 5페이지 씩


    private String order;

}
