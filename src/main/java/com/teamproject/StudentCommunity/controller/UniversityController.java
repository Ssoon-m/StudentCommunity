package com.teamproject.StudentCommunity.controller;


import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.University.UniversityDTO;
import com.teamproject.StudentCommunity.dto.board.BoardCategoryDto;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import com.teamproject.StudentCommunity.dto.post.PostSearch;
import com.teamproject.StudentCommunity.service.BoardService;
import com.teamproject.StudentCommunity.service.CourseRatingService;
import com.teamproject.StudentCommunity.service.PostService;
import com.teamproject.StudentCommunity.service.UniversityService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@RequiredArgsConstructor
@RequestMapping("/university")
@Slf4j
@Controller
public class UniversityController {

    private final BoardService boardService;
    private final PostService postService;
    private final UniversityService universityService;
    private final CourseRatingService courseRatingService;

    @Resource(name = "loginMemberDTO")
    @Lazy
    private MemberDTO loginMemberDTO;


    @GetMapping("/{universityId}")
    public String movehome(HttpSession session,@PathVariable Long universityId,
                           Model model) {

        PostSearch postSearch = new PostSearch();
        postSearch.setLimit(5);
        List<PostMemberDTO> postList = new ArrayList<>();
        List<BoardCategoryDto> popularBoard = boardService.findPopularBoard(universityId);

        // 쿼리를 통해 순서가 정해진 레코드를 순서대로 add함. (게시판 6개를 가져옴)
        for(BoardCategoryDto b : popularBoard) {
            postSearch.setBoardId(b.getId()); // 카테고리 아이디 set
            postList.addAll(postService.getByPostSearch(postSearch)); // 카테고리 id로 해당 게시판 찾기
        }
        System.out.println("postList : sdfdsfdsfdsfdsfdsf : " + postList);

        // [PostMemberDTO(id=578, title=ㅎㅎ, content=<p>ㅎㅎㅎㅎㅎ</p>, good=3, report=1, views=0, email=null, status=null, anonymous=TRUE, postMemberList=null, createdAt=2021-06-07T10:16:37, updatedAt=null, name=짱구에요, categoryName=null, totalReply=0, memberId=152, boardId=42, universityId=null),
        // PostMemberDTO(id=577, title=ㅎㅎ, content=<p>ㅎㅎㅎㅎㅎ</p>, good=0, report=0, views=0, email=null, status=null, anonymous=TRUE, postMemberList=null, createdAt=2021-06-07T10:16:36, updatedAt=null, name=짱구에요, categoryName=null, totalReply=0, memberId=152, boardId=42, universityId=null),
        model.addAttribute("popularBoard",popularBoard);    // 제일 최근 글을 쓴 게시판 6개 가져오기
        model.addAttribute("postList",postList);            // 카테고리에 해당하는 게시글이 저장되어 있는 list
        model.addAttribute("today", LocalDateTime.now());
        model.addAttribute("popular",postService.getPopularPosts(universityId)); // 인기 게시글

        // topmenu를 위한 것들
        List<BoardCategoryDto> boardList = boardService.findWithCategoryByUniversityId(universityId);//session
        session.removeAttribute("universityName");
        session.setAttribute("universityName",universityService.getUniversityNameByID(universityId));
        log.info(universityService.getUniversityNameByID(universityId));
        session.removeAttribute("boardList");
        session.setAttribute("boardList",boardList);
        loginMemberDTO.setBoardList(boardList);

        return "home";
    }

    @GetMapping("/uniAutoSearch")
    @ResponseBody
    public List<UniversityDTO> getAllUniName(){

    	return universityService.getAll();
    }



}
