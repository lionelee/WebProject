<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!doctype html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Online BookStore</title>
    <link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/main.css">
	 <style>
        #main{
        	width: 1000px;
        	height: 300px;
        	margin-top: 120px;
        	background-color: white;
        }
        #info{
        	width: 700px;
        	margin-left: 150px;
        	margin-top: 50px; 
        	font-family: 'Covered By Your Grace', 'DejaVu Serif';
        	font-size: 30px;
        }
        .btn{
        	margin-top: 50px;
        	margin-left: 100px;
        }
    </style>
</head>
<body style="background-color: #FAFAFA">
<nav class="navbar  navbar-inverse navbar-fixed-top">
    <div class="container">
    	<!-- nav-bar for narrow windows -->
    	<div class="navbar-header">
      		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
      		data-target="#navbar-collapse" aria-expanded="false">
        		<span class="sr-only">Toggle navigation</span>
        		<span class="icon-bar"></span>
        		<span class="icon-bar"></span>
        		<span class="icon-bar"></span>
      		</button>
      		<a class="navbar-brand" href="../index.jsp">Online BookStore</a>
		</div>
    </div>
</nav>
<div class="container" id="main">
	<div id="info">
		<p>The book has been successfuly added into your shopping cart.<p>
		<p><a class="col-md-3 btn btn-warning btn-lg" 
			href="cart.jsp">
			Go to cart &raquo;</a></p>
		<p><a class="col-md-3 btn btn-success btn-lg" style="margin-left: 10px;"
			href="../index.jsp">
			Keep shopping &raquo;</a></p>	
	</div>
</div>
</body>
</html>