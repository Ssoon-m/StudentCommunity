package com.teamproject.StudentCommunity.controller;

import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.post.UpdatePost;
import com.teamproject.StudentCommunity.dto.reply.NewReply;
import com.teamproject.StudentCommunity.dto.reply.ReplyDTO;
import com.teamproject.StudentCommunity.dto.reply.ReplyPagingDTO;
import com.teamproject.StudentCommunity.dto.reply.ReplyUpdateDTO;
import com.teamproject.StudentCommunity.service.ReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;


@Slf4j
@RequiredArgsConstructor
@RequestMapping("/post")
@Controller
public class ReplyController {

    private final ReplyService replyService;


    @Resource(name = "loginMemberDTO")
    @Lazy
    private MemberDTO loginMemberDTO;



    @GetMapping("/{postId}/reply")
    @ResponseBody
    public List<ReplyDTO> getByPostId(@ModelAttribute ReplyPagingDTO replyDto){
        log.info(replyDto.toString());
        replyDto.setStartNo((replyDto.getPageNo()-1)*replyDto.getLimit());
        return replyService.getByReplyPaging(replyDto);
    }

    //페이지 넘버 표시를 위한 전체 댓글 개수
    @GetMapping("/{postId}/reply_count")
    @ResponseBody
    public int getCountByPostId(@PathVariable Long postId){
        return replyService.getCountByPostId(postId);
    }


    @PostMapping("/{postId}/reply.do")
    @ResponseBody
    public int newReply(@RequestBody NewReply newReply, @PathVariable Long postId){
        log.info(newReply.toString());
        newReply.setCreatedAt(LocalDateTime.now());
        newReply.setPostId(postId);

        newReply.setMemberId(loginMemberDTO.getId());
        log.info(newReply.toString());

        return replyService.newReply(newReply);
    }

    //대댓글 없으면 delete, 대댓글 있으면 update(삭제된 댓글 입니다.)
    //대댓글은 그냥 삭제
    @DeleteMapping("/{postId}/reply/{replyId}.do")
    @ResponseBody
    public int deleteReply(@PathVariable Long replyId){
        log.info(replyId.toString());
        return replyService.deleteReply(replyId);
    }



    @PatchMapping("/{postId}/reply.do")
    @ResponseBody
    public int updateReply(@RequestBody ReplyUpdateDTO replyUpdateDTO){
        replyUpdateDTO.setUpdatedAt(LocalDateTime.now());
        log.info(replyUpdateDTO.toString());
        return replyService.updateReply(replyUpdateDTO);
    }


    @GetMapping("/replyReadableSetting")
    public String replyReadableSetting(@RequestParam("post_id")long post_id) throws Exception{

        if(post_id == 0) {
        	replyService.readableSettingByMemberID(loginMemberDTO.getId());
        }else {
        	replyService.readableSettingByPostID(post_id);
        }
        
        return "redirect:/member/myNote";
    }
    
    @GetMapping("/reReplyReadableSetting")
    public String reReplyReadableSetting(@RequestParam("reply_id")long reply_id) throws Exception{

    	if(reply_id == 0)
    		replyService.readableSettingByMemberIDtoReply(loginMemberDTO.getId());
    	else
    		replyService.readableSettingByReplyID(reply_id);
        
        return "redirect:/member/myNote";
    }
}
