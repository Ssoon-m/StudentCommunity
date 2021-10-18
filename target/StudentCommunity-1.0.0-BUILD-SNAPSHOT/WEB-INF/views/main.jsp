<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/include/head_meta.jsp" />
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!-- 절대경로 설정  -->
<c:set var="path" value="${pageContext.request.contextPath}/" />


<!DOCTYPE html>
<html>

<head>
<title>유니티</title>
<!--자동완성-->
<!-- CSS , JS -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="${path}resources/css_member/style.css">
<!--자동완성-->
<!-- CSS , JS -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
 .loginform > div
 {
 	@media screen and (min-width:1200px)
	 {
	 	    margin-left: 100px;
	 }
	 @media screen and (max-width:1199px)
	 {
	 	   	 margin-left: 60px;
	 }
 }
</style>
</head>

<body
	style="background: linear-gradient(94deg, rgba(30, 161, 247, 0.3), rgba(70, 207, 167, 0.3));">
	<section style="margin-top: 100px;" class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-5">
					<div class="login-wrap p-4 p-md-5"
						style="box-shadow: 10px 10px 10px grey;">
						<div class="icon d-flex align-items-center justify-content-center"
							style="background: linear-gradient(94deg, #1ea1f7, #46cfa7);">
							<span class="fas fa-school fa"></span>
						</div>

						<h3 class="text-center mb-4" style="color: #46cfa7;">유니티</h3>

						<form class="loginform">
							<a href="/member/login" class="button login"
								style="border: 1px solid #46cfa7; color: #46cfa7;">로그인</a><br>
							<a href="/member/before_register" class="button register"
								style="border: 1px solid #46cfa7; color: #46cfa7;">회원가입</a> <br>
								
								
								<div style="justify-content: center; display: flex; align-items: center; flex-direction: row;">
								
								<input type="text" id="autoSearch" class="button register"
									style="border: 1px solid #46cfa7;" placeholder="대학교를 입력해 주세요" >
								<input type="hidden" id="selectId" >
								<input type="hidden" id="selectName">
								<input type="button" id="doSearch" class="button register"
									style="border: 1px solid #46cfa7; margin-left:10px;" value="검색" onClick="doSearch">
									
								</div>
								
								
								
						</form>
						
							


					</div>


				</div>
			</div>
		</div>
		
	</section>
</body>


<script>
	var totalUniversity = [];
	//오토 컴플리티
	$(document).ready(function() {
		$.ajax({
			type : "GET",
			url : "/university/uniAutoSearch",
			dataType : "json",
			contentType : "application/json",
			async : false,
			data : {},
			success : function(data) {
				$.each(data, function(i, v) {
					totalUniversity.push({
						label : v.name,
						city : v.id
		
					});//전체 대학 ,id
				});
			},
			error : function() {
			}
		});//ajax
	});//ready
	//auto complete
      $('#autoSearch').autocomplete({
         source: totalUniversity ,
         select: function(event, ui){
        	// doSearch(ui.item.label, ui.item.city);
        
        	$("#selectId").val(ui.item.city);
        	$("#selectName").val(ui.item.label);
        	 console.log("전",ui.item.label);
        	 console.log("전",ui.item.city);
        	
         },
         focus:function(event, ui){
        	 return false;
         }
       
   });
      
    	  $('#doSearch').click(function(){ 

    	 var id = $("#selectId").val();
    	 var name = $("#selectName").val();
    	 var searchTxt = $("#autoSearch").val();
    	 
    	 console.log('-----doSearch-----')
    		console.log('name--->', name)
    		console.log('id--->', id)
    		console.log('searchTxt--->', searchTxt)
    		console.log('-----doSearch-----')
    		
    		// 자동완성 select -> 값 지우고 다른 대학 이름 검색
    		if( name === searchTxt ){
    			window.location.href = '/university/' + id;
    		}else{
    		alert("다시 입력해주세요!!!");
    		 var searchTxt = $("#autoSearch").val("");
    		
    		
    		}
    	 
    		
    	  });
	
	
	
</script>
<%-- <script src="${path}resources/js_member/jquery.min.js"></script> --%>
<script src="${path}resources/js_member/popper.js"></script>
<script src="${path}resources/js_member/bootstrap.min.js"></script>
<script src="${path}resources/js_member/main.js"></script>

<c:import url="/WEB-INF/views/include/bottom_info.jsp" />