package com.teamproject.StudentCommunity.mapper;

import com.teamproject.StudentCommunity.dto.CategoryDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CategoryDAO {
    void insertCategory(CategoryDTO categoryDTO);
    void deleteCategory(Long id);
}
