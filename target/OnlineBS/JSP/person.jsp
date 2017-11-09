<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.*"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="../css/bootstrap.min.css">	
    <link rel="stylesheet" href="../css/bootstrapValidator.css">
    <script src="../jeasyui/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/bootstrapValidator.js"></script>
    <link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
	<title>OnlineBS | Personal Center</title>
	<style type="text/css">
    	h2{text-align: center;font-family: romans;margin-top: 30px;}
    	.navbar-brand {
    		font-family: "Cambria";
    		font-size: 24px;
		}
		.form{ 
			margin-left: 10%;
			width:80%;
		}
    	#mf{width:1180px; height:580px; position:absolute;margin-top:70px;margin-left:90px;}
    	#tabs{margin-top: 50px;}
    	#mark{margin-top:30px;text-align: center;font-size:22px;font-family:romans;}
    	#left{width:200px; height:580px;background-color:white;}
    	#pad{width:8px;height:580px;}
    	#right{width:950px; height:580px;background-color:white;}
    	.tb{width:800px;height:400px;margin-left:70px;margin-top:70px;}
    </style>
</head>
<body style="background-color: #F1F1F1">
	<nav class="navbar  navbar-inverse navbar-fixed-top">
    <div class="container">
    	<div class="navbar-header">
      		<a class="navbar-brand" href="../">Online BookStore</a>
		</div>
		<div class="collapse navbar-collapse">
		<ul class="nav navbar-nav navbar-right">
            	<li><a class="navbar-brand">
            		<s:property value="#session.usr.username"/>
            	</a></li>
        </ul>
        </div>
	</div>
	</nav>
	<% Users u = (Users)session.getAttribute("usr"); 
	%>
	<div class="container-fluid" id="mf">
        <div class="row">
        	<div class="col-md-1" id="left">
        		<p id="mark">Personal Center</p>
        		<ul class="nav nav-pills nav-stacked" id="tabs">
        			<li class="active"><a href="./person.jsp">My Info</a></li>
  					<li><a href="./orders.jsp">Orders</a></li>
				</ul>
			</div>
        	<div class="col-md-1" id="pad"></div>
        	<div class="col-md-6" id="right">
				<h2>Personal Information</h2>
				<div class="container tb">
					<table class="table">
						<tr>
							<th>User Name</th>
							<td><%=u.getUsername()%></td>
						</tr>
						<tr>
							<th>Password</th>
							<td id="passwd"">&hearts;&hearts;&hearts;&hearts;&hearts;&hearts;</td>
						</tr>
						<tr>
							<th>First Name</th>
							<td><%=u.getFirstname()%></td>
						</tr>
						<tr>
							<th>Last Name</th>
							<td><%=u.getLastname()%></td>
						</tr>
						<tr>
							<th>Phone</th>
							<td><%=u.getPhone()%></td>
						</tr>
						<tr>
							<th>Email</th>
							<td><%=u.getEmail()%></td>
						</tr>
						<tr>
							<th>Address</th>
							<td><%=u.getAddress()%></td>
						</tr>
						<tr>
							<th></th>
							<td></td>
						</tr>
					</table>
					<div class="row" style="margin-top: 50px;">
						<div class="col-md-6"></div>
						<div class="col-md-2">
							<button class="btn btn-primary" style="font-size: 20px;"
								onclick="edit()">Edit info</button>
						</div>
						<div class="col-md-2">
							<a href="user_logout"><button class="btn btn-warning" style="font-size: 20px;">
								Logout
							</button></a>
						</div>
						<div class="col-md-2">
							<button class="btn btn-danger" style="font-size: 20px;"
								onclick="del()">Delete Account</button>
						</div>
					</div>

					<!-- edit user info -->
					<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
						aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">Edit info</h4>
								</div>
								<div class="modal-body">
									<form class="form" action="user_edit" method="post" id="fm">
										<div class="form-group input-group">
											<span class="input-group-addon">User Name</span> <input
												type="text" class="form-control" name="usr.username"
												id="Username">
										</div>
										<div class="form-group input-group">
											<span class="input-group-addon">Password</span> <input
												type="password" class="form-control" name="usr.pwd" id="Pwd">
										</div>
										<div class="form-group input-group">
											<span class="input-group-addon">First Name</span> <input
												type="text" class="form-control" name="usr.firstname"
												id="Fname">
										</div>
										<div class="form-group input-group">
											<span class="input-group-addon">Last Name</span> <input
												type="text" class="form-control" name="usr.lastname"
												id="Lname">
										</div>
										<div class="form-group input-group">
											<span class="input-group-addon">Phone</span> <input
												type="text" class="form-control" name="usr.phone" id="Phone">
										</div>
										<div class="form-group input-group">
											<span class="input-group-addon">Email</span> <input
												type="text" class="form-control" name="usr.email" id="Email">
										</div>
										<div class="form-group input-group">
											<span class="input-group-addon">Address</span> <input
												type="text" class="form-control" name="usr.address"
												id="Address">
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">Cancel</button>
											<input type="submit" class="btn btn-primary" value="Submit" />
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
        </div>
    </div>
