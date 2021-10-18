package com.teamproject.StudentCommunity.PagingService;

import org.springframework.stereotype.Service;

import com.teamproject.StudentCommunity.dto.PageDTO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class PagingFactoryService {
	
	private final BoardPagingService boardPagingService;
	private final MemberPagingService memberPagingService;

	public PagingService PagingFactoryMethod(PageDTO pageDTO) {
		final PagingService pagingService;
		if (pageDTO.getShowType() == 1) {
			pagingService = boardPagingService;
		} else if (pageDTO.getShowType() == 2) {
			pagingService = memberPagingService;
		} else {
			throw new IllegalArgumentException();
		}

		return pagingService;
	}
	
}
