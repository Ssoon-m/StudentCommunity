package com.teamproject.StudentCommunity.PagingService;

import org.springframework.stereotype.Service;

import com.teamproject.StudentCommunity.dto.PageDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PagingFactoryServiceRating {
  private final RatingPagingSerivce ratingPagingSerivce;

  public RatingService PagingFactoryMethod(PageDTO pageDTO) {
      final RatingService ratingService;
      if (pageDTO.getShowType() == 1) {
      	ratingService = ratingPagingSerivce;
      }
      else {
          throw new IllegalArgumentException();
      }

      return ratingService;
  }
}
