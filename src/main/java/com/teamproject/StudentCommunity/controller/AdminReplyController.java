package com.teamproject.StudentCommunity.controller;

import com.teamproject.StudentCommunity.PagingService.PagingFactoryServiceReply;
import com.teamproject.StudentCommunity.PagingService.ReplypService;
import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.University.UniversityDTO;
import com.teamproject.StudentCommunity.dto.board.BoardCategoryDto;
import com.teamproject.StudentCommunity.dto.reply.ReplyBoardMemberDTO;
import com.teamproject.StudentCommunity.service.*;
import com.teamproject.StudentCommunity.service.ReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin")
public class AdminReplyController {

    private final PagingFactoryServiceReply pagingFactoryServiceReply;
    private final UniversityService universityService;
    private final BoardService boardService;
    private final ReplyService replyService;


    @GetMapping("/replyManagement")
    public String admin(PageDTO pageDTO, Model model, @RequestParam(value="page", defaultValue="1") int page){
        List<UniversityDTO> universityList =universityService.getAll();
        model.addAttribute("universityList",universityList);

        List<BoardCategoryDto> boardList = boardService.findWithCategoryByUniversityId(pageDTO.getSelectUniversity());
        model.addAttribute("boardList", boardList);
        // 현재 페이지 세팅
        pageDTO.setCurrentPage(page);
        // 팩토리 메서드 패턴을 이용해서 매개변수에 따른 객체 주입.
        ReplypService pagingService = pagingFactoryServiceReply.PagingFactoryMethod(pageDTO);
        log.info(pageDTO.toString());

        List<ReplyBoardMemberDTO> replyList = pagingService.Pagingflow(pageDTO);
        log.info(pageDTO.toString());

        model.addAttribute("replyList",replyList);
        model.addAttribute("pageDTO",pageDTO);

        return "admin/admin_reply";
    }

    @PostMapping("replyDelete")
    @ResponseBody
    public Object replyDelete(@RequestParam(value="id[]") List<Long> id ){
            for(Long Id : id) {
                int a = replyService.deleteReplyAdmin(Id);
            }
            Map<String, Object> retVal = new HashMap<String, Object>();
            retVal.put("code", "OK");
            retVal.put("message", "삭제에 성공 하였습니다.");
            return retVal;
    }

    @GetMapping("/autoContentEmail")
    @ResponseBody
    public List<ReplyBoardMemberDTO> auto() {
        return  replyService.getAllContentEmail();
    }




}

