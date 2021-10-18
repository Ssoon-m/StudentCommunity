<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

 <c:import url="/WEB-INF/views/include/head_meta.jsp" />
 <c:import url="/WEB-INF/views/include/top_menu.jsp" />


 <!-- 메인 컨텐츠 적는곳 -->
 <div style="margin-top: 130px;">
 <div class="card pconly ml-3 float-left" id="loginmenu">
      <form class="loginform">
        <p>커뮤니티<br><strong>로그인</strong>이 필요합니다!</p>
        <a href="#" class="button login" style="border: 1px solid #d6d6d6;">로그인</a><br>
        <a href="#" class="button register" style="background-color: red;">회원가입</a>
      </form>
  </div>
<div class="card mr-3 float-right" id="aa1">
	<div class="board">
		<h3><a>실시간 인기 글</a></h3>
		<hr>
		<a class="article">
			<p>로그인 후 확인할 수 있습니다.</p>
			<ul class="status">
			</ul>
			<hr>
		</a>
		<a class="article">
			<p>로그인 후 확인할 수 있습니다.</p>
			<ul class="status">
			</ul>
		<hr>
		</a>
	</div>
</div>

  <!-- 게시판 미리보기 부분 -->
  <div class="container" style="margin-top: 100px">
  <img src="https://apple.contentsfeed.com/RealMedia/ads/Creatives/jobkorea/210426_kotra_mb_s/210423_kotra_752110.jpg" width="1100px" height="130px">
    <div class="row">
    
		<div class="col-lg-4" style="margin-top:35px">
			<div class="card shadow-sm">
				<div class="card-body">
				
					<h4 class="card-title">자유 게시판</h4>
					<table class="table table-hover" id="board_list">
						<thead>
							<tr>
								<th class="text-center w-25">글번호</th>
								<th>제목</th>
								<th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
					
						</tbody>
					</table>
					
					<a href="${root }board/main" class="btn btn-dark">더보기</a>
				</div>
			</div>
		</div>
		<div class="col-md-4" style="margin-top:35px">
			<div class="card shadow-sm">
				<div class="card-body">
					<h4 class="card-title">창업취업 정보방</h4>
					<table class="table table-hover" id="board_list">
						<thead>
							<tr>
								<th class="text-center w-25">글번호</th>
								<th>제목</th>
								<th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
						</tbody>
					</table><a href="${root }board/main" class="btn btn-dark">더보기</a>
				</div>
			</div>
		
		</div>
		<div class="col-md-4" style="margin-top:35px">
			<div class="card shadow-sm">
				<div class="card-body">
					<h4 class="card-title">새내기 게시판</h4>
					<table class="table table-hover" id="board_list">
						<thead>
							<tr>
								<th class="text-center w-25">글번호</th>
								<th>제목</th>
								<th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
						</tbody>
					</table><a href="${root }board/main" class="btn btn-dark">더보기</a>
				</div>
			</div>
		</div>
		<div class="col-lg-6" style="margin-top:20px">
			<div class="card shadow-sm">
				<div class="card-body">
					<h4 class="card-title">졸업생 게시판</h4>
					<table class="table table-hover" id="board_list">
						<thead>
							<tr>
								<th class="text-center w-25">글번호</th>
								<th>제목</th>
								<th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
						</tbody>
					</table><a href="${root }board/main" class="btn btn-dark">더보기</a>
				</div>
			</div>
		</div>
        <div class="col-lg-6" style="margin-top:20px">
			<div class="card shadow-sm">
				<div class="card-body">
					<h4 class="card-title">익명방</h4>
					<table class="table table-hover" id="board_list">
						<thead>
							<tr>
								<th class="text-center w-25">글번호</th>
								<th>제목</th>
								<th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
						</tbody>
					</table><a href="${root }board/main" class="btn btn-dark">더보기</a>
				</div>
			</div>
		</div>
        <div class="col-lg-12" style="margin-top:20px">
			<div class="card shadow-sm">
				<div class="card-body">
					<h4 class="card-title">장터 게시판</h4>
					<table class="table table-hover" id="board_list">
						<thead>
							<tr>
								<th class="text-center w-25">글번호</th>
								<th>제목</th>
								<th class="text-center w-25 d-none d-xl-table-cell">작성날짜</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
							<tr>
								<td class="text-center">5</td>
								<td><a href="${root }board/read" style="color: black;">제목입니다</a></td>
								<td class="text-center d-none d-xl-table-cell">2018-12-12</td>
							</tr>
						</tbody>
					</table><a href="${root }board/main" class="btn btn-dark">더보기</a>
				</div>
			</div>
		</div>
	</div>
  </div>
</div>
	
	

 <c:import url="/WEB-INF/views/include/bottom_info.jsp" />