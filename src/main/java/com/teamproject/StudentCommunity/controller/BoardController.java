package com.teamproject.StudentCommunity.controller;


import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.board.BoardDto;
import com.teamproject.StudentCommunity.dto.post.Post;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import com.teamproject.StudentCommunity.dto.post.PostSearch;
import com.teamproject.StudentCommunity.service.BoardService;
import com.teamproject.StudentCommunity.service.PostService;

import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RequestMapping( "/board")
@RequiredArgsConstructor
@Controller
@Slf4j
public class BoardController {

    private final PostService postService;
    private final BoardService boardService;


    @GetMapping("/{boardId}")
    private String getboard(@ModelAttribute PostSearch postSearch,
                         @PathVariable Long boardId,
                         Model model){


        postSearch.setStartNo((postSearch.getPageNo()-1)*postSearch.getLimit());

        //이부분 마이바티스는 조건 select 할때 select 제외한 total 값은 못가지나
        int totalPage = (int)Math.ceil(
                postService.getTotalByPostSearch(postSearch)*1f/postSearch.getLimit());
        int block = (postSearch.getPageNo()-1)/postSearch.getPageSize()+1;
        postSearch.setBlock(block);
        BoardDto boardDto = boardService.findById(boardId);

        List<PostMemberDTO> postList = postService.getByPostSearch(postSearch);
        model.addAttribute("board",boardDto);//게시판 정보
        model.addAttribute("postList",postList);// 실행 결과
        model.addAttribute("totalPage",totalPage);// totalPage
        model.addAttribute("postSearch",postSearch); // 그 전 검색값 저장!!

        return "board/board";
    }


}
