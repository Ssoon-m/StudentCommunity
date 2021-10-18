<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="root" value="/" />
<script>
  alert('다른 환경에서 로그인 됐습니다.');
  location.href = '${root}member/login';
</script>