package com.teamproject.StudentCommunity.mapper;

import com.teamproject.StudentCommunity.dto.board.BoardCategoryDto;
import com.teamproject.StudentCommunity.dto.board.BoardDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BoardDAO {

    List<BoardDto> findByUniversityId(Long universityId);
    List<BoardDto> findAll();



    BoardDto findById(Long id);

    List<BoardCategoryDto> findWithCategoryByUniversityId(Long universityId);
    List<BoardCategoryDto> findPopularBoard(Long universityId);


    void insertBoard(BoardDto boardDto);

}
