package com.teamproject.StudentCommunity.controller;


import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.reply.ReplyDTO;
import com.teamproject.StudentCommunity.dto.replyDetail.ReplyDetailDTO;
import com.teamproject.StudentCommunity.service.ReplyDetailService;
import com.teamproject.StudentCommunity.service.ReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/reply/{replyId}")
@RequiredArgsConstructor
@Slf4j
public class ReplyDetailController {

    private final ReplyDetailService replyDetailService;
    private final ReplyService replyService;

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
    public int likeProc(@PathVariable Long replyId,
                        @RequestBody ReplyDetailDTO replyDetailDTO) {

        replyDetailDTO.setMemberId(loginMemberDTO.getId());//여기는 세션으로
        replyDetailDTO.setReplyId(replyId);

        int result = replyDetailService.goodReport(replyDetailDTO);

        //조아요 성공하면, reply 테이블에 +1
        if (result == 1) {
            replyService.GoodReportCal(replyDetailDTO,1);
            log.info("1");
            return 1;
        }

        //조아요 이미 눌렀으면 reply 테이블에-1
        else if (result == -1) {
            replyService.GoodReportCal(replyDetailDTO,-1);
            return -1;
        }

        else //둘다 누른 케이스
            return 0;

    }

    @GetMapping("/like")
    public ReplyDTO getLike(@RequestParam Long replyId) {
        log.info(replyId.toString());

        return replyService.getById(replyId);
    }


//    @GetMapping("/count.do")
//    public int getGoodReportNum(@ModelAttribute PostDetail postDetail){
//        return postService.getGoodReport(postDetail);
//    }



}
