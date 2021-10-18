<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>유니티</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css_top/top.css">
    <link rel="stylesheet" href="${path}/resources/css_home/home.css">


</head>


<script>

    // 다른페이지 어디서든 꺼내쓸수 있게 전역으로 처리
    var socket = null;
    // 도큐먼트가 완전히 준비가 됐을때 시작
    $(document).ready(function(){
        // $.ajax({
        //     url: "ws://localhost:8090/replyHandler",
        //     type: "get",
        //     success: function (data) {
        //     },
        //     error: function(request, status, error){
        //         alert("서버통신 오류");
        //         console.log(request,status,error);
        //     }
        // });
        connectWS();
    })


    function connectWS(){
       //var ws = new WebSocket("ws://localhost:8090/replyHandler");
        var ws = new WebSocket("ws://tkksm.cafe24.com/replyHandler");

        socket = ws;
        // event listener 라고 한다. connection이 연결 됐을때 동작
        ws.onopen = function (){
            console.log('Info: connection opened.');
            // setTimeout(function(){connect();},1000); // retry connection;
        };
        ws.onmessage = function(event){
            $(".compare-button").css("display","block");
            console.log("ReceiveMessage:", event.data+'\n');
            $('#socketAlert').css("display","block");
            //$('#socketAlert').text(event.data);
            $('#socketAlert').html(event.data);

            $('#replyalarm1').css("display","block");
            $('#replyalarm2').css("display","block");

            // 10초 뒤에 알람창 꺼짐
            setTimeout(function(){
                $('#socketAlert').css('display','none');
            },10000);

        };
        ws.onclose = function (event) {
            console.log('Info: connection closed.');
        };
        ws.onerror = function(event){
            console.log("error : " + event);

        }
    }


</script>