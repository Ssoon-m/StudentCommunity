<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form"%>

<!-- 절대경로 설정   -->
<c:set var="path" value="${pageContext.request.contextPath}/" />

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>유니티</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="${path}resources/css_myPage/style.css">
    <style>
        table{
            border: 2px solid #d2d2d2;
            border-collapse: collapse;
            font-size: 0.9em;
        }
        th, td{
            border: 1px solid #d2d2d2;
            border-collapse: collapse;
        }
        th{
            height: 5px;
        }
        td {
            width: 75px;
            height: 60px;
        }
        .btn{
         color: white;
         background: #46cfa7;
         cursor:pointer;
         margin-bottom: 5px;
      }
      .btn:hover{
         background: #45be98;
         color: white;
      }
      
      .delete-btn{
         background: #cf5b46;
      }
      .delete-btn:hover{
         background: #c25b48;
         color: white;
      }
    </style>

</head>

<c:import url="/WEB-INF/views/include/head_meta.jsp" />
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<body style="background:linear-gradient(94deg,rgba(30, 161, 247,0.3), rgba(70, 207, 167, 0.3));"> 
<section class="ftco-section" style="font-family: Jua, sans-serif;">
    <div class="container">
        <div class="row justify-content-center" style="padding:20px">
            <div class="col-md-6 text-center mb-4"></div>
        </div>

        <h3 class="mb-4 text-center" style="font-weight: bold;">시간표</h3>
	    
	    <div style="float:right;">
	    	<select class="form-control rounded-left" id="semester" onchange="viewTimeTable(this.value);">
				<!-- 입학년도부터 나타나게 자동으로..  -->
				<option value="">선택</option>
				<option value="17-1" >2017년도 1학기</option>
				<option value="17-2" >2017년도 2학기</option>
				<option value="18-1" >2018년도 1학기</option>
				<option value="18-2" >2018년도 2학기</option>
				<option value="19-1" >2019년도 1학기</option>
				<option value="19-2" >2019년도 2학기</option>
				<option value="20-1" >2020년도 1학기</option>
				<option value="20-2" >2020년도 2학기</option>
				<option value="21-1" >2021년도 1학기</option>
			 </select><br>
	         <button class="btn" onClick="insertTimeTable()">과목추가</button><br>
	         <button class="btn delete-btn" onClick="deleteTimeTable()">과목삭제</button><br>
	    	 <button class="btn" onClick="saveTimeTable()">저장하기</button>
	    </div>

        <table id="tb" name="tb" width="800" height="800" style="color: #121212; padding:50px; text-align:center; width:80%; margin:auto; background-color:white">
            <tr>
                <th></th>
                <th>월</th>
                <th>화</th>
                <th>수</th>
                <th>목</th>
                <th>금</th>
            </tr>
            <tr>
                <td name="timeRowColumn" style="font-weight: bold;">09:00</td>

                <td name="timeRowColumn" id="1_1" ></td>
                <td name="timeRowColumn" id="1_2" ></td>
                <td name="timeRowColumn" id="1_3" ></td>
                <td name="timeRowColumn" id="1_4" ></td>
                <td name="timeRowColumn" id="1_5" ></td>
            </tr>
            <tr>
                <td name="timeRowColumn" style="font-weight: bold;">10:00</td>
                <td name="timeRowColumn" id="2_1" ></td>
                <td name="timeRowColumn" id="2_2" ></td>
                <td name="timeRowColumn" id="2_3" ></td>
                <td name="timeRowColumn" id="2_4" ></td>
                <td name="timeRowColumn" id="2_5" ></td>
            </tr>
            <tr>
                <td name="timeRowColumn" name="timeRowColumn" style="font-weight: bold;">11:00</td>
                <td name="timeRowColumn" id="3_1" ></td>
                <td name="timeRowColumn" id="3_2" ></td>
                <td name="timeRowColumn" id="3_3" ></td>
                <td name="timeRowColumn" id="3_4" ></td>
                <td name="timeRowColumn" id="3_5" ></td>
            </tr>
            <tr>
                <td name="timeRowColumn" style="font-weight: bold;">12:00</td>
                <td name="timeRowColumn" id="4_1" ></td>
                <td name="timeRowColumn" id="4_2" ></td>
                <td name="timeRowColumn" id="4_3" ></td>
                <td name="timeRowColumn" id="4_4" ></td>
                <td name="timeRowColumn" id="4_5" ></td>
            </tr>
            <tr>
                <td name="timeRowColumn" style="font-weight: bold;">13:00</td>
                <td name="timeRowColumn" id="5_1" ></td>
                <td name="timeRowColumn" id="5_2" ></td>
                <td name="timeRowColumn" id="5_3" ></td>
                <td name="timeRowColumn" id="5_4" ></td>
                <td name="timeRowColumn" id="5_5" ></td>
            </tr>
            <tr>
                <td name="timeRowColumn" style="font-weight: bold;">14:00</td>
                <td name="timeRowColumn" id="6_1" ></td>
                <td name="timeRowColumn" id="6_2" ></td>
                <td name="timeRowColumn" id="6_3" ></td>
                <td name="timeRowColumn" id="6_4" ></td>
                <td name="timeRowColumn" id="6_5" ></td>

            </tr>
            <tr>
                <td name="timeRowColumn" style="font-weight: bold;">15:00</td>
                <td name="timeRowColumn" id="7_1"></td>
                <td name="timeRowColumn" id="7_2"></td>
                <td name="timeRowColumn" id="7_3"></td>
                <td name="timeRowColumn" id="7_4"></td>
                <td name="timeRowColumn" id="7_5"></td>
            </tr>
            <tr>
                <td name="timeRowColumn" style="font-weight: bold;">16:00</td>
                <td name="timeRowColumn" id="8_1"></td>
                <td name="timeRowColumn" id="8_2"></td>
                <td name="timeRowColumn" id="8_3"></td>
                <td name="timeRowColumn" id="8_4"></td>
                <td name="timeRowColumn" id="8_5"></td>
            </tr>
            <tr>
                <td name="timeRowColumn" style="font-weight: bold;">17:00</td>
                <td name="timeRowColumn" id="9_1"></td>
                <td name="timeRowColumn" id="9_2"></td>
                <td name="timeRowColumn" id="9_3"></td>
                <td name="timeRowColumn" id="9_4"></td>
                <td name="timeRowColumn" id="9_5"></td>
            </tr>
            <tr>
                <td name="timeRowColumn" style="font-weight: bold;">18:00</td>
                <td name="timeRowColumn" id="10_1"></td>
                <td name="timeRowColumn" id="10_2"></td>
                <td name="timeRowColumn" id="10_3"></td>
                <td name="timeRowColumn" id="10_4"></td>
                <td name="timeRowColumn" id="10_5"></td>
            </tr>
        </table>
    </div>
