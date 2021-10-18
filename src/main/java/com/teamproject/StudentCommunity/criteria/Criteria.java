package com.teamproject.StudentCommunity.criteria;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.util.UriComponentsBuilder;

@Getter
@Setter
public class Criteria {
    private int pageNum; // 페이지
    private int amount;  // 한 페이지에 보여줄 게시글 수

    private String type;        // 검색 기준
    private String keyword;     // 검색어

    public Criteria() {
        this(1, 10);
    }

    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public String[] getTypeArr(){
        return type == null ? new String[] {} : type.split("");
    }

    public String getListLink(){
        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("").queryParam("pageNum",this.pageNum)
                .queryParam("amount", this.amount).queryParam("type",this.type).queryParam("keyword",this.keyword);
        return builder.toUriString();
    }

    @Override
    public String toString() {
        return "Criteria{" +
                "pageNum=" + pageNum +
                ", amount=" + amount +
                ", type='" + type + '\'' +
                ", keyword='" + keyword + '\'' +
                '}';
    }
}