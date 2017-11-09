<%@page import="model.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="../css/bootstrap.min.css">	
    <link href="../css/bootstrap-table.css" rel="stylesheet">
    <script src="../jeasyui/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/bootstrap-table.js"></script>
	<script src="../js/bootstrap-table-zh-CN.js"></script>
    <link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
	<title>OnlineBS | Orders</title>
	<style type="text/css">
    	h2{text-align: center;font-family: romans;margin-top: 30px;}
    	.navbar-brand {
    		font-family: "Cambria";
    		font-size: 24px;
		}
    	#mf{height:580px; position:absolute;margin-top:70px;margin-left:90px;}
    	#tabs{margin-top: 50px;}
    	#mark{margin-top:30px;text-align: center;font-size:22px;font-family:romans;}
    	#left{width:200px; height:580px;background-color:white;float:left;margin-top:70px;}
    	#pad{width:8px;loat:left;margin-top:70px;}
    	#right{width:950px; height:580px;background-color:white;float:left;margin-top:70px;}
    	.tb{width:800px;height:400px;margin-left:70px;margin-top:70px;}
    	li {list-style-type:none;font-size: 18px;}
    	.boright{width:110px; border-right:1px solid #888;}
    	a:hover{text-decoration: none;}
    	a:focus{text-decoration: none;}
    	.order {margin-bottom: 10px;}
    	.panel {width: 880px;}
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
        	<div id="left">
        		<p id="mark">Personal Center</p>
        		<ul class="nav nav-pills nav-stacked" id="tabs">
        			<li><a href="./person.jsp">My Info</a></li>
  					<li class="active"><a href="./orders.jsp">Orders</a></li>
				</ul>
			</div>
        	<div id="pad"></div>
        	<div id="right">
        		<h2>My Orders</h2>
        		<ul id="status" style="margin-top: 20px;">
        			<li class="col-md-1 boright" style="width:52px;"><a id="A" href="#A">All</a></li>
					<li class="col-md-1 boright"><a id="B" href="#B">Not Paid</a></li>
					<li class="col-md-1 boright" style="width:142px;"><a id="C" href="#C">Not Received</a></li>
					<li class="col-md-1"><a id="D" href="#D">Canceled</a></li>
				</ul>
				<div class="col-md-3"></div>
				<div class="col-md-3 input-group">
					<input type="text" placeholder="Order ID"/>
					<button style="margin-left:-1px;">Go</button>
				</div>
				<hr style="width:90%;margin-top: 10px;"/>
				
				<div class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="tabA">
					<div class="container" id="contA">
						<div class="panel panel-success">
							<div class="panel-body">
    							<div class="col-md-2">Image</div>
    							<div class="col-md-2">Title</div>
    							<div class="col-md-2">Price</div>
    							<div class="col-md-1">Number</div>
    							<div class="col-md-2">Subtotal</div>
    						</div>
  						</div>
  						<div class="panel panel-success">
  						<div class="panel-body">
    					<div class="row order">
    						<div class="col-md-2">OrderID: </div>
    						<div class="col-md-2">Subtotal: </div>
    						<div class="col-md-3">Time: </div>
    						<div class="col-md-3">Status: </div>
    					</div>
					</div>
				</div>
				<div role="tabpanel" class="tab-pane fade in" id="tabB">
					<div class="container" id="contB"></div>
				</div>
				<div role="tabpanel" class="tab-pane fade in" id="tabC">
					<div class="container" id="contC"></div>
				</div>
				<div role="tabpanel" class="tab-pane fade in" id="tabD">
					<div class="container" id="contD"></div>
				</div>
				</div>
        	</div>
        </div>
	</div>
</div>
<% 
	int userid = ((Users)session.getAttribute("usr")).getUid();
%>
</body>
<script type="text/javascript">
$(document).ready(function() {
	var stat = "A";
	var page = new array(4);
	var size = 20;
	for(var i=0; i<4;++i)page[i]=0;
	load(page[0],size,status);
	
	$('#status a').on('click', function(e) {
		e.preventDefault();
		$(this).tab('show');
		stat = $(this).attr("id"); 
	});
});

function load(page,size,status){
	$.ajax({
        type: 'post',
        url: 'order_load',
        data: 'page='+page+'&size='+size+'&status='+status,
        async: false,
        dataType: 'json',
        success: function(order){
       	 	var result = "";
            var arrLen = order.length;
            if(arrLen > 0){
                for(var i=0; i<arrLen; i++){
                	result += '<div class="panel panel-success"><div class="panel-heading"></div><a href="./JSP/book.jsp?bid='
                		      +book[i].bid+'" target="_blank" onclick="book('+book[i].bid+')">\
                		      <img src="book_image?i='+book[i].image+'" width="180px;\
    			         	  height="250px" alt="${book.title }"/></a>\
    						  <p><a href="./JSP/book.jsp?bid='+book[i].bid+'" target="_blank">'
    						  +book[i].title+'</a></p><h6>Author: '+book[i].author+'</h6><h5>Price: &yen;'
    						  +book[i].price/100.00+'</h5></div>';
                }
            }
            $('#tab'+cate).append(result);
        },
        error: function(xhr,type){ 
        	 alert('Load error!');
      	 }
   	});
}

Date.prototype.Format = function(fmt)   
{
  var o = {   
    "M+" : this.getMonth()+1,                 //月份   
    "d+" : this.getDate(),                    //日   
    "h+" : this.getHours(),                   //小时   
    "m+" : this.getMinutes(),                 //分   
    "s+" : this.getSeconds(),                 //秒   
    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
    "S"  : this.getMilliseconds()             //毫秒   
  };   
  if(/(y+)/.test(fmt))   
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
  for(var k in o)   
    if(new RegExp("("+ k +")").test(fmt))   
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
  return fmt;   
}


function del(oid){
	var r = confirm("Are you sure to remove?");
	if(r==true){
		$('#mytab').bootstrapTable(
			'remove', {
			field: 'oid',
			values: oid
		});
		$.post('order_delete?oid='+oid);
	}
}
</script>
</html>

