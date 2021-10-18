<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java"  import="java.util.*" %>

<!-- 절대경로 설정  -->
<c:set var="path" value="${pageContext.request.contextPath}/" />

<!DOCTYPE html>
<html lang="en">

<head>
   <title>유니티</title>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
   <link rel="stylesheet" href="${path}resources/css_myPage/style.css">
</head>

	<c:import url="/WEB-INF/views/include/head_meta.jsp" />
	<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<body style="background:linear-gradient(94deg,rgba(30, 161, 247,0.3), rgba(70, 207, 167, 0.3));">

	<section class="ftco-section">
		<div class="container">
			
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-4">
				</div>
			</div>
			
			<div class="row" style="display:block;">
				<div class="col-md-12">
					<button style="background:linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right; font-family: Jua, sans-serif;" onClick="location.href='${path}post/replyReadableSetting?post_id=0'">전체확인</button>
					<h3 class="h5 mb-4 text-left" style="font-family: Jua, sans-serif;">댓글</h3>
					<div class="table-wrap">
						<table class="table">
							<thead style="background:linear-gradient(94deg,#46cfa7,#1ea1f7);">
								<tr>
									<th>&nbsp;</th>
									<th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">유형</th>
									<th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">글제목</th>
									<th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">날짜</th>
									<th>&nbsp;</th>
								</tr>
							</thead>
							<tbody id="myPostReply" style="font-family: Jua, sans-serif;">

							</tbody>
						</table>
						<!--PAGING-->
						<div>
							<ul class="pagination justify-content-center" id ="myPostReplyPagination">
							</ul>
						</div>
					</div>
					<br>
					<button style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right; font-family: Jua, sans-serif;" onClick="location.href='${path}post/reReplyReadableSetting?reply_id=0'">전체확인</button>
					<h3 class="h5 mb-4 text-left" style="font-family: Jua, sans-serif;">대댓글</h3>
					<div class="table-wrap">
						<table class="table">
							<thead style="background:linear-gradient(94deg,#46cfa7,#1ea1f7);">
								<tr>
									<th>&nbsp;</th>
									<th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">유형</th>
									<th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">글제목</th>
									<th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">날짜</th>
									<th>&nbsp;</th>
								</tr> 
							</thead>
							<tbody id="myReplyPost" style="font-family: Jua, sans-serif;">
								
							</tbody>
						</table>
						<!--PAGING-->
						<div>
							<ul class="pagination justify-content-center" id ="myReplyPostPagination">
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
	<script type="text/javascript">
		var pageSize = 5;	// 한 페이지에 네비게이션 버튼 5개씩
		var limit = 4;     // 한 페이지에 10개의 글
	
		var pageNo = 1;
		var pageNo2 = 1;
		var block = 1;
		var block2 = 1;
	
		var myPost = 0;
		var myPost2 = 0;
	
		$(document).ready(function() {
			//보여줘야할 쪽지 개수
			myPost = ${replyNoteNum};
			myPost2 = ${reReplyNoteNum};
			
			myPostPaging();
			myPostPaging2();
		});
		
		// 댓글 쪽지 페이징 함수
		function myPostPaging(newPageNo) {
			if (newPageNo != null) {
				pageNo = newPageNo;
				// block 1 일때 1~5 버튼 (pageSize가 5이므로)
				// 2 일떄 6~10 버튼
				block = Math.ceil(pageNo / pageSize);
			}
			
			$.ajax({
				type: "GET",
				url: "/member/myPostWithNewReply",
				dataType: "json",
				async: false,
				data: {
					"limit": limit,
					"pageNo": pageNo
				}, success: function (data) {
					$('#myPostReply').empty();
					$.each(data, function (i, v) {

						var post;
						post += "<tr class='alert' role='alert'>";
						post += "<td><div class='clickable' style='cursor:pointer' data-toggle='collapse' data-target='#accordion" + v[0].postId + "' > > </div></td>";
						post += "<td>댓글알림</td>";
						post += "<td><a href='${path}board/" + v[0].boardId + "/post/" + v[0].postId + "' style='font-weight: bold; font-size: 1em'>" + v[0].title + "</a></td>";
						post += "<td>" + v[0].postCreatedAt + "</td>";
						post += "<td class='border-bottom-0'>";
						post += "<button type='button' style='background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right;' onClick=\"location.href='${path}post/replyReadableSetting?post_id=" + v[0].postId + "'\">";
						post += "<span aria-hidden='true'><i class='fa fa-close'>확인</i></span>";
						post += "</button>";
						post += "</td>";
						post += "</tr>";
						for(var j=0;j<v.length;j++){
							post += "<tr class='collapse' id='accordion" + v[0].postId + "'>";
							post += "<td style='background-color: rgb(248,249,253)'></td>";
							post += "<td style='background-color: rgb(248,249,253)'></td>";
							post += "<td style='background-color: rgb(248,249,253)'>ㄴ> " + v[j].content + "</td>";
							post += "<td style='background-color: rgb(248,249,253)'>" + v[j].replyCreatedAt + "</td>";
							post += "<td style='background-color: rgb(248,249,253)'></td>";
							post += "</tr>";
						}

						$('#myPostReply').append(post);

					});
				}
			});
			
			// pagination
			// totalPage 는 페이징에 필요한 버튼의 개수
			var totalPage = Math.ceil(myPost/limit);
			
			$('#myPostReplyPagination').empty();
			var page = '';

			if(pageNo>1){
				page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+(1)+');"> '+"<<"+' </li>';
			}

			else {
				page += '<li class="page-link"> '+"<<"+' </li>';
			}

			if(block>1){
				page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+((block-1)*pageSize)+');"> '+"<"+' </li>';
			}
			else {
				page += '<li class="page-link"> '+"<"+' </li>';
			}

				// block = 1 이면 1~5버튼
				// block = 2 일때 6~10
				// pageSize 는 한 페이지에 보여줄 버튼의 최대 개수 pageSize = 5
			for(var i=(block-1)*pageSize+1; i<block*pageSize+1;i++){
				if(i<=totalPage){
					if(i===pageNo)
						page +='<li class="page-link" style="cursor: pointer; color: #c82333" onclick="myPostPaging('+i+');"> '+i+' </li>';

					else
						page +='<li class="page-link" style="cursor: pointer" onclick="myPostPaging('+i+');"> '+i+' </li>';
				}
			}

			if((block*pageSize+1)<=totalPage)
				page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+ block*pageSize+1 +');"> '+">"+' </li>';
			else {
				page += '<li class="page-link"> '+">"+' </li>';
			}

			if(pageNo<totalPage)
				page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+(totalPage)+');"> '+">>"+' </li>';
			else {
				page += '<li class="page-link"> '+">>"+' </li>';
			}
			$('#myPostReplyPagination').append(page);
		
		}
		
		// 대댓글 쪽지 페이징 함수
		function myPostPaging2(newPageNo) {
			if (newPageNo != null) {
				pageNo2 = newPageNo;
				// block 1 일때 1~5 버튼 (pageSize가 5이므로)
				// 2 일떄 6~10 버튼
				block2 = Math.ceil(pageNo2 / pageSize);
			}
			
			$.ajax({
				type: "GET",
				url: "/member/myReplyWithNewReReply",
				dataType: "json",
				async: false,
				data: {
					"limit": limit,
					"pageNo": pageNo2
				}, success: function (data) {
					$('#myReplyPost').empty();
					$.each(data, function (i, v) {
						
						var post;
						post += "<tr class='alert' role='alert'>";
						post += "<td><div class='clickable' style='cursor:pointer' data-toggle='collapse' data-target='#accordion2" + v[0].postId + "' > > </div></td>";
						post += "<td>대댓글알림</td>";
						post += "<td><a href='${path}board/" + v[0].boardId + "/post/" + v[0].postId + "' style='font-weight: bold; font-size: 1em'>" + v[0].title + "</a></td>";
						post += "<td>" + v[0].postCreatedAt + "</td>";
						post += "<td class='border-bottom-0'>";
						post += "<button type='button' style='background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right;' onClick=\"location.href='${path}post/reReplyReadableSetting?reply_id=" + v[0].replyId + "'\">";
						post += "<span aria-hidden='true'><i class='fa fa-close'>확인</i></span>";
						post += "</button>";
						post += "</td>";
						post += "</tr>";
						post += "<tr class='collapse' id='accordion2" + v[0].postId + "'>";
						post += "<td style='background-color: rgb(248,249,253)'></td>";
						post += "<td style='background-color: rgb(248,249,253)'></td>";
						post += "<td style='background-color: rgb(248,249,253)'>ㄴ> " + v[0].reply + "</td>";
						post += "<td style='background-color: rgb(248,249,253)'>-> " + v[0].reReply + "</td>";
						post += "<td style='background-color: rgb(248,249,253)'>" + v[0].reReplyCreatedAt + "</td>";
						post += "</tr>";
						for(var j=1;j<v.length;j++){
							post += "<tr class='collapse' id='accordion2" + v[0].postId + "'>";
							post += "<td style='background-color: rgb(248,249,253)'></td>";
							post += "<td style='background-color: rgb(248,249,253)'></td>";
							post += "<td style='background-color: rgb(248,249,253)'></td>";
							post += "<td style='background-color: rgb(248,249,253)'>-> " + v[j].reReply + "</td>";
							post += "<td style='background-color: rgb(248,249,253)'>" + v[j].reReplyCreatedAt + "</td>";
							post += "</tr>";
						}

						$('#myReplyPost').append(post);

					});
				}
			});
			
			// pagination
			// totalPage 는 페이징에 필요한 버튼의 개수
			var totalPage2 = Math.ceil(myPost2/limit);
			
			$('#myReplyPostPagination').empty();
			var page = '';

			if(pageNo2>1){
				page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging2('+(1)+');"> '+"<<"+' </li>';
			}

			else {
				page += '<li class="page-link"> '+"<<"+' </li>';
			}

			if(block2>1){
				page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging2('+((block2-1)*pageSize)+');"> '+"<"+' </li>';
			}
			else {
				page += '<li class="page-link"> '+"<"+' </li>';
			}

				// block = 1 이면 1~5버튼
				// block = 2 일때 6~10
				// pageSize 는 한 페이지에 보여줄 버튼의 최대 개수 pageSize = 5
			for(var i=(block2-1)*pageSize+1; i<block2*pageSize+1;i++){
				if(i<=totalPage2){
					if(i===pageNo2)
						page +='<li class="page-link" style="cursor: pointer; color: #c82333" onclick="myPostPaging2('+i+');"> '+i+' </li>';

					else
						page +='<li class="page-link" style="cursor: pointer" onclick="myPostPaging2('+i+');"> '+i+' </li>';
				}
			}

			if((block2*pageSize+1)<=totalPage2)
				page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging2('+ block2*pageSize+1 +');"> '+">"+' </li>';
			else {
				page += '<li class="page-link"> '+">"+' </li>';
			}

			if(pageNo2<totalPage2)
				page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging2('+(totalPage2)+');"> '+">>"+' </li>';
			else {
				page += '<li class="page-link"> '+">>"+' </li>';
			}
			$('#myReplyPostPagination').append(page);
		}
		
	</script>
	
	<script src="${path}resources/js_myPage/jquery.min.js"></script>
	<script src="${path}resources/js_myPage/popper.js"></script>
	<script src="${path}resources/js_myPage/bootstrap.min.js"></script>
	<script src="${path}resources/js_myPage/main.js"></script>
	
	<c:import url="/WEB-INF/views/include/bottom_info.jsp" />