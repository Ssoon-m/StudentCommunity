
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form"%>

<!-- 절대경로 설정   -->
<c:set var="path" value="${pageContext.request.contextPath}/" />


<!DOCTYPE html>
<html>

<head>
    <title>유니티</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${path}resources/css_member/style.css">
</head>

<c:import url="/WEB-INF/views/include/head_meta.jsp" />

<body style="background:linear-gradient(94deg,rgba(30, 161, 247,0.3), rgba(70, 207, 167, 0.3));">
<section style="margin-top:80px;" class="ftco-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="login-wrap p-4 p-md-5" style="box-shadow: 10px 10px 10px grey;">
                    <div class="icon d-flex align-items-center justify-content-center" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7);">
                        <span class="far fa-user"></span>
                    </div>

                    <h3 class="text-center mb-4" style="color:#46cfa7">Forgot Password</h3>

                    <form:form action="/member/change_password" method="post" modelAttribute="forgotMemberDTO" class="login-form"/>


                </div>
            </div>
        </div>
    </div>
</section>
</body>

<script type="text/javascript">


</script>

<script src="${path}resources/js_member/jquery.min.js"></script>
<script src="${path}resources/js_member/popper.js"></script>
<script src="${path}resources/js_member/bootstrap.min.js"></script>
<script src="${path}resources/js_member/main.js"></script>

<c:import url="/WEB-INF/views/include/bottom_info.jsp" />