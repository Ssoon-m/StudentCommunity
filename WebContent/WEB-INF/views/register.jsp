<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 절대경로 설정 -->
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<head>
   <title>StudentCommunity</title>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
   <link rel="stylesheet" href="${path}resources/css_member/style.css">
</head>

   <c:import url="/WEB-INF/views/include/head_meta.jsp" />
   <c:import url="/WEB-INF/views/include/top_menu.jsp" />
 
   <section style="margin-top:50px;" class="ftco-section">
      <div class="container">
         <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
               <div class="login-wrap p-4 p-md-5">
                  <div class="icon d-flex align-items-center justify-content-center">
                     <span class="far fa-user"></span>
                  </div>
                  
                  <h3 class="text-center mb-4">Sign up</h3>
                  
                  <form action="#" class="login-form">
                     <p>school</p>
                     <div class="form-group d-flex">
                        <input type="text" class="form-control rounded-left" value="school" readonly>
                     </div>
                     
                     <p>Email</p>
                     <div class="form-group">
                        <input type="text" class="form-control rounded-left" placeholder="Email" required>
                     </div>
                     
                     <p>password</p>
                     <div class="form-group d-flex">
                        <input type="password" class="form-control rounded-left" placeholder="Password" required>
                     </div>

                     <div class="form-group d-flex">
                        <input type="password" class="form-control rounded-left" placeholder="Password check" required>
                     </div>
                     
                     <p>Phone</p>
                     <div class="form-group d-flex">
                        <input type="text" class="form-control rounded-left" placeholder="Phone" required>
                     </div>
                     
                     <div class="form-group text-center mb-4">
                        <a href="#">already a member!</a>
                     </div>
                     
                     <div class="form-group">
                        <button type="submit" class="btn btn-primary rounded submit p-3 px-5">Get Started</button>   
                     </div>
                  </form>
               </div>
            </div>
         </div>
      </div>
   </section>

   <script src="${path}resources/js_member/jquery.min.js"></script>
   <script src="${path}resources/js_member/popper.js"></script>
   <script src="${path}resources/js_member/bootstrap.min.js"></script>
   <script src="${path}resources/js_member/main.js"></script>

 <c:import url="/WEB-INF/views/include/bottom_info.jsp" />
