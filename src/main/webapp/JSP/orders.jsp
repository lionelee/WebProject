<%@page import="model.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="../css/bootstrap.min.css">	
	<link rel="stylesheet" href="../css/bootstrap.css">	
    <link href="../css/bootstrap-table.css" rel="stylesheet">
    <link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
	<title>OnlineBS | Orders</title>
	<style type="text/css">
    	h2{text-align: center;font-family: romans;margin-top: 30px;}
    	.navbar-brand {
    		font-family: "Cambria";
    		font-size: 24px;
		}
    	#mf{width:1180px; height:580px;position:absolute;margin-top:70px;margin-left:90px;}
    	#tabs{margin-top: 50px;}
    	#mark{margin-top:30px;text-align: center;font-size:22px;font-family:romans;}
    	#left{width:200px;height:580px;background-color:white;}
    	#pad{width:8px;}
    	#right{width:950px;min-height:580px;background-color:white;}
    	.tb{width:800px;height:400px;margin-left:70px;margin-top:70px;}
    	li {list-style-type:none;font-size: 18px;}
    	.boright{width:110px; border-right:1px solid #888;}
    	a:hover{text-decoration: none;}
    	a:focus{text-decoration: none;}
    	.panel-info {margin-bottom: 10px;}
    	.panel {width: 880px;}
    	.mtop{margin-top: 20px;}
    	.amtop{margin-top: 4px;}
    </style>
</head>
<body style="background-color: #F1F1F1">
	<nav class="navbar  navbar-inverse navbar-fixed-top">
    	<div class="container">
    		<div class="navbar-header">
      			<a class="navbar-brand" href="../index.jsp">Online BookStore</a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><div style="width:50px; height:50px; border-radius:50%; overflow:hidden;">
    					<img style="width:48px;height:48px;" src="user_img?uid=<%=((Users)session.getAttribute("usr")).getUid()%>"/>
					</div></li>
            		<li><a class="navbar-brand">
            			<s:property value="#session.usr.username"/>
            		</a></li>
        		</ul>
        	</div>
		</div>
	</nav>
	<div class="container-fluid" id="mf">
        <div class="row pinleft">
        	<div class="col-md-1" id="left">
        		<div class="pinned">
        		<p id="mark">Personal Center</p>
        		<ul class="nav nav-pills nav-stacked" id="tabs">
        			<li><a href="./person.jsp">My Info</a></li>
  					<li class="active"><a href="./orders.jsp">Orders</a></li>
				</ul>
				</div>
			</div>
        	<div class="col-md-1" id="pad"></div>
        	<div class="col-md-6" id="right">
        		<h2>My Orders</h2>
        		<ul id="status" style="margin-top: 20px;">
        			<li class="col-md-1 boright" style="width:52px;"><a id="A" href="#tabA">All</a></li>
					<li class="col-md-1 boright"><a id="N" href="#tabN">Not Paid</a></li>
					<li class="col-md-1 boright" style="width:80px;"><a id="D" href="#tabD">Done</a></li>
					<li class="col-md-1"><a id="C" href="#tabC">Canceled</a></li>
				</ul>
				<div class="col-md-3"></div>
				<div class="col-md-3 input-group">
					<input type="text" placeholder="Order ID" id="oid"/>
					<button style="margin-left:-1px;" id="go">Go</button>
				</div>
				<hr style="width:90%;margin-top: 10px;"/>
				<div class="container">
						<div class="panel panel-success">
							<div class="panel-heading panel-body">
								<div class="col-md-1"></div>
    							<div class="col-md-2">Image</div>
    							<div class="col-md-4">Title</div>
    							<div class="col-md-2">Price</div>
    							<div class="col-md-1">Number</div>
    							<div class="col-md-2">Subtotal</div>
    						</div>
  						</div></div>
				<div class="tab-content">
				<div role="tabpanel" class="tab-pane fade in active" id="tabA">
					<div class="container">
  						<div id="contA"></div>
  						<div>
  							<ul id="pagA"></ul>
  						</div>
					</div>
				</div>
				<div role="tabpanel" class="tab-pane fade in" id="tabN">
					<div class="container">
						<div id="contN"></div>
						<div>
  							<ul id="pagN"></ul>
  						</div>
					</div>
				</div>
				<div role="tabpanel" class="tab-pane fade in" id="tabD">
					<div class="container">
						<div id="contD"></div>
						<div>
  							<ul id="pagD"></ul>
  						</div>
					</div>
				</div>
				<div role="tabpanel" class="tab-pane fade in" id="tabC">
					<div class="container">
						<div id="contC"></div>
						<div>
  							<ul id="pagC"></ul>
  						</div>
					</div>
				</div>
				</div>
        	</div>
        </div>
	</div>
<% 
	int userid = ((Users)session.getAttribute("usr")).getUid();
%>
<!-- show when empty -->
<div class="modal fade" id="promt" tabindex="-1" role="dialog" aria-hidden="true">
 	<div class="modal-dialog">
		<div class="modal-content">
        	<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                	&times;
                </button>
            </div>
            <div class="modal-body">
            	<p style="text-align: center;font-size:20px;">No orders.</p>
        	</div>
		</div>
	</div>
</div>
</body>
<script src="../jeasyui/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/bootstrap-table.js"></script>
<script src="../js/bootstrap-table-zh-CN.js"></script>
<script src="../js/bootstrap-paginator.js"></script>
<script src="../js/jquery.pin.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('.pinned').pin({
		containerSelector: ".container-fluid"
	});
	var stat = "A";
	var size = 1;
	setTimeout("$('#A').click()", 300);
	
	$('#status a').on('click', function(e) {
		e.preventDefault();
		$(this).tab('show');
		stat = $(this).attr("id");
		$(function(){
			$.ajax({
		        type: 'post',
		        url: 'order_load',
		        data: 'page='+1+'&size='+size+'&status='+stat,
		        async: false,
		        dataType: 'json',
		        success: function(data){
		       	 	inflate(data.orders, stat);
		       	 	var pageCount = data.total/size+1;
                 	var currentPage = data.curp;
                 	var options = {
                 		bootstrapMajorVersion: 3,
                 		currentPage: currentPage,
                        totalPages: pageCount,
                        onPageClicked: function (event, originalEvent, type, page){
                        	$.ajax({
                		        type: 'post',
                		        url: 'order_load',
                		        data: 'page='+page+'&size='+size+'&status='+stat,
                		        async: false,
                		        dataType: 'json',
                		        success: function(data){
                		        	inflate(data.orders,stat);
                		        }
                		    });
                        }
                     }
                 	 $('#pag'+stat).bootstrapPaginator(options);
		        }
		   	});
		});
	});
	
	$('#go').on('click',function(){
		$.ajax({
	        type: 'post',
	        url: 'order_search',
	        data: 'oid='+$('#oid').val(),
	        async: false,
	        dataType: 'json',
	        success: function(data){
	       	 	inflate(data.orders, stat);
	        }
	   	});
	});
	
});

