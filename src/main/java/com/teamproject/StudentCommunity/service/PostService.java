package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.post.*;
import com.teamproject.StudentCommunity.dto.postDetail.PostDetail;

import java.util.List;

public interface PostService {
	
	List<Post> findAll();

	Post findById(Long id);

    List<Post> getByBoardId(Long boardId);

    List<PostMemberDTO>getByMemberId(PostMemberSearchDTO postMemberSearchDTO);

    List<PostMemberDTO> getPopularPosts(Long universityId);

    List<PostMemberDTO> getByPostSearch(PostSearch postSearch);
    Post getPost(Long id);

    int getCountMemberPost(Long memberId);

    int getPostPage(Long postId);

    int getTotalByPostSearch(PostSearch postSearch);

    int updatePost(UpdatePost updatePost);

    int newPost(NewPost newPost);

    int deletePost(Long postId,Long memberId);
    
    void deleteList(Long postId);
    
    void deleteDeActiveMember(Long memberId);
    
    int GoodReportCal(PostDetail postDetail,int num);


    int viewPlusById(Long id);

    int getGoodReport(PostDetail postDetail);

    List<PostMemberDTO> getMyPostList(Long member_id);
    List<PostMemberDTO> getMyReplyPostList(Long member_id);

}
