<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}/" />


<c:import url="/WEB-INF/views/include/admin_head_meta.jsp" />
<c:import url="/WEB-INF/views/include/admin_top.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css_home/admin_home.css">
<!--자동완성-->
<!-- CSS , JS -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<div class="container" style="margin: 150px auto">

   <div class="card shadow-none">
      <div class="card-body">
         <h2 class="card-title text-center" style="margin-left:20px;">게시글 관리</h2>
         <table class="table table-hover" id='board_list'>
            <thead>
            <tr>
               <th class="d-none d-md-table-cell text-center"><input type="checkbox" id="check-all" onclick="checkAll()">&nbsp;글번호</th>
               <th class="w-30 text-center">제목</th>
               <th class="d-none d-md-table-cell text-center">작성자</th>
               <th class="text-center">신고 횟수</th>
               <th class="d-none d-md-table-cell text-center">작성날짜</th>
               <th></th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="postList" items="${post}" >
               <tr>
                  <td style="text-align: center; cursor: Hand"><input type="checkbox" name="reportChkBxRow" id="${postList.id}">&nbsp;${postList.id}</td>
                  <td style="overflow:hidden; max-width:100px; white-space:nowrap; text-overflow:ellipsis; text-align: center; cursor: pointer" onclick="detail(${postList.boardId},${postList.id});">${postList.title}</td>
                  <td style="text-align: center;">${postList.email}</td>
                  <td style="text-align: center;">${postList.report}</td>
                  <td style="text-align: left;">${postList.createdAt.toLocalDate()}</td>
                  <!--  수정된 게시글이 있으면 수정된 날짜를 보여준다. -->
                     <%--                  <c:choose>--%>
                     <%--                     <c:when test="${not empty postList.updatedAt}">--%>
                     <%--                        <td style="text-align: left;">${postList.updatedAt.toLocalDate()}</td>--%>
                     <%--                     </c:when>--%>
                     <%--                     <c:otherwise>--%>
                     <%--                        <td style="text-align: left;">${postList.createdAt.toLocalDate()}</td>--%>
                     <%--                     </c:otherwise>--%>
                     <%--                  </c:choose>--%>

                  <c:if test="${postList.status != 'DE_ACTIVE'}">
                     <td>
                        <select class='term' name='term'>
                           <option value='' selected> -- 기간을 선택하세요 --</option>
                           <option value='1'>1일</option>
                           <option value="4">4일</option>
                           <option value='7'>7일</option>
                           <option value='14'>14일</option>
                           <option value='30'>30일</option>
                        </select>
                        <input type="hidden" id="memberId"  value="${postList.memberId }">
                        <input type="button" class="stop stop-btn btn" id="stop" data-val2="" data-val="${postList.memberId }" value="정지" >
                     </td>
                  </c:if>

                  <c:if test="${postList.status ==  'DE_ACTIVE'}">
                     <td></td>
                  </c:if>

               </tr>
            </c:forEach>

            <!--대학 검색 -->

            <select id='selectUniversity' name='selectUniversity'>
               <option value='' disabled hidden selected> 대학별 리스트 </option>
               <c:forEach var="universityList" items = "${universityList}" >

                  <c:if test="${pageDTO.selectUniversity eq universityList.id}">
                     <option selected value="${universityList.id}  " > ${universityList.name } </option>
                  </c:if>

                  <c:if test="${pageDTO.selectUniversity ne universityList.id}">
                     <option  value="${universityList.id}  " > ${universityList.name } </option>
                  </c:if>

               </c:forEach>
            </select>
            <!-- 카테고리 검색 -->

            <c:if test="${pageDTO.selectUniversity != null}">
               <c:if test="${pageDTO.selectUniversity != '' }">

                  <select style="margin-left:10px;" id='category' name='category'>
                     <option value='' selected> 카테고리 목록 </option>
                     <c:forEach var="boardList" items = "${boardList}" >

                        <c:if test="${pageDTO.category eq boardList.categoryId}">
                           <option selected value="${boardList.categoryId}" > ${boardList.name } </option>
                        </c:if>
                        <c:if test="${pageDTO.category ne boardList.categoryId}">
                           <option value="${boardList.categoryId}" > ${boardList.name } </option>
                        </c:if>

                     </c:forEach>
                  </select>


               </c:if>
            </c:if>


            <!--  날짜 검색 -->
            <div class="border">
               <form method="get" action="${pageContext.request.contextPath}/admin/admin_index">
                  <input type="date" name="date1" class="date1" value="${pageDTO.date1}">
                  ~
                  <input type="date" name="date2" class="date2" value="${pageDTO.date2}">

                  <input type="hidden" name="select"value="${pageDTO.select}">
                  <input type="hidden" name="input"value="${pageDTO.input}">
                  <input type="hidden" name="showSuspend"value="${pageDTO.showSuspend}">
                  <input type="hidden" name="selectUniversity" value="${pageDTO.selectUniversity }">
                  <input type="hidden" name="category" value="${pageDTO.category}">
                  <input type="submit" class="searchDate btn" value="검색">
               </form>
            </div>




            <!-- 키워드 검색 -->
            <form method="get" action="${pageContext.request.contextPath}/admin/admin_index">
               <div style="float:left">
                  <input type="button" value="정지회원글보기" class="showSuspend btn" >
                  <input type="button" value="회원글보기" class="showall btn" >
               </div>
               <div style="float:right">
                  <select id ="select" name="select">
                     <c:if test="${pageDTO.select eq 'title'}">
                        <option selected value="title">제목</option>
                        <option value="titleContent">제목 내용</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                     </c:if>

                     <c:if test="${pageDTO.select eq 'titleContent'}">
                        <option value="title">제목</option>
                        <option selected value="titleContent">제목 내용</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                     </c:if>

                     <c:if test="${pageDTO.select eq 'content'}">
                        <option value="title">제목</option>
                        <option value="titleContent">제목,내용</option>
                        <option selected value="content">내용</option>
                        <option value="writer">작성자</option>
                     </c:if>

                     <c:if test="${pageDTO.select eq 'writer'}">
                        <option value="title">제목</option>
                        <option value="titleContent">제목,내용</option>
                        <option value="content">내용</option>
                        <option selected value="writer">작성자</option>
                     </c:if>

                     <c:if test="${pageDTO.select eq null}">
                        <option selected value="title">제목</option>
                        <option value="titleContent">제목,내용</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                     </c:if>

                     <c:if test="${pageDTO.select eq ''}">
                        <option selected value="title">제목</option>
                        <option value="titleContent">제목,내용</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                     </c:if>

                  </select>
                  <input type="hidden" name="date1" value="${pageDTO.date1}">
                  <input type="hidden" name="date2" value="${pageDTO.date2}">
                  <input type="hidden" name="showSuspend" value="${pageDTO.showSuspend}">
                  <input type="hidden" name="selectUniversity" value="${pageDTO.selectUniversity }">
                  <input type="hidden" name="category" value="${pageDTO.category}">
                  <input type="text" name="input" id="AutoSearch" value="${postDTO.input}">

                  <input type="submit" class="btn" value="검색">
               </div>
            </form>




            </tbody>
         </table>


         <div>
            <input type="button" value="좋아요순" class="likeRank btn" >
            <input type="button" value="신고순"  class="suspendRank btn" >
            <input type="button" value="최신글순" class="regDateRank btn" >
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
                        <a href="${pageContext.request.contextPath}/admin/admin_index?page=${pageDTO.prePage-1}&likeRank=${pageDTO.likeRank}&suspendRank=${pageDTO.suspendRank}&regDateRank=${pageDTO.regDateRank}&showSuspend=${pageDTO.showSuspend}&input=${pageDTO.input}&select=${pageDTO.select}&date1=${pageDTO.date1}&date2=${pageDTO.date2}&selectUniversity=${pageDTO.selectUniversity}&category=${pageDTO.category}"
                           class="page-link">이전</a>
                     </li>
                  </c:otherwise>
               </c:choose>

               <c:forEach var="idx" begin="${pageDTO.min }" end="${pageDTO.max }">
                  <c:choose>
                     <c:when test="${idx == pageDTO.currentPage }">
                        <li class="page-item active">
                           <a href="${pageContext.request.contextPath}/admin/admin_index?page=${idx}&likeRank=${pageDTO.likeRank}&suspendRank=${pageDTO.suspendRank}&regDateRank=${pageDTO.regDateRank}&showSuspend=${pageDTO.showSuspend}&input=${pageDTO.input}&select=${pageDTO.select}&date1=${pageDTO.date1}&date2=${pageDTO.date2}&selectUniversity=${pageDTO.selectUniversity}&category=${pageDTO.category}"
                              style="background: #5fbcfa" class="page-link">${idx }</a>
                        </li>
                     </c:when>
                     <c:otherwise>
                        <li class="page-item">
                           <a href="${pageContext.request.contextPath}/admin/admin_index?page=${idx}&likeRank=${pageDTO.likeRank}&suspendRank=${pageDTO.suspendRank}&regDateRank=${pageDTO.regDateRank}&showSuspend=${pageDTO.showSuspend}&input=${pageDTO.input}&select=${pageDTO.select}&date1=${pageDTO.date1}&date2=${pageDTO.date2}&selectUniversity=${pageDTO.selectUniversity}&category=${pageDTO.category}"
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
                        <a href="${pageContext.request.contextPath}/admin/admin_index?page=${pageDTO.prePage+1}&likeRank=${pageDTO.likeRank }&showSuspend=${pageDTO.showSuspend}&input=${pageDTO.input}&select=${pageDTO.select}&date1=${pageDTO.date1}&date2=${pageDTO.date2}&selectUniversity=${pageDTO.selectUniversity}&category=${pageDTO.category}"
                           class="page-link">다음</a>
                     </li>
                  </c:otherwise>
               </c:choose>
            </ul>
         </div>
         <!-- 페이징 코드 끝 -->




         <!--  글 삭제 -->
         <input type="button" id="delete" onClick="deleteReport();" class="stop-btn btn" style="float: right" value="삭제">

         <!-- </form>
      </div>
       -->

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
<br>
<br>
<br>