function stat(s){
	switch(s){
	case 'N':
		return 'Not paid';
	case 'P':
		return 'Paid';
	case 'C':
		return 'Canceled';
	case 'D':
		return 'Done';
	case 'R':
		return 'Returned';
	default: return s;
	}
}

function inflate(order, status){
	$('#cont'+status).html("");
	var result = "";
    var arrLen = order.length;
    if(arrLen > 0){
        for(var i=0; i<arrLen; i++){
        	result+='<div class="panel panel-info"><div class="panel-heading"><div class="row">\
					<div class="col-md-1"></div><div class="col-md-2">OrderID: '+order[i].oid+'</div><div class="col-md-2">\
					Total: &yen;'+order[i].total/100.0+'</div><div class="col-md-3">Time: '
					+new Date(order[i].time.time).Format("yyyy-MM-dd / hh:mm:ss")+'</div>\
				<div class="col-md-3">Status: '+stat(order[i].status)+'</div></div></div><div class="panel-body">\
				<div class="row"><div class="col-md-11">';
			var item = order[i].items;
			var len = item.length;
			var j = 0;
			while(j<len){
				result+='<div class="row"><div class="col-md-1"></div><div class="col-md-2">\
				<img src="book_image?i='+item[j].image+'" width="50px;"height="75px;"/></div>\
					<div class="col-md-4 mtop">'+item[j].title+'</div><div class="col-md-2 mtop">&yen; '
					+item[j].price/100.0+'</div><div class="col-md-1 mtop">'+item[j].num+'</div>\
					<div class="col-md-2 mtop">&yen;'+(item[j].num*item[j].price)/100.0+'</div></div>';
				++j;
				if(j<len)result+="<div style='height:10px;'></div>";
			}
			if(order[i].status=='N')
				result+='</div><div class="col-md-1"><div class="amtop"><a onclick="cancel(\''+order[i].oid+'\')">\
				Cancel</a></div><div class="amtop"><a onclick="del(\''+order[i].oid+'\')">\
				delete</a></div></div> </div> </div></div>';
			else if(order[i].status=='C' || order[i].status=='R' || order[i].status=='D')
				result+='</div><div class="col-md-1"><div class="amtop"><a onclick="del(\''+order[i].oid+'\')">\
				delete</a></div></div> </div> </div></div>';
			else
				result+='</div><div class="col-md-1"><div class="amtop"><a onclick="done(\''+order[i].oid+'\')">\
				Done</a></div><div class="amtop"><a onclick="cancel(\''+order[i].oid+'\')">\
				Cancel</a></div><div class="amtop"><a onclick="del(\''+order[i].oid+'\')">\
				delete</a></div></div> </div> </div></div>';
		};
    }else{
    	$('#promt').modal("show");
    }
    $('#cont'+status).append(result);
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

function edit(oid, uid, status){
	$('#Oid').val(oid);
	$('#Uid').val(uid);
	$('#Status').val(status);
	$('#editModal').modal('show');
}

function done(oid){
	var r = confirm("Are you sure to change status?");
	if(r==true){
		$.post('order_changStatus?oid='+oid+'&s=D');
	}
}

function cancel(oid){
	var r = confirm("Are you sure to cancel?");
	if(r==true){
		$.post('order_changStatus?oid='+oid+'&s=C');
	}
}

function del(oid){
	var r = confirm("Are you sure to remove?");
	if(r==true){
		$.post('order_delete?oid='+oid);
	}
}
</script>
</html>

