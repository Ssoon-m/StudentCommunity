<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/WEB-INF/views/include/admin_head_meta.jsp" />
<c:import url="/WEB-INF/views/include/admin_top.jsp" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css_home/admin_home.css">



<div class="container" style="margin:150px auto">

   <div class="card shadow-none">
      <div class="card-body">
         <h2 class="card-title text-center" style="margin-left:20px;">회원 관리</h2>
         <form method="get" action="${pageContext.request.contextPath}/admin/admin_member">

            <div style="float:right">
               <select id ="select" name="select">
                  <c:if test="${pageDTO.select eq 'email'}">
                     <option selected value="email">이메일</option>
                     <option value="name">닉네임</option>
                  </c:if>

                  <c:if test="${pageDTO.select eq 'name'}">
                     <option value="email">이메일</option>
                     <option selected value="name">닉네임</option>
                  </c:if>

                  <c:if test="${pageDTO.select eq null}">
                     <option selected value="email">이메일</option>
                     <option value="name">닉네임</option>
                  </c:if>

                  <c:if test="${pageDTO.select eq ''}">
                     <option selected value="email">이메일</option>
                     <option value="name">닉네임</option>
                  </c:if>
               </select>
               <input type="hidden" name="showSuspend" value="${pageDTO.showSuspend}">
               <input type="text" name="input" value="${postDTO.input}">

            </div>
         </form>
         <table class="table table-hover" id="board_list">
            <thead>
            <tr>
               <th class="w-5 text-center">nickname</th>
               <th class="text-center d-none d-md-table-cell ">e-mail</th>
               <th class="text-center d-none d-md-table-cell">status</th>
               <th class="text-center d-none d-md-table-cell">member secession</th>
               <c:if test="${pageDTO.showSuspend eq '1'}">
                  <th class="text-center d-none d-md-table-cell">suspended</th>
               </c:if>
               <c:if test="${pageDTO.showSuspend ne '1'}">
                  <th class="text-center d-none d-md-table-cell"></th>
               </c:if>
            </tr>
            </thead>

            <tbody>
               <c:forEach var="member" items="${memberList}" >
                  <tr>
                     <td class="w-5 text-center">${member.name}</td>
                     <td class="text-center d-none d-md-table-cell" href="#">${member.email}</td>
                     <c:if test="${member.status eq'ACTIVE'}">
                        <td class="text-center d-none d-md-table-cell" href="#">활동상태</td>
                     </c:if>
                     <c:if test="${member.status eq 'DE_ACTIVE'}">
                        <td class="text-center d-none d-md-table-cell" href="#">정지상태</td>
                     </c:if>
                     <td class="text-center"><button class="unsubscribe stop-btn btn" onClick ="unsubscribe(${member.id});">회원탈퇴</button></td>
                     <c:if test="${member.status eq 'DE_ACTIVE'}">
                        <td class="text-center"><button class="MemberChangeActive continue-btn btn" onClick ="MemberChangeActive(${member.id});">정지해제</button></td>
                     </c:if>
                     <c:if test="${member.status != 'DE_ACTIVE'}">
                        <td>
                           <select class='term' name='term'>
                              <option value='' selected> -- 기간을 선택하세요 --</option>
                              <option value='1'>1일</option>
                              <option value="4">4일</option>
                              <option value='7'>7일</option>
                              <option value='14'>14일</option>
                              <option value='30'>30일</option>
                           </select>
                           <input type="hidden" id="memberId"  value="${member.id }">
                           <input type="button" class="stop stop-btn btn" id="stop" data-val2="" data-val="${member.id }" value="정지" >
                        </td>
                     </c:if>
                  </tr>
               </c:forEach>
            </tbody>

         </table>


         <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">
               <!-- Modal content-->
               <div class="modal-content">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                     <h4 class="modal-title">회원 정지</h4>
                  </div>
                  <div class="modal-body">
                     <span>정말로 정지 시키겠습니까?</span>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-default deleteMember" data-dismiss="modal">탈퇴</button>
                     <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                  </div>
               </div>
            </div>
         </div>


         <!--  페이징 코드 시작 -->
         <div class="d-none d-md-block">
            <ul class="pagination justify-content-center">
               <!--
                  현재 페이지가 맨 처음 네비게이션 버튼에 있는 경우에는 다음 버튼이 안 보이도록 함
                  prePage의 값이 네비게이션 버튼의 최소랑 비교했을때 같을경우 안눌린다.
               -->
               <c:choose>
                  <c:when test="${pageDTO.prePage == 1}" >
                     <li class="page-item disabled">
                        <a href="#" class="page-link">이전</a>
                     </li>
                  </c:when>
                  <c:otherwise>
                     <li class="page-item">
                        <a href="${pageContext.request.contextPath}/admin/admin_member?page=${pageDTO.prePage-1}&showSuspend=${pageDTO.showSuspend}&input=${pageDTO.input}""
                           class="page-link">이전</a>
                     </li>
                  </c:otherwise>
               </c:choose>

               <c:forEach var="idx" begin="${pageDTO.min }" end="${pageDTO.max }">
                  <c:choose>
                     <c:when test="${idx == pageDTO.currentPage }">
                        <li class="page-item active">
                           <a href="${pageContext.request.contextPath}/admin/admin_member?page=${idx}&showSuspend=${pageDTO.showSuspend}&input=${pageDTO.input}"
                              style="background: #5fbcfa" class="page-link">${idx }</a>
                        </li>
                     </c:when>
                     <c:otherwise>
                        <li class="page-item">
                           <a href="${pageContext.request.contextPath}/admin/admin_member?page=${idx}&showSuspend=${pageDTO.showSuspend}&input=${pageDTO.input}"
                              class="page-link">${idx }</a>
                        </li>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>

               <!--
                  현재 페이지가 맨 마지막 네비게이션 버튼인 경우 다음 버튼이 안 눌리게 한다.
                  nextPage의 값이 네비게이션 버튼의 최대보다 같을경우 안눌리게 한다.
               -->
               <!--  pageCount 는 최대 네비게이션 페이지 총 양-->
               <c:choose>
                  <c:when test="${pageDTO.nextPage == pageDTO.pageCount}">
                     <li class="page-item disabled">
                        <a href="#" class="page-link">다음</a>
                     </li>
                  </c:when>
                  <c:otherwise>
                     <li class="page-item">
                        <a href="${pageContext.request.contextPath}/admin/admin_member?page=${pageDTO.prePage+1}&showSuspend=${pageDTO.showSuspend}&input=${pageDTO.input}"
                           class="page-link">다음</a>
                     </li>
                  </c:otherwise>
               </c:choose>
            </ul>
         </div>
         <!-- 페이징 코드 끝 -->

         <input type="button" value="정지회원" class="showSuspend btn" >
         <input type="button" value="일반회원" class="showMember btn" >

         <!-- Model -->
         <div id="myModal2" class="modal fade" role="dialog">
            <div class="modal-dialog">
               <!-- Modal content-->
               <div class="modal-content">
                  <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                     <h4 class="modal-title">정지해제</h4>
                  </div>
                  <div class="modal-body">
                     <span>정지해제 시키겠습니까?</span>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="continue-btn btn btn-default ChangeActive" data-dismiss="modal">정지 해제</button>
                     <button type="button" class="continue-btn btn btn-default" data-dismiss="modal">취소</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- -->

         <!--  모달창!! -->
         <div id="firstModal" class="modal fade"
              data-backdrop="static" data-keyboard="false">
            <!-- size : modal-sm, modal-lg -->
            <div class="modal-dialog modal-sm">

               <div class="modal-content">
                  <div class="modal-header">
                     <h4 class="modal-title">회원정지 사유</h4>
                     <button type="button" class="close" data-dismiss="modal">&times;</button>
                  </div>
                  <div class="modal-body">
                     <p><input class="form-control reason" type="text"></p>
                  </div>
                  <div class="modal-footer">
                     <button type="button" onClick="saveReason();" class="btn btn-info save">Save</button>
                     <button type="button" class="btn btn-danger close2" data-dismiss="modal">Close</button>
                  </div>
               </div>
            </div>
         </div>


      </div>
   </div>
