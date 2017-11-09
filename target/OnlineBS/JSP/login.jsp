<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/bootstrap-theme.css">
    <link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
    <style type="text/css">
    	h1{width:100%;text-align: center;font-family: romans;}
    	#log{width:350px; height:420px; background-color:white; position:absolute; margin-left:65%; margin-top:100px;}
    	#fd{width:250px; height:300px;margin-left: 50px;margin-top: 50px;}
    	#op{text-align: center;}
    	.in{width:250px;height: 45px;}
    	.cont{font-size: 16px;padding-left:10px;}
    </style>
    <script src="../jeasyui/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/bootstrapValidator.js"></script>
	<title>OnlineBS | login</title>
</head>
<body>
    <div class="container" style="height: 75px;">
        <div class="navbar-header">
        	<a href="#" class="btn-closemenu"><i class="icon-x"></i></a>
         	<a class="navbar-brand" href="./login.jsp"><img src='../images/bs.png' alt="OnlineBS"/></a>
        </div>
        <nav id="navbar" class="navbar-collapse collapse">
        	<h2 style="font-size:30px;font-family: times;">
        		<a style="text-decoration: none;color: black;" href="./login.jsp" >Welcome to login</a> 
        	</h2>
        </nav>
    </div>
	<div  style="background-image:url('../images/background.jpg');height:600px;">
		<div id="log">
			<h1>Login</h1> 
    		<form id="fd" action="user_login" method="post">
    		<s:fielderror cssStyle="color:Red;"></s:fielderror>
        		<div class="form-group">
           	 		<input type="text" class="in cont"  name="usr.username" id="uid"
                   		   placeholder="User Name" autocomplete="off"/ autofocus="true">
        		</div>
        		<div class="form-group">
            		<input type="password" class="in cont" name="usr.pwd" 
            		       placeholder="Password" />
       		 	</div>
        		<div class="form-group">
          			<input type="submit" class="in btn-primary" value="Sign in"/>
        		</div>
        		<p id="op">
        			<a class="btn" href="register.jsp">Register now</a>|<a class="btn">Forgot password?</a>
        		</p>
    		</form>	
		</div>
	</div>
    <footer>
    <div class="container" style="height:70px;">
    	<div class="row" style="margin-top:15px;">
      	<div class="col-md-4"></div>
      	<div  class="col-md-1">
			<div class="foot-logo">
				<img src='../images/bs.png' />
			</div>
		</div>
        <div class="col-md-4">
    		<p class="copy" style="margin-top: 3.5%;">&COPY; 2017 Lionel. &nbsp;All Rights Reserved.</p>
    	</div>
    	</div>
  	</div>
    </footer>
</body>
<script type="text/javascript">
$(document).ready(function() {
	$('#fd').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
	    	invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
	fields: {
		"usr.username": {
			message: 'Username is not valid',
			validators: {
				notEmpty: {
					message: 'Username is required and cannot be empty'
				},
				stringLength: {
					min: 1,
					max: 200,
					message: 'Username must be more than 1 and less than 200 characters long'
				},
				regexp: {
					regexp: /^[a-zA-Z0-9_]+$/,
					message: 'Username can only consist of alphabetical, number, dot and underscore'
				},
				different: {
					field: 'usr.pwd',
					message: 'Username and password cannot be the same as each other'
				}
			}
		},
		"usr.pwd": {
			validators: {
				notEmpty: {
					message: 'Password is required and cannot be empty'
				},
				stringLength: {
					min: 6,
					max: 200,
					message: 'Password must be more than 6 and less than 200 characters long'
				},
				regexp: {
					regexp: /^[a-zA-Z0-9_.@#$%^&*~]+$/,
					message: 'Password can only consist of alphabetical, number and _.@#$%^&*~'
				},
				different: {
					field: 'usr.username',
					message: 'Password cannot be the same as username'
				}
			}
		}
	}
	});
});
</script>
</html>