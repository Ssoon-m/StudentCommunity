<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--		<c:import url="/WEB-INF/views/include/admin_head_meta.jsp" />--%>
<%--		<c:import url="/WEB-INF/views/include/admin_top.jsp" />--%>

		<c:import url="/WEB-INF/views/include/head_meta.jsp" />
		<c:import url="/WEB-INF/views/include/top_menu.jsp" />



    <!-- 서머노트를 위해 추가해야할 부분 -->
    <script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
    <script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">



    <style>
        .reply{ font-size: 12px; }
        .reply_writer{ text-align:left; position: absolute; }
        .reply_date{ text-align:right;  position: relative; }
    </style>

    <!--본문-->
    <body style="background:linear-gradient(94deg,rgba(30, 161, 247,0.3), rgba(70, 207, 167, 0.3));">
        <div class="container" style="margin-top: 150px; font-family: Jua, sans-serif;">
            <div class="row">
                <div class="col-md-9" style="margin-left: 150px;">
                    <div class="card shadow-sm">
                        <div class="card-body">



                            <h4 class="card-title" id="boardTitle">${board.categoryName}게시판</h4>

                            <div id="beforeUpdate" style="display: block">



                                <div class="article-info" style="margin-top:8px;float: left; display:inline-block;">


                                    <c:if test="${post.anonymous=='TRUE'}">
                                        <img src="${pageContext.request.contextPath}/resources/images_profile/profile.jpg" style="padding-bottom: 15px;width:50px; height:50px;">

                                        <span class="badge badge-pill badge-light" style="color: #2356FF;">익명</span>
                                        </c:if>
                                        <c:if test="${post.anonymous=='FALSE'}">
                                            <img src="/resources/${post.img}" style="padding-bottom: 15px;width:50px; height:50px;">

                                            <span class="badge badge-pill badge-light"  style="color: #2356FF;">${post.name}</span>
                                        </c:if>

                                        <c:if test="${post.updatedAt==null}">
                                            <fmt:parseDate value="${post.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var = "parsedDateTime" type="both"/>
                                            <span class="badge badge-pill badge-light" >등록 :
                                                 <fmt:formatDate pattern="MM-dd HH:mm" value="${parsedDateTime}"/>
                                            </span>
                                        </c:if>

                                        <c:if test="${post.updatedAt!=null}">
                                            <fmt:parseDate value="${post.updatedAt}" pattern="yyyy-MM-dd'T'HH:mm" var = "parsedDateTime" type="both"/>										<span class="badge badge-pill badge-light" >수정 :
                                                 <fmt:formatDate pattern="MM-dd HH:mm" value="${parsedDateTime}"/>
                                            </span>
                                        </c:if>

                                        </div>



                                <hr>
                                <c:if test="${loginMemberDTO.status == 'ADMIN'}">
                                    <span class="badge badge-pill badge-light" onclick="goBack();" style="float:right; margin-top:15px;cursor: pointer">뒤로가기(Admin)</span>
                                </c:if>

                                <span class="badge badge-pill badge-light" onclick="goList();" style="float:right; margin-top:15px;cursor: pointer">목록으로</span>


                                <br>

                                <hr>
                                <c:if test="${loginMemberDTO.id == post.memberId}">
                                    <div style="float:right; font-size:12px;">
                                        <span class="badge badge-pill badge-light" id="deletePost" style="cursor: pointer;color: red" >삭제</span>
                                        <span class="badge badge-pill badge-light" id="updatePost" style="cursor: pointer;color: red" onclick="div_hide();">수정</span>
                                    </div>
                                </c:if>
                                <h5 style="font-size:20px; margin-bottom:0px;" id="postTitle">${post.title}</h5>
                                <pre id="postContent">${post.content}</pre>
                                <hr>

                            <br>

                            <div>



                            <div style="text-align: center;">
                                <button id = "good" class="btn-outline-primary"></button>
                                <button id = "report" class="btn-outline-danger"></button>
                            </div>






                            </div>




        <!--댓글~~~~~~~~~~~~~~~~~-->
        <div class="form-group">
            <c:choose>
                    <c:when test="${post.memberId == loginMemberDTO.id and board.categoryName.equals('비밀')}">

                    </c:when>
            <c:otherwise>
                <label id = "totalReply"></label><br>
                <div>

                    <textarea id="newReplyContent" name="board_content" class="form-control" placeholder="논란이 있는 댓글을 관리자에 의해 삭제될 수 있습니다." style="resize:none" ></textarea>
                    <select id = anonymous>
                        <option value="TRUE">익명</option>
                        <c:if test="${!board.categoryName.equals('익명')}">
                            <option value="FALSE">닉네임</option>
                        </c:if>
                    </select>
                    <button id="newReply">등록</button>
                </div>
            </c:otherwise>
            </c:choose>
            <div class="reply" id ="reply">
            </div>
            <br>

            <div id = pageNo>
                <ul class="pagination justify-content-center" id ="pagination">
                </ul>
            </div>

        </div>

        <div class="col-sm-3"></div>
        <br>
        <br>
                            </div>


                            <div id="updateForm" style="display: none;">
                            <div>
                                <input type="text" id="title" style="width: 600px;" value="${post.title}">
                                <select id = "postAnonymous">

                                    <c:if test="${post.anonymous eq 'TRUE'}">
                                        <option selected value="TRUE">익명</option>
                                        <c:if test="${!board.categoryName.equals('익명')}">
                                            <option value="FALSE">닉네임</option>
                                        </c:if>
                                    </c:if>

                                    <c:if test="${post.anonymous eq 'FALSE'}">
                                        <option value="TRUE">익명</option>
                                        <option selected value="FALSE">닉네임</option>
                                    </c:if>

                                </select>

                            </div>



                            <div>
                                <textarea class="summernote" id="content">${post.content}</textarea>
                            </div>

                                <div style="float:right; font-size:12px;">
                                    <button type="button" onclick="div_show()">취소</button>
                                    <button type="button"  id ="update">수정</button>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    <div id = "boardList">

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


        function div_hide() {
            document.getElementById("beforeUpdate").style.display = "none";
            document.getElementById("updateForm").style.display = "block";
        }

        function div_show() {
            document.getElementById("beforeUpdate").style.display = "block";
            document.getElementById("updateForm").style.display = "none";
        }


        var boardName ="${board.categoryName}";
        var toggle = -1;
        var limit = 10;
        var pageNo =1;
        var block  = 1;
        var pageSize = 5;
        var anonymousNo=[-1];
        var postId =${post.id};
        var memberId = ${loginMemberDTO.id};
        var postMemberId = ${post.memberId};


        function goList(){ //목록으로
            var location = document.querySelector("#boardList").offsetTop;
            window.scrollTo({top:location, behavior:'smooth'});
        }
        function goBack(){ //목록으로
            window.location.href = document.referrer;
        }

        $('#deletePost').click(function(){
             if(!confirm("정말 삭제 할까요?")){
                 return;
             }
            //검색 조건 누를 시 ajax
            $.ajax({

                url:"/post/"+postId+".do",
                method: "DELETE",
                dataType: "json",
                success:function(data){
                        //리턴 받은 데이터가 1 이면 삭제 성공
                    if (data === 1){
                        alert("게시글 삭제 완료");
                        var str = window.location.href.split('/post');
                        window.location.href = str[0];
                    }
                    else {
                        alert("다시 시도해 주세요");
                    }

                },error:function(request,status,error){
                    alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
                }
            });//ajax
        });

        $('#update').click(function(){
            if(!confirm("게시글을 수정할 까요?")){
                return false;
            }
            var title = $('#title').val();
            var anonymous = $('#postAnonymous').val();
            var content = $('#content').val();

            // var bodyAdd = CKEDITOR.instances['content'].getData();
            //검색 조건 누를 시 ajax
            $.ajax({
                url:"/post/"+postId+".do",
                type : "patch",
                dataType: "json",
                contentType:"application/json",
                data : JSON.stringify({
                    "title" : title,
                    "content" : content,
                    "anonymous":anonymous
                }),
                success:function(data){
                    //리턴 받은 데이터가 1 이면 update 성공
                    if (data === 1){
                        alert("게시글 수정 완료");
                        div_show();
                        $('#postTitle').empty();
                        $('#postContent').empty();
                        $('#postTitle').append(title);
                        $('#postContent').append(content);
                    }
                    else {
                        alert("다시 시도해 주세요`");
                    }

                },error:function(request,status,error){
                    alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
                }
            });//ajax
        });//ready



        $('#good').click(function(){
            //검색 조건 누를 시 ajax
            $.ajax({
                type:"POST",
                url:"/post/"+postId+"/like.do",
                dataType: "json",
                contentType:"application/json",
                data : JSON.stringify({
                    "status":"GOOD"
                }),
                success:function(data){
                    if(data === 0){
                        alert("추천 신고를 둘다 할 수는 없습니다.");
                    }
                    $.ajax({
                        type:"GET",
                        url:"/post/"+postId+"/count",
                        dataType: "json",
                        contentType:"application/json",
                        data : ({
                            "status":"GOOD"
                        }),
                        success:function(data){
                            $("#good").empty();
                            var str ="추천 "+data;
                            $("#good").append(str);
                        }
                        //다시 불러오기
                    });//ajax
                },error:function(request,status,error){
                    alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
                }
            });
        });


        // /count
        $('#report').click(function(){
            //검색 조건 누를 시 ajax
            $.ajax({
                type:"POST",
                url:"/post/"+postId+"/like.do",
                dataType: "json",
                contentType:"application/json",
                data : JSON.stringify({
                    "status":"REPORT"
                }),
                success:function(data){
                    if(data === 0){
                        alert("추천 신고를 둘다 할 수는 없습니다.");

                    }


                    $.ajax({
                        type:"GET",
                        url:"/post/"+postId+"/count",
                        dataType: "json",
                        contentType:"application/json",
                        data : ({
                            "status":"REPORT"
                        }),
                        success:function(data){
                            $("#report").empty();
                            var str ='신고'+data;
                            $("#report").append(str);
                        }
                        //다시 불러오기
                    });//ajax
                },error:function(request,status,error){
                    alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
                }
                //다시 불러오기
            });//ajax


        });



        //아무 조건도 없이 dom 로드 되자마자 실행되는 제이쿼리
        $(document).ready(function() {
            $.ajax({
                type:"GET",
                url:"/post/"+postId+"/count",
                dataType: "json",
                contentType:"application/json",
                data : ({
                    "status":"GOOD"
                }),
                success:function(data){
                    $("#good").empty();
                    var str ='추천 '+data;
                    $("#good").append(str);
                },error:function (){
                    alert("잠시 후 다시 시도해 주세요.."); // 실패 시 처리
                }
            });//ajax

            $.ajax({
                type:"GET",
                url:"/post/"+postId+"/count",
                dataType: "json",
                contentType:"application/json",
                data : ({
                    "status":"REPORT"
                }),
                success:function(data){
                    $("#report").empty();
                    var str ='신고'+data;
                    $("#report").append(str);
                }
            });//ajax
            replyReload();

            var queryString = window.location.search;
            var boardLoc = location.href.split("/post/"+postId);
            var pageNo ='';
            if(!queryString.includes("pageNo") && !queryString.includes("?")){
                $.ajax({
                    url:"/post/"+postId+"/pageNo",
                    method: "get",
                    async:false,
                    dataType: "json",
                    success:function(data){
                        //리턴이 -1 이면 이미 삭제된 계시글임
                        if(data ===-1){//그냥 1번 페이지로
                            pageNo = "?pageNo="+1;
                        }
                        else {//그외 모든 경우에는 ?pageNo 이걸 붙여서 보내준다.
                            queryString +="?pageNo=" +Math.ceil(data/limit);
                        }

                    },error(){
                        alert("다시 시도해 주세요")
                    }
                });//ajax


            }



            $.ajax({
                url : boardLoc[0]+queryString,
                dataType : "html",
                type : "get",  // post 또는 get
                success : function(data){
                    $("#boardList").html(data);
                }
            });



        });//ready




        <!--여기는 댓글 js 시작-->
        function replyReload(newPageNo){
            if(newPageNo!=null){
                pageNo = newPageNo;
                block = parseInt(pageNo/pageSize)+1;
                if(pageNo%pageSize == 0){
                    block--;
                }
            }

            $.ajax({
                type:"GET",
                url:"/post/"+postId+"/reply",
                dataType: "json",
                data : {
                    "limit" : limit,
                    "pageNo" : pageNo
                },
                success:function(data){
                    //토탈 리플 개수 이거 나중에 따로 빼서 갯수만 구해오는 로직에 추가해야함

                    $("#reply").empty();
                    var imgAppend = true;
                    var reply ='';


                    $.each(data,function (i,v){
                        //댓글
                        reply += '<div id="replyDiv'+v.id+'">';

                        if(!anonymousNo.includes(v.memberId) && postMemberId != v.memberId){//같은 멤버 아이디면 같은 익명 번호 or 글쓴이는 글쓴이
                            anonymousNo.push(v.memberId);
                        }


                        if(v.parent === null) {
                            imgAppend = true;

                            if(v.status ==="NOT_DELETED"){
                                reply += '<div class="reply_date" style="top:35px;" id ="GoodReport'+v.id+'"'+'>';
                                reply +='<span class="badge badge-pill badge-light" style="cursor: pointer;" onclick="replyGoodReport('+v.id+','+1+');"><img src="/resources/post_image/good_image.PNG" style="width:15px; height:15px;"> '+v.good+'</span>'
                                reply +='<span class="badge badge-pill badge-light" style="cursor: pointer;" onclick="replyGoodReport('+v.id+','+-1+');"><img src="/resources/post_image/report_image.PNG" style="width:15px; height:15px;">  '+v.report+'</span>'
                                reply += '</div>';
                            }
                            else {
                                reply += '<div class="reply_date" style="top:35px;" id ="GoodReport'+v.id+'"'+'>';
                                reply +='<span class="badge badge-pill badge-light" ><img src="/resources/post_image/good_image.PNG" style="width:15px; height:15px;"> '+v.good+'</span>'
                                reply +='<span class="badge badge-pill badge-light" ><img src="/resources/post_image/report_image.PNG" style="width:15px; height:15px;">  '+v.report+'</span>'
                                reply += '</div>';
                            }

                            if(v.anonymous==='TRUE' && v.memberId != postMemberId){
                                var anoNo = anonymousNo.indexOf(v.memberId);
                                reply += '<div class="reply_writer"><img src="/resources/images_profile/profile.jpg"style="width:50px; height:50px;">작성자:익명'+anoNo+'</div>';
                            }

                            else if(v.anonymous==='TRUE' && v.memberId == postMemberId){

                                reply += '<div class="reply_writer"  style=" color: blue"><img src="/resources/images_profile/profile.jpg"style="width:50px; height:50px;">작성자:익명(글쓴이)</div>';
                            }

                            else {
                                reply += '<div class="reply_writer"><img src="/resources/'+v.img+'"style="width:50px; height:50px;">작성자:'+v.name+'</div>';
                            }


                            reply +='<div>';//추가

                            reply += '<div class="reply_date" style="top:35px;">작성일:'+v.createdAt;


                            if(boardName.includes('비밀') && (v.memberId !== memberId && memberId !== postMemberId)){

                            }

                            else {
                                reply +='<span class="badge badge-pill badge-light" onclick="replyReplyForm('+v.id+');" >댓글</span>';
                            }


                            if(v.status==="NOT_DELETED" && v.memberId === memberId){//삭제가 안된 댓글만 수정, 삭제 가능
                                reply +='<span class="badge badge-pill badge-light" onclick="deleteReply('+v.id+');">삭제</span>';
                                reply +='<span class="badge badge-pill badge-light" onclick="modifyReply('+v.id+');">수정</span>';
                            }


                            reply +='</div>'; //추가

                            if(boardName.includes('비밀') && memberId !== postMemberId && v.memberId !==memberId){
                                reply += '<textarea  readonly id="board_content'+v.id+'"  class="form-control"  style="margin-top:35px; resize:none;font-size: 13px; color: skyblue" >게시글 댓글 작성자만 볼 수 있습니다.</textarea>';
                            }
                            else if(v.status==="NOT_DELETED"){//삭제가 안된 댓글은 정상 출력
                                reply += '<textarea  readonly id="board_content'+v.id+'"  class="form-control"  style="margin-top:35px; resize:none;font-size: 13px;" >' + v.content + '</textarea>';
                            }
                            else if(v.status==="DELETED"){
                                reply += '<textarea  readonly id="board_content'+v.id+'"  class="form-control"  style="margin-top:35px; resize:none;font-size: 13px;" >삭제된 댓글 입니다.</textarea>';
                            }

                            else if(v.status==="DELETED_ADMIN"){
                                reply += '<textarea  readonly id="board_content'+v.id+'"  class="form-control"  style="margin-top:35px; resize:none;font-size: 13px;" >관리자에 의해 삭제된 댓글입니다.</textarea>';
                            }
                            reply += '</div>';
                            reply +='<div id="newReplyForm'+v.id+'">';
                            reply +='</div>';

                        }

                        //대댓글
                        else {
                            if(imgAppend){// 전에 화살표 이미지가 append 됬으면 취소 화살표 이미지 안달음
                                imgAppend=false;
                                reply+='<img src="https://img.icons8.com/fluent-systems-regular/2x/down-right.png" width="13px">'
                            }

                            reply += '<div class="reply_date" style="top:35px;" id ="GoodReport'+v.id+'"'+'>';
                            reply +='<span class="badge badge-pill badge-light" onclick="replyGoodReport('+v.id+','+1+');"><img src="/resources/post_image/good_image.PNG" style="width:15px; height:15px;">  '+v.good+'</span>'
                            reply +='<span class="badge badge-pill badge-light" onclick="replyGoodReport('+v.id+','+-1+');"><img src="/resources/post_image/report_image.PNG" style="width:15px; height:15px;">  '+v.report+'</span>'
                            reply += '</div>';

                            if(v.anonymous==='TRUE' && v.memberId != postMemberId){
                                var anoNo = anonymousNo.indexOf(v.memberId);
                                reply += '<div class="reply_writer"><img src="/resources/images_profile/profile.jpg"style="width:50px; height:50px;">작성자:익명'+anoNo+'</div>';
                            }

                            else if(v.anonymous==='TRUE' && v.memberId == postMemberId){

                                reply += '<div class="reply_writer"  style=" color: blue"><img src="/resources/images_profile/profile.jpg"style="width:50px; height:50px;">작성자:익명(글쓴이)</div>';
                            }

                            else {
                                reply += '<div class="reply_writer"><img src="/resources/'+v.img+'"style="width:50px; height:50px;">작성자:'+v.name+'</div>';
                            }


                            reply +='<div style="margin-top: 35px">';//추가

                            if(v.updatedAt ==null){
                                reply += '<div class="reply_date">작성일:'+v.createdAt+''
                            }
                            else {
                                reply += '<div class="reply_date">수정일:'+v.updatedAt+''
                            }


                            if(v.memberId === memberId){
                                reply +='<span class="badge badge-pill badge-light" onclick="deleteReply('+v.id+');">삭제</span>'
                                reply +='<span class="badge badge-pill badge-light" onclick="modifyReply('+v.id+');">수정</span>'
                            }

                            reply += '</div>';


                            reply+='<div class="text-right" >';

                            if(boardName.includes('비밀') && (memberId !== postMemberId && v.parentMemberId !== memberId)){

                                reply += '<textarea  readonly id="board_content'+v.id+'"  class="form-control"  style="resize:none;width: 90%;font-size: 13px; color: skyblue" >게시글 댓글 작성자만 볼 수 있습니다.</textarea>';
                            }

                            else {
                                reply += '<textarea  readonly id="board_content'+v.id+'" class="form-control"  style="resize:none;width: 90%;font-size: 13px">' + v.content + '</textarea>';
                            }
                            reply+='</div>';
                            reply += '</div>';
                        }
                        reply+='</div>';
                        reply+='<br>';
                    });
                    $("#reply").append(reply);


                }
            });//ajax

            //댓글 pagenation
            $.ajax({
                type:"Get",
                url:"/post/"+postId+"/reply_count",
                contentType: "application/json",
                dataType: "json",
                data : {
                },
                success:function(data){
                    var totalReply = "댓글["+data+"]";
                    $('#totalReply').empty();
                    $('#totalReply').append(totalReply)
                    var totalPage = parseInt(data/limit);
                    if(data%limit!=0)
                        totalPage++;
                    $('#pagination').empty();
                    var page = '';

                    if(data>1){

                    if(pageNo>1){
                        page += '<li class="page-link"  style="cursor: pointer" onclick="replyReload('+(1)+');"> '+"<<"+' </li>';
                    }
                    else {
                        page += '<li class="page-link"> '+"<<"+' </li>';
                    }

                    if(block>1){
                        page += '<li class="page-link"  style="cursor: pointer" onclick="replyReload('+((block-1)*pageSize)+');"> '+"<"+' </li>';
                    }
                    else {
                        page += '<li class="page-link"> '+"<"+' </li>';
                    }



                    for(var i=(block-1)*pageSize+1; i<block*pageSize+1;i++){
                        if(i<=totalPage){
                            if(i===pageNo)
                                page +='<li class="page-link" style="cursor: pointer; color: #c82333" onclick="replyReload('+i+');"> '+i+' </li>';

                            else
                                page +='<li class="page-link" style="cursor: pointer" onclick="replyReload('+i+');"> '+i+' </li>';
                        }
                    }

                    if((block*pageSize+1)<=totalPage)
                        page += '<li class="page-link"  style="cursor: pointer" onclick="replyReload('+(block*pageSize+1)+');"> '+">"+' </li>';
                    else {
                        page += '<li class="page-link"> '+">"+' </li>';
                    }
                    if(pageNo<totalPage)
                        page += '<li class="page-link"  style="cursor: pointer" onclick="replyReload('+(totalPage)+');"> '+">>"+' </li>';
                    else {
                        page += '<li class="page-link"> '+">>"+' </li>';

                    }}

                    $('#pagination').append(page);
                },error:function(request,status,error){
                    alert("잠시 후 다시 시도해 주세요.."); // 실패 시 처리
                }

            });//ajax
        }

        //새로운 댓글 등록 ajax
        $('#newReply').click(function(){
            var content = $('#newReplyContent').val();
            var replywriter = "${loginMemberDTO.name}";
            var boardwriter = "${memberDTO.email}";
            var pno = "${post.id}";
            var bno = "${post.boardId}";

            if(content===""){
                alert("댓글을 입력해 주세요");
                return;
            }
            var anonymous = $('#anonymous').val();
            $.ajax({
                type:"POST",
                url:"/post/"+postId+"/reply.do",
                contentType: "application/json",
                dataType: "json",
                data : JSON.stringify({
                    "content":content,
                    "anonymous":anonymous
                }),
                success:function(data){
                    alert("댓글등록완료");
                    // 알람을 위한 소캣 연결
                    console.debug("replt.js::socket>>",socket);
                    if(socket){
                        //websocket에 보내기 !! (reply,댓글작성자,게시글작성자,글번호)
                        let socketMsg = "reply"+","+replywriter+","+boardwriter+","+pno+","+bno;
                        console.log(socketMsg);
                        socket.send(socketMsg);
                    }else{
                        console.debug("Error on editReply>>");
                    }
                    // 소켓

                    document.getElementById("newReplyContent").value=''; //textarea지우기

                    //맨 마지막 페이지로 이동
                    $.ajax({
                        type: "Get",
                        url: "/post/"+postId+"/reply_count",
                        contentType: "application/json",
                        dataType: "json",
                        data: {},
                        success:function (data){
                            var totalReply = "댓글["+data+"]";
                            $('#totalReply').empty();
                            $('#totalReply').append(totalReply)
                            var totalPage = parseInt(data/limit);
                            if(data%limit!=0)
                                totalPage++;
                            replyReload(totalPage);
                        }
                    });

                },error:function(request,status,error){
                    alert("잠시 후 다시 시도해 주세요.."); // 실패 시 처리
                }
            });//ajax
        });//func


        //추천 신고
        function replyGoodReport(replyId,status) {
            //1 == GOOD //2 == REPORT
            var divId = "#GoodReport"+replyId;
            if (status === 1) {
                status = "GOOD";
            }
            else {
                status="REPORT";
            }

            $.ajax({
                type: "POST",
                url: "/reply/"+replyId+"/like.do",
                dataType: "json",
                contentType: "application/json",
                data: JSON.stringify({
                    "status": status
                }),
                success: function (data) {
                    if(data===0)
                        alert("추천,신고 둘다 할 수는 없습니다.");

                    $.ajax({
                        type: "GET",
                        url: "/reply/"+replyId+"/like.do",
                        dataType: "json",
                        data:{
                            "replyId": replyId
                        },
                        success: function (data) {
                            $(divId).empty();
                            var goodReport = '';
                            goodReport +='<span class="badge badge-pill badge-light" onclick="replyGoodReport('+data.id+','+1+');"><img src="/resources/post_image/good_image.PNG" style="width:15px; height:15px;">  '+data.good+'</span>'
                            goodReport +='<span class="badge badge-pill badge-light" onclick="replyGoodReport('+data.id+','+-1+');"><img src="/resources/post_image/report_image.PNG" style="width:15px; height:15px;"> '+data.report+'</span>'
                            $(divId).append(goodReport);
                        }
                    });//ajax
                }
            });
        }

        //리플 수정
        function modifyReply(replyId){
            var reply = "board_content"+replyId;
            var check = document.getElementById(reply).readOnly;
            if(check=== true){
                document.getElementById(reply).readOnly=false;
            }
            else {//readOnly가 false 이고 다시 수정 버튼을 누르면 그 데이터를 ajax해야지
                var replyContentID = "#"+reply;
                var content = $(replyContentID).val();
                $.ajax({
                    url: "/post/"+postId+"/reply.do",
                    type : "PATCH",
                    dataType: "json",
                    contentType:"application/json",
                    data : JSON.stringify({
                        "content" : content,
                        "id" : replyId
                    }),
                    success: function (data) {
                        alert("수정 성공");
                    },error:function(request,status,error){
                        alert("잠시 후 다시 시도해 주세요.."); // 실패 시 처리
                    }
                });//ajax
                document.getElementById(reply).readOnly=true;
            }
        }



        //리플 삭제
        function deleteReply(replyId) {
            if(!confirm("정말 삭제 할까요, 대댓글이 달린 댓글은 삭제가 불가능 합니다.")){
                return ;
            }
            $.ajax({
                type: "DELETE",
                url: "/post/"+postId+"/reply/"+replyId+".do",
                dataType: "json",
                contentType: "application/json",
                data:{
                },
                success: function (data) {
                    if(data ===1){
                        alert("댓글 삭제 완료");
                        replyReload(pageNo);
                    }
                    else {
                        replyReload(pageNo);
                    }
                },error:function(request,status,error){
                    alert("잠시 후 다시 시도해 주세요.."); // 실패 시 처리
                }
            });
        }

        //대댓글 append -> append 삭제 이순으로 되어야 하는
        function replyReplyForm(replyId){
            var contentId = "#newReplyForm"+replyId;
            var removeReplyForm = "#newReplyForm"+toggle;
            $(removeReplyForm).empty();

            if(toggle == replyId){
                $(removeReplyForm).empty();
                toggle=-1;
            }


            else {
                var newReply = '';
                newReply+='<img src="https://img.icons8.com/fluent-systems-regular/2x/down-right.png" width="13px">';
                newReply+='<textarea id="replyReplyContent'+replyId+'" class="form-control" placeholder="논란이 있는 댓글을 관리자에 의해 삭제될 수 있습니다." style="resize:none" ></textarea>';
                newReply+='<select id="replyReplyAnonymous'+replyId+'">';
                newReply+='<option value="TRUE">익명</option>';

                if(boardName.includes('익명')){
                newReply+='<option value="FALSE">닉네임</option>';
                }

                newReply+='</select>';
                newReply+='<button onclick="newReplyReply('+replyId+');">등록</button>';
                $(contentId).append(newReply);
                toggle = replyId;

            }
        }

        // 대댓글 작성 !!!!
        function newReplyReply(replyId){
            alert("replyId : " + replyId );
            var content = "#replyReplyContent"+replyId;

            var rereplywriter = "${loginMemberDTO.name}";
            var replywriter = "${memberDTO.email}";       // 여기에 대댓글 작성자 이메일만 가져오면 끝남
            var pno = "${post.id}";
            var bno = "${post.boardId}";

            content = $(content).val();
            if(content ===""){
                alert("댓글을 입력해 주세요");
                return false;
            }

            var anonymous = "#replyReplyAnonymous"+replyId;
            anonymous = $(anonymous).val();
            $.ajax({
                type:"POST",
                url:"/post/"+postId+"/reply.do",
                contentType: "application/json",
                dataType: "json",
                data : JSON.stringify({
                    "content":content,
                    "anonymous":anonymous,
                    "parent" : replyId
                }),
                success:function(data){
                    var removeReplyForm = "#newReplyForm"+toggle;
                    $(removeReplyForm).empty();
                    toggle=-1;
                    replyReload(pageNo);

                    // 알람을 위한 소캣 연결
                    console.debug("replt.js::socket>>",socket);
                    if(socket){
                        alert("socket연결 완료")
                        //websocket에 보내기 !! (rereply,댓글작성자,게시글작성자,글번호)
                        let socketMsg = "rereply"+","+rereplywriter+","+replywriter+","+pno+","+bno;
                        console.log(socketMsg);
                        socket.send(socketMsg);
                    }else{
                        console.debug("Error on editReply>>");
                    }
                    // 소켓


                },error:function(request,status,error){
                    alert("잠시 후 다시 시도해 주세요.."); // 실패 시 처리
                }
            });//ajax
        }


    </script>
<c:import url="/WEB-INF/views/include/bottom_info.jsp" />