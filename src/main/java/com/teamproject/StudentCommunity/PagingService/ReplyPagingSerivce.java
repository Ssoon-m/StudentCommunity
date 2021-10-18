package com.teamproject.StudentCommunity.PagingService;

import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.reply.ReplyBoardMemberDTO;
import com.teamproject.StudentCommunity.mapper.ReplyDAO;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ReplyPagingSerivce implements ReplypService {

    private final ReplyDAO replyDAO;

    @Override
    public void RecordTotalCount(PageDTO pageDTO) {
        pageDTO.setTotalCount(replyDAO.replyListCount(pageDTO));
        System.out.println("pageDTO.getTotalCount() : " + pageDTO.getTotalCount());
    }

    @Override
    public List<ReplyBoardMemberDTO> PageList(PageDTO pageDTO) {
        PageCalculator pageCalculator = new PageCalculator(pageDTO);
        pageCalculator.calculation(pageDTO);

        List<ReplyBoardMemberDTO> reply = replyDAO.replyList(pageDTO);
        System.out.println("reply = " + reply);

        return reply;
    }


}