package com.teamproject.StudentCommunity.controller;


import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.post.NewPost;
import com.teamproject.StudentCommunity.dto.post.Post;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import com.teamproject.StudentCommunity.dto.post.UpdatePost;
import com.teamproject.StudentCommunity.service.BoardService;
import com.teamproject.StudentCommunity.service.MemberService;
import com.teamproject.StudentCommunity.service.PostService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.converter.json.GsonBuilderUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class PostController {

    private final PostService postService;
    private final BoardService boardService;
    private final MemberService memberService;

    @Resource(name = "loginMemberDTO")
    @Lazy
    private MemberDTO loginMemberDTO;


    @PatchMapping("/post/{postId}.do")//UPDATE METHOD
    @ResponseBody
    public int updatePost(@RequestBody UpdatePost updatePost,@PathVariable Long postId){
        updatePost.setUpdatedAt(LocalDateTime.now());
        updatePost.setPostId(postId);
        return postService.updatePost(updatePost);
    }

    @DeleteMapping("/post/{postId}.do")
    @ResponseBody
    public int deletePost(@PathVariable Long postId){
        log.info("Post:{} 삭제 요청",postId);

        //멤버 아이디는 session값 으로 진행 할것임
        return postService.deletePost(postId,loginMemberDTO.getId());
    }

    @GetMapping("/post/{postId}")
    @ResponseBody
    public Post postPage(@PathVariable Long postId){
        Post post = postService.getPost(postId);
        postService.viewPlusById(postId);
        return post;
    }


    //현제 게시글이 몇 페이지에 있는 게시글인지 계산..
    //페이지 못찾으면 -1;
    @GetMapping("/post/{postId}/pageNo")
    @ResponseBody
    public int getPage(@PathVariable Long postId){
        int result = postService.getPostPage(postId);

        return result;
    }

    //게시글 상세보기
    @GetMapping("/board/{boardId}/post/{postId}")
    public String postPage(@PathVariable Long postId,@PathVariable Long boardId,
                           Model model){
        Post post = postService.getPost(postId);

        // 글쓴 멤버의 이메일을 가져오기!! 웹 소켓 알람을 위해서
        Post member = postService.findById(postId);
        Long memberId = member.getMemberId();
        MemberDTO memberDTO = memberService.findUserInfoById(memberId);
        // 여기까지

        model.addAttribute("memberDTO",memberDTO);
        model.addAttribute("post",post);
        model.addAttribute("board",boardService.findById(boardId));
        return "post/viewPost";
    }


    //게시판 글쓰기
    @GetMapping("/board/{boardId}/post/new_post")
    public String newPost(Model model,@PathVariable Long boardId){
        model.addAttribute("board",boardService.findById(boardId));
        return "post/newPost";
    }
    

    @PostMapping("board/{boardId}/post/new_post.do")
    @ResponseBody
    public Long newPostDo(@RequestBody NewPost newPost, @PathVariable Long boardId){
        newPost.setBoardId(boardId);
        newPost.setMemberId(loginMemberDTO.getId());
        postService.newPost(newPost);
        log.info("글 등록 {}",newPost.toString());
        return newPost.getId();//입력된 id값 return
    }











}
