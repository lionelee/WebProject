<%@page import="java.io.Console"%>
<%@page import="java.util.List"%>
<%@page import="model.Books, model.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="../css/bootstrap.min.css">	
    <link rel="stylesheet" href="../css/bootstrapValidator.css">
    <script src="../jeasyui/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
	<title>OnlineBS | Book</title>
	<style type="text/css">
    	.navbar-brand {
    		font-family: "Cambria";
    		font-size: 24px;
		}
		#main{margin-top: 120px;}
    </style>
</head>
<body>
<% Users usr = (Users)session.getAttribute("usr");
   Boolean b = (usr==null)? true : false;
%>
<script type="text/javascript">
	function promt(){
		$('#logpromt').modal({show:true, backdrop:'static',keyboard:false});
		setTimeout(function(){
			$("#logpromt").modal("hide");
			window.location.href="login.jsp";
		},3000);
	}
	function add(){
		var flag = "<%=b%>";
		if(flag=="true") promt();
		if(flag=="false"){
			var bid = "<%=request.getParameter("bid")%>";
			var num = $("#in").val();
			window.location.href="cart_add?bid="+bid+"&num="+num;
		}
	}
	
	$('#fm').on("submit",function(){
		var flag = "<%=b%>";
		if(flag=="true"){
			promt();
			return;
		}
		if(flag=="false"){
			var cbid = "<%=request.getParameter("bid")%>";
			var ctitle = $('#title').text();
			var cimage = $('#img').attr("src");
			cimage = cimage.substring(cimage.indexOf('=') + 1);
			var pri = $('#pri').data("bind");
			var cnum = $("#in").val();
			var citems = {
				bid : cbid,
				title : ctitle,
				image : cimage,
				price : pri,
				num : cnum
			};
			$('#items').val(JSON.stringify(citems));
		}
	});
</script>
<nav class="navbar navbar-inverse navbar navbar-fixed-top">
    <div class="container">
    	<div class="navbar-header">
		</div>
	</div>
</nav>
<div calss="container" id="main">
	<div class="col-md-2"></div>
	<div class="col-md-3 pic">
	</div>
	<div class="col-md-1"></div>
	<div class="col-md-5 books">
	</div>
</div>

 <div class="modal fade" id="logpromt" tabindex="-1" role="dialog" aria-hidden="true">
 	<div class="modal-dialog">
		<div class="modal-content">
        	<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                	&times;
                </button>
               	<h4 class="modal-title" id="myModalLabel">New Book</h4>
            </div>
            <div class="modal-body">
            	<p style="text-align: center;font-size:20px;">You haven't logged in, and<br/>
            	it's gonna forward to login page in 3s.</p>
        	</div>
		</div>
	</div>
</div>

</body>
<script type="text/javascript">
	$(document).ready(function(){
		var bid="<%=request.getParameter("bid")%>";
		$.ajax({
	         type: 'post',
	         url: 'book_get',
	         data: 'bid='+bid,
	         async: false,
	         dataType: 'json',
	         success: function(book){
	        	 var result = "";
	        	 result = '<a class="navbar-brand">'+book.title+'</a>';
	        	 $('.navbar-header').append(result);
	        	 result = '<img id="img" src="book_image?i='+book.image+'" width="330px;"\
	                 height="450px;" alt="'+book.title+'"/>';
	             $('.pic').append(result);
	             result = '<h1 id="title">'+book.title+'</h1>\
	     		<h3>Author: '+book.author+'</h3>\
	    		<h3>ISBN: '+book.isbn+'</h3>\
	    		<h3>Press: '+book.press+'</h3>\
	    		<h3 id="pri" data-bind="'+book.price+'">Price: &yen; '+book.price/100.00+'</h3>\
	    		<div id="num" class="input-group" style="width:120px;margin-top:70px;">\
	      			<span class="btn input-group-addon minus">-</span>\
	      			<input id="in" type="text" class="number form-control input-sm" value="1" />\
	      			<span class="btn input-group-addon plus">+</span>\
	     		</div>\
	    		<p><a class="col-md-3 btn btn-warning btn-lg" style="margin-top:35px;"\
	    			onclick="add()">Add to cart &raquo;</a></p>\
	    		<form class="form" action="order_confirm" id="fm">\
	    		<input type="hidden" name="total" id="total"/>\
	     		<input type="hidden" name="items" id="items"/>\
	     		<input class="col-md-3 btn btn-danger btn-lg" style="margin-left:10px;margin-top:25px;"\
	    		type="submit" value="Buy now &raquo;" /></form>';
	             $('.books').append(result);
	         },
	         error: function(xhr,type){ 
	         	 alert('Load error!');
	       	 }
	    	});
		
		
		$('#in').keyup(function() {
			var val = $('#in').val();
			var value = parseInt($('#in').val());
			if ( val.charAt(0) == '-'){
				$('#in').val(val.replace(/^\-/g,''));
				return;
			}
			if(val.toString().split(".").length > 1){
				$('#in').val(value);
				return;
			}
			if (isNaN(val) || (value < 1)) { 
				$('#in').val(1);
				return;
			}
			if(value > 99)
				$('#in').val(99);
        });
	    $(".plus").click(function(e){ 
	        var count = 1; 
	        var countField = $("#in");  
	        var count = $("#in").val();
	        var newcount = count;
	        if (count < 99)
	        	newcount = parseInt(count) + 1; 
	        $("#in").val(newcount);  
	    });  
	  
	    $(".minus").click(function(e){
	        var count = 1;  
	        var newcount = 1;  
	        var countField = $("#in");  
	        var count = $("#in").val();
	        if(count > 1)
	        	newcount = parseInt(count) - 1;
	        $("#in").val(newcount);  
	          
	    });
	});
</script>
</html>