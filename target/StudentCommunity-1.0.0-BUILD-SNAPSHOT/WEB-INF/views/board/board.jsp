<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/include/head_meta.jsp" />
<c:import url="/WEB-INF/views/include/top_menu.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}" />

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>

<body style="background:linear-gradient(94deg,rgba(30, 161, 247,0.3), rgba(70, 207, 167, 0.3));">
<!-- 게시글 리스트 -->
<div class="container" style="margin-top: 150px; font-family: Jua, sans-serif;">
	<div class="row">
		<div class="col-md-9" style="margin-left: 150px;">
			<div class="card shadow-sm">
				<div class="card-body">
			<h4 class="card-title">${board.categoryName}게시판</h4>
			<table class="table table-hover" id='board_list'>
				<thead>
				<tr>
					<th class="text-left" style="width: 55%">제목</th>
					<th class="text-right">작성자</th>
					<th class="text-right" id="views" style="cursor: pointer;" onclick="orderBy(id)">조회수</th>
					<th class="text-right" id="good" style="cursor: pointer;" onclick="orderBy(id)">추천</th>
					<th class="text-right" id="created_at" style="cursor: pointer;" onclick="orderBy(id)">작성날짜</th>

				</tr>
				</thead>
				<tbody>
				<c:forEach var="postList" items="${postList}" varStatus="status">
				<tr  style="cursor: pointer" onclick="detail(${postList.id});">

					<td style="text-align:left;">${postList.title} <span class="badge badge-pill badge-light" style="size: 1px"><img src="${pageContext.request.contextPath}/resources/post_image/reply_image.PNG" style="width:10px; height:10px;">${postList.totalReply}</span></td>
					<c:if test="${postList.anonymous eq 'TRUE'}">
					<td style="text-align:right;" >익명</td>
					</c:if>
					<c:if test="${postList.anonymous eq 'FALSE'}">
						<td style="text-align:right;" >${postList.name}</td>
					</c:if>
					<td style="text-align:right;" >${postList.views}</td>
					<td style="text-align:right;" ><img src="${pageContext.request.contextPath}/resources/post_image/good_image.PNG" style="width:15px; height:15px;">${postList.good}</td>
					<fmt:parseDate value="${postList.createdAt}" pattern="yy-MM-dd'T'HH:mm" var = "parsedDateTime" type="both"/>
					<td style="text-align:right;"><fmt:formatDate pattern="MM-dd HH:mm" value="${parsedDateTime}"/></td>
				</tr>
				</c:forEach>
			</table>

	<div class="d-none d-md-block">
			<ul class="pagination justify-content-center">

				<c:if test="${postSearch.block>1}">
					<il class="page-item"><a onclick="blockMinus()" class="page-link"> < </a> </il>
				</c:if>

				<c:if test="${postSearch.block<=1}">
					<il class="page-item"><a class="page-link"><</a></il>
				</c:if>

				<c:forEach begin="${(postSearch.block-1)*postSearch.pageSize +1}"
						   end="${postSearch.block*postSearch.pageSize}" varStatus="status">
					<c:if test="${status.index<=totalPage}">
						<c:if test="${postSearch.pageNo==status.index}">
						<il class="page-item"><a onclick="pageMove(${status.index});" class="page-link" style="color: #c82333" >${status.index}</a></il>
						</c:if>
						<c:if test="${postSearch.pageNo!=status.index}">
							<il class="page-item"><a onclick="pageMove(${status.index});" class="page-link" >${status.index}</a></il>
						</c:if>
					</c:if>
				</c:forEach>

				<c:if test="${postSearch.block*postSearch.pageSize < totalPage}">
					<il class="page-item"> <a onclick="blockPlus();" class="page-link"> > </a> </il>
				</c:if>

				<c:if test="${postSearch.block*postSearch.pageSize >= totalPage}">
					<il class="page-item"> <a class="page-link"> > </a> </il>
				</c:if>

			</ul>
	</div>



			<form method="get" action="/board/${postSearch.boardId}">
				<select id ="select" name="select">
					<c:if test="${postSearch.select eq 'title'}">
						<option selected value="title">제목</option>
						<option value="titleContent">제목 내용</option>
						<option value="content">내용</option>
					</c:if>

					<c:if test="${postSearch.select eq 'titleContent'}">
						<option value="title">제목</option>
						<option selected value="titleContent">제목 내용</option>
						<option value="content">내용</option>
					</c:if>

					<c:if test="${postSearch.select eq 'content'}">
						<option value="title">제목</option>
						<option value="titleContent">제목,내용</option>
						<option selected value="content">내용</option>
					</c:if>

					<c:if test="${postSearch.select eq null}">
						<option selected value="title">제목</option>
						<option value="titleContent">제목,내용</option>
						<option value="content">내용</option>
					</c:if>

				</select>

				<input type="hidden" name="pageNo" value="1">
				<input type="text" name="input" value="${postSearch.input}">
				<input type="submit" value="검색">
				<input type="button" style="float: right" onclick="newPost();" value="글 등록">
			</form>


				</div>
			</div>
		</div>
	</div>
