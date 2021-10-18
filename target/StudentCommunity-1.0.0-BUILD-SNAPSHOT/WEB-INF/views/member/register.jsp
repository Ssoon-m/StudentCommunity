
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
<c:import url="/WEB-INF/views/include/top_menu.jsp" />

<body style="background:linear-gradient(94deg,rgba(30, 161, 247,0.3), rgba(70, 207, 167, 0.3));">
<section style="margin-top:100px;" class="ftco-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="login-wrap p-4 p-md-5">
                    <div class="icon d-flex align-items-center justify-content-center" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7);  ">
                        <span class="far fa-user"></span>
                    </div>

                    <h3 class="text-center mb-4" style="color:#46cfa7">Sign up</h3>

                    <form:form action="/member/registration" method="post" modelAttribute="memberDTO" class="login-form">
                        <h5>School</h5>
                        <div class="form-group d-flex">
                            <form:input path="universityName" class="form-control rounded-left" value="${universityName }" readonly="true"/>
                        </div>

                        <h5>Email</h5>
                        <div class="form-group">

                            <div>
                                <form:input path="email" placeholder="E-Mail" class="col-sm-5 float-left form-control rounded-left email" onkeypress="resetInputUserEmail()"/>@
                                <form:errors path="email" style="color:red;" />

                                <form:select path="domain" class="col-sm-6 float-right form-control rounded-left domain">
                                    <form:option value="naver.com">naver.com</form:option>
                                    <form:option value="Gmail.com">Gmail.com</form:option>
                                </form:select>

                                <br><br>

                                <form:hidden path="emailAuth" />
                                <form:errors path="emailAuth" style="color:red;" />

                            </div>

                            <input type="button" value="인증하기" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7); color:#fff" class="btn w-25 sendMail"> <br><br>
                            <section class="check-section">

                                <input type="text" placeholder="인증번호 입력" style="display: none;"
                                       class="form-control rounded-left compare">
                                <span id="timer"></span> <!-- 타이머 보이기 -->
                                <button type="button" class="compare-button btn " style=" display:none; background:linear-gradient(94deg,#1ea1f7,#46cfa7); color:#fff" onClick="checkKey();">인증번호 확인</button>
                                <span class="compare-text" style="display: none"></span>
                            </section>

                        </div>


                        <h5>Nickname</h5>
                        <div class="form-group d-flex">
                            <input type="text" name="name" id="name" class="form-control rounded-left" oninput = "checkId()" placeholder="Nickname" />
                            <div class="input-group-append">
                                <button type="button" class="btn" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7); color:#fff" onClick="checkUser();">중복확인</button>
                            </div>
                        </div>
                        <form:errors path="name" style="color:red;" />
                        <font id="checkMessage" size="2"></font>


                        <h5>Password</h5>
                        <div class="form-group d-flex">
                            <form:password path="password" class="form-control rounded-left" placeholder="Password" />
                        </div>
                        <form:errors path="password" style="color:red;" />
                        <font id="chkNotice1" size="2"></font>

                        <div class="form-group d-flex">
                            <form:password path="password2" class="form-control rounded-left" placeholder="Password check" />
                        </div>
                        <form:errors path="password2" style="color:red;" />
                        <font id="chkNotice2" size="2"></font>

                        <div class="form-group text-center mb-4">
                            <a href="${path}member/login" style="color:#46cfa7; font-weight:bold;">already a member!</a>
                        </div>

                        <form:hidden  path="status" value="${memberStatus}"/>
                        <form:hidden  path="universityId" value="${universityId }"/>

                        <div class="form-group">
                            <button type="submit" style="background:linear-gradient(94deg,#1ea1f7,#46cfa7); color:#fff"  class="btn rounded submit p-3 px-5">Get Started</button>
                        </div>

                    </form:form>

                </div>
            </div>
        </div>
    </div>
</section>
</body>


<script type="text/javascript">


    // $(function() {

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
                    where : "register"
                },
                dataType : 'json',

                //contentType : "application/json; charset=utf-8",

                success : function(data){

                     console.log(data.key);// 나중에 꼭 지워주기!!!!!
                     console.log(data);

                    if(data.key == "false"){
                        alert("이미 존재하는 아이디입니다.");
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

                    // AuthTimer.fnCallback = function(){alert("다시인증을 시도해주세요.")}; // 제한 시간 만료 메세지

                    AuthTimer.timer =  setInterval(function(){AuthTimer.fnTimer()},1000);

                    AuthTimer.domId = document.getElementById("timer");

                }
            });

        }
    });




    /*         키보드 누르는 즉시 계속 체크해주는 로직

              $(".compare").on("propertychange change keyup paste input", function() {
                  if ($(".compare").val() == key) {   //인증 키 값을 비교를 위해 텍스트인풋과 벨류를 비교
                     $(".compare-text").text("인증 성공!").css("color", "blue");

                     $("#emailAuth").val("1");

                     isCertification = true;  //인증 성공여부 check
                  } else {
                     $(".compare-text").text("불일치!").css("color", "red");

                     $("#emailAuth").val("-1");

                     isCertification = false; //인증 실패
                  }
               });

    */

    //  });



    function resetInputUserEmail() {
        // 사용자 이메일 입력하는 곳에서 (input)
        // 키보드를 누르면 무조건 false로! 초기값 세팅
        $("#emailAuth").val("-1");
        //$("#checkUser").val("false");
    }




    function checkUser(){

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
                    //$('#checkUser').val('true');

                }else{
                    // 글자가 하나만 들어왔을때도 해당 알림을 띄운다. 다시 생각해봐야 할듯
                    alert('이미 존재하는 닉네임입니다');
                    $('#checkMessage').html('닉네임을 다시 입력해주세요');
                    $('#checkMessage').attr('color', 'red');
                    $('#name').val('').focus();
                    //$('#checkUser').val('false');
                }
            }
        });
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




    // 엔터키 눌렀을때 서브밋 막기
    $(document).keypress(function(e) {
        if (e.keyCode == 13)
            e.preventDefault();
    });


</script>




<script src="${path}resources/js_member/jquery.min.js"></script>
<script src="${path}resources/js_member/popper.js"></script>
<script src="${path}resources/js_member/bootstrap.min.js"></script>
<script src="${path}resources/js_member/main.js"></script>

<c:import url="/WEB-INF/views/include/bottom_info.jsp" />