<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- 절대경로 설정 -->
<c:set var="path" value="${pageContext.request.contextPath}/" />

<!DOCTYPE html>
<html lang="en">

<head>
   <title>유니티</title>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
   <link rel="stylesheet" href="${path}resources/css_member/style.css">
</head>

   <section style="margin-top:50px;" class="ftco-section">
      <div class="container">
         <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
               <div class="login-wrap p-4 p-md-5">
                  <div class="icon d-flex align-items-center justify-content-center">
                     <span class="far fa-user"></span>
                  </div>
                  
                  <h3 class="text-center mb-4">Login Denied</h3>
                  
                  <form:form action="${path}member/logout" method="get" class="login-form">
                     <div class="form-group">
                     	<p>정지기간</p>
                        <input style="color:red;" type="text" class="form-control rounded-left" value="${endOn}" readonly/>
                     </div>
                     
                     <div class="form-group">
                     	<p>정지사유</p>
                        <input style="color:red;" type="text" class="form-control rounded-left" value="${reason}" readonly/>
                     </div>
                     
                     <div class="form-group">
                        <button type="submit" class="btn btn-primary rounded submit p-3 px-5">로그아웃</button>   
                     </div>
                  </form:form>
               </div>
            </div>
         </div>
      </div>
   </section>

   <script src="${path}resources/js_member/jquery.min.js"></script>
   <script src="${path}resources/js_member/popper.js"></script>
   <script src="${path}resources/js_member/bootstrap.min.js"></script>
   <script src="${path}resources/js_member/main.js"></script>

