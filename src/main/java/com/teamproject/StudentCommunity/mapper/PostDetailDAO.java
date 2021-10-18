package com.teamproject.StudentCommunity.mapper;


import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import com.teamproject.StudentCommunity.dto.post.PostMemberSearchDTO;
import com.teamproject.StudentCommunity.dto.postDetail.PostDetail;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Optional;

@Mapper
public interface PostDetailDAO {

    Optional<PostDetail> findByMemberPostId(@Param("memberId") Long memberId, @Param("postId") Long postId);

    int insertPostDetail(PostDetail postDetail);

    List<PostMemberDTO> findGoodPost(PostMemberSearchDTO postMemberSearchDTO);

    int countGoodPost(Long memberId);

    int deleteById(Long id);



}
