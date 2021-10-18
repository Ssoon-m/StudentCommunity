<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/include/head_meta.jsp" />
<c:import url="/WEB-INF/views/include/top_menu.jsp" />
<c:set var="path" value="${pageContext.request.contextPath}/" />


<body style="background:linear-gradient(94deg,rgba(30, 161, 247,0.3), rgba(70, 207, 167, 0.3)); font-family: Jua, sans-serif;">

<!-- 전체 body_div -->
<div style="margin-top: 150px;">

	<!-- 좌측바 -->
	<div class="leftside card pconly ml-3 float-left position-fixed" style="  background-color:rgba(255,255,255,0.3); margin-top:20px;" id="loginmenu">
		<form class="loginform" style="text-align: center;">
			<c:choose>
				<c:when test="${loginMemberDTO.isUserLogin() == true }">

					<div class="img" style="margin-top:20px">
						<img src="${path}resources/${loginMemberDTO.img};">
						<h6 id="test22">${loginMemberDTO.universityName}
							201710944</h6>
						<a href="${path}member/myPage">${loginMemberDTO.name}</a>
					</div>
					<br>
					<div style="margin-top:10px">
						<a href="${path}member/myPage" class="login" style="color: rgba(70, 207, 167, 0.5); float:left;">마이페이지</a>
						<a href="${path}member/logout" class="register" style=" color: rgba(70, 207, 167, 0.5); float:right;">로그아웃</a>
					</div>

				</c:when>
				<c:otherwise>
					<div style="margin-top:30px">
						<p style="text-align:center;">커뮤니티<strong> 로그인</strong>이 필요합니다!</p>
						<a href="/member/login" class="register" style="color: #1ea1f7; margin-right:20px;">로그인</a>
						<a href="/member/before_register" class="register" style="color: #1ea1f7;">회원가입</a>
					</div>
				</c:otherwise>
			</c:choose>
		</form>
	</div>

	<!-- 우측바 -->
	<div class="rightside position-fixed mt-4" style="margin-top:20px; right: 10px; ">

		<div class="card mb-2 p-2"
			 style=" background-color:rgba(255,255,255,0.3); float: right;">

			<div class="board">
				<h2>
					<a style="font-size: 14px;color: #005cbf; font-weight: bold;">실시간 인기 글</a>
				</h2>
				<hr>

				<c:forEach var="popular" items="${popular}" varStatus="status" >
				<c:if test="${loginMemberDTO.isUserLogin()==true}">
				<a class="article" style="cursor: pointer" onclick="goBoard( ${popular.boardId},${popular.id})">
					</c:if>
					<c:if test="${loginMemberDTO.isUserLogin()==false}">
					<a class="article">
						</c:if>


						<c:if test="${popular.title.length()>14 and loginMemberDTO.isUserLogin()==true}">
							<p style="font-size: 11px;">${popular.title.substring(0,11)}...</p>
						</c:if>

						<c:if test="${popular.title.length()<=14 and loginMemberDTO.isUserLogin()==true}">
							<p style="font-size: 11px;">${popular.title}</p>
						</c:if>

						<c:if test="${loginMemberDTO.isUserLogin()==false}">
							<p style="font-size: 11px;">로그인 후에 확인 하실 수 있습니다.</p>
						</c:if>


						<fmt:parseDate value="${popular.createdAt}" pattern="yy-MM-dd'T'HH:mm" var = "parsedDateTime" type="both"/>
						<time style="vertical-align: bottom;"><fmt:formatDate pattern="MM-dd HH:mm" value="${parsedDateTime}"/></time>
						&nbsp;&nbsp;
						<span class="badge badge-pill badge-light">
							<img src="${pageContext.request.contextPath}/resources/post_image/reply_image.PNG"style="width: 15px; height: 15px;">${popular.totalReply}
						</span>
						<span	class="badge badge-pill badge-light">
							<img src="${pageContext.request.contextPath}/resources/post_image/good_image.PNG" style="width: 15px; height: 15px;">
							${popular.good}
						</span>
						<hr>
					</a>
					</c:forEach>
			</div>
		</div>
	</div>

	<!-- 게시판 미리보기 부분 -->
	<div class="container">
		<div class="row">
			<c:forEach var="board" items="${popularBoard}" varStatus="status">
				<div class="col-md-5" style="margin-top:20px; margin-left: 50px;">
					<div class="card shadow-sm">
						<div class="card-body">
							<h4 class="card-title" style="cursor: pointer" onclick="goBoard(${board.id})">${board.name}게시판</h4>

							<c:choose>
								<c:when test="${board.name =='비밀' and loginMemberDTO.isUserLogin() == false}">
									<div>
										<%-- 비밀게시판 --%>
										<div style="border: solid 2px black; font-size: 20px; padding-top: 130px; width: 100%; height: 295px; text-align: center">
											<a>로그인 후에 확인 하실 수 있습니다.</a>
											<br>
											<a href="/member/login" style=" padding: 5px; background-color: #0056b3; color: white;">로그인</a>
											<br>

										</div>
									</div>
								</c:when>

								<c:otherwise>
									<table class="table table-hover" id="board_list">
										<thead>
										<tr>
											<th class="text-left">제목</th>
											<th class="text-right">작성일</th>
										</tr>
										</thead>
										<tbody style="font-size: 13px">
										<c:forEach var="post" items="${postList}" varStatus="status">
											<c:if test="${post.boardId.equals(board.id)}">
												<tr onclick="goBoard(${board.id},${post.id})" style="cursor: pointer;">

													<c:choose>
														<%-- 익명 게시판 --%>
														<c:when test="${board.name=='익명' and loginMemberDTO.isUserLogin() == false}">
															<td class="text-left">로그인 후 확인 할 수 있습니다.
																<span class="badge badge-pill badge-light" ><img src="${pageContext.request.contextPath}/resources/post_image/reply_image.PNG" style="width:15px; height:15px;">${post.totalReply}</span>

																<span class="badge badge-pill badge-light" ><img src="${pageContext.request.contextPath}/resources/post_image/good_image.PNG" style="width:15px; height:15px;">${post.good}</span>

															</td>
														</c:when>
														<c:otherwise>


															<c:if test="${post.title.length()<=20}">
																<td class="text-left">${post.title}
															</c:if>

															<c:if test="${post.title.length()>20}">
																<td class="text-left">${post.title.substring(0,17)} ${"..."}
															</c:if>


															<span class="badge badge-pill badge-light" ><img src="${pageContext.request.contextPath}/resources/post_image/reply_image.PNG" style="width:15px; height:15px;">${post.totalReply}</span>
															<span class="badge badge-pill badge-light" ><img src="${pageContext.request.contextPath}/resources/post_image/good_image.PNG" style="width:15px; height:15px;">${post.good}</span>
															</td>
														</c:otherwise>
													</c:choose>

													<c:choose>
														<%-- LocalDateTime의 isAfter => 인자 보다 미래일때 true 리턴 --%>
														<c:when test="${post.createdAt.isAfter(today.minusMinutes(60))}">
															<td class="text-right">${60-(post.createdAt.toLocalTime().minusMinutes(today.toLocalTime().plusMinutes(1).minute).minute)}분 전</td>
														</c:when>

														<c:otherwise>

															<fmt:parseDate value="${post.createdAt}" pattern="yy-MM-dd'T'HH:mm" var = "parsedDateTime" type="both"/>
															<td class="text-right"><fmt:formatDate pattern="MM-dd HH:mm" value="${parsedDateTime}"/></td>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:if>
										</c:forEach>
										</tbody>
									</table>
								</c:otherwise>

							</c:choose>

						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

<%--	<div class="weel">--%>
<%--		<input type="text" id="msg" value="1212" class="form-control"/>--%>
<%--		<button id="btnSend" class="btn btn-primary">Send Message</button>--%>
<%--	</div>--%>

</div>
</body>

<%--<script>--%>
<%--	$(document).ready(function(){--%>
<%--		$('#btnSend').on('click',function(evt){--%>
<%--			evt.preventDefault();--%>
<%--			if(socket.readyState !== 1 ) return;--%>

<%--			let msg = $('input#msg').val();--%>
<%--			socket.send(msg);--%>
<%--		});--%>
<%--	});--%>

<%--</script>--%>

<script>


	function goBoard(boardId,postId){
		var loc ="/board/";
		loc += boardId;
		if(postId != null)
			loc +="/post/"+postId;

		location.href = loc;
	}


</script>


<c:import url="/WEB-INF/views/include/bottom_info.jsp" />


