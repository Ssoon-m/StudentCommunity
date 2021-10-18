
package com.teamproject.StudentCommunity.controller;

import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.teamproject.StudentCommunity.dto.Course.CourseDTO;
import com.teamproject.StudentCommunity.dto.MemberDTO;
import com.teamproject.StudentCommunity.service.CourseService;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.teamproject.StudentCommunity.dto.RowColumnTimeTableDTO;
import com.teamproject.StudentCommunity.dto.SubjectTimeTableDTO;
import com.teamproject.StudentCommunity.dto.TimeTableDTO;
import com.teamproject.StudentCommunity.service.TimeTableService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/function")
public class FunctionController {

	@Resource(name = "loginMemberDTO")
	@Lazy
	private MemberDTO loginMemberDTO;
	
	private TimeTableService timeTableService;
	private CourseService courseService;

	@GetMapping("/chatting")
	public String chatting(){ return "function/chatting"; }

	@GetMapping("/credit_calculator")
	public String creditCalculator() {
		return "function/credit_calculator";
	}

	@GetMapping("/timeTable")
	public String timeTable(Model model) {
		return "function/timeTable";
	}
	
	@GetMapping("/todayMenu")
	public String todayMenu(Model model) {
		return "function/todayMenu";
	}

	@RequestMapping(value="/getCourseName", produces = "application/json; charset=utf8")
	@ResponseBody
	public String getCourseName(@RequestParam("university_major_id") String university_major_id, HttpServletRequest request ){
		System.out.println("getCourseName function called");
		
		List<CourseDTO> courseNameList = new ArrayList<>();
		
		if(university_major_id.equals("1")) {//교양 리스트 리턴
			courseNameList = courseService.getNotMajorList(loginMemberDTO.getUniversityId());
		}else {//전공 리스트 리턴
			courseNameList = courseService.getMajorList(loginMemberDTO.getUniversityId());
		}

		JsonObject jsonObject = new JsonObject();
		JsonArray jsonArray = new JsonArray();
		
		for(CourseDTO course : courseNameList) {
			JsonObject jo = new JsonObject();
			jo.addProperty("name", course.getName());
			jo.addProperty("id", course.getId());
			jsonArray.add(jo);
		}
		
		jsonObject.add("courseNameList", jsonArray);
		jsonObject.addProperty("responseCode", "success");

		String data = jsonObject.toString();
		return data;
	}

	@RequestMapping(value="/viewTimeTable", produces = "application/json; charset=utf8")
	@ResponseBody
	public String viewTimeTable(@RequestParam("semester") String semester, HttpServletRequest request )  {
		//System.out.println("viewTimeTable function called");

		JsonObject jsonObject = new JsonObject();

		// 먼저 로그인한 아이디로 시간표 아이디 뽑아옴
		TimeTableDTO timeTableDTO = new TimeTableDTO();
		timeTableDTO.setSemester(semester);
		long timeTableID = timeTableService.getTimeTableID(timeTableDTO);

		// timeTableID를 이용해 과목 리스트를 뽑아옴
		List<SubjectTimeTableDTO> subjectList = timeTableService.getSubjectList(timeTableID);

		JsonArray jsonArray = new JsonArray();

		for(int i=0;i<subjectList.size();i++) {
			JsonObject jo = new JsonObject();
			jo.addProperty("subjectName", subjectList.get(i).getSubjectName());
			jo.addProperty("color", subjectList.get(i).getColor());

			JsonArray ja = new JsonArray();
			// subjectID를 이용해 rowColumn 리스트 뽑아옴
			List<String> rcList = timeTableService.getTimeList(subjectList.get(i).getId());
			for(int j=0;j<rcList.size();j++) {
				ja.add(rcList.get(j));
			}

			jo.add("timeList", ja);

			jsonArray.add(jo);
		}

		jsonObject.add("subjectList", jsonArray);
		jsonObject.addProperty("responseCode", "success");

		String data = jsonObject.toString();
		return data;
	}

