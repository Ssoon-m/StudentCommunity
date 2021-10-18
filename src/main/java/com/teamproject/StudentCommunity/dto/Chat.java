package com.teamproject.StudentCommunity.dto;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
public class Chat implements Serializable{
    private int no;
    private String memberId;
    private int srNo;
    private String chatContent;
    private Date sendDate;

    private String vaildYN;
}

