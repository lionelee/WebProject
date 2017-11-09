<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/bootstrap-table.css" rel="stylesheet">
	<link href="../css/bookstore.css" rel="stylesheet">
	<link href="../css/fileinput.css" rel="stylesheet" type="text/css"/>
	<link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
	<title>BookStoreAdmin | Books</title>
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
			<a class="navbar-brand" href="./book.jsp">BookStore</a>
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
					<li><a href="./user.jsp"><i class="fa fa-user fa-fw"></i>
							Users</a></li>
					<li><a href="./book.jsp" class="active"><i
							class="fa fa-book fa-fw"></i> Books</a></li>
					<li><a href="./order.jsp"><i class="fa fa-reorder fa-fw"></i>
							Orders</a></li>
					<li><a href="./item.jsp"><i class="fa fa-reorder fa-fw"></i>
							Order Items</a></li>
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
		<!-- /.navbar-static-side -->
		</nav>

		<!-- table -->
		<div id="page-wrapper">
			<h2 class="page-header" style="padding-top: 20px;">Books</h2>
			<div id="toolbar">
				<div class="row">
				<div class="col-md-2">
            		<input type="number" class="form-control" id="bookid"  placeholder="BookID" autocomplete="off"/>
            	</div>
            	<div class="col-md-4">
            		<input type="text" class="form-control" id="title"  placeholder="Title" autocomplete="off"/>
            	</div>
            	<div class="col-md-4">
            		<input type="text" class="form-control" id="author"  placeholder="Author" autocomplete="off"/>
            	</div>
            	<div class="col-md-1">
            		<button class="btn btn-primary" id="search">Search</button>
            	</div>
            	<div class="col-md-1">
            		<button class="btn btn-primary" onclick="add()">Add Book</button>
            	</div>
            </div>
			</div>
			<table id="mytab" class="table table-hover" data-show-export="true"></table>

			<!-- Add model -->
                <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-hidden="true">
                   <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                    &times;
                                </button>
                                <h4 class="modal-title" id="myModalLabel">New Book</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form" enctype="multipart/form-data" action="book_add" method="post" id="fm">
                                	<div class="form-group">
                                        <input type="file" class="file" name="image" id="image" />
                                    </div>
                                	<div class="form-group input-group">
                                	 	<span class="input-group-addon">Category</span>
                                        <select type="text" class="form-control" name="category" id="Category1">
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="isbn" placeholder="ISBN">
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control" name="title" placeholder="Title">
                                    </div>
                                     <div class="form-group">
                                        <input type="text" class="form-control" name="author" placeholder="Author">
                                    </div>
                                     <div class="form-group">
                                        <input type="text" class="form-control" name="press" placeholder="Press">
                                    </div>
                                    <div class="form-group input-group">
                                    	<span class="input-group-addon">&yen;</span>
                                        <input class="form-control" name="price" placeholder="Price" id="pri" onkeyup="checkPri(this)">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" name="stock" placeholder="Stock">
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
                                <h4 class="modal-title" id="eModalLabel">Edit Book</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form" enctype="multipart/form-data" action="book_update" method="post" id="efm">
                                	<div class="form-group input-group">
                                		<span class="input-group-addon">Book ID</span>
                                        <input type="text" class="form-control" readonly="true" name="bid" id="Bid" >
                                    </div>
                                    
                                    <div class="form-group">
                                        <input type="file" class="file" name="image" id="eimage"/>
                                    </div>
                                    
                                	<div class="form-froup input-group">
                                		<span class="input-group-addon">Category</span> 
                                        <select type="text" class="form-control" name="category" id="Category2" >
                                        </select>
                                    </div>
                                    <div class="form-group input-group" style="padding-top:15px;">
                                        <span class="input-group-addon">Title</span>
                                        <input type="text" class="form-control" name="title" id="Title" >
                                    </div>
                                    <div class="form-group input-group">
                                        <span class="input-group-addon">ISBN</span>
                                        <input type="text" class="form-control" name="isbn" id="Isbn" >
                                    </div>
                                     <div class="form-group input-group">
                                     	<span class="input-group-addon">Author</span>
                                        <input type="text" class="form-control" name="author" id="Author" >
                                    </div>
                                     <div class="form-group input-group">
                                        <span class="input-group-addon">Press</span>
                                        <input type="text" class="form-control" name="press" id="Press" >
                                    </div>
                                    <div class="form-group input-group">
                                    	<span class="input-group-addon">Price &yen;</span>
                                        <input type="text" class="form-control" name="price" id="Price" onkeyup="checkPri(this)">
                                    </div>
                                    <div class="form-group input-group">
                                    	<span class="input-group-addon">Stock</span>
                                        <input type="number" class="form-control" name="stock" id="Stock" >
                                    </div>
                                	<div class="modal-footer">
                                		<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                		<input type="submit" class="btn btn-primary" id="editModel" value="Submit"/>
									</div>
                                </form>
                            </div>
					</div>
				</div>
        	</div>
        	<!-- end -->
	</div>
</div>

<script src="../jeasyui/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/bootstrap-table.js"></script>
<script src="../js/bootstrap-table-zh-CN.js"></script>
<script src="../js/category.js"></script>
<script src="../js/fileinput.js"></script>
<script src="../js/bootstrapValidator.js"></script>
<script src="../js/book.js"></script>
</body>
</html>

