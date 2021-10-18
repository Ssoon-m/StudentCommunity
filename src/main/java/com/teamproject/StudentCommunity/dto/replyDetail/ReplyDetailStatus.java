package com.teamproject.StudentCommunity.dto.replyDetail;

import com.fasterxml.jackson.annotation.JsonFormat;


@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum ReplyDetailStatus {
    REPORT
    ,GOOD;

}
