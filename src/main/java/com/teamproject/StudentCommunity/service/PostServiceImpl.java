package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.post.*;
import com.teamproject.StudentCommunity.dto.postDetail.PostDetail;
import com.teamproject.StudentCommunity.mapper.PostDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class PostServiceImpl implements PostService{
    private final PostDAO postDAO;
    
	@Override
	public List<Post> findAll() {
		return postDAO.findAll();
	}

	@Override
    public Post findById(Long id){
	    return postDAO.findById(id);
    }

    @Override
    public List<Post> getByBoardId(Long boardId) {
        return postDAO.findByBoardId(boardId);
    }

    @Override
    public List<PostMemberDTO> getByMemberId(PostMemberSearchDTO postMemberSearchDTO) {
        return postDAO.findByMemberId(postMemberSearchDTO);
    }

    @Override
    public List<PostMemberDTO> getPopularPosts(Long universityId) {
        return postDAO.findPopularPosts(universityId);
    }


    @Override
    public List<PostMemberDTO> getByPostSearch(PostSearch postSearch) {
        return postDAO.findByPostSearch(postSearch);
    }

    @Override
    public int getTotalByPostSearch(PostSearch postSearch) {
        return postDAO.countByPostSearch(postSearch);
    }

    @Override
    public Post getPost(Long id) {
        return postDAO.findById(id);
    }

    @Override
    public int getCountMemberPost(Long memberId) {
        return postDAO.countByMemberId(memberId);
    }

    @Override
    public int getPostPage(Long postId) {
        Post post = postDAO.findById(postId);
        Long boardId = post.getBoardId();
        List<Post> postList= postDAO.findByBoardId(boardId);
        for(int i = 0;i<postList.size();i++){
            if(post.getId().equals(postList.get(i).getId())) {

                log.info("{}",i);
                return i+1;
            }
        }
        return -1;//그사이에 없어진
    }

    @Override
    public int updatePost(UpdatePost updatePost) {
        return postDAO.updatePost(updatePost);
    }

    @Override
    public int newPost(NewPost newPost) {
        //memberId 셋 해줘야해
        newPost.setCreatedAt(LocalDateTime.now());
        log.info(newPost.toString());
        return postDAO.newPost(newPost);
    }

    @Override
    public int deletePost(Long postId,Long memberId) {
        //검증 로직인데 postDetail Reply 들은 전부다 delete On cascade이니까 굳이 신경 쓸 필요 없고.

        //원래는 세션에서 받아온 파라미터 값이여야 하는데 그냥 1로

        //만약 dao에서 받아온 값 중에 memberId 가 같지 않으면 return -1을 줄까
        Post post = postDAO.findById(postId);
        if(memberId.equals(post.getMemberId())){
            return postDAO.deletePost(postId);
        }


        return -1;

    }
    
    @Override
    public void deleteList(Long postId) {
    	postDAO.deleteList(postId);
    }
    
    @Override
	public void deleteDeActiveMember(Long memberId) {
		postDAO.deleteDeActiveMember(memberId);
	}

    @Override
    public int GoodReportCal(PostDetail postDetail,int num) {
        //받아온 num 값으로
        //마이너스 인지 플러스 인지 체크
        if(num==1){
            log.info("플러스 실행");
            postDAO.goodReportPlus(postDetail);
            return num;
        }
        else {
            postDAO.goodReportMinus(postDetail);
            return num;
        }
    }

    @Override
    public int viewPlusById(Long id) {
        return postDAO.viewsPlusById(id);
    }

    @Override
    public int getGoodReport(PostDetail postDetail) {
        return postDAO.countGoodReport(postDetail);
    }

    @Override
    public List<PostMemberDTO> getMyPostList(Long member_id){
    	return postDAO.getMyPostList(member_id);
    }
    
    @Override
    public List<PostMemberDTO> getMyReplyPostList(Long member_id){
    	return postDAO.getMyReplyPostList(member_id);
    }

}
