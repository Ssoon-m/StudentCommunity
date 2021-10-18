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
                  
                  <h3 class="text-center mb-4">School Info</h3>
                  
                  <form action="#" class="login-form">
                     <p>entrance year</p>
                     
                     <div class="form-group d-flex">
                        <select class="form-control rounded-left">
                           <option value="">entrance year</option>
                           <option value="2007">2007</option>
                           <option value="2010">2010</option>
                           <option value="2011">2011</option>
                           <option value="2012">2012</option>
                           <option value="2013">2013</option>
                           <option value="2014">2014</option>
                           <option value="2015">2015</option>
                           <option value="2016">2016</option>
                           <option value="2017">2017</option>
                           <option value="2018">2018</option>
                           <option value="2019">2019</option>
                           <option value="2020">2020</option>
                           <option value="2021">2021</option>
                        </select>
                     </div>
                     
                     <p>school</p>
                     <div class="form-group">
                        <input type="text" class="form-control rounded-left" placeholder="school" required>
                     </div>
                     
                     <div class="form-group text-center mb-4">
                        <a href="#">already a member!</a>
                     </div>
                     
                     <div class="form-group">
                        <button type="submit" class="btn btn-primary rounded submit p-3 px-5">Get   Started</button>   
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