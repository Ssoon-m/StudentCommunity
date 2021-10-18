package com.teamproject.StudentCommunity.service;

import com.teamproject.StudentCommunity.dto.CategoryDTO;
import com.teamproject.StudentCommunity.mapper.CategoryDAO;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CategoryService {

    private final CategoryDAO categoryDAO;

    public void insertCategory(CategoryDTO categoryDTO){
        categoryDAO.insertCategory(categoryDTO);
    }
    public void deleteCategory(Long id){
        categoryDAO.deleteCategory(id);
    }


}
