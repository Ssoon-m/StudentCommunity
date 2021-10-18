
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form"%>

<!-- 절대경로 설정   -->
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

   <c:import url="/WEB-INF/views/include/head_meta.jsp" />
   <c:import url="/WEB-INF/views/include/top_menu.jsp" />

<body style="background:linear-gradient(94deg,rgba(30, 161, 247,0.3), rgba(70, 207, 167, 0.3));">
   <section style="margin-top:50px;" class="ftco-section">
      <div class="container">
         <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
               <div class="login-wrap p-4 p-md-5">
                  <div class="icon d-flex align-items-center justify-content-center" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7)">
                     <span class="far fa-user"></span>
                  </div>
                  
                  <h3 class="text-center mb-4" style="color:#46cfa7">회원탈퇴</h3>
                  
                  <form:form action="${path }member/after_memberdelete_proc" method="post" modelAttribute="deleteMemberDTO" class="login-form" enctype="multipart/form-data">

                     <p>Name</p>
                     <div class="form-group d-flex">
                        <input value="${loginMemberDTO.name }" class="form-control rounded-left"readonly/>
                     </div>
                     
                     <p>Email</p>
                     <div class="form-group d-flex">
                        <input value="${loginMemberDTO.email }" class="form-control rounded-left email"/>
                     </div>
                     
                     <p>Password</p>
                     <div class="form-group d-flex">
                        <form:password value="${password}" path="password" class="form-control rounded-left"/>
                     </div>
                     
                     <div class="form-group">
                        <button type="submit" class="btn rounded submit p-3 px-5" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7); color:#fff">회원탈퇴</button>   
                     </div>
                     
                  </form:form>
                  
               </div>
            </div>
         </div>
      </div>
   </section>
</body>
<!--    <script type="text/javascript">

 function readImage(input) {
    // 인풋 태그에 파일이 있는 경우
    if(input.files && input.files[0]) {
        // 이미지 파일인지 검사 (생략)
        // FileReader 인스턴스 생성
        const reader = new FileReader()
        // 이미지가 로드가 된 경우
        reader.onload = e => {
            const previewImage = document.getElementById("preview-image");
            previewImage.src = e.target.result;
        }
        // reader가 이미지 읽도록 하기
        reader.readAsDataURL(input.files[0])
    }
 }

   // input file에 change 이벤트 부여
   const inputImage = document.getElementById("gdsImg")
   inputImage.addEventListener("change", e => {
       readImage(e.target)
   })


</script>
    -->
   

   <script src="${path}resources/js_member/jquery.min.js"></script>
   <script src="${path}resources/js_member/popper.js"></script>
   <script src="${path}resources/js_member/bootstrap.min.js"></script>
   <script src="${path}resources/js_member/main.js"></script>

 <c:import url="/WEB-INF/views/include/bottom_info.jsp" />