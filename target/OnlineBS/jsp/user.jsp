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
			<h2 class="page-header" style="padding-top: 20px;">Users</h2>
			<div id="toolbar">
			<div class="row">
            	<div class="col-md-5">
            		<input type="text" class="form-control" id="username"  placeholder="User Name" autocomplete="off"/>
            	</div>
            	<div class="col-md-5">
            		<input type="text" class="form-control" id="fname"  placeholder="First Name" autocomplete="off"/>
            	</div>
            	<div class="col-md-2">
            		<button class="btn btn-primary" id="search">Search</button>
            	</div>
            </div>
			</div>
			<table id="mytab" class="table table-hover">
			</table>

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
<script>
$(function() {
    //根据窗口调整表格高度
    $(window).resize(function() {
        $('#mytab').bootstrapTable('resetView', {
            height: tableHeight()
        })
    })

    $('#mytab').bootstrapTable({
        url: "user_getAll",//数据源
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
            	username: $('#username').val(),
            	fname: $('#fname').val()
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
            	title: "User ID",
                field: "uid",
                sortable: true
            },
            {
            	title: "User Name",
                field: "username",
                sortable: true
            },
            {
                title: "First Name",
                field: "firstname",
                sortable: true
            },
            {
                title: "Last Name",
                field: "lastname",
                sortable: true
            },
            {
            	title: "Phone",
                field: "phone",
                sortable: true
            },
            {
                title: "Email",
                field: "email"
            },
            {
                title: "Operation",
                field: "operation",
                align: "center",
                formatter: function(value, row, index){
                	var html = '<a onclick="edit(';
                	$.each(row,function(key,value){
                		switch(key){
                    	case 'uid':case 'level':
                    	case 'username':case 'firstname':
                    		html+='\''+value+'\',';break;
                    	case 'lastname':
                    		html+='\''+value+'\')">';break;
                    	default:break;
                    	}
                	});
                	html +='<i class="glyphicon glyphicon-pencil"></i></a>';
                	return html;
                }
            }
        ],
        locale: "zh-CN",//中文支持,
        detailView: true, //是否显示详情折叠
        detailFormatter: function(index, row, element) {
            var html = "<div class='row'><div class='col-md-4' style='padding-left:80px;'>";
            var tmp = "<div class='col-md-4'>"
            var addr="";
            $.each(row,function(key,value){
            	switch(key){
            	case 'level':
            		html+="<p>Level: "+lev(value)+"</p>";break;
            	case 'username':
            		html+="<p>User Name: "+value+"</p>";break;
            	case 'phone':
            		html+="<p>Phone: "+value+"</p>";break;
            	case 'firstname':
            		tmp+="<p>First Name: "+value+"</p>";break;
            	case 'lastname':
            		tmp+="<p>Last Name: "+value+"</p>";break;
            	case 'email':
            		tmp+="<p>Email: "+value+"</p>";break;
            	case 'address':
            		addr="<div class='col-md-9' style='padding-left:80px;'><p>Address: "+value+"</p></div>";
            	default:break;
            	}
            });
            html+="</div>"+tmp+"</div>"+addr+"</div>";
            return html;
        }
    });
});

function edit(level,uid,uname,fname,lname){
	$('#Uid').val(uid);
	$('#Username').val(uname);
	$('#Level').val(level);
	$('#Fname').val(fname);
	$('#Lname').val(lname);
	var s=document.getElementById('Level');
	for(var i=1; i < 6; ++i)
		s.options.add(new Option(lev(i),i));
	$('#editModal').modal('show');
}


function tableHeight() {
    return $(window).height();
}

$('#search').click(function(){
	$('#mytab').bootstrapTable(
		'refresh', 
		{url:'user_getAll'}
	);
});

function lev(level){
	switch(level){
	case 1:
		return "普通会员";
	case 2:
		return "铜牌会员";
	case 3:
		return "银牌会员";
	case 4:
		return "金牌会员";
	case 5:
		return "钻石会员";
	default: 
		return level;
	}
}
</script>
</body>
</html>`