</div>



</body>

<script type="text/javascript">

   // select 태그가 change될때마다(option값이 바뀔때마다 실행)
   // .stop 클래스의 data-val2에 바뀐 option의 value값을 넣어준다.
   $('.term').on('change',function(){
      $('.stop').attr('data-val2',$(this).val());
   });


   var day;
   var memberId;

   $('.stop').click(function(){
      var s = $(this).attr("data-val2");
      if(s != ''){
         showModal();
         day = s;
         memberId = $(this).attr("data-val");

      }else{
         alert("정지일수를 선택해주세요");
      }
   });

   function saveReason(){
      var savereason = $('.reason').val();
      if(savereason != ""){

         console.log("day : "+day);
         console.log("memberId : "+memberId);
         console.log("savereason :"+savereason);

         var param = {
            'SetendOn' : day,
            'reason' : savereason,
            'memberId' : memberId
         };

         console.log(JSON.stringify(param));

         $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/admin/admin_report",
            data: JSON.stringify(param),
            dataType:"json",
            contentType : "application/json; charset=utf-8",
            success: function(data){
               if(data == "1") {
                  window.location.reload();

               } else {
                  alert("회원 정지 오류");
               }
            },
            error: function(request, status, error){
               alert("서버통신 오류");
               console.log("AJAX_ERROR");
            }
         });

      }
      $(".close2").click();
   }

   // 모달 보여주기
   function showModal(){
      var arr = new Array();

      $('').each(function() {
         arr.push($(this).attr('id'));
      });

      $("#firstModal").modal("show");
   }

   var id;
   function unsubscribe(id){
      //id = $(this).attr("data-val");
      this.id = id;
      $('#myModal').modal('show');
   }

   $('.deleteMember').click(function(){
      alert("회원탈퇴");
      console.log(id);
      $.ajax({
         type: "POST",
         url: "${pageContext.request.contextPath}/admin/member_delete",
         data : {'id' : id},
         async:false,
         dataType:"text",
         success: function(data){
            if(data==1){
               window.location.reload();
            }
         },
         error: function(request, status, error){
            alert("서버통신 오류");
            console.log("AJAX_ERROR");
         }
      });
   })

   var memberId;
   function MemberChangeActive(memberId) {
      this.memberId = memberId;
      $('#myModal2').modal('show');
   }


   $('.ChangeActive').click(function(){
      console.log(memberId);
      alert("정지해제");
      $.ajax({
         type: "POST",
         url: "${pageContext.request.contextPath}/admin/member_ChangeActive",
         data : {'memberId' : memberId},
         dataType:"text",
         success: function(data){
            if(data==1){
               window.location.reload();
            }
         },
         error: function(request, status, error){
            alert("서버통신 오류");
            console.log("AJAX_ERROR");
         }
      });
   })


