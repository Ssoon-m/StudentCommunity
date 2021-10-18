<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 절대 경로 설정 -->
<c:url var="root" value="/" />

<script type="text/javascript">
  alert('비밀번호가 올바르지 않습니다.');
  location.href='${root}member/before_modify';
</script> 