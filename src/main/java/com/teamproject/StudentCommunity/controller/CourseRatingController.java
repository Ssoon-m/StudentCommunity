package com.teamproject.StudentCommunity.controller;

import com.teamproject.StudentCommunity.dto.Course.CourseDTO;
import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.dto.courseRating.CourseRatingDTO;
import com.teamproject.StudentCommunity.dto.courseRating.CourseRatingPagingDTO;
import com.teamproject.StudentCommunity.service.CourseRatingService;
import com.teamproject.StudentCommunity.service.CourseService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/course-rating")
@Slf4j
public class CourseRatingController {

    @Resource(name = "loginMemberDTO")
    @Lazy
    private MemberDTO loginMemberDTO;

    private final CourseService courseService;
    private final CourseRatingService courseRatingService;

    @GetMapping
    public List<CourseDTO> getAllCourse(){
         return courseService.getByUniversityId(loginMemberDTO.getUniversityId());
    }

    @GetMapping("/{courseId}")
    public CourseDTO getCourse(@PathVariable Long courseId){
        return courseService.getById(courseId);
    }


    @GetMapping("/{courseId}/count")
    public int countCourseRating(@PathVariable Long courseId){
        return courseRatingService.countByCourseId(courseId);
    }
    @GetMapping("/{courseId}/member")
    public CourseRatingDTO getMemberCourseRating(@PathVariable Long courseId){
        Optional<CourseRatingDTO> courseRatingDTO = courseRatingService.getByMemberCourseId(loginMemberDTO.getId(),courseId);
        if(courseRatingDTO.isPresent()){
            return courseRatingDTO.get();
        }
        else {
            return new CourseRatingDTO();
        }
    }

    @GetMapping("/{courseId}/rating")
    public List<CourseRatingDTO> getCourseRating(@ModelAttribute CourseRatingPagingDTO courseDTO){
        courseDTO.setStartNo((courseDTO.getPageNo()-1)*courseDTO.getLimit());
        courseDTO.setMemberId(loginMemberDTO.getId());
        return courseRatingService.getByCourseId(courseDTO);
    }


    @GetMapping("/{courseId}/rating/{id}")
    public CourseRatingDTO courseRating(@PathVariable Long id){
        return courseRatingService.getById(id);
    }

    @DeleteMapping("/{courseId}/rating/{id}.do")
    public int deleteCourseRating(@PathVariable Long id){
        return courseRatingService.deleteById(id);
    }

    @PatchMapping("/{courseId}/rating/{id}.do")
    public int deleteCourseRating(@RequestBody CourseRatingDTO courseRatingDTO){
        return courseRatingService.updateCourseRating(courseRatingDTO);
    }


    @PostMapping("/{courseId}/rating.do")
    public int newCourseRating(@RequestBody CourseRatingDTO courseRatingDTO,@PathVariable Long courseId){
        courseRatingDTO.setCourseId(courseId);
        courseRatingDTO.setMemberId(loginMemberDTO.getId());
        courseRatingDTO.setCreatedAt(LocalDateTime.now());
        return courseRatingService.newCourseRating(courseRatingDTO);
    }


}
