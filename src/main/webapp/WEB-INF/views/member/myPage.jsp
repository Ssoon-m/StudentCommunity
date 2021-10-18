
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
   <link rel="stylesheet" href="${path}resources/css_myPage/style.css">
</head>

   <c:import url="/WEB-INF/views/include/head_meta.jsp" />
   <c:import url="/WEB-INF/views/include/top_menu.jsp" />

<body style="background:linear-gradient(94deg,rgba(30, 161, 247,0.3), rgba(70, 207, 167, 0.3));">
   <section class="ftco-section">
      <div class="container">
         <div class="row justify-content-center">
            <div class="col-md-6 text-center mb-4"></div>
         </div>

         <div class="row memberInfoTable" style="display:block;">
            <div class="col-md-12">

               <button style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right; margin-right:5px; font-family: Jua, sans-serif;" onClick="viewComment()">좋아요 누른 글</button>
               <button style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right; margin-right:5px; font-family: Jua, sans-serif;" onClick="viewWritten()">내가 쓴 글</button>
               <button style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right; margin-right:5px; font-family: Jua, sans-serif;" onClick="viewMyPage()">프로필</button>

               <h3 class="h5 mb-4 text-left" style="font-family: Jua, sans-serif;">Profile</h3>

               <div class="table-wrap">
                  <table class="table">
                     <thead style="background:linear-gradient(94deg,#46cfa7,#1ea1f7);">
                        <tr>
                           <th>&nbsp;</th>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">School</th>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">Name</th>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">Email</th>
                           <th>&nbsp;</th>
                           <th>&nbsp;</th>
                        </tr>
                     </thead>

                     <tbody>
                        <tr class="alert" role="alert">
                           <td>
                              <div class="img">
                                    <img src="${path}resources/${loginMemberDTO.img};" style="width:100px; height:100px;" >
                              </div>
                           </td>

                           <td>
                              <div class="email">
                                 <span style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">${loginMemberDTO.universityName }</span>
                                 <span style="font-weight: bold; font-family: Jua, sans-serif;">201710944</span>
                              </div>
                           </td>

                           <td style="font-weight: bold; font-family: Jua, sans-serif;">${loginMemberDTO.name }</td>

                           <td style="font-weight: bold; font-family: Jua, sans-serif;">${loginMemberDTO.email }</td>

                           <td><a href="${path}member/before_modify" style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">정보수정</a></td>
                           <td><a href="${path}member/before_memberdelete" style="font-weight: bold; font-size: 1em; color:red; font-family: Jua, sans-serif;">회원탈퇴</a></td>
                        </tr>
                     </tbody>
                  </table>
               </div>
            </div>
         </div>

         <div class="row wroteListTable" style="display:none;">
            <div class="col-md-12">

               <button style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right; margin-right:5px; font-family: Jua, sans-serif;" onClick="viewComment()">좋아요 누른 글</button>
               <button style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right; margin-right:5px; font-family: Jua, sans-serif;" onClick="viewWritten()">내가 쓴 글</button>
               <button style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right; margin-right:5px; font-family: Jua, sans-serif;" onClick="viewMyPage()">프로필</button>

               <h3 class="h5 mb-4 text-left" style="font-family: Jua, sans-serif;">내가 쓴글</h3>

               <div class="table-wrap">

                  <table class="table">
                     <thead style="background:linear-gradient(94deg,#46cfa7,#1ea1f7);">
                        <tr>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">게시판</th>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">글제목</th>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">좋아요</th>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">조회수</th>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">등록일</th>
                        </tr>
                     </thead>

                     <tbody id = "myPost" style="font-family: Jua, sans-serif;">

                     </tbody>

                  </table>

                  <!--PAGING-->
                  <div>
                     <ul class="pagination justify-content-center" id ="myPostPagination">
                     </ul>
                  </div>


               </div>
            </div>
         </div>




         <div class="row commentListTable" style="display:none;">
            <div class="col-md-12">

               <button style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right; margin-right:5px; font-family: Jua, sans-serif;" onClick="viewComment()">좋아요 누른 글</button>
               <button style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right; margin-right:5px; font-family: Jua, sans-serif;" onClick="viewWritten()">내가 쓴 글</button>
               <button style="background: linear-gradient(94deg,#46cfa7,#1ea1f7); color: #fff; border: none; padding: 0 2em; cursor: pointer; float: right; margin-right:5px; font-family: Jua, sans-serif;" onClick="viewMyPage()">프로필</button>

               <h3 class="h5 mb-4 text-left" style="font-family: Jua, sans-serif;">좋아요 누른 글</h3>

               <div class="table-wrap">
                  <table class="table">
                     <thead style="background:linear-gradient(94deg,#46cfa7,#1ea1f7);">
                        <tr>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">게시판</th>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">글제목</th>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">좋아요</th>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">조회수</th>
                           <th style="font-weight: bold; font-size: 1em; font-family: Jua, sans-serif;">등록일</th>
                        </tr>
                     </thead>


                     <tbody id="myGoodPost" style="font-family: Jua, sans-serif;">
                     </tbody>

                  </table>

                  <!--PAGING-->
                  <div>
                     <ul class="pagination justify-content-center" id ="myGoodPostPagination">
                     </ul>
                  </div>

               </div>
            </div>
         </div>
      </div>
   </section>