</script>

<script type="text/javascript">

   $('.showSuspend').click(function(){
      var showSuspend = '1';
      window.location.href="${pageContext.request.contextPath}/admin/admin_member?showSuspend="+ showSuspend  ;
   })
   $('.showMember').click(function(){
      var showSuspend = '0';
      window.location.href="${pageContext.request.contextPath}/admin/admin_member?showSuspend="+ showSuspend  ;
   })
   // var pageSize = 5;	// 한 페이지에 네비게이션 버튼 5개씩
   // var limit = 10;     // 한 페이지에 10개의 글
   //
   // var pageNo =1;
   // var block  = 1;
   //
   // // var totalMember = [];
   // // var searchMember = [];
   // var myPost = 0;
   // //var myGoodPost = 0;
   //
   // $(document).ready(function() {
   //
   //    $.ajax({//내가 쓴 전체 글 개수를 구해옴
   //       type: "GET",
   //       url: "/admin/member_count",
   //       async:false,
   //       dataType: "json",
   //       data: {},
   //       success: function (data) {
   //          myPost = data;
   //          // $.each(data,function (i,v){
   //          //    totalMember.push(v); //전체 멤버
   //          // });
   //       }
   //    });
   //
   //    myPostPaging();
   // });//ready


   // function myPostPaging(newPageNo) {
   //
   //    if (newPageNo != null) {
   //       pageNo = newPageNo;
   //       // block 1 일때 1~5 버튼 (pageSize가 5이므로)
   //       // 2 일떄 6~10 버튼
   //       block = Math.ceil(pageNo / pageSize);
   //    }
   //
   //    $.ajax({ //이거 내가 쓴글 보기
   //       type: "GET",
   //       url: "/admin/member",
   //       dataType: "json",
   //       data: {
   //          "limit": limit,
   //          "pageNo": pageNo
   //       }, success: function (data) {
   //          $('#myPost').empty();
   //          $.each(data, function (i, v) {
   //             var post;
   //             post += '<tr><td class="w-5 text-center">'+ v.name +'</td>';
   //             post += '<td class="text-center d-none d-md-table-cell" href="#">'+ v.email +'</td>';
   //             if(v.status === 'ACTIVE'){
   //                post +=	'<td class="text-center d-none d-md-table-cell" href="#">활동상태</td>';
   //             }
   //             if(v.status === 'DE_ACTIVE'){
   //                post +=  '<td class="text-center d-none d-md-table-cell" href="#">정지상태</td>';
   //             }
   //             post += '<td class="text-center"><button class="unsubscribe stop-btn btn" onClick ="unsubscribe('+v.id+');">회원탈퇴</button></td>';
   //             post +=	'<td class="text-center"><button class="MemberChangeActive continue-btn btn" onClick ="MemberChangeActive('+v.id+');">정지해제</button></td></tr>';
   //             $('#myPost').append(post);
   //          });
   //       }
   //    });
   //
   //    // pagination
   //    // totalPage 는 페이징에 필요한 버튼의 개수
   //    var totalPage = Math.ceil(myPost/limit);
   //    $('#myPostPagination').empty();
   //    var page = '';
   //
   //    if(pageNo>1){
   //       page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+(1)+');"> '+"<<"+' </li>';
   //
   //    }
   //    else {
   //       page += '<li class="page-link"> '+"<<"+' </li>';
   //    }
   //
   //    if(block>1){
   //       page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+((block-1)*pageSize)+');"> '+"<"+' </li>';
   //    }
   //    else {
   //       page += '<li class="page-link"> '+"<"+' </li>';
   //    }
   //
   //
   //    for(var i=(block-1)*pageSize+1; i<block*pageSize+1;i++){
   //       if(i<=totalPage){
   //          if(i===pageNo)
   //             page +='<li class="page-link" style="cursor: pointer; color: #c82333" onclick="myPostPaging('+i+');"> '+i+' </li>';
   //
   //          else
   //             page +='<li class="page-link" style="cursor: pointer" onclick="myPostPaging('+i+');"> '+i+' </li>';
   //       }
   //    }
   //
   //    if((block*pageSize+1)<=totalPage)
   //       page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+(block*pageSize+1)+');"> '+">"+' </li>';
   //    else {
   //       page += '<li class="page-link"> '+">"+' </li>';
   //    }
   //
   //    if(pageNo<totalPage)
   //       page += '<li class="page-link"  style="cursor: pointer" onclick="myPostPaging('+(totalPage)+');"> '+">>"+' </li>';
   //    else {
   //       page += '<li class="page-link"> '+">>"+' </li>';
   //    }
   //    $('#myPostPagination').append(page);
   // }

</script>
