package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.board.BoardCategoryDto;
import com.teamproject.StudentCommunity.dto.board.BoardDto;

import java.util.List;

public interface BoardService {


    List<BoardDto> findByUniversityId(Long universityId);
    List<BoardCategoryDto> findWithCategoryByUniversityId(Long universityId);
    List<BoardCategoryDto> findPopularBoard(Long universityId);
    List<BoardDto> findAll();
    BoardDto findById(Long id);
    void insertBoard(BoardDto boardDto);

}
