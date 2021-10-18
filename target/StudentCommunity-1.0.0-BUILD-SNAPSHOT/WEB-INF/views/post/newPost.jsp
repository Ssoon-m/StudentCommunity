<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/include/top_menu.jsp" />
<c:import url="/WEB-INF/views/include/head_meta.jsp" />
<!-- 서머노트를 위해 추가해야할 부분 -->
<script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">


<body style="background:linear-gradient(94deg,rgba(30, 161, 247,0.3), rgba(70, 207, 167, 0.3));">
<div class="container" style="margin-top: 150px">
        <div class="row">
                <div class="col-md-9" style="margin-left:150px;">
                        <div class="card shadow-sm">
                                <div class="card-body">
<%--                                        <h4 class="card-title">게시판 이름</h4>--%>

                                        <div>
                                                <div class="input-group input-group-sm mb-3">
                                                        <div class="input-group-prepend">
                                                                <span class="input-group-text">제목</span>
                                                        </div>
                                                        <input type="text" name="title" id = "title"
                                                               class="form-control form-control-sm" id="inputTitle"
                                                               maxlength="200">
                                                </div>
                                        </div>


                                        <select id = anonymous>
                                                <option value="TRUE">익명</option>
                                            <c:if test="${!board.categoryName.equals('익명')}">
                                                <option value="FALSE">닉네임</option>
                                            </c:if>
                                        </select>


    <textarea class="summernote" id = "content"></textarea>
    <input type="button" id="newPost" value="등록" class="btn btn-info" style="margin-top:10px; border:solid 1px silver;">


                                </div>
                                <div>

                                </div>
                        </div>
                </div>
        </div>
        <div class="col-sm-3"></div>
</div>
</body>


<script>
    $('.summernote').summernote({
        // 에디터 높이
        height: 450,
        // 에디터 한글 설정
        lang: "ko-KR",
        toolbar: [
            // 글꼴 설정
            ['fontname', ['fontname']],
            // 글자 크기 설정
            ['fontsize', ['fontsize']],
            // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
            ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
            // 글자색
            ['color', ['forecolor','color']],
            // 그림첨부, 링크만들기, 동영상첨부
            ['insert',['picture','link']],
        ],
        // 추가한 글꼴
        fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
        // 추가한 폰트사이즈
        fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
        callbacks : {
            onImageUpload : function(files, editor, welEditable) {
                // 파일 업로드(다중업로드를 위해 반복문 사용)
                for (var i = files.length - 1; i >= 0; i--) {
                    uploadSummernoteImageFile(files[i],
                        this);
                }
            }
        }
    });

    function uploadSummernoteImageFile(file, editor) {
        data = new FormData();
        data.append("file", file);
        $.ajax({
            data : data,
            type : "POST",
            url : "/post/img/upload",
            contentType : false,
            enctype : 'multipart/form-data',
            processData : false,
            success : function(data) {
                $(editor).summernote('editor.insertImage',data.url);
            }
        });
    }


       $('#newPost').click(function(){
           var title = $('#title').val();
           var anonymous = $('#anonymous').val();
            var bodyAdd = $('#content').val();

           if(title.length ===0 || bodyAdd.length ===0){
                   alert("게시글 널 불가");
                   return false;
           }


           var url = window.location.href;
           var newUrl = url.replace("new_post","");

               $.ajax({
               type:"POST",
               url:url+".do",
               contentType: "application/json",
               dataType:"json",
               data : JSON.stringify({
                   "title" : title,
                   "content" : bodyAdd,
                   "anonymous":anonymous
               }),
               success:function(data){
                   alert("글 등록 완료");
                       window.location.href = newUrl+data;
               },error:function(request,status,error){
                   alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
               }
           });//ajax
       });//click








</script>
