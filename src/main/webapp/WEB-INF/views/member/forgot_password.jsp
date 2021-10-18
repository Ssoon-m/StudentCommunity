
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
                  
                  <form:form action="/member/change_password" onsubmit="return passwordCheck();" method="post" modelAttribute="forgotMemberDTO" class="login-form">
                     
                     <h5>Email</h5>
                     <div class="form-group">
                        
                        <div>
                        <form:input path="email" placeholder="E-Mail" class="col-sm-5 float-left form-control rounded-left email" onkeypress="resetInputUserEmail()"/>@
                          
		                  <form:select path="domain" class="col-sm-6 float-right form-control rounded-left domain">
		                     <form:option value="naver.com">naver.com</form:option>
		                     <form:option value="Gmail.com">Gmail.com</form:option>
		                  </form:select>
                  
                  <br><br> 
                  
                   <form:hidden path="emailAuth" />
                   <form:errors path="emailAuth" style="color:red;" />
                   
                  </div>
                  
                     <input type="button" value="인증하기" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7); color:#fff; float:right;" class="btn w-25 sendMail"> <br><br>
                     <section class="check-section">
                     
                     <input type="text" placeholder="인증번호 입력" style="display: none;"
                           class="form-control rounded-left compare">
                           <span id="timer"></span> <!-- 타이머 보이기 -->
                           <button type="button" class="compare-button btn " style=" display:none; background:linear-gradient(94deg,#1ea1f7,#46cfa7); color:#fff; float:right;" onClick="checkKey();">인증번호 확인</button>
                           <span class="compare-text" style="display: none"></span>
                     </section>
                  
                   </div>



                     
                     <div class="form-group text-center mb-4">
                        <a href="${path}member/before_register" style="color:#46cfa7; float:left; font-weight:bold;">회원가입</a>
                     </div>

                      <div id = "newPassword">
                      </div>

                      <div>
                          <font id="chkNotice1" size="2"></font>
                          <font id="chkNotice2" size="2"></font>
                      </div>

                   <div class="form-group" id = "postSubmit">
                   </div>
                     

                     
                  </form:form>
                  
               </div>
            </div>
         </div>
      </div>
   </section>
</body>   
   
   <script type="text/javascript">
   
   $(".sendMail").click(function() {
      var key = "";
         var mail = $(".email").val();
         
          if(mail == ""){
             alert("메일 주소를 입력해주세요.")
          } else {
             mail = mail + "@" + $(".domain").val();
             $.ajax({
               type : 'post',
               url : '/CheckMail',
               data : {
                  mail : mail,
                  where : "login"
                  },
               dataType : 'json',
               
               //contentType : "application/json; charset=utf-8",

               success : function(data){
                  
                  console.log(data.key);// 나중에 꼭 지워주기!!!!!
                  console.log(data);
                  
                  if(data.key == "false"){
                  		alert("존재하지 않는 아이디입니다");
                  		return;
                  }
                  
                  key = data.key;
                  alert("인증번호가 전송되었습니다.");
                  $(".compare-button").css("display","block");
                  $(".compare").css("display", "block");
                  $(".compare-text").css("display", "block");
               
                  // 타이머 구현
                  function $ComTimer(){
                      //prototype extend
                  }

                  $ComTimer.prototype = {
                      comSecond : ""
                      , fnCallback : function(){}
                      , timer : ""
                      , domId : ""
                      , fnTimer : function(){
                          var m = Math.floor(this.comSecond / 60) + "분 " + (this.comSecond % 60) + "초";
                          this.comSecond--;   // 1초씩 감소
                          // console.log(m);
                          this.domId.innerText = m;
                          if (this.comSecond < 0) {         // 시간이 종료 되었으면..
                              clearInterval(this.timer);      // 타이머 해제
                              /* window.close();
                              window.opener.location = "/index.do" */
                          }
                      }
                      ,fnStop : function(){
                          clearInterval(this.timer);
                      }
                  }

                  var AuthTimer = new $ComTimer()

                  AuthTimer.comSecond = 60; // 제한 시간

                  AuthTimer.timer =  setInterval(function(){AuthTimer.fnTimer()},1000); 

                  AuthTimer.domId = document.getElementById("timer"); 

               }
             });
             
          }
     });
     
       function resetInputUserEmail() {
            // 사용자 이메일 입력하는 곳에서 (input)
            // 키보드를 누르면 무조건 false로! 초기값 세팅
            $("#emailAuth").val("-1");
            //$("#checkUser").val("false");
      }
            
        function checkKey(){
            
            var key = $(".compare").val();
            
            $.ajax({
              url: '/CheckEmailKey', 
              
              type : 'post',   
              
              data : {
                       'key' : key
                    },
                                            
              dataType: 'text',                  
              
              success : function(result){  
                 if(result.trim() == 'true'){
                    alert('인증되었습니다.');
                    $(".compare-text").text("인증 성공!").css("color", "blue");
                    $("#emailAuth").val("1");
                    $(".compare-button").css("display","none");
                    $(".compare").css("display", "none");
                    $("#timer").css("display", "none");
                    $(".sendMail").css("display", "none");
                    var append = '';
                    append+='<button type="submit" class="btn rounded submit p-3 px-5" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7); color:#fff">Change Password</button>';

                    $("#postSubmit").append(append);

                     append = '';
                     append+='<h5>Password</h5>';
                     append+='<div class="form-group d-flex">';
                     append+='<input type="password" name = "password" id = "password" class="form-control rounded-left" placeholder="Password" />';
                     append+='</div>';
                     append+='<h5>repeat-Password</h5>';
                     append+='<div class="form-group d-flex">';
                     append+='<input type="password" id = "password2" class="form-control rounded-left" placeholder="repeat-Password" />';
                     append+='</div>';

                     $("#newPassword").append(append);


                    
                 }else if(result.trim() == 'timeout'){
                    alert('인증번호가 만료되었습니다.');
                    $(".compare-text").text("불일치!").css("color", "red");
                    $("#emailAuth").val("-1");
                 }else{
                    $(".compare-text").text("불일치!").css("color", "red");
                    alert('인증번호가 다릅니다.');
                    $("#emailAuth").val("-1");
                    
                 }
              }
            });
         }
       
       // 엔터키 눌렀을때 서브밋 막기
       $(document).keypress(function(e) { 
          if (e.keyCode == 13) 
             e.preventDefault(); 
          });


       function passwordCheck(){

           var pw1 = $('#password').val();
           return checkPassword(pw1);
       }

   function checkPassword(password){

       if($('#password').val() != $('#password2').val()){
           $('#chkNotice2').html('비밀번호 일치하지 않음<br><br>');
           $('#chkNotice2').attr('color', 'red');
           return false;
       }

       if(!/^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-])(?=.*[0-9]).{8,16}$/.test(password)){
           $('#chkNotice1').html('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.(최대 16글자)');
           $('#chkNotice1').attr('color', 'red');
           return false;
       }

       if(/(\w)\1\1\1/.test(password)){
           $('#chkNotice1').html('같은 문자를 4번 이상 사용하실 수 없습니다.');
           $('#chkNotice1').attr('color', 'red');
           return false;
       }

       return true;
   }


   </script>
   
   <script src="${path}resources/js_member/jquery.min.js"></script>
   <script src="${path}resources/js_member/popper.js"></script>
   <script src="${path}resources/js_member/bootstrap.min.js"></script>
   <script src="${path}resources/js_member/main.js"></script>

 <c:import url="/WEB-INF/views/include/bottom_info.jsp" />