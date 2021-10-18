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
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

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

</body>
<script type="text/javascript">
</script>

<c:import url="/WEB-INF/views/include/bottom_info.jsp" />