<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.request.contextPath}/" />

<head>
   <link rel="preconnect" href="https://fonts.gstatic.com">
   <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
</head>

<body>

<nav id="top" class="navbar navbar-expand-md navbar-dark back fixed-top shadow-lg" style="border-bottom: solid 1px gray; border-top: solid 1px gray;">
   <!-- navbar-brand의 content 변경 -->
	<c:if test="${loginMemberDTO.isUserLogin()==true }">
   <a class="navbar-brand text-white mx-5" href="${root}/university/${loginMemberDTO.universityId}">
	   </c:if>

		   <c:if test="${loginMemberDTO.isUserLogin()==false }">
		   <a class="navbar-brand text-white mx-5" href="${root}/">
			   </c:if>

      <i class="fas fa-school fa" style="padding-top:5px" >
         <h2 class="font" style="float:right">&nbsp;${universityName}유니티</h2>
      </i>
   </a>

      <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false"
            aria-label="Toggle navigation">
         <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse menu" id="navbarSupportedContent">
         <span class="row mx-auto">
             <li id="top_dropdown" class="nav-item dropdown list-unstyled">
               <a style="cursor:pointer;" id="top_nav_link_dropdown_toggle" class="nav-link dropdown-toggle font "  data-toggle="dropdown">
                  <h2 class="font mx-3">게시판</h2>
               </a>
               <!-- 임시 드롭다운 메뉴 -->
               <div id="top_dropdown_menu" class="dropdown-menu dropdown-menu-left" style="background-color: rgb(247, 243, 243)">
                  <div id="submenu">
									<div class="wrap">

										<div class="divider"></div>
										<div class="group">
													<ul id = "BASIC">
											<c:forEach items="${boardList}" var="boardList">
												<c:if test="${boardList.description eq 'BASIC'}">
													<li><a href=${root}"/board/${boardList.id}" style="color: #2db2db; font-family: Jua, sans-serif;">${boardList.name}게시판</a></li>
												</c:if>
											</c:forEach>
												</ul>
												</div>


										<div class="divider"></div>
										<div class="group">
											<ul id = "UNIQUE">
											<c:forEach items="${boardList}" var="boardList">
												<c:if test="${boardList.description eq 'UNIQUE'}">
													<li><a href=${root}"/board/${boardList.id}" style="color: #2db2db; font-family: Jua, sans-serif;">${boardList.name}게시판</a></li>
												</c:if>
											</c:forEach>
											</ul>
										</div>


										<div class="divider"></div>
										<div class="group">
											<ul id = "ETC">
											<c:forEach items="${boardList}" var="boardList">
												<c:if test="${boardList.description eq 'ETC'}">
													<li><a href=${root}"/board/${boardList.id}" style="color: #2db2db; font-family: Jua, sans-serif;">${boardList.name}게시판</a></li>
												</c:if>
											</c:forEach>
											</ul>
										</div>




									</div>
							</div>
						</div>
            </li>
            <a id="top_nav_link" href="${path}function/timeTable" class="nav-link font"><h2 class="font mx-3">시간표</h2></a>
            <a id="top_nav_link" href="${path}course" class="nav-link font"><h2 class="font mx-3">강의평가</h2></a>
            <a id="top_nav_link" href="${path}function/credit_calculator" class="nav-link font"><h2 class="font mx-3">학점계산기</h2></a>
			<a id="top_nav_link" href="${path}function/todayMenu" class="nav-link font"><h2 class="font mx-3">오늘뭐먹지?</h2></a>
			<a id="top_nav_link" href="${path}function/chatting" class="nav-link font"><h2 class="font mx-3">실시간 채팅</h2></a>

         </span>

         <li id="top_dropdown" class="nav-item dropdown list-unstyled mx-5">
            <!-- 드롭다운 메뉴-->
            <a id="top_nav_link_dropdown_toggle" class="nav-link dropdown-toggle"  data-toggle="dropdown">
               <i class="fas fa-users" ></i>
               <span class="font" style="font-size: 21px;">&nbsp;회원정보</span>
				<c:if test="${messageNum==0}">
				<i id="replyalarm1" class="fas fa-bell" style="color:yellow; float:right; display:none;"></i>
				</c:if>
               <c:choose>
			   		<c:when test="${messageNum!=0}">
               			<i class="fas fa-bell" style="color:yellow; float:right;"></i>
               		</c:when>
               </c:choose>

            </a>

            <div id="top_dropdown_menu" class="dropdown-menu">
               <c:choose>
               		<c:when test="${loginMemberDTO.isUserLogin()==true }">
               			<a class="dropdown-item" href="${path}member/myPage" style="color: #46cfa7; font-family: Jua, sans-serif;">마이페이지</a>
               			<a class="dropdown-item" href="${path}member/myNote" style="color: #46cfa7; font-family: Jua, sans-serif;">
	               			쪽지함
				   			<c:if test="${messageNum==0}">
								<i id="replyalarm2" class="fas fa-exclamation" style="color:red; float:right; display:none;"></i>
							</c:if>
							<c:choose>
				            	<c:when test="${messageNum!=0}">
				               		<i class="fas fa-exclamation" style="color:red; float:right;"></i>
				               	</c:when>
			            	</c:choose>

						</a>
               			<a class="dropdown-item" href="${path}member/logout" style="color: #46cfa7; font-family: Jua, sans-serif;">로그아웃</a>
               		</c:when>
               		<c:otherwise>
               			<a class="dropdown-item" href="${path}member/login" style="color: #46cfa7; font-family: Jua, sans-serif;">로그인</a>
               			<a class="dropdown-item" href="${path}member/before_register" style="color: #46cfa7; font-family: Jua, sans-serif;">회원가입</a>
               		</c:otherwise>
               </c:choose>
            </div>
         </li>
      </div>
   </nav>

<div id="socketAlert" class="alert alert-danger" style="position:absolute; top:140px; display: none;" role="alert">

</div>


