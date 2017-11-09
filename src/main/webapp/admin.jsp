<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="./css/bootstrap.css">
    <link rel="stylesheet" href="./css/bootstrap-theme.css">
    <link rel="icon" href="./images/bs.ico" type="image/x-icon"/>
    <style type="text/css">
    	h1{width:100%;text-align: center;font-family: romans;}
    	#log{width:350px; background-color:white; position:absolute; margin-left:36%; margin-top:100px;}
    	#fd{width:250px; margin-left: 50px;margin-top: 50px;}
    	#op{text-align: center;}
    </style>
    <script src="./jeasyui/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
    <script src="./js/bootstrapValidator.js"></script>
	<title>OnlineBS |  administrator login</title>
</head>
<body style="background-color: 	#F0F8FF;">
    <div class="container-fluid" style="height: 75px;background-color: white">
        <div class="navbar-header">
        	<a href="#" class="btn-closemenu"><i class="icon-x"></i></a>
         	<a class="navbar-brand" href="./login.jsp"><img src='./images/bs.png' alt="OnlineBS"/></a>
        </div>
        <nav id="navbar" class="navbar-collapse collapse">
        	<h2 style="font-size:30px;font-family: times;">
        		<a style="text-decoration: none;color: black;" href="./admin.jsp" >Welcome, Administrator</a> 
        	</h2>
        </nav>
    </div>
	<div class="container-fluid" style="background-color: black;">
		<div id="log">
			<h1>Admin Login</h1> 
    		<form id="fd" action="admin_login" method="post">
    			<s:fielderror cssStyle="color:Red;"></s:fielderror>
        		<div class="form-group">
           	 		<input type="text" class="form-control"  name="aname"
                   		   placeholder="Admin Name" autocomplete="off" autofocus="true"/>
        		</div>
        		<div class="form-group">
            		<input type="password" class="form-control" name="apwd" 
            		       placeholder="Password"  autocomplete="off"/>
       		 	</div>
        		<div class="form-group" style="margin-bottom:40px;">
          			<button type="submit" class="btn btn-primary btn-fat btn-block">Sign in</button>
        		</div>
    		</form>	
		</div>
	</div>
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
		"aname": {
			message: 'Aminname is not valid',
			validators: {
				notEmpty: {
					message: 'Adminname is required and cannot be empty'
				},
				stringLength: {
					min: 1,
					max: 200,
					message: 'Adminname must be more than 1 and less than 200 characters long'
				},
				regexp: {
					regexp: /^[a-zA-Z0-9_]+$/,
					message: 'Adminname can only consist of alphabetical, number, dot and underscore'
				},
				different: {
					field: 'apwd',
					message: 'Adminname and password cannot be the same as each other'
				}
			}
		},
		"apwd": {
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
					field: 'aname',
					message: 'Password cannot be the same as adminname'
				}
			}
		}
	}
	});
});
</script>
</html>