</div>
<br>
<br>
<br>

</body>
<script>



	var totalPage = ${totalPage};
	var queryString = window.location.search;

	var queryString = window.location.search;
	//클릭한 게시글의 detail
	function detail(postId){
		var loc = location.href.split('/post');
		loc[0] = loc[0].replace(queryString,'');


		location.href = loc[0]+"/post/"+postId+queryString;
	}

	function newPost(){
		var loc = location.href.split('/post');
		loc[0] = loc[0].replace(queryString,'');
		location.href = loc[0]+"/post/new_post";
	}


	function blockPlus(){
		var origin = window.location.href;
		var url ='';
		if(origin.includes("post")){
			var arr = origin.split("/post");
			url = arr[0]+queryString;
		}
		else {
			url = origin;
		}
		var pageNo = ${postSearch.block}*${postSearch.pageSize}+1;
		if(url.includes("pageNo")){
			var oldPageNo = "pageNo="+${postSearch.pageNo};
			var newPageNo = "pageNo="+pageNo;
			url = url.replace(oldPageNo,newPageNo);
			window.location.href=url;
		}
		else if(url.includes("?")){
			window.location.href=url+"&pageNo="+pageNo;
		}
		else{
			window.location.href=url+"?pageNo="+pageNo;
		}
	}

	function blockMinus(){
		var origin = window.location.href;
		var url ='';
		if(origin.includes("post")){
			var arr = origin.split("/post");
			url = arr[0]+queryString;
		}
		else {
			url = origin;
		}

		var pageNo = (${postSearch.block}-1)*${postSearch.pageSize};
		if(url.includes("pageNo")){
			var oldPageNo = "pageNo="+${postSearch.pageNo};
			var newPageNo = "pageNo="+pageNo;
			url = url.replace(oldPageNo,newPageNo);
			window.location.href=url;
		}
		else if(url.includes("?")){
			window.location.href=url+"&pageNo="+pageNo;
		}
		else{
			window.location.href=url+"?pageNo="+pageNo;
		}
	}


	function pageMove(pageNo){
		var origin = window.location.href;
		var url ='';
		if(origin.includes("post")){
			var arr = origin.split("/post");
			url = arr[0]+queryString;
		}
		else {
			url = origin;
		}

		if(url.includes("pageNo")){
			var oldPageNo = "pageNo="+${postSearch.pageNo};
			var newPageNo = "pageNo="+pageNo;
			url = url.replace(oldPageNo,newPageNo);
			window.location.href=url;
		}
		else if(url.includes("?")){
			window.location.href=url+"&pageNo="+pageNo;
		}
		else{
			window.location.href=url+"?pageNo="+pageNo;
		}
	}

	// queryParams
	//new or modify
	function orderBy(id){
		var queryParams = new URLSearchParams(window.location.search);
		var origin = location.href;

		if((origin.includes("pageNo"))){
			queryParams.set("pageNo", "1");//이미 페이지 넘버가 있다면 혹시 모르니까 1로 변환
		}
		if(origin.includes("order")){//이미 정렬이 되어있다면 클릭된 order로 변환
			queryParams.set("order",id);//이미 페이지 넘버가 있다면 혹시 모르니까 1로 변환
		}else {//만약 이미 order
			queryParams.set("order",id);
		}

		var loc = location.href.split(location.search||location.hash||/[?#]/)[0]+'?';
		window.location.href = loc+queryParams;

		}


	// //아무 조건도 없이 dom 로드 되자마자 실행되는 제이쿼리
	// $(document).ready(function() {
	// 	var offset = $('#board_list').offset();
	// 	$('html').animate({scrollTop : offset.top},400);
	//
	// });//ready


</script>
