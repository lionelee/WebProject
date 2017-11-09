<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/bootstrap-table.css" rel="stylesheet">
	<link href="../css/bookstore.css" rel="stylesheet">
	<link rel="icon" href="../images/bs.ico" type="image/x-icon"/>
	<title>BookStoreAdmin | Orders</title>
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
			<a class="navbar-brand" href="./item.jsp">BookStore</a>
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
					<li><a href="./book.jsp"><i
							class="fa fa-book fa-fw"></i> Books</a></li>
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
			<h2 class="page-header" style="padding-top: 20px;">Order Items</h2>
			<div id="toolbar">
			<div class="row">
            	<div class="col-md-5">
            		<input type="text" class="form-control" id="oid"  placeholder="Order ID" autocomplete="off"/>
            	</div>
            	<div class="col-md-2">
            		<button class="btn btn-primary" id="search">Search</button>
            	</div>
            </div>
			</div>
			<table id="mytab" class="table table-hover"></table>
			
	</div>
</div>

<!-- /#wrapper -->
<script src="../jeasyui/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/bootstrap-table.js"></script>
<script src="../js/bootstrap-table-zh-CN.js"></script>
<script>
$(function() {
    //根据窗口调整表格高度
    $(window).resize(function() {
        $('#mytab').bootstrapTable('resetView', {
            height: tableHeight()
        })
    })

    $('#mytab').bootstrapTable({
        url: "item_getAll",//数据源
        dataField: "rows",//服务端返回数据键值 就是说记录放的键值是rows，分页时使用总记录数的键值为total
        height: tableHeight(),//高度调整
        striped: true, //隔行换色
        search: false,
        pagination: true,//是否分页
        pageSize: 20,//单页记录数
        pageList: [5, 10, 20, 50],//分页步进值
        sidePagination: "server",//服务端分页
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",//期待返回数据类型
        method: "post",//请求方式
        queryParamsType: "limit",//查询参数组织方式
        queryParams: function getParams(params) {
            return{
            	psize: params.limit,
            	offset: params.offset,
            	sort: params.sort,
            	order: params.order,
            	oid: $('#oid').val()
            }
        },
        clickToSelect: true,
        showToggle: true,
        showRefresh: true, //刷新按钮
        searchAlign: "right",//查询框对齐方式
        buttonsAlign: "right",//按钮对齐方式
        toolbar: "#toolbar",//指定工具栏
        toolbarAlign: "left",//工具栏对齐方式
        columns: [
        	{
                title: "Order ID",
                field: "oid",
                sortable: true
            },
	    	{
                title: "Book ID",
                field: "bid",
                sortable: true
            },
            {
                title: "Price",
                field: "price"
            },
            {
            	title: "Number",
                field: "num",
                sortable: true
            },
	    ],
        locale: "zh-CN",//中文支持,
        detailView: false
    });
});

function tableHeight() {
    return $(window).height();
}

$('#search').click(function(){
	$('#mytab').bootstrapTable(
		'refresh', 
		{url:'item_getAll'}
	);
});
</script>
</body>
</html>