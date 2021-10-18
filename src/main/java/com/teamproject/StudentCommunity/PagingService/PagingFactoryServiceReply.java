package com.teamproject.StudentCommunity.PagingService;

import com.teamproject.StudentCommunity.dto.PageDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PagingFactoryServiceReply {

    private final ReplyPagingSerivce replyPagingSerivce;

    public ReplypService PagingFactoryMethod(PageDTO pageDTO) {
        final ReplypService replyService;
        if (pageDTO.getShowType() == 1) {
            replyService = replyPagingSerivce;
        }
        else {
            throw new IllegalArgumentException();
        }

        return replyService;
    }
}
