<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/bootstrap-table.css" rel="stylesheet">
	<link href="../css/bookstore.css" rel="stylesheet">
	<link rel="stylesheet" href="../css/bootstrapValidator.css">
    <link rel="stylesheet" href="../css/fileinput.css">
	<link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
	<title>BookStoreAdmin | Users</title>
	<style type="text/css">
		.form{ 
			margin-left: 10%;
			width:80%;
		}
	</style>
</head>

<body>
	<div id="wrapper" >
		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-fixed-top"
			style="margin-bottom: 20px;">

		<div class="navbar-header">
			<a class="navbar-brand" href="./user.jsp">BookStore</a>
		</div>
		<div class="collapse navbar-collapse">
			<ul class="nav navbar-nav navbar-right" style="height:8px;">
            	<li><a href="admin_logout" class="btn" style="height:12px; margin-right: 50px;font-size: 20px;">
					Logout
            	</a></li>
            </ul>
		</div>
		<div class="navbar-default sidebar">
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav" id="side-menu">
					<li><a href="./user.jsp" class="active"><i class="fa fa-user fa-fw"></i>
							Users</a></li>
					<li><a href="./book.jsp"><i class="fa fa-book fa-fw"></i> Books</a></li>
					<li><a href="./order.jsp"><i class="fa fa-reorder fa-fw"></i>
							Orders</a></li>
					<li><a href="./sale.jsp" target="_blank"><i class="fa fa-reorder fa-fw"></i>
							Statistics</a></li>
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
		<!-- /.navbar-static-side -->
		</nav>

		<!-- table -->
		<div id="page-wrapper">
			<h2 class="page-header" style="padding-top: 20px;">Users</h2>
			<div id="toolbar">
			<div class="row">
            	<div class="col-md-4">
            		<input type="text" class="form-control" id="username"  placeholder="User Name" autocomplete="off"/>
            	</div>
            	<div class="col-md-4">
            		<input type="text" class="form-control" id="fname"  placeholder="First Name" autocomplete="off"/>
            	</div>
            	<div class="col-md-2">
            		<button class="btn btn-primary" id="search">Search</button>
            	</div>
            	<div class="col-md-2">
            		<button class="btn btn-primary" onclick="add()">Add User</button>
            	</div>
            </div>
			</div>
			<table id="mytab" class="table table-hover">
			</table>
			
			<!-- Add model -->
                <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-hidden="true">
                   <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                    &times;
                                </button>
                                <h4 class="modal-title" >New User</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form" enctype="multipart/form-data" action="user_signup" method="post" id="fm">
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
          							<div class="modal-footer form-group">
                                		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                		<input type="submit" class="btn btn-primary" id="addModel" value="Submit" >
									</div>
                                </form>
                            </div>
					</div>
				</div>
        	</div>
        	<!-- end -->

			<!-- Edit model -->
                <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
                   <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                    &times;
                                </button>
                                <h4 class="modal-title" id="myModalLabel">Edit User</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form" action="user_update" method="post">
                                    <div class="form-group input-group">
                                    	<span class="input-group-addon">User ID</span>
                                        <input type="text" class="form-control" readonly="true" name="usr.uid" id="Uid" />
                                    </div>
                                    <div class="form-group input-group">
                                    	<span class="input-group-addon">User Name</span>
                                        <input type="text" class="form-control" readonly="true" id="Username">
                                    </div>
                                     <div class="form-group input-group">
                                     	<span class="input-group-addon">User Level</span>
                                        <select type="text" class="form-control" name="usr.level" id="Level">
                                        
                                        </select>
                                    </div>
                                     <div class="form-group input-group">
                                     	<span class="input-group-addon">First Name</span>
                                        <input type="text" class="form-control" readonly="true" id="Fname">
                                    </div>
                                    <div class="form-group input-group">
                                    	<span class="input-group-addon">Last Name</span>
                                        <input type="text" class="form-control" readonly="true" id="Lname">
                                    </div>
                                    <div class="modal-footer">
                                		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                		<input type="submit" class="btn btn-primary" value="Submit"/>
									</div>
                                </form>
                            </div>
					</div>
				</div>
        	</div>
        	<!-- end -->
	</div>
</div>

<!-- /#wrapper -->
<script src="../jeasyui/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/bootstrap-table.js"></script>
<script src="../js/bootstrap-table-zh-CN.js"></script>
<script src="../js/bootstrapValidator.js"></script>
<script src="../js/fileinput.js"></script>
<script src="../js/user.js"></script>
</body>
</html>`