</section>

<div id="SubjectModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
            	<h4 class="modal-title">과목 추가</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                	<select id="isMajor" class="isMajor" onchange="isMajor()">
                        <option value="" disabled selected> 선택 </option>
                        <option value="2"> 전공 </option>
                        <option value="1"> 교양 </option>
                    </select>
                    
                    <select id="courseId" name="timeSubject" class="timeSubject">
                    	<option value='' selected > -- 과목을 선택하세요 -- </option>
                    </select>					
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default Subject" data-dismiss="modal">등록</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>


<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
            	<h4 class="modal-title">과목 추가</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <table>
                    <thead>
                    <th style="width:30px;">시간 선택</th>
                    <th style="width:30px;">날짜 선택</th>
                    </thead>
                    <tbody id="timeTableBody">
                    	<tr>
                    		<td>
								<select id='time' name='time'>
		            				<option value='' selected > -- 시간을 선택하세요 --</option>
						          	<option value='1'>1교시</option>
						            <option value='2'>2교시</option>
						            <option value='3'>3교시</option>
						            <option value='4'>4교시</option>
						            <option value='5'>5교시</option>
						            <option value='6'>6교시</option>
						            <option value='7'>7교시</option>
						            <option value='8'>8교시</option>
						            <option value='9'>9교시</option>
						            <option value='10'>10교시</option>
		            			</select>
	        				</td>
	        				<td>
		        				<select id='day' name='day'>
						            <option value='' selected > -- 날짜를 선택하세요 --</option>
						            <option value='1'>월요일</option>
						            <option value='2'>화요일</option>
						            <option value='3'>수요일</option>
						            <option value='4'>목요일</option>
						            <option value='5'>금요일</option>
		            			</select>
		            		</td>
            			</tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button onClick="addRow()">+</button>
                <button onClick="deleteRow()">-</button>
                <button type="button" class="btn btn-default time" data-dismiss="modal">등록</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>

