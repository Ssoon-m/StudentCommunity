package com.teamproject.StudentCommunity.PagingService;

import com.teamproject.StudentCommunity.dto.*;
import com.teamproject.StudentCommunity.dto.reply.ReplyBoardMemberDTO;

import java.util.List;

public interface ReplypService {

    default public List<ReplyBoardMemberDTO> Pagingflow(PageDTO pageDTO){
        RecordTotalCount(pageDTO);
        List<ReplyBoardMemberDTO> test = PageList(pageDTO);
        return test;
    }

    public void RecordTotalCount(PageDTO pageDTO);

    public List<ReplyBoardMemberDTO> PageList(PageDTO pageDTO);


}
