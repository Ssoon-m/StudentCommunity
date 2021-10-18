<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 절대 경로 설정 -->
<c:url var="root" value="/" />

<script type="text/javascript">
  location.href='${root}member/login?failure=true';
</script> 

