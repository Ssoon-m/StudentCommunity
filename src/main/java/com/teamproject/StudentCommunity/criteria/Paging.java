package com.teamproject.StudentCommunity.criteria;

import lombok.Getter;
import lombok.ToString;

@Getter
public class Paging {

    private int startPage;

    private int endPage;

    private boolean prev;
    private boolean next;

    private int lastPage;
    private int total;

    // 요청이 온 페이지의 페이지 번호와 게시글을 몇개씩 보고 싶은지
    private Criteria cri;

    public Paging(Criteria cri, int total){
        this.cri = cri;
        this.total = total; // 전체 게시글 수

        this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
        this.startPage = this.endPage - 9;

        int realEnd = (int)(Math.ceil((total*1.0)/cri.getAmount()));

        lastPage = realEnd;

        if(realEnd < this.endPage){
            this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }

    @Override
    public String toString() {
        return "Paging{" +
                "startPage=" + startPage +
                ", endPage=" + endPage +
                ", prev=" + prev +
                ", next=" + next +
                ", lastPage=" + lastPage +
                ", total=" + total +
                ", cri=" + cri +
                '}';
    }
}
