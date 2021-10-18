package com.teamproject.StudentCommunity.PagingService;


import com.teamproject.StudentCommunity.PagingService.PageCalculator;
import com.teamproject.StudentCommunity.PagingService.PagingService;
import com.teamproject.StudentCommunity.dto.PageDTO;
import com.teamproject.StudentCommunity.dto.post.PostMemberDTO;
import com.teamproject.StudentCommunity.mapper.MemberDAO;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@AllArgsConstructor
public class MemberPagingService implements PagingService {

    private final MemberDAO memberDAO;

    @Override
    public void RecordTotalCount(PageDTO pageDTO) {
        pageDTO.setTotalCount(memberDAO.getTotalCountMember(pageDTO));
       
    }

    @Override
    public List<PostMemberDTO> PageList(PageDTO pageDTO) {

        PageCalculator pageCalculator = new PageCalculator(pageDTO);
        pageCalculator.calculation(pageDTO);

        List<PostMemberDTO> test = memberDAO.findAllMember(pageDTO);

        return test;
    }

	
}
