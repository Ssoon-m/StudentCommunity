<%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:import url="/WEB-INF/views/include/admin_head_meta.jsp" />
<c:import url="/WEB-INF/views/include/admin_top.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css_home/admin_home.css">

<div class="container" style="margin:150px auto">
   <div class="card shadow-none">
      <div class="card-body">
         <h2 class="card-title text-center" style="margin-left:20px;">${pageDTO.universityName}</h2>

         <input type="button" id="deleteUniversity" onClick="deleteUniversity();" class="stop-btn btn" style="float: right" value="현재 대학교 삭제">
         <select id='selectUniversity' name='selectUniversity'>
            <option value='' disabled hidden selected> 대학별 리스트 </option>
            <c:forEach var="universityList" items = "${universityList}" >
               <c:if test="${pageDTO.universityName eq universityList.name}">
                  <option selected value="${universityList.id}">${universityList.name}</option>
               </c:if>
               <c:if test="${pageDTO.universityName ne universityList.name}">
                  <option value="${universityList.id}" >${universityList.name }</option>
               </c:if>
            </c:forEach>
         </select>

         <div>
            <form action="${pageContext.request.contextPath}/admin/insertUniversity" method="post">
               <input type="text" name="name">
               <input type="submit" class="btn" value="대학교 추가">
            </form>
         </div>

         <table class="table table-hover" id="board_list">
            <thead>
            <tr>
               <th class="d-none d-md-table-cell text-center"><input type="checkbox" id="check-all" onclick="checkAll()">id</th>
               <th class="text-center d-none d-md-table-cell ">name</th>
               <th class="text-center d-none d-md-table-cell">description</th>
               <th></th>
            </tr>
            </thead>
            <tbody id="boardListBody">
            <c:forEach var="boardList" items = "${boardList}" >
               <tr>
                  <td style="text-align: center; cursor: Hand"><input type="checkbox" name="reportChkBxRow" id="${boardList.categoryId}">&nbsp;${boardList.categoryId}</td>
                  <td class="text-center d-none d-md-table-cell" href="#">${boardList.name}</td>
                  <td class="text-center d-none d-md-table-cell" href="#">${boardList.description}</td>
                  <td></td>
               </tr>
            </c:forEach>
            </tbody>
         </table>


         <input style="float: left; right:200px; margin-right:5px;" type="button" onClick="addRow();" class="btn" value="카테고리 추가">
         <input style="float: left; right:200px;" type="button" onClick="deleteRow();" class="stop-btn btn" value="카테고리 추가 행 삭제">

         <input type="button" id="delete" onClick="deleteReport();" class="stop-btn btn" style="float: right" value="카테고리 삭제">

      </div>
   </div>
</div>

<div id="deleteUniver" class="modal fade" role="dialog">
   <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">대학교 삭제</h4>
         </div>
         <div class="modal-body">
            <span>정말 삭제 시키겠습니까?</span>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-default deleteSelectUniversity" data-dismiss="modal">대학교 삭제</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
         </div>
      </div>
   </div>
</div>


</body>



<script type="text/javascript">

   function deleteUniversity(){
      $('#deleteUniver').modal('show');
   }

   $(".deleteSelectUniversity").click(function(){
      var id = '${pageDTO.selectUniversity}';
      $.ajax({
         type: "POST",
         url: "${pageContext.request.contextPath}/admin/deleteUniversity",
         data: {
            'id' : id
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
   // TODO:admin_universityCategoryDelete 구현할것!!
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
            url: "${pageContext.request.contextPath}/admin/category_delete",
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



   $('#selectUniversity').on('change',function(){
      var selectUniversity = $(this).val();
      var universityName = $("#selectUniversity option:checked").text();
      console.log(selectUniversity);
      console.log(universityName);
      window.location.href = "${pageContext.request.contextPath}/admin/admin_universityCategory?selectUniversity=" + selectUniversity +"&universityName="+universityName ;
   })

   function addRow(){
      var boardListBody = document.getElementById('boardListBody');
      var row = boardListBody.insertRow(boardListBody.rows.length);
      var cell1 = row.insertCell(0);
      var cell2 = row.insertCell(1);
      var cell3 = row.insertCell(2);
      var cell4 = row.insertCell(3);
      cell1.innerHTML =  "<td class='w-5 text-center'>x</td>";
      cell2.innerHTML =  "<td class='text-center d-none d-md-table-cell'><input class='categoryName' type='text' name='name' ></td>";
      cell3.innerHTML = "<td class='text-center d-none d-md-table-cell'>"
                  +"<select class='description' name='description'>"
                  +"   <option value='' selected disabled hidden> 게시판 적용범위 </option>"
                  +"   <option value='BASIC' >모든대학교 </option>"
                  +"   <option value='UNIQUE' >분캠 </option>"
                  +"   <option value='ETC' >주식 게시판 </option>"
                  +"</select>"
                  +"</td>";
      cell4.innerHTML = "<td class='text-center d-none d-md-table-cell'><input onClick='insertCategory();' class='insertCategory' type='button' value='등록' ></td>";
   }

   function insertCategory(){
      alert("카테고리등록");
      var categoryName = $(".categoryName").val();
      var description = $(".description").val();

      var param = {
         'categoryName' : categoryName,
         'description' : description,
         'selectUniversity' : '${pageDTO.selectUniversity}'
      };

      console.log(param);

      $.ajax({
         type: "POST",
         url: "${pageContext.request.contextPath}/admin/admin_insertCategory",
         data : JSON.stringify(param),
         dataType:"json",
         contentType : "application/json; charset=utf-8",
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

   }

   function deleteRow() {
      var boardListBody = document.getElementById('boardListBody');
      if (boardListBody.rows.length < ${boardListSize+1}) return;
      boardListBody.deleteRow( boardListBody.rows.length-1 ); // 하단부터 삭제
   }

</script>

</html>