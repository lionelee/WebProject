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
			<a class="navbar-brand" href="./order.jsp">BookStore</a>
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
					<li><a href="./order.jsp" class="active"><i class="fa fa-reorder fa-fw"></i>
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
			<h2 class="page-header" style="padding-top: 20px;">Orders</h2>
			<div id="toolbar">
			<div class="row">
            	<div class="col-md-2">
            		<input type="text" class="form-control" id="uid"  placeholder="User ID" autocomplete="off"/>
            	</div>
            	<div class="col-md-3">
            		<div class="input-group">
            			<span class="input-group-addon">Status</span>
                   		<select type="text" class="form-control" id="stat">
                   			<option value=""></option>
                   			<option value="N">Not paid</option>
                        	<option value="P">Paid</option>
                        	<option value="C">Canceled</option>
                        	<option value="D">Done</option>
                        	<option value="R">Returned</option>
                    	</select>
                    </div>
            	</div>
            	<div class="col-md-2">
            		<button class="btn btn-primary" id="search">Search</button>
            	</div>
            </div>
			</div>
			<table id="mytab" class="table table-hover"></table>
			
			<!-- Edit model -->
                <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
                   <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                    &times;
                                </button>
                                <h4 class="modal-title" id="myModalLabel">Edit Order</h4>
                            </div>
                            <div class="modal-body">
                                <form class="form" action="order_update" method="post">
                                    <div class="form-group input-group">
                                    	<span class="input-group-addon">Order ID</span>
                                        <input class="form-control" readonly="true" name="oid" id="Oid" />
                                    </div>
                                    <div class="form-group input-group">
                                    	<span class="input-group-addon">User ID</span>
                                        <input class="form-control" readonly="true" id="Uid">
                                    </div>
                                     <div class="form-group input-group">
                                     	<span class="input-group-addon">Status</span>
                                        <select type="text" class="form-control" name="status" id="Status">
                                        	<option value="N">Not paid</option>
                                        	<option value="P">Paid</option>
                                        	<option value="C">Canceled</option>
                                        	<option value="D">Done</option>
                                        	<option value="R">Returned</option>
                                        </select>
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
        url: "order_getAll",//数据源
        dataField: "rows",//服务端返回数据键值 就是说记录放的键值是rows，分页时使用总记录数的键值为total
        height: tableHeight(),//高度调整
        striped: true, //隔行换色
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
            	uid: $('#uid').val(),
            	stat: $('#stat').val()
            }
        },
        search: false,
        searchOnEnterKey: false,
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
                title: "User ID",
                field: "uid",
                sortable: true
            },
            {
                title: "Total",
                field: "total",
                formatter:function(value, row, index){
                	return value/100.00;
                }
            },
            {
            	title: "Time",
                field: "time",
                sortable: true,
                formatter:function(value, row, index){
                	return new Date(row.time.time).Format("yyyy-MM-dd / hh:mm:ss");
                }
            },
            {
                title: "Status",
                field: "status",
                sortable: true,
                formatter: function(value, row, index){
                	switch(row.status){
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
                	default: return row.status;
                	}
                }
            },
            {
                title: "Operation",
                field: "operation",
                align: "center",
                formatter: function(value, row, index){
                	return ['<a onclick="edit(\''+row.oid+'\',\''+row.uid+'\',\''+row.status+'\')">',
                			'<i class="glyphicon glyphicon-pencil"></i></a>'].join('');
                }
            }
        ],
        locale: "zh-CN",//中文支持,
        detailView: true, //是否显示详情折叠
        detailFormatter: function(index, row, element) {
        	var cur_table = "<table class='table table-striped table-bordered table-hover'>\
        					<thead><tr><td>Book ID</td><td>Price</td><td>Number</td></tr></thead><tbody>";
        	var items = row.items;
        	var siz = items.length;
        	for(var i=0; i < siz; ++i){
        		item = items[i];
        		cur_table+="<tr>";
        		var pri="<td>", num="<td>";
        		$.each(item,function(key,value){
        			switch(key){
        			case "bid":
        				cur_table+="<td>"+value+"</td>";break;
        			case "price":
        				pri+=value/100.00+"</td>";break;
        			case "num":
        				num+=value+"</td>";break;
        			default:break;
        			}
        		});
        		cur_table+=pri+num+"</tr>";
        	}
        	cur_table+="</tbody></table>";
        	return cur_table;
        }
    });
});

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


function tableHeight() {
    return $(window).height();
}

$('#search').click(function(){
	$('#mytab').bootstrapTable(
		'refresh', 
		{url:'order_getAll'}
	);
	$('#uid').val('');
	$('#stat').val('');
});
</script>
</body>
</html>`