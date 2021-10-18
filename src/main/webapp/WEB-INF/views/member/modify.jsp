
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
                  <div class="icon d-flex align-items-center justify-content-center" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7);">
                     <span class="far fa-user"></span>
                  </div>
                  
                  <h3 class="text-center mb-4" style="color:#46cfa7">Update Information</h3>
                  
                  <form:form action="${path }member/modify_proc" method="post" modelAttribute="modifyMemberDTO" class="login-form" enctype="multipart/form-data">
                     
                     <p>profile image</p>
                     <div class="img">
                        <img src="${path}resources/${modifyMemberDTO.img};" style="width:100px; height:100px; margin-left:35%;" id="preview-image" >
                     </div> 
                     <div class="form-group d-flex">
                        <input type="file" id="gdsImg" name="files" value="${modifyMemberDTO.img}"/>
                     </div>
                     <input type="button" class="test" id="imageDelete" value="삭제" />
                <form:input type="hidden" value="${modifyMemberDTO.id}" id="id"  path="id"/>
                <input type="hidden" id="imgPath"  value="${modifyMemberDTO.img}"/>
                <input type="hidden" id="srcPath"  value="${path}resources/" />               

                     <p>school</p>
                     <div class="form-group d-flex">
                       <input type="text" class="form-control rounded-left" value="${modifyMemberDTO.universityName}" readonly> 
                     </div>
                     
                     <p>Email</p>
                     <div class="form-group d-flex">
                        <input value="${modifyMemberDTO.email }" class="form-control rounded-left email" readonly/>
                     </div>
                     
                      <p>name</p>
                      <div class="form-group d-flex">
                          <input value="${modifyMemberDTO.name }" type="text" name="name" id="name" class="form-control rounded-left" oninput = "checkId()" placeholder="Nickname" />
                          <div class="input-group-append">
                              <button type="button" class="btn" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7); color:#fff" onClick="checkUserName();">중복확인</button>
                          </div>
                      </div>
                      <form:errors path="name" style="color:red;" />
                      <font id="checkMessage" size="2"></font>

                      <form:hidden path="checkUser" />
                      <form:errors path="checkUser" style="color:red;" />

                     
                     <p>password</p>
                     <div class="form-group d-flex">
                        <form:password value="${password}" path="password" class="form-control rounded-left"/>
                     </div>
                     <form:errors path="password" style="color:red;" />
                        <font id="chkNotice1" size="2"></font>
                       <div class="form-group d-flex">
                        <form:password path="password2" class="form-control rounded-left" placeholder="Password check" />
                       </div>
                        <form:errors path="password2" style="color:red;" />
                        <font id="chkNotice2" size="2"></font>

                     <div class="form-group">
                        <button type="submit" class="btn rounded submit p-3 px-5" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7); color:#fff">Update</button>   
                     </div>


                  </form:form>
                  
               </div>
            </div>
         </div>
      </div>
   </section>
</body>

 <script type="text/javascript">

     $('#checkUser').val(false);

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


function onClick() {   
   var src = $('#imgPath').val();
   var id =$('#id').val();   
   var test =$('.test').val();
   //$('#').val(); //id
   //$('.').val(); //class
   //$('input[name= NAME ]').val // name
   //파일 초기화
   console.log("src==>" , src ,"id==>",id);
   console.log('test-->',test);
   
   var testarr = new Array();   
   testarr.push('1');
   testarr.push('2');
   testarr.push('3');
   //
   console.log(testarr);
   //
   $.ajax({
      
      url : '/member/imgDelete',
        type : 'post',
           data : {
              id : id,
               path:src
           },
        dataType : 'json',
        
        //contentType : "application/json; charset=utf-8",

        success : function(data){
          
           console.log('data',data);
         //여기로!!
         $('#imgPath').val(data.img);
        }
      });   
   console.log(JSON.stringify(testarr));
   return ;
}
document.getElementById('imageDelete').addEventListener('click', onClick);


$(function(){
    $('#password').keyup(function(){
      $('#chkNotice2').html('');
    });

    $('#password2').keyup(function(){

        if($('#password').val() != $('#password2').val()){
          $('#chkNotice2').html('비밀번호 일치하지 않음<br><br>');
          $('#chkNotice2').attr('color', 'red');
        } else{
          $('#chkNotice2').html('비밀번호 일치함<br><br>');
          $('#chkNotice2').attr('color', 'blue');
        }

    });
});

$("#password").change(function(){
    checkPassword($('#password').val());
});
function checkPassword(password){
    
    if(!/^(?=.*[a-zA-Z])(?=.*[~!@#$%^*+=-])(?=.*[0-9]).{8,16}$/.test(password)){     
       $('#chkNotice1').html('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.(최대 16글자)');
       $('#chkNotice1').attr('color', 'red');
        $('#password').val('').focus();
        return false;
    }else{
       $('#chkNotice1').html('사용하실 수 있는 비밀번호 입니다.');
       $('#chkNotice1').attr('color', 'blue');
    }    
    
    /* var checkNumber = password.search(/[0-9]/g);
    var checkEnglish = password.search(/[a-z]/ig);
    if(checkNumber <0 || checkEnglish <0){
        alert("숫자와 영문자를 혼용하여야 합니다.");
        $('#password').val('').focus();
        return false;
    } */
    
    if(/(\w)\1\1\1/.test(password)){
        $('#chkNotice1').html('같은 문자를 4번 이상 사용하실 수 없습니다.');
        $('#chkNotice1').attr('color', 'red');
        $('#password').val('').focus();
        return false;
    }
      
    return true;
}



function checkUserName(){

    const user = $("#name").val();

    $.ajax({
        url: '/member/checkUser/' + user,
        type : 'get',

        dataType: 'text',

        success : function(result){
            if(result.trim() == 'true'){
                alert('사용할 수 있는 닉네임입니다');
                $('#checkMessage').html('중복확인 완료');
                $('#checkMessage').attr('color', 'blue');
                $('#checkUser').val(true);

            }else{
                // 글자가 하나만 들어왔을때도 해당 알림을 띄운다. 다시 생각해봐야 할듯
                alert('이미 존재하는 닉네임입니다');
                $('#checkMessage').html('닉네임을 다시 입력해주세요');
                $('#checkMessage').attr('color', 'red');
                $('#name').val('').focus();
                $('#checkUser').val(false);
            }
        }
    });
}


// 닉네임 유효성 검사
$("#name").change(function(){
    checkName($('#name').val());
});
function checkName(name){
    if(!/^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,8}$/.test(name)){
        $('#checkMessage').html('사용하실 수 없는 닉네임 입니다.<br>(2글자 ~ 8글자)');
        $('#checkMessage').attr('color', 'red');
        $('#name').val('').focus();
        return false;
    }/* else{
          $('#checkMessage').html('사용하실 수 있는 닉네임 입니다.');
          $('#checkMessage').attr('color', 'blue');
       }     */
}

</script>

   
   

   <script src="${path}resources/js_member/jquery.min.js"></script>
   <script src="${path}resources/js_member/popper.js"></script>
   <script src="${path}resources/js_member/bootstrap.min.js"></script>
   <script src="${path}resources/js_member/main.js"></script>

 <c:import url="/WEB-INF/views/include/bottom_info.jsp" />