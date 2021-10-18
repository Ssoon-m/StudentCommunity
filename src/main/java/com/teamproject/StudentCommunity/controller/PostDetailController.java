package com.teamproject.StudentCommunity.controller;

import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.postDetail.PostDetail;
import com.teamproject.StudentCommunity.service.PostDetailService;
import com.teamproject.StudentCommunity.service.PostService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

//좋아요, 싫어요 관리 컨트롤러
@RestController
@RequestMapping("post/{postId}")
@RequiredArgsConstructor
@Slf4j
public class PostDetailController {

    private final PostDetailService postDetailService;
    private final PostService postService;

    @Resource(name = "loginMemberDTO")
    @Lazy
    private MemberDTO loginMemberDTO;
    /*
     검증 순서
     1. .do로 입력 받은 정보
     2. service 로직에서 검사
     3. 처음  조아요 누르면 return +1
     4. 다시 누르면 return -1
     5. 다시 누르면 return +1 ...
     6. 조아를 누른 상태로 신고 누르거나 신고 누른 상태로 조아요 누르면 +1
    * */

    @PostMapping("/like.do")
    public int likeProc(@PathVariable Long postId,
                        @RequestBody PostDetail postDetail) {

        postDetail.setMemberId(loginMemberDTO.getId());//여기는 세션으로
        postDetail.setPostId(postId);



        int result = postDetailService.goodReport(postDetail);
        //조아요 성공하면, post 테이블에 +1
        if (result == 1) {
            postService.GoodReportCal(postDetail,1);
            return 1;
        }
        //조아요 이미 눌렀으면 post 테이블에-1
        else if (result == -1) {
            postService.GoodReportCal(postDetail,-1);
            return -1;
        }
        else //둘다 누른 케이스
            return 0;
    }


    @GetMapping("/count")
    public int getGoodReportNum(@ModelAttribute PostDetail postDetail){
        return postService.getGoodReport(postDetail);
    }

}
