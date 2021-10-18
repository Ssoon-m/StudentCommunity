package com.teamproject.StudentCommunity.dto.postDetail;

import com.fasterxml.jackson.annotation.JsonFormat;


@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum PostDetailStatus {
    REPORT
    ,GOOD;

}
