package com.teamproject.StudentCommunity.scheduler;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.teamproject.StudentCommunity.dto.SuspendedHistoryDTO;
import com.teamproject.StudentCommunity.service.MemberService;
import com.teamproject.StudentCommunity.service.SuspendedHistoryService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class statusSchedule {

	 private final SuspendedHistoryService suspendedHistoryService;
	 private final MemberService memberService;

	@Scheduled(cron = "0 0 0 * * *")
	public void TestScheduler() {

		SimpleDateFormat formatTime = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		List<SuspendedHistoryDTO> listSuspend = suspendedHistoryService.getEndOn();

		for(SuspendedHistoryDTO DTO : listSuspend) {
			// 디비안의 정지 날짜가 현재 날짜보다 작거나 같은경우
			if(DTO.getEndOn().compareTo(formatTime.format(date)) <= 0) {
				//System.out.println("DTO.getMemberId() = " + DTO.getMemberId());
				memberService.changeActive(DTO.getMemberId());
			}
		}


	}

}