</body>
<script>
	function edit(){
		var uname = "<%=u.getUsername()%>";
		$('#Username').val(uname);
		var pwd = "<%=u.getPwd()%>";
		$('#Pwd').val(pwd);
		var fname = "<%=u.getFirstname()%>";
		$('#Fname').val(fname);
		var lname = "<%= u.getLastname()%>";
		$('#Lname').val(lname);
		var phone = "<%= u.getPhone()%>";
		$('#Phone').val(phone);
		var email = "<%= u.getEmail()%>";
		$('#Email').val(email);
		var address = "<%= u.getAddress()%>";
		$('#Address').val(address);
		$('#editModal').modal('show');
	}
	
	function del(){
		var r = confirm("Are you sure to delete your account?");
		if(r){
			window.location.href="user_delete";
		}
	}
	
	$('#editModal').on('hide.bs.modal',function(e){
    	$('#fm').data('bootstrapValidator').resetForm();
    });
    
    $('#fm').bootstrapValidator({
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
					regexp: /^[a-zA-Z0-9_. @#$%^&*~]+$/,
					message: 'Password can only consist of alphabetical, number and _. @#$%^&*~'
				},
				different: {
					field: 'usr.username',
					message: 'Password cannot be the same as username'
				}
			}
		},
		"usr.firstname": {
			validators: {
				notEmpty: {
					message: 'First name is required and cannot be empty'
		        },
		        stringLength: {
					min: 1,
					max: 200,
					message: 'First name must be more than 1 and less than 200 characters long'
				},
		        regexp: {
					regexp: /^[a-zA-Z]+$/,
					message: 'First name can only consist of alphabetical'
				}
			}
		},
		"usr.lastname": {
			validators: {
				notEmpty: {
					message: 'Last name is required and cannot be empty'
				},
				stringLength: {
					min: 1,
					max: 200,
					message: 'Last name must be more than 1 and less than 200 characters long'
				},
				regexp: {
					regexp: /^[a-zA-Z]+$/,
					message: 'Last name can only consist of alphabetical'
				}
			}
		},
		"usr.phone": {
			validators: {
				notEmpty: {
					message: 'Phone is required and cannot be empty'
				},
				stringLength: {
					min: 6,
					max: 50,
					message: 'Phone number must be more than 6 and less than 50 characters long'
				},
				regexp: {
					regexp: /^[0-9]+$/,
					message: 'Phone can only consist of number'
				}
			}
		},
		"usr.email": {
			validators: {
				notEmpty: {
					message: 'Email is required and cannot be empty'
				},
				emailAddress: {
					message: 'The input is not a valid email address'
				}
			}
		},
		"usr.address": {
			validators: {
				notEmpty: {
					message: 'Address is required and cannot be empty'
				},
				regexp: {
					regexp: /^[a-zA-Z0-9_.]+$/,
					message: 'Address can only consist of alphabetical, number, dot and underscore'
				}
			}
		}
	}
	});
	
</script>
</html>