<div id="DeleteSubject" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
            	<h4 class="modal-title">과목 삭제</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <input type="text" name="deleteSubject1" class="deleteSubject1">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default deleteSubject" data-dismiss="modal">등록</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
	function isMajor(){
		var university_major_id = $("#isMajor").val();
		
		$('#courseId').empty();
		
		data = new FormData();
    	data.append("university_major_id", university_major_id);
    	
    	$.ajax({
    		data : data,
    		type : "POST",
    		url : "getCourseName",
    		contentType : false,
    		processData : false,
    		success : function(data) {

    			var courseNameList = data.courseNameList;
    			
    			var option = "<option value='' selected > -- 과목을 선택하세요 -- </option>";
    			$('#courseId').append(option);
    			
    			for(var i=0;i<courseNameList.length;i++){
    				var subjectName = courseNameList[i].name;
    				var courseId = courseNameList[i].id;
    				
    				option = "<option value='" + courseId + "'>"+ subjectName +"</option>"
                    $('#courseId').append(option);

    			}
    		}
    	});
	}

    function nextColor(){

        var color;

        while(true){
            color = Math.floor(Math.random()*16777215).toString(16);
            if(color > 'a00000')
                break;
        }

        return '#'+color;
    }

    function addTable(name, nameList){

        //넘겨받은 인자 길이에 맞게 조절
        let tdIdList= new Array(nameList.length);

        for(var i=0;i<tdIdList.length;i++){
            tdIdList[i] = nameList[i];//id 값
            //alert(tdIdList[i]);//id 값 확인
        }

        var color = nextColor();

        for(var i=0;i<tdIdList.length;i++){
            var htmlstring = document.getElementById(tdIdList[i]).innerHTML;
            htmlstring = (htmlstring.trim) ? htmlstring.trim() : htmlstring.replace(/^\s+/,'');
            if(htmlstring != ''){
                alert('다른 과목 수업과 시간이 겹칩니다.');
                return;
            }
        }

        for(var i=0;i<tdIdList.length;i++){
            document.getElementById(tdIdList[i]).innerHTML = name;
            document.getElementById(tdIdList[i]).style.backgroundColor = color;
        }
    }

    function deleteTable(subjectName){
        var str = document.getElementsByTagName('td');

        //0과 6의 배수는 앞에 시간 나타내 주는 곳
        for(var i=0;i<str.length;i++){
            var htmlstring = str[i].innerHTML;
            htmlstring = (htmlstring.trim) ? htmlstring.trim() : htmlstring.replace(/^\s+/,'');

            if(htmlstring == subjectName){
                str[i].innerHTML=null;
                str[i].style.backgroundColor='#ffffff';
            }
        }

    }

    function insertTimeTable(){
        $('#SubjectModal').modal('show');
    }

    function addRow(){
        var timeTableBody = document.getElementById('timeTableBody');
        var row = timeTableBody.insertRow(timeTableBody.rows.length);
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        cell1.innerHTML =  "<select id='time' name='time'>"
            +"<option value='' selected > -- 시간을 선택하세요 --</option>"
            +"<option value='1'>1교시</option>"
            +"<option value='2'>2교시</option>"
            +"<option value='3'>3교시</option>"
            +"<option value='4'>4교시</option>"
            +"<option value='5'>5교시</option>"
            +"<option value='6'>6교시</option>"
            +"<option value='7'>7교시</option>"
            +"<option value='8'>8교시</option>"
            +"<option value='9'>9교시</option>"
            +"<option value='10'>10교시</option>"
            +"</select>";
        cell2.innerHTML =  "<select id='day' name='day'>"
            +"<option value='' selected > -- 날짜를 선택하세요 --</option>"
            +"<option value='1'>월요일</option>"
            +"<option value='2'>화요일</option>"
            +"<option value='3'>수요일</option>"
            +"<option value='4'>목요일</option>"
            +"<option value='5'>금요일</option>"
            +"</select>";

    }

    function deleteTimeTable(){
        $('#DeleteSubject').modal('show');
    }

    $('.deleteSubject').click(function(){
        var Subject = $('.deleteSubject1').val();
        deleteTable(Subject);
        //alert("삭제완료");
    })



    function deleteRow() {
        var timeTableBody = document.getElementById('timeTableBody');
        if (timeTableBody.rows.length < 1) return;
        // my_tbody.deleteRow(0); // 상단부터 삭제
        timeTableBody.deleteRow( timeTableBody.rows.length-1 ); // 하단부터 삭제
    }


    var timeSubject1;
    var subjectInTableList = new FormData();
    
    $('.Subject').click(function(){
    	var courseName = document.getElementById('courseId');
    	courseName = courseId.options[courseId.selectedIndex].innerHTML;
        timeSubject1 = courseName;
        
        subjectInTableList.append(courseName, courseId.options[courseId.selectedIndex].value);
        
        $('#myModal').modal('show');
    })

    $('.time').click(function(){

        var timeList = new Array($("select[name=time]").length);
        var dayList = new Array(timeList.length);
        var timeSubmitList = new Array(timeList.length);
        var timeId = new Array(timeList.length);

        for(var i=0; i<timeList.length; i++) {
            // 다 null 일때
            timeList[i] = $("select[name=time]").eq(i).val();
            console.log("timeList : " + timeList[i]);

            dayList[i] = $("select[name=day]").eq(i).val();
            console.log("dayList : " + dayList[i]);

            timeId[i] = timeList[i] + "_" + dayList[i];
            console.log("timeId : " + timeId[i]);

            console.log("timeSubject1 : " + timeSubject1);

        }
        addTable(timeSubject1,timeId);
    })


    
    function viewTimeTable(semester){
        var str = document.getElementsByTagName('td');

        //0과 6의 배수는 앞에 시간 나타내 주는 곳
        for(var i=0;i<str.length;i++){
            var htmlstring = str[i].innerHTML;
            htmlstring = (htmlstring.trim) ? htmlstring.trim() : htmlstring.replace(/^\s+/,'');

            if(i%6 != 0){
                str[i].innerHTML=null;
                str[i].style.backgroundColor='#ffffff';
            }
        }
    	
    	data = new FormData();
    	data.append("semester", semester);
    	
    	$.ajax({
    		data : data,
    		type : "POST",
    		url : "viewTimeTable",
    		contentType : false,
    		processData : false,
    		success : function(data) {

    			var subjectList = data.subjectList;

    			for(var i=0;i<subjectList.length;i++){
    				var subjectName = subjectList[i].subjectName;
    				var color = subjectList[i].color;
    				var rowColumnList = subjectList[i].timeList;
    				for(var j=0;j<rowColumnList.length;j++){
    					document.getElementById(rowColumnList[j]).style.backgroundColor=color;
    					document.getElementById(rowColumnList[j]).innerHTML = subjectName;
    				}
    			}
    		}
    	});
    	
    }
    
    function saveTimeTable(){
    	var semester = document.getElementById('semester');
    	semester = semester.options[semester.selectedIndex].value;
    	
    	var str = document.getElementsByName("timeRowColumn");

        var List = new Array();

        //0과 6의 배수는 앞에 시간 나타내 주는 곳
        for(var i=0;i<str.length;i++){
            var htmlstring = str[i].innerHTML;
            htmlstring = (htmlstring.trim) ? htmlstring.trim() : htmlstring.replace(/^\s+/,'');
            if(htmlstring != '') {
                if(i%6 != 0){
                    var array = new Array();
                    var subjectName = str[i].innerHTML;
                    var color = str[i].style.backgroundColor;
                    //a_b -> id
                    var a = parseInt(i/6)+1;
                    var b = i%6;

                    array.push(subjectName);
                    array.push(color);
                    array.push(a+'_'+b);
                    array.push(subjectInTableList.get(subjectName));
                    List.push(array);
                }
            }
        }
    	var data = {"semester" : semester,
                    "subjectList" : List
                   }
    	$.ajax({
    		type : "POST",
    		url : "${path}function/saveTimeTable",
    		data : JSON.stringify(data),
            dataType : "json",
            contentType : "application/json; charset=utf-8",
    		success : function(data) {
    		    window.location.reload();
    			alert('저장되었습니다!');
    		},
    		/* error: function(request, status, error){
                alert("서버통신 오류");
                console.log("AJAX_ERROR");
            } */
    	});
    	alert('저장되었습니다!');
    }
</script>

<c:import url="/WEB-INF/views/include/bottom_info.jsp" />