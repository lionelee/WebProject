<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html5 >
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <style type="text/css">
    	.navbar-brand {
    		font-family: "Cambria";
    		font-size: 24px;
		}
		.chart{
			margin-top:50px;
			margin-left:100px;
		}
		.form{ 
			margin-left: 10%;
			width:80%;
		}
    </style>
	<title>BookStoreAdmin | Sale Statistics</title>
</head>
<body>
<nav class="navbar  navbar-inverse navbar-fixed-top">
    <div class="container">
    	<div class="navbar-header">
      		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            	<span class="sr-only">Toggle navigation</span>
            	<span class="icon-bar"></span>
            	<span class="icon-bar"></span>
            	<span class="icon-bar"></span>
          	</button>
      		<a class="navbar-brand" href="./">Sale Statistics</a>
		</div>
		<div class="collapse navbar-collapse" id="navbar">
            <ul class="nav navbar-nav navbar-right">
        		<li><a class="navbar-brand btn" onclick="sear()">Search</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="row">
	<div class="col-md-5 chart">
		<canvas id="thisYearO"></canvas>
		<canvas id="thisYearB"></canvas>
	</div>
	<div class="col-md-5 chart">
		<canvas id="allCate"></canvas>
	</div>
</div>
<div id="ucharts"></div>
<div id="userCharts" style="display:none;">
	<hr/>
	<div class="row">
		<h3 style="text-align:center;margin-top: 20px;"><strong id="title"></strong></h3>
		<div class="col-md-5 chart">
			<canvas id="thisOrderM"></canvas>
		</div>
		<div class="col-md-5 chart">
			<canvas id="thisOrderD"></canvas>
		</div>
	</div>
	<div class="row">
		<h3 style="text-align:center;margin-top: 20px;"><strong id="title"></strong></h3>
		<div class="col-md-5 chart">
			<canvas id="thisBookM"></canvas>
		</div>
		<div class="col-md-5 chart">
			<canvas id="thisBookD"></canvas>
		</div>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">	
			<canvas id="thisCate"></canvas>
		</div>
	</div>
</div>
<hr/>
<footer>
	<h4 style="text-align:center;">&copy; All rights reserved @Lionel</h4>
</footer>
<div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                	&times;
                </button>
                <h4 class="modal-title">Search</h4>
            </div>
            <div class="modal-body">
            	<form class="form" id="fm">
                   	<div class="form-group input-group">
                   		<span class="input-group-addon">User ID</span>
                   		<input type="number" class="form-control" id="uid" />
                    </div>
                    <p id="uerr"style="display:none;color:red;">User ID is invalid or none</p>
                    <div class="form-group input-group">
                    	<span class="input-group-addon">Start time</span>
                    	<input type="date" class="form-control" id="stime" />
                    </div>
                    <p id="serr" style="display:none;color:red;">Time is invalid or none</p>
                    <div class="form-group input-group">
                    	<span class="input-group-addon">End time</span>
                    	<input type="date" class="form-control" id="etime" />
                   	</div>
                   	<p id="eerr" style="display:none;color:red;">Time is invalid or none</p>
                    <div class="modal-footer form-group">
                    	<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    	<button type="button" class="btn btn-primary" onclick="sub()">Submit</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
<script src="../jeasyui/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/chart.bundle.js"></script>
<script src="../js/category.js"></script>
<script src="../js/sale.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		url: 'sale_thisYearOrders',
        async: false,
        dataType: 'json',
        success: function(data){
        	var thisY = $("#thisYearO").get(0).getContext("2d");
        	var datas = {
        		labels : ["January","February","March","April","May","June",
        					"July","August","September","October","November","December"],
        		datasets : [{
        				label:"Orders of each month",
        				backgroundColor : "rgba(80,178,200,0.8)",
        				borderColor : "rgba(80,178,200,1)",
        				data : data,//[1,2,3,4,5,6,7,8,9,10,11,1000],
        				borderWidth: 1
        		}]
        	};
        	new Chart(thisY,{type: 'bar',data: datas,options:{
        			title: {
                    	display: true,
                    	text: 'Sale Statistics of This Year',
                    	fontSize: 20
                	}}
        	});
        },
		error: function(xhr,type){ 
    		alert('Load error!');
  	 	}
	});
	
	$.ajax({
		url: 'sale_thisYearBooks',
        async: false,
        dataType: 'json',
        success: function(data){
        	var thisY = $("#thisYearB").get(0).getContext("2d");
        	var datas = {
        		labels : ["January","February","March","April","May","June",
        					"July","August","September","October","November","December"],
        		datasets : [{
        				label:"Books of each month",
        				backgroundColor : "rgba(80,108,200,0.8)",
        				borderColor : "rgba(80,108,200,1)",
        				data : data,
        				borderWidth: 1
        		}]
        	};
        	new Chart(thisY,{type: 'bar',data: datas});
        },
		error: function(xhr,type){ 
    		alert('Load error!');
  	 	}
	});
	
	$.ajax({
		url: 'sale_allCate',
        async: false,
        dataType: 'json',
        success: function(data){
        	var allC = $("#allCate").get(0).getContext("2d");
        	var colors=[], clabels=[];
        	for(var i=0;i<22;++i){
        		colors[i]="rgba("+i*11+",0,255,0.8)";
        		clabels[i]=cateInt(i);
        	}
        	var datas = {
        		labels:clabels,
        		datasets: [{
        			label:[],
    				backgroundColor :colors,
        			data: data,
        			borderWidth: 1
        		}]
        	};
			new Chart(allC,{type: 'polarArea',data: datas,options:{
        			title: {
                    	display: true,
                    	text: 'Sale Statistics of All categories this year',
                    	fontSize: 20
                	}}
        	});
        },
		error: function(xhr,type){ 
    		alert('Load error!');
  	 	}
	});
});


window.onload=function(){
	window.location.hash="";
}
</script>
</html>