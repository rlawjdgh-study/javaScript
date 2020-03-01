<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script> 
<title>Insert title here</title>
</head>
<body>
	<form action="/customLogout" method="post">
		<button id="logout_btn"></button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form> 
</body> 
	<script type="text/javascript">
		$(document).ready(function() { 
			$("#logout_btn").trigger("click");
		});
	</script>  
</html>   