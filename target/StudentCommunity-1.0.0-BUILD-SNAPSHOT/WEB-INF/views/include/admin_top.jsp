<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${pageContext.request.contextPath}/" />

<head>
   <link rel="preconnect" href="https://fonts.gstatic.com">
   <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
</head>

<body>
<nav id="top_top" class="navbar navbar-expand-md navbar-dark back fixed-top shadow-lg" style="border-bottom: solid 1px gray; border-top: solid 1px gray;">
   <!-- navbar-brand의 content 변경 -->
   <a class="navbar-brand text-white mx-5" href="${pageContext.request.contextPath}/admin/admin_index">
      <i class="fas fa-school fa" style="padding-top:5px" >
         <h2 class="font" style="float:right">&nbsp;관리자 페이지</h2>
      </i>
   </a>

   <button class="navbar-toggler" type="button" data-toggle="collapse"
         data-target="#navbarSupportedContent"
         aria-controls="navbarSupportedContent" aria-expanded="false"
         aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
   </button>

   <div class="collapse navbar-collapse menu" id="navbarSupportedContent" style="padding-top:5px">
         <span class="row mx-auto">

           <a id="top_nav_link" href="${pageContext.request.contextPath}/admin/admin_index" class="nav-link font"><h3 class="mx-3">게시글관리</h3></a>
           <a id="top_nav_link" href="${pageContext.request.contextPath}/admin/replyManagement" class="nav-link font"><h3 class="mx-3">댓글관리</h3></a>
           <a id="top_nav_link" href="${pageContext.request.contextPath}/admin/admin_member" class="nav-link font"><h3 class="mx-3">회원관리</h3></a>
           <a id="top_nav_link" href="${pageContext.request.contextPath}/admin/admin_universityCategory" class="nav-link font"><h3 class="mx-3">대학관리</h3></a>
           <a id="top_nav_link" href="${pageContext.request.contextPath}/admin/admin_courseRating" class="nav-link font"><h3 class="mx-3">강의평가 관리</h3></a>


          <!-- <a id="top_nav_link" href="#" class="nav-link"><h3 class="mx-5">&nbsp;</h3></a>
             <a id="top_nav_link" href="#" class="nav-link"><h3 class="mx-5">&nbsp;</h3></a> -->
         </span><!-- mr-auto 다음 블럭부터는 오른쪽 정렬로 나옴-->

      <li id="top_dropdown" class="nav-item dropdown list-unstyled mx-5">
         <!-- 드롭다운 메뉴-->
          <a id="top_nav_link_dropdown_toggle" class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">
             <i class="fas fa-users" ></i><span class="font" style="font-size: 21px;">&nbsp;회원정보</span>
          </a>


         <div id="top_dropdown_menu" class="dropdown-menu">
            <c:choose>
               <c:when test="${loginMemberDTO.isUserLogin()==true }">
                  <%-- <a class="dropdown-item" href="${path}member/myPage">마이페이지</a> --%>
                  <a class="dropdown-item" href="${path}member/logout">로그아웃</a>
               </c:when>
               <c:otherwise>
                  <a class="font dropdown-item" href="${path}member/login">로그인</a>
                  <a class="font dropdown-item" href="${path}member/before_register">회원가입</a>
               </c:otherwise>
            </c:choose>
         </div>

      </li>
   </div>
</nav>
</body>
</html>