</body>

<script>
   var memberId =${loginMemberDTO.id};

   var pageSize = 5;
   var limit = 5;


   var pageNo =1;
   var block  = 1;

   var goodPageNo =1;
   var goodBlock  = 1;

   var myPost = 0;
   var myGoodPost = 0;

   //jquery
   //아무 조건도 없이 dom 로드 되자마자 실행되는 제이쿼리
   $(document).ready(function() {

      $.ajax({//내가 쓴 전체 글 개수를 구해옴
         type: "GET",
         url: "/member/"+ memberId +"/post_count",
         async:false,
         dataType: "json",
         data: {},
         success: function (data) {
            myPost = data;
         }
      });

      $.ajax({//내가 쓴 전체 글 개수를 구해옴
         type: "GET",
         url: "/member/"+ memberId +"/post/good_count",
         async:false,
         dataType: "json",
         data: {},
         success: function (data) {
            myGoodPost = data;
         }
      });

      myPostPaging();
      myGoodPostPaging();
   });//ready


   function myPostPaging(newPageNo){
      if(newPageNo!=null){
         pageNo = newPageNo;
         block = Math.ceil(pageNo/pageSize);
      }

      $.ajax({ //이거 내가 쓴글 보기
         type: "GET",
         url: "/member/" + memberId + "/post",
         dataType: "json",
         data: {
            "limit": limit,
            "pageNo": pageNo
         },success: function (data) {
            $('#myPost').empty();
            $.each(data, function (i, v) {
               var post = '<tr class="alert" role="alert" >';
               post+='<td style="font-weight: bold;cursor: pointer;" onclick="goToPage('+v.boardId+');">'+v.categoryName+'</td>';
               post+='<td style="font-weight: bold;cursor: pointer;" onclick="goToPage('+v.boardId+','+v.id+');">'+v.title+'</a></td>';
               post+='<td style="font-weight: bold">'+v.good+'</td>';
               post+='<td style="font-weight: bold">'+v.views+'</td>';
               post+='<td style="font-weight: bold">'+v.createdAt+'</td>';
               post+='</tr>'
               $('#myPost').append(post);
            });

         }
      });

      // pagination
            var totalPage = Math.ceil(myPost/limit);
            $('#myPostPagination').empty();
            var page = '';
            if(myPost>=1){
               if(pageNo>1){
                  page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+(1)+');"> '+"<<"+' </li>';

               }
               else {
                  page += '<li class="page-link"> '+"<<"+' </li>';
               }

               if(block>1){
                  page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+((block-1)*pageSize)+');"> '+"<"+' </li>';
               }
               else {
                  page += '<li class="page-link"> '+"<"+' </li>';
               }


               for(var i=(block-1)*pageSize+1; i<block*pageSize+1;i++){
                  if(i<=totalPage){
                     if(i===pageNo)
                        page +='<li class="page-link" style="cursor: pointer; color: #c82333" onclick="myPostPaging('+i+');"> '+i+' </li>';

                     else
                        page +='<li class="page-link" style="cursor: pointer" onclick="myPostPaging('+i+');"> '+i+' </li>';
                  }
               }

               if((block*pageSize+1)<=totalPage)
                  page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+(block*pageSize+1)+');"> '+">"+' </li>';
               else {
                  page += '<li class="page-link"> '+">"+' </li>';
               }

               if(pageNo<totalPage)
                  page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+(totalPage)+');"> '+">>"+' </li>';
               else {
                  page += '<li class="page-link"> '+">>"+' </li>';
               }
            }
            $('#myPostPagination').append(page);
   }







   function myGoodPostPaging(newPageNo){
      if(newPageNo!=null){
         goodPageNo = newPageNo;
         goodBlock = Math.ceil(goodPageNo/pageSize);
      }

      $.ajax({ //이거 내가 쓴글 보기
         type: "GET",
         url: "/member/" + memberId + "/post/good",
         dataType: "json",
         data: {
            "limit": limit,
            "pageNo": goodPageNo
         },success: function (data) {
            $('#myGoodPost').empty();
            $.each(data, function (i, v) {
               var post = '<tr class="alert" role="alert" >';
               post+='<td style="font-weight: bold;cursor: pointer;" onclick="goToPage('+v.boardId+');">'+v.categoryName+'</td>';
               post+='<td style="font-weight: bold;cursor: pointer;" onclick="goToPage('+v.boardId+','+v.id+');">'+v.title+'</a></td>';
               post+='<td style="font-weight: bold">'+v.good+'</td>';
               post+='<td style="font-weight: bold">'+v.views+'</td>';
               post+='<td style="font-weight: bold">'+v.createdAt+'</td>';
               post+='</tr>'
               $('#myGoodPost').append(post);
            });

         }
      });

      // pagination
      var totalPage = Math.ceil(myGoodPost/limit);
      $('#myGoodPostPagination').empty();
      var page = '';

      if (myGoodPost >1){
      if(goodPageNo>1){
         page += '<li class="page-link"  style="cursor: pointer" onclick="myGoodPostPaging('+(1)+');"> '+"<<"+' </li>';

      }

      else {
         page += '<li class="page-link"> '+"<<"+' </li>';
      }

      if(goodBlock>1){
         page += '<li class="page-link"  style="cursor: pointer" onclick="myGoodPostPaging('+((goodBlock-1)*pageSize)+');"> '+"<"+' </li>';
      }

      else {
         page += '<li class="page-link"> '+"<"+' </li>';
      }


      for(var i=(goodBlock-1)*pageSize+1; i<goodBlock*pageSize+1;i++){
         if(i<=totalPage){
            if(i===goodPageNo)
               page +='<li class="page-link" style="cursor: pointer; color: #c82333" onclick="myGoodPostPaging('+i+');"> '+i+' </li>';

            else
               page +='<li class="page-link" style="cursor: pointer" onclick="myGoodPostPaging('+i+');"> '+i+' </li>';
         }
      }

      if((goodBlock*pageSize+1)<=totalPage)
         page += '<li class="page-link"  style="cursor: pointer" onclick="myGoodPostPaging('+(goodBlock*pageSize+1)+');"> '+">"+' </li>';

      else {
         page += '<li class="page-link"> '+">"+' </li>';
      }

      if(goodPageNo<totalPage)
         page += '<li class="page-link"  style="cursor: pointer" onclick="myGoodPostPaging('+(totalPage)+');"> '+">>"+' </li>';

      else {
         page += '<li class="page-link"> '+">>"+' </li>';
      }}
//      location.reload();
      $('#myGoodPostPagination').append(page);
   }




   function goToPage(boardId,postId){

   var loc = "/board/"+boardId;

   if(postId!=null)
      loc+="/post/"+postId;

   location.href = loc;

   }

</script>

   <script type="text/javascript">
      function viewMyPage(){
         //alert('viewMyPage');
         $(".memberInfoTable").css("display","block");
         $(".wroteListTable").css("display","none");
         $(".commentListTable").css("display","none");
      }

      function viewWritten(){
         //alert('viewWritten');
         $(".memberInfoTable").css("display","none");
         $(".wroteListTable").css("display","block");
         $(".commentListTable").css("display","none");
      }

      function viewComment(){
         //alert('viewWritten');
         $(".memberInfoTable").css("display","none");
         $(".wroteListTable").css("display","none");
         $(".commentListTable").css("display","block");
      }

   </script>

   <script src="${path}resources/js_myPage/jquery.min.js"></script>
   <script src="${path}resources/js_myPage/popper.js"></script>
   <script src="${path}resources/js_myPage/bootstrap.min.js"></script>
   <script src="${path}resources/js_myPage/main.js"></script>

   <c:import url="/WEB-INF/views/include/bottom_info.jsp" />