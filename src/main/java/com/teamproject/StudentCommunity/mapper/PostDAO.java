package com.teamproject.StudentCommunity.mapper;

import com.teamproject.StudentCommunity.dto.post.*;
import com.teamproject.StudentCommunity.dto.postDetail.PostDetail;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface
PostDAO {

    List<Post> findAll();
    List<Post> findByBoardId(Long boardId);
    List<PostMemberDTO> findByPostSearch(PostSearch postSearch);

    List<PostMemberDTO> findPopularPosts(Long universityId);

    List<PostMemberDTO>findByMemberId(PostMemberSearchDTO postMemberSearchDTO);



    Post findById(Long id);

    int countByPostSearch(PostSearch postSearch);

    int countByMemberId(Long memberId);

    int goodReportMinus(PostDetail postDetail);
    int goodReportPlus(PostDetail postDetail);

    void deleteList(Long postId);
    
    int newPost(NewPost newPost);
    
    int updatePost(UpdatePost updatePost);
    
    int deletePost(Long postId);

    int countGoodReport(PostDetail postDetail);

    int viewsPlusById(Long id);
    
    
    void deleteDeActiveMember(Long memberId);

    List<PostMemberDTO> getMyPostList(Long member_id);
    List<PostMemberDTO> getMyReplyPostList(Long member_id);
}
