<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
<title>Online Bookstore</title>
</head>
<body>
	<div style="margin-top: 10%;">
		<h2 style="text-align:center;">Login timeout, it will be forwarded to login page in 3s.</h2>
	</div>
</body>
<script src="../jeasyui/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		setTimeout(function(){
			window.location.href="./login.jsp";
		},3000);
	});
</script>
</html>