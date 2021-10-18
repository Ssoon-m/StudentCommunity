<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.request.contextPath}/" />

<c:import url="/WEB-INF/views/include/admin_head_meta.jsp" />
<c:import url="/WEB-INF/views/include/admin_top.jsp" />
<!--자동완성-->
<!-- CSS , JS -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css_home/admin_home.css">

<html>

<body>
	<div class="container" style="margin-top: 150px">
		<div class="card shadow-none">
			<div class="card-body">
				<table class="table table-hover" id='board_list'>
					<thead>
						<tr>
							<th class="d-none d-md-table-cell text-center"><input
								type="checkbox" id="check-all" onclick="checkAll()">&nbsp;글번호</th>
							<th class="d-none d-md-table-cell text-center">강좌명</th>	
							<th class="w-30 text-center">평가내용</th>
							<th class="d-none d-md-table-cell text-center">작성자</th>
							<th class="d-none d-md-table-cell text-center">작성날짜</th>
							<th></th>
						</tr>
					</thead>
					<tbody>

						<!-- 게시글 리스트 -> 강의평가 리스트 -->

						<c:forEach var="ratingList" items="${ratingList}">
							<tr>
								<td style="text-align: center; cursor: Hand"><input
									type="checkbox" name="reportChkBxRow"
									id="${ratingList.id}">&nbsp;${ratingList.id}</td>
									<td style="text-align: center;">${ratingList.courseName}</td> 
								<td style="text-align: center; cursor: Hand"
									onclick="detail(${ratingList.id}, ${ratingList.comment});">${ratingList.comment}</td>
							<td style="text-align: center;">${ratingList.email}</td> 
								<td style="text-align: center;">${ratingList.createdAt}</td>



							</tr>
						</c:forEach>


						<!--대학 검색 -->

						<select id='selectUniversity' name='selectUniversity'>
							<option value='' disabled hidden selected>대학별 리스트</option>
							<c:forEach var="universityList" items="${universityList}">
							
								<c:if test="${pageDTO.selectUniversity eq universityList.id}">
									<option selected value="${universityList.id}  ">
										${universityList.name }</option>
								</c:if>
							<c:if test="${pageDTO.selectUniversity ne universityList.id}">
									<option value="${universityList.id}  ">
										${universityList.name }</option>
							</c:if>

							</c:forEach>
						</select>

 			

						<!-- 카테고리 검색 -->

						 <c:if test="${pageDTO.selectUniversity != null}">
							<c:if test="${pageDTO.selectUniversity != '' }"> 
							
								<select style="margin-left: 10px;" id='courseList' name='courseList'>
									<option value='' selected>교과목</option>
									<c:forEach var="courseList" items="${courseList}">
										<c:if
											test="${pageDTO.courseList eq courseList.id}">
											<option selected value="${courseList.id}">
												${courseList.name }</option>
										</c:if>
										<c:if
											test="${pageDTO.courseList ne courseList.id}">
											<option value="${courseList.id}">
												${courseList.name }</option>
										</c:if>

									</c:forEach>
								</select>
							</c:if>
						</c:if> 



						<!-- 키워드 검색 -->
						<form method="get"
							action="${pageContext.request.contextPath}/admin/admin_courseRating">

							<div style="float: right">
								<select id="select" name="select">
								
								 <c:if test="${pageDTO.select eq 'courseName'}">
                       			 <option selected value="courseName">강좌명</option>                        
                       			 <option value="comment">평가내용</option>
                        		<option value="writer">작성자</option>
                    			 </c:if>
								
									<c:if test="${pageDTO.select eq 'comment'}">
									 <option selected value="courseName">강좌명</option>                        
                       			 <option value="comment">평가내용</option>
                        		<option value="writer">작성자</option>
									</c:if>

									<c:if test="${pageDTO.select eq 'writer'}">
									 <option selected value="courseName">강좌명</option>                        
                       			 <option value="comment">평가내용</option>
                        		<option value="writer">작성자</option>
									</c:if>

									<c:if test="${pageDTO.select eq null}">
										 <option selected value="courseName">강좌명</option>                        
                       			 <option value="comment">평가내용</option>
                        		<option value="writer">작성자</option>
									</c:if>

									<c:if test="${pageDTO.select eq ''}">
									 <option selected value="courseName">강좌명</option>                        
                       			 <option value="comment">평가내용</option>
                        		<option value="writer">작성자</option>
									</c:if>

								</select> 
										
                  <input type="hidden" name="selectUniversity" value="${pageDTO.selectUniversity}">
                   <input type="hidden" name="courseList" value="${pageDTO.courseList}"> 
                  <input type="text" name="input" id="AutoSearch" value="${pageDTO.input}">

                  <input type="submit" class="btn" value="검색">
				
             	 
				<%-- 		
		          <input type="text" name="input" id="AutoSearch" value="${pageDTO.input}"> 
		          <input type="submit" class="btn" value="검색"> 
				--%>			
							
							</div>
						</form>

					</tbody>
				</table>


				<!--  페이징 코드 시작 -->
				<div class="d-none d-md-block">
				
					<ul class="pagination justify-content-center">
						<!--
                       현재 페이지가 맨 처음 네비게이션 버튼에 있는 경우에는 다음 버튼이 안 보이도록 함
                       prePage의 값이 네비게이션 버튼의 최소랑 비교했을때 같을경우 안눌린다.
                    -->
						<c:choose>
							<c:when test="${pageDTO.prePage == 1}">
								<li class="page-item disabled"><a href="#"
									class="page-link">이전</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a
									href="${pageContext.request.contextPath}/admin/admin_courseRating?page=${pageDTO.prePage-1}&input=${pageDTO.input}&select=${pageDTO.select}&selectUniversity=${pageDTO.selectUniversity}"
									class="page-link">이전</a></li>
							</c:otherwise>
						</c:choose>

						<c:forEach var="idx" begin="${pageDTO.min }" end="${pageDTO.max }">
							<c:choose>
								<c:when test="${idx == pageDTO.currentPage }">
									<li class="page-item active"><a
										href="${pageContext.request.contextPath}/admin/admin_courseRating?page=${idx}&input=${pageDTO.input}&select=${pageDTO.select}&selectUniversity=${pageDTO.selectUniversity}&courseList=${pageDTO.courseList}"
										style="background: #5fbcfa" class="page-link">${idx }</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a
										href="${pageContext.request.contextPath}/admin/admin_courseRating?page=${idx}&input=${pageDTO.input}&select=${pageDTO.select}&selectUniversity=${pageDTO.selectUniversity}&courseList=${pageDTO.courseList}"
										class="page-link">${idx }</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						

						<!--
                       현재 페이지가 맨 마지막 네비게이션 버튼인 경우 다음 버튼이 안 눌리게 한다.
                       nextPage의 값이 네비게이션 버튼의 최대보다 같을경우 안눌리게 한다.
                    -->
						<!--  pageCount 는 최대 네비게이션 페이지 총 양-->
						<c:choose>
							<c:when test="${pageDTO.nextPage == pageDTO.pageCount}">
								<li class="page-item disabled"><a href="#"
									class="page-link">다음</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a
									href="${pageContext.request.contextPath}/admin/admin_courseRating?page=${pageDTO.prePage+1}&select=${pageDTO.select}&selectUniversity=${pageDTO.selectUniversity}&courseList=${pageDTO.courseList}"
									class="page-link">다음</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<!-- 페이징 코드 끝 -->




				<!--  글 삭제 -->
				<input type="button" id="delete" onClick="deleteReport();"
					class="btn" style="float: right" value="삭제">



			</div>
		</div>
	</div>
	<br>
	<br>
	<br>

