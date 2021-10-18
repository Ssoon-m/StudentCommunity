<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="path" value="${pageContext.request.contextPath }/" />

<script type="text/javascript">
  alert('정보가 수정되었습니다. 다시 로그인 해주세요.');
  location.href = '${path}member/login';
</script> 
