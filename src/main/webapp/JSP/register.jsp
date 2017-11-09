<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/bootstrapValidator.css">
    <link rel="stylesheet" href="../css/fileinput.css">
    <link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
	<title>OnlineBS | Register</title>
	<style type="text/css">
    	h2{text-align: center;font-family: romans;}
    	#mf{width:60%; height:auto;background-color:white; position:absolute; margin-left:20%; margin-top:30px;}
    	#fd{width:40%; height:auto;margin-left: 30%;margin-top: 30px;}
    </style>
</head>
<body style="background-color: #F1F1F1">
	<div id="mf"> 
        <div class="row" style="margin-top: 15px;">
        	<div class="col-md-3"></div>
        	<div class="col-md-6">
        		<h2>Register for BookStore</h2>
        	</div>
        </div>
        <form id="fd" enctype="multipart/form-data" action="user_signup" method="post" role="form">
        		<div class="form-group">
                	<input type="file" class="file" name="image" id="image" />
                </div>
        		<div class="form-group">
           	 		<input type="text" class="form-control"  name="username"
                   		   placeholder="User Name" autofocus autocomplete="off"/>
        		</div>
        		<div class="form-group">
            		<input type="password" class="form-control" name="pwd" 
            		       placeholder="Password" />
       		 	</div>
       		 	<div class="form-group">
            		<input type="password" class="form-control" name="cpassword"
            		       placeholder="Confirm Password"/>
       		 	</div>
       		 	<div class="form-group">
           	 		<input type="text" class="form-control"  name="firstname"
                   		   placeholder="First Name" autocomplete="off"/>
        		</div>
        		<div class="form-group">
            		<input type="text" class="form-control" name="lastname" 
            		       placeholder="Last Name" autocomplete="off"/>
       		 	</div>
       		 	<div class="form-group">
            		<input type="text" class="form-control" name="phone" 
            		       placeholder="Phone" autocomplete="off"/>
       		 	</div>
       		 	<div class="form-group">
            		<input type="email" class="form-control" name="email" 
            		       placeholder="Email" autocomplete="off"/>
       		 	</div>
       		 	<div class="form-group">
            		<textarea class="form-control" rows="2" name="intro" 
            		       placeholder="Introduction"></textarea>
       		 	</div>
       		 	<div class="form-group">
            		<textarea class="form-control" rows="2" name="address" 
            		       placeholder="Address"></textarea>
       		 	</div>
        		<div class="form-group">
          			<button type="submit" class="btn btn-primary btn-fat btn-block">Sign up</button>
        		</div>
    	</form>
		<div class="row">
      		<div class="col-md-4"></div>
        	<div class="col-md-4">
    		<p class="copy" style="padding-left:10px; margin-top: 3.5%;">&COPY; 2017 Lionel. All Rights Reserved.</p>
    		</div>
  		</div>
	</div>
</body>
<script src="../jeasyui/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/bootstrapValidator.js"></script>
<script src="../js/fileinput.js"></script>
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
		"username": {
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
				remote: {
					type: 'POST',
					url: 'user_check',
					message: 'Username is not available',
					delay: 1000
				},
				different: {
					field: 'pwd',
					message: 'Username and password cannot be the same as each other'
				}
			}
		},
		"pwd": {
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
					field: 'username',
					message: 'Password cannot be the same as username'
				}
			}
		},
		cpassword: {
			validators: {
				notEmpty: {
					message: 'Confirm password is required and cannot be empty'
				},
				identical: {
					field: 'pwd',
					message: 'It\'s different from password'
				}
			}
		},
		"firstname": {
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
		"lastname": {
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
		"phone": {
			validators: {
				notEmpty: {
					message: 'Phone is required and cannot be empty'
				},
				stringLength: {
					min: 6,
					max: 20,
					message: 'Phone number must be more than 6 and less than 50 characters long'
				},
				regexp: {
					regexp: /^[0-9]+$/,
					message: 'Phone can only consist of number'
				}
			}
		},
		"email": {
			validators: {
				notEmpty: {
					message: 'Email is required and cannot be empty'
				},
				emailAddress: {
					message: 'The input is not a valid email address'
				}
			}
		},
		"address": {
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
});

$('#image').fileinput({
	showUpload: false,
	maxFileCount: 1,
	maxFileSize: 2048,
	allowedFileExtensions : ['jpg','png','gif']
});
</script>
</html>