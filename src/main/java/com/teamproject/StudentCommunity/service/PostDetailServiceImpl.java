package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import com.teamproject.StudentCommunity.dto.post.PostMemberSearchDTO;
import com.teamproject.StudentCommunity.dto.postDetail.PostDetail;
import com.teamproject.StudentCommunity.mapper.PostDetailDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
@Slf4j
@RequiredArgsConstructor
public class PostDetailServiceImpl implements PostDetailService{

    private final PostDetailDAO postDetailDAO;

    @Override
    public int goodReport(PostDetail postDetail) {
        //1.PostDetail 똑같은 postId memberId 쓰는 사람이 있는지.
        Optional<PostDetail> postDetailChk =
                postDetailDAO.findByMemberPostId(postDetail.getMemberId(), postDetail.getPostId());
        log.info(postDetail.toString());

        if(!postDetailChk.isPresent()){
            log.info("기존 테이터 없음");
            postDetail.setCreatedAt(LocalDateTime.now());//db저장 시간
            return postDetailDAO.insertPostDetail(postDetail);
        }

        //두게의 status 가 같으면 기존 데이터 삭제
        else if(postDetailChk.get().getStatus() == postDetail.getStatus()){ 
            log.info("기존 데이터 있음");
            postDetailDAO.deleteById(postDetailChk.get().getId());
            return -1;
        }

        else {//만약에 신고 좋아요 둘다 누르려 한다면
            return 0;
        }

    }

    @Override
    public int getCountGoodPost(Long memberId) {

        return postDetailDAO.countGoodPost(memberId);
    }


    @Override
    public List<PostMemberDTO> getGoodPost(PostMemberSearchDTO postMemberSearchDTO) {
        return postDetailDAO.findGoodPost(postMemberSearchDTO);
    }



}
