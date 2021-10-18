package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.board.BoardCategoryDto;
import com.teamproject.StudentCommunity.dto.board.BoardDto;
import com.teamproject.StudentCommunity.mapper.BoardDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
@Transactional
@Slf4j
public class BoardServiceImpl implements BoardService{

    private final BoardDAO boardDAO;

    @Override
    public List<BoardDto> findByUniversityId(Long universityId) {
        return boardDAO.findByUniversityId(universityId);
    }

    @Override
    public List<BoardCategoryDto> findWithCategoryByUniversityId(Long universityId) {
        return boardDAO.findWithCategoryByUniversityId(universityId);
    }

    @Override
    public List<BoardCategoryDto> findPopularBoard(Long universityId) {
        return boardDAO.findPopularBoard(universityId);
    }

    @Override
    public List<BoardDto> findAll() {
        return boardDAO.findAll();
    }

    @Override
    public BoardDto findById(Long id) {
        return boardDAO.findById(id);
    }

    @Override
    public void insertBoard(BoardDto boardDto){
        boardDAO.insertBoard(boardDto);
    }
}
