package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.replyDetail.ReplyDetailDTO;
import com.teamproject.StudentCommunity.mapper.ReplyDetailDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.Optional;

@Service
@Transactional
@Slf4j
@RequiredArgsConstructor
public class ReplyDetailServiceImpl implements ReplyDetailService{

    private final ReplyDetailDAO replyDetailDAO;

    @Override
    public int goodReport(ReplyDetailDTO replyDetailDTO) {
        //1.ReplyDetail 똑같은 postId memberId 쓰는 사람이 있는지.
        Optional<ReplyDetailDTO> replyDetailChk =
                replyDetailDAO.findByMemberReplyId(replyDetailDTO);

        //2.기존 추천,신고 안눌렀으면 테이블에 추가
        if(!replyDetailChk.isPresent()){
            replyDetailDTO.setCreatedAt(LocalDateTime.now());
            return replyDetailDAO.insertReplyDetail(replyDetailDTO);
        }

        //3.두게의 status 가 같으면 기존 데이터 삭제
        else if(replyDetailChk.get().getStatus() == replyDetailDTO.getStatus()){
            replyDetailDAO.deleteById(replyDetailChk.get().getId());
            return -1;
        }
        //4.추천, 신고 둘다 누르려 하면
        else {
            return 0;
        }
    }
}