</body>

<script>
				 	
// 디테일보기?? =>  
  
  
  
 	var autocourseName = [];
    var autoemail = [];
    var autocomment = [];  
   
   
   $(document).ready(function() {
	      $.ajax({
	         url: "/admin/courseAutoSearch",
	         type: "get",
	         dataType: "json",
	         contentType: "application/json",
	         async: false,
	         success: function (data) {
	            $.each(data, function (i, v) {
	            	autocourseName.push(v.courseName);
	            	autoemail.push(v.email);
	            	autocomment.push(v.comment);
	               
	            });
	            // autotitlecontent = autotitle.concat(autocontent);
	             autoemail = autoemail.filter((item, index) => autoemail.indexOf(item) === index);
	             autocourseName = autocourseName.filter((item, index) => autocourseName.indexOf(item) === index);
	             
	             console.log("autocourseName ------->>>>>", autocourseName);
	             console.log("autoemail ------->>>>>", autoemail);
	             console.log("autocomment ------->>>>>", autocomment);
	         }
	      });
	      
	   });
	   // var autonameemail = autoname.filter( (item, idx, array) => {
	   //    return array.indexOf( item ) === idx ;
	   // });
	   $(function () {
	      $('#AutoSearch').autocomplete({
	         source: autocourseName
	      })
	      
	   });
   
    
  

	   var autoselect;
	      $('#select').on('change',function(){
	         autoselect = $(this).val();

	         if(autoselect == 'courseName') {
	            $(function () {
	               $('#AutoSearch').autocomplete({
	                  source: autocourseName
	               })
	            });
	         }
	         if(autoselect == 'comment'){
	            $(function () {
	               $('#AutoSearch').autocomplete({
	                  source: autocomment
	               })
	            });
	         }
	         if(autoselect == 'writer'){
	            $(function () {
	               $('#AutoSearch').autocomplete({
	                  source: autoemail
	               })
	            });
	         }
	       
	      })

   
 
   $('#check-all').click(function(){
      var checked = $('#check-all').is(':checked');

      if(checked)
      {
         $('input:checkbox').prop('checked',true);
      }
      else
      {
         $('input:checkbox').prop('checked',false);
      }
     
   });

   // checkbox로 글 삭제!!
   function deleteReport(){
      var cnt = $("input[name='reportChkBxRow']:checked").length;
      var arr = new Array();
      // input 태그에서 name이 reportChkMxRow이면서 체크가 되어있는것
      $("input[name='reportChkBxRow']:checked").each(function() {
         arr.push($(this).attr('id'));
      });
      if(cnt == 0){
         alert("선택된 글이 없습니다.");
      }
      else{
         $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/admin/courseRating_delete",
            data: {
               'id' : arr
            },
            dataType:"json",
            success: function(retVal){
               if(retVal.code == "OK") {
                  alert(retVal.message);
                  window.location.reload();
               } else {
                  alert(retVal.message);
               }
            },
            error: function(request, status, error){
               alert("서버통신 오류");
               console.log("AJAX_ERROR");
            }
         });
      }
   }
   
   
     
 
   // 대학 선택 하자마자 보여주기
   $('#selectUniversity').on('change',function(){ 
	   var universityId = "";
	 universityId =  $(this).val();
	// alert(universityId);
	 console.log(universityId);
  	 window.location.href = "${pageContext.request.contextPath}/admin/admin_courseRating?select=${pageDTO.select}&selectUniversity=" + universityId;

   });	   
  
 $('#courseList').on('change',function(){
	   
	   var courseList = "";
	   courseList = $(this).val();
     console.log(courseList);
    // alert(courseList);
    window.location.href = "${pageContext.request.contextPath}/admin/admin_courseRating?&select=${pageDTO.select}&selectUniversity=${pageDTO.selectUniversity}&courseList=" + courseList ;
  
 });



</script>

</html>