</body>

<script type="text/javascript">

   var autoname = [];
   var autoemail = [];
   var autocontent = [];
   var autotitle = [];
   var autotitlecontent = [];
   var autonameemail = [];
   //오토 컴플리티 푸쉬, 전체 강좌 푸쉬
   //auto complete
   $(document).ready(function() {
      $.ajax({
         url: "/admin/autocomplete",
         type: "get",
         dataType: "json",
         contentType: "application/json",
         async: false,
         success: function (data) {
            $.each(data, function (i, v) {
               autoname.push(v.name);
               autoname.push(v.email);
               autocontent.push(v.content);
               autotitle.push(v.title)
            });
            autotitlecontent = autotitle.concat(autocontent);
             autonameemail = autoname.filter((item, index) => autoname.indexOf(item) === index);
             
           // console.log("autotitlecontent ------->>>>>", autotitlecontent);
           // console.log("autonameemail ------->>>>>", autonameemail);
           // console.log("autotitle ------->>>>>", autotitle);
            
         }
      });
   });
   // var autonameemail = autoname.filter( (item, idx, array) => {
   //    return array.indexOf( item ) === idx ;
   // });
   $(function () {
      $('#AutoSearch').autocomplete({
         source: autotitle
      })
   });

   var autoselect;
      $('#select').on('change',function(){
         autoselect = $(this).val();

         if(autoselect == 'title') {
            $(function () {
               $('#AutoSearch').autocomplete({
                  source: autotitle
               })
            });
         }
         if(autoselect == 'content'){
            $(function () {
               $('#AutoSearch').autocomplete({
                  source: autocontent
               })
            });
         }
         if(autoselect == 'writer'){
            $(function () {
               $('#AutoSearch').autocomplete({
                  source: autonameemail
               })
            });
         }
         if(autoselect == 'titleContent'){
            $(function(){
               $('#AutoSearch').autocomplete({
                  source : autotitlecontent
               })
            })
         }
      })


   $('#check-all').click(function(){
      var checked = $('#check-all').is(':checked');

      if(checked)
      {
         $('input:checkbox').prop('checked',true);
      }
      else
      {
         $('input:checkbox').prop('checked',false);
      }
   });


   // checkbox로 글 삭제!!
   function deleteReport(){
      var cnt = $("input[name='reportChkBxRow']:checked").length;
      var arr = new Array();
      // input 태그에서 name이 reportChkMxRow이면서 체크가 되어있는것
      $("input[name='reportChkBxRow']:checked").each(function() {
         arr.push($(this).attr('id'));
      });
      if(cnt == 0){
         alert("선택된 글이 없습니다.");
      }
      else{
         $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/admin/admin_delete",
            data: {
               'id' : arr
            },
            dataType:"json",
            success: function(retVal){
               if(retVal.code == "OK") {
                  alert(retVal.message);
                  window.location.reload();
               } else {
                  alert(retVal.message);
               }
            },
            error: function(request, status, error){
               alert("서버통신 오류");
               console.log("AJAX_ERROR");
            }
         });
      }
   }

   // 회원 정지및 정지사유
   /* function membeerReport(){
   } */
   // select 태그가 change될때마다(option값이 바뀔때마다 실행)
   // .stop 클래스의 data-val2에 바뀐 option의 value값을 넣어준다.
   $('.term').on('change',function(){
      $('.stop').attr('data-val2',$(this).val());
   });


   var day;
   var memberId;

   $('.stop').click(function(){
      var s = $(this).attr("data-val2");
      console.log(s);
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

   function detail(boardId,postId){
      window.location.href = "${pageContext.request.contextPath}"  + "/board/" + boardId + "/post/" + postId ;
   }

   // 대학 선택 하자마자 보여주기
   $('#selectUniversity').on('change',function(){
      var universityId = $(this).val();
      console.log(universityId);
      window.location.href = "${pageContext.request.contextPath}/admin/admin_index?date1=${pageDTO.date1}&date2=${pageDTO.date2}&showSuspend=${pageDTO.showSuspend}&select=${pageDTO.select}&selectUniversity=" + universityId;
   })


   $('#category').on('change',function(){
      var category = $(this).val();
      console.log(category);
      window.location.href = "${pageContext.request.contextPath}/admin/admin_index?date1=${pageDTO.date1}&date2=${pageDTO.date2}&showSuspend=${pageDTO.showSuspend}&select=${pageDTO.select}&selectUniversity=${pageDTO.selectUniversity}&category=" + category ;
   })




   $('.likeRank').click(function(){
      var likeRank = '1';
      window.location.href="${pageContext.request.contextPath}/admin/admin_index?likeRank="+ likeRank +
              "&showSuspend=" + ${pageDTO.showSuspend} + "&input=${pageDTO.input}&select=${pageDTO.select}&date1=${pageDTO.date1}&date2=${pageDTO.date2}&selectUniversity=${pageDTO.selectUniversity}&category=${pageDTO.category}";
   })
   $('.suspendRank').click(function(){
      var suspendRank = '1';
      window.location.href="${pageContext.request.contextPath}/admin/admin_index?suspendRank="+ suspendRank  +
              "&showSuspend=" + ${pageDTO.showSuspend} + "&input=${pageDTO.input}&select=${pageDTO.select}&date1=${pageDTO.date1}&date2=${pageDTO.date2}&selectUniversity=${pageDTO.selectUniversity}&category=${pageDTO.category}";
   })
   $('.regDateRank').click(function(){
      var regDateRank = '1';
      window.location.href="${pageContext.request.contextPath}/admin/admin_index?regDateRank="+ regDateRank  +
              "&showSuspend=" + ${pageDTO.showSuspend} + "&input=${pageDTO.input}&select=${pageDTO.select}&date1=${pageDTO.date1}&date2=${pageDTO.date2}&selectUniversity=${pageDTO.selectUniversity}&category=${pageDTO.category}";
   })
   $('.showSuspend').click(function(){
      var showSuspend = '1';
      window.location.href="${pageContext.request.contextPath}/admin/admin_index?showSuspend="+ showSuspend  ;
   })

   $('.showall').click(function(){
      var showSuspend = '0';
      window.location.href="${pageContext.request.contextPath}/admin/admin_index?showSuspend="+ showSuspend  ;
   })








   /* $('.searchDate').click(function(){
      var date1 = $('.date1').val();
      var date2 = $('.date2').val();
      console.log(date1);
      console.log(date2);
      $.ajax({
          type: "GET",
          url: "${pageContext.request.contextPath}/admin/admin_index",
       data: {
                'date1' : date1,
                'date2' : date2
            },
       dataType:"text",

       success: function(){
          alert('날짜검색완료');
       },
       error: function(request, status, error){
          alert("서버통신 오류");
          console.log("AJAX_ERROR");
       }
   });

}) */


</script>
