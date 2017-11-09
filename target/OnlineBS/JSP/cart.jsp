<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,java.util.List,model.Carts,model.Books,model.Users"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/cart.css">
    <link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
	<title>OnlineBS | Shopping Cart</title>
</head>
<body style="background-color: #F1F1F1">
<nav class="navbar navbar-inverse navbar navbar-fixed-top">
    <div class="container">
    	<div class="navbar-header">
      		<a class="navbar-brand">My Shopping Cart</a>
		</div>
	</div>
</nav>

<!-- cart table -->
<div class="container tab">
<table id="cartTable" class="cart table table-condensed" >
 <thead>
 <tr>
 	<th style="width:80px;"><label><input class="check-all check" type="checkbox" />All</label></th>
 	<th style="width:120px;"><label>Image</label></th>
 	<th ><label>Title</label></th>
 	<th style="width:100px;"><label>Price</label></th>
 	<th style="width:150px;padding-left: 2.5em;"><label>Number</label></th>
 	<th style="width:120px;"><label>Subtotal</label></th>
 	<th style="width:40px;"><label>Operation</label></th> 
 </tr>
 </thead>
 <tbody class="carts">
 </tbody>
 </table>
 <div class="row">
 	<div class="col-md-12 col-lg-12 col-sm-12">
 	<div style="border-top:1px solid gray;padding:4px 10px;">
 		<div style="margin-left:20px;margin-top: 20px;" class="pull-right total">
  			<label>total:<span class="currency">&yen;</span>
  				<span id="priceTotal" class="large-bold-red">0.00</span>
  			</label>
 		</div>
 		<div style="margin-top: 20px;" class="pull-right">
  			<label>You have chosen<span id="itemCount" class="large-bold-red" style="margin:0 4px;"></span>
  		   		kinds, all is <span id="qtyCount" class="large-bold-red" style="margin:0 4px;"></span>books
  			</label>
 		</div>
 		<div class="pull-right selected" id="selected">
  			<span id="selectedTotal"></span>
 		</div>
 	</div>
 	</div>
 </div>
 <div class="row">
 	<div class="pull-right" style="margin-bottom: 20px;margin-right: 30px;">
 		<form class="form" action="order_confirm" id="fm">
 			<input type="hidden" name="total" id="total"/>
 			<input type="hidden" name="items" id="items"/>
 			<input class=" btn btn-warning btn-lg" type="submit" style="width: 170px;" value="Generate order &raquo;"/>
 		</form>
 	</div>
 </div>
 </div>

<!-- show when cart is empty -->
	<div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Info</h4>
				</div>
				<div class="modal-body">
					<h3 style="text-align: center;">Your shopping cart is empty<br/>
						<a href="../index.jsp">Click here back to homepage</a>
					</h3>
				</div>
			</div>
		</div>
	</div>

<!-- show when not logged in -->
	<div class="modal fade" id="logcheck" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Info</h4>
				</div>
				<div class="modal-body">
					<h3 style="text-align: center;">You haven't logged in</br/>
						<a href="login.jsp">Click here to login</a>
					</h3>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="../jeasyui/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/etao.js"></script>
<script src="../js/cart.js"></script>
</html>