	@RequestMapping(value="/saveTimeTable", produces = "application/json; charset=utf8")
	@ResponseBody
	public String saveTimeTable(@RequestBody Map<String,Object> map, HttpServletRequest request )  {

		System.out.println("semester : " + map.get("semester"));

		TimeTableDTO timeTableDTO = new TimeTableDTO();
		timeTableDTO.setSemester((String) map.get("semester"));
		Long timeTableID = timeTableService.getTimeTableID(timeTableDTO);

		if(Objects.isNull(timeTableID)) { //new timetable
			//timetable insert 후 id 뽑아옴
			System.out.println("new timetable");
			timeTableService.insertTimetable(timeTableDTO);
			timeTableID = timeTableDTO.getId();
		}else { //timetable update
			//timetable_id 로 된 subjectTable 싹 지움
			System.out.println("update timetable");
			timeTableService.deleteSubjectTableByTimeTableID(timeTableID);
		}

		SubjectTimeTableDTO subjectTimeTableDTO = new SubjectTimeTableDTO();
		RowColumnTimeTableDTO rowColumnTimeTableDTO = new RowColumnTimeTableDTO();

		@SuppressWarnings("unchecked")
		List<List<String>> subjectList = (List<List<String>>) map.get("subjectList");

		// {subjectName, color, [1_1, 1_2, ...], course_id}

		HashMap<String, List<String>> subjectMap = new HashMap<String, List<String>>();
		HashMap<String, List<String>> RCMap = new HashMap<String, List<String>>();

		for(List<String> list : subjectList) {
			//{subjectName, color, 1_1}
			if(subjectMap.containsKey(list.get(0))) { // 이미 넣어준 subjectName
				List<String> tempList = RCMap.get(list.get(0));
				tempList.add(list.get(2));
				RCMap.replace(list.get(0), tempList);
			}else { // 새로 해야함~_~
				List<String> tempList = new ArrayList<>();
				tempList.add(RGBToHex(list.get(1)));
				tempList.add(list.get(3));
				subjectMap.put(list.get(0), tempList);
				List<String> tl = new ArrayList<>();
				tl.add(list.get(2));
				RCMap.put(list.get(0), tl);
			}

		}

		subjectTimeTableDTO.setTimeTableId(timeTableID);
		System.out.println("subjectTimeTableDTO.getTimeTableId() = " + subjectTimeTableDTO.getTimeTableId());

		for(Map.Entry<String, List<String>> subject : subjectMap.entrySet()){

			String subjectName = subject.getKey();
			List<String> subjectInfo = subject.getValue();
			subjectTimeTableDTO.setSubjectName(subjectName);
			subjectTimeTableDTO.setColor(subjectInfo.get(0));
			subjectTimeTableDTO.setCourseId(Long.parseLong(subjectInfo.get(1)));
			timeTableService.insertSubjectTable(subjectTimeTableDTO);

			rowColumnTimeTableDTO.setSubjectId(subjectTimeTableDTO.getId());

			Iterator<String> rowCol = RCMap.get(subjectName).iterator();
			while(rowCol.hasNext()) {
				String str = rowCol.next();
				rowColumnTimeTableDTO.setRowColumn(str);
				timeTableService.insertRcTable(rowColumnTimeTableDTO);
			}
		}

		subjectMap.forEach((key, value) -> System.out.println("key: " + key + ", value: " + value));
		RCMap.forEach((key, value) -> System.out.println("key: " + key + ", value: " + value));

		return "data";
	}

	public String RGBToHex(String rgb) {
		String color = rgb;
		color = color.substring(4, color.length()-1);

		StringTokenizer st = new StringTokenizer(color, ",");

		String r = st.nextToken().trim();
		String g = st.nextToken().trim();
		String b = st.nextToken().trim();

		String hex = String. format("#%02X%02X%02X", Integer.parseInt(r), Integer.parseInt(g), Integer.parseInt(b));

		return hex;
	}

}
