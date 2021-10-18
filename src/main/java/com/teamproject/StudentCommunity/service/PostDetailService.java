package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import com.teamproject.StudentCommunity.dto.post.PostMemberSearchDTO;
import com.teamproject.StudentCommunity.dto.postDetail.PostDetail;

import java.util.List;

public interface PostDetailService {

    int goodReport(PostDetail postDetail);
    int getCountGoodPost(Long memberId);
    List<PostMemberDTO> getGoodPost(PostMemberSearchDTO postMemberSearchDTO);


}
