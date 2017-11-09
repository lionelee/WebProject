<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" import="java.util.List"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/process.css">
    <link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
    <script src="../jeasyui/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
	<title>OnlineBS | Order</title>
</head>

<%	
	int total = (Integer)session.getAttribute("total");
	JSONArray items = (JSONArray)session.getAttribute("items");
%>

<body style="background-color: #F1F1F1">
<nav class="navbar navbar-inverse navbar navbar-fixed-top">
    <div class="container">
    	<div class="navbar-header">
      		<a class="navbar-brand">Order</a>
		</div>
	</div>
</nav>
<div id="progressBar">
	<div>
    	<span id="line"></span>
    </div>
	<span id="s1"></span>
	<span id="s2"></span>
	<span id="s3"></span>
	<ul id="tabs">
		<li><a id="p" href="#pay"></a></li>
	</ul>
</div>
<div >
	<div class="tab-content">
    	<div role="tabpanel" class="tab-pane fade in active" id="confirm">
    	<div class="container"> 
    		<div class="panel panel-success">
  				<div class="panel-heading">
    				<h3 class="panel-title">Confirm order</h3>
  				</div>
  				<div class="panel-body">
    				<p>Delivery Address: <s:property value="#session.usr.address" /></p>
    				<hr/>
    				<div class="row" style="margin-bottom: 10px;">
    					<div class="col-md-1"></div>
    					<div class="col-md-2">Image</div>
    					<div class="col-md-4">Title</div>
    					<div class="col-md-2">Price</div>
    					<div class="col-md-1">Number</div>
    					<div class="col-md-2">Subtotal</div>
    				</div>
    				<%  int size = items.size();
    					for(int i = 0; i < size; ++i){
    						JSONObject item = items.getJSONObject(i);
    						int num = item.getInt("num");
    						int price = item.getInt("price");
    				%>
    				<div class="panel panel-success">
    					<div class="panel-heading"></div>
    					<div class="row">
    					<div class="col-md-1"></div>
						<div class="col-md-2">
							<img id="img" src="book_image?i=<%=item.get("image")%>" width="50px;"height="75px;"
         						alt="<%=item.get("title")%>"/></div>
         				<div class="col-md-4"><%=item.get("title")%></div>
						<div class="col-md-2">&yen; <%=price/100.0%></div>
						<div class="col-md-1"><%=num%></div>
						<div class="col-md-2">&yen; <%=(num*price)/100.0%></div></div></div>
    				<%} %>
    				<a class="btn btn-success" style="float: right;margin-left: 20px;" onclick="confirm()">Confirm</a>
    				<a class="btn btn-warning" style="float: right;" href="order_cancel">Back to Cart</a>
  				</div>
			</div>
    	</div>
    	</div>
    	<div role="tabpanel" class="tab-pane fade" id="pay">
    		<div class="container"> 
    		<div class="panel panel-info">
  				<div class="panel-heading">
    				<h3 class="panel-title">Pay</h3>
  				</div>
  				<div class="panel-body">
    				<h2 style="text-align: center;">
    					The total money you need to pay is<br/><br/>
    					&yen;<%=total/100.0 %>
    				</h2>
    				<hr/>
    				<a class="btn btn-info"  style="float: right;margin-left: 20px;" onclick="pay()">Pay now</a>
    				<a class="btn btn-warning" style="float: right;" href="order_cancel">Back to cart</a>
  				</div>
			</div>
    	</div>
    	</div>
    </div>
</div>
</body>
<script type="text/javascript">

	$('#tabs a').on('click', function(e) {
	 e.preventDefault();
	 $(this).tab('show');
	});
	
	function confirm(){
		document.getElementById("line").style.width="75%";
		document.getElementById('s1').style.background="green";
		$('#p').click();
		$.post("order_add");
	}
	
	function pay(){
		document.getElementById("line").style.width="100%";
		document.getElementById('s2').style.background="green";
		window.location.href="order_pay";
	}
</script>
</html>