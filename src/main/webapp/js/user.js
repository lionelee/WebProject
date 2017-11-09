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
        search: false,
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
                    	case 'firstname':case 'lastname':
                    		html+='\''+value+'\',';break;
                    	case 'username':
                    		html+='\''+value+'\')">';break;
                    	default:break;
                    	}
                	});
                	html +='<i class="glyphicon glyphicon-pencil"></i></a><a onclick="del(\''
                		+row.uid+'\')" style="padding-left:30px;"><i class="glyphicon glyphicon-remove"></i></a>';
                	return html;
                }
            }
        ],
        locale: "zh-CN",//中文支持,
        detailView: true, //是否显示详情折叠
        detailFormatter: function(index, row, element) {
        	var html = "<div class='row'><div class='col-md-3' style='padding-left:80px;'>";
        	var info = "";
        	$.ajax({
        		url: "user_getProfile",
        		async: false,
        		data: "uid="+row.uid,
        		dataType: 'text',
        		success: function(data){
        			html+="<div style='width:120px; height:120px; border-radius:50%; overflow:hidden;'>\
        			<img style='width:120px;height:120px;' src='user_img?uid="+row.uid+"' /></div></div>";
        			info=data;
        		}
        	});
            html += "<div class='col-md-4'>";
            var tmp = "<div class='col-md-4'>",addr="";
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
            		addr="<p>Address: "+value+"</p>";
            	default:break;
            	}
            });
            html+='<p>Intro: '+info+"</div>"+tmp+addr+'</p></div>';
            return html;
        }
    });
});

$('#addModal').on('hide.bs.modal',function(e){
	$('#fm').data('bootstrapValidator').resetForm();
});

function add(){
	$('#fm')[0].reset();
	$('#addModal').modal('show');
}

$('#fm').bootstrapValidator({
	message: 'This value is not valid',
	feedbackIcons: {
		valid: 'glyphicon glyphicon-ok',
    	invalid: 'glyphicon glyphicon-remove',
		validating: 'glyphicon glyphicon-refresh'
	},
fields: {
	"username": {
		message: 'Username is not valid',
		validators: {
			notEmpty: {
				message: 'Username is required and cannot be empty'
			},
			stringLength: {
				min: 1,
				max: 200,
				message: 'Username must be more than 1 and less than 200 characters long'
			},
			regexp: {
				regexp: /^[a-zA-Z0-9_]+$/,
				message: 'Username can only consist of alphabetical, number, dot and underscore'
			},
			remote: {
				type: 'POST',
				url: 'user_check',
				message: 'Username is not available',
				delay: 1000
			},
			different: {
				field: 'pwd',
				message: 'Username and password cannot be the same as each other'
			}
		}
	},
	"pwd": {
		validators: {
			notEmpty: {
				message: 'Password is required and cannot be empty'
			},
			stringLength: {
				min: 6,
				max: 200,
				message: 'Password must be more than 6 and less than 200 characters long'
			},
			regexp: {
				regexp: /^[a-zA-Z0-9_. @#$%^&*~]+$/,
				message: 'Password can only consist of alphabetical, number and _. @#$%^&*~'
			},
			different: {
				field: 'username',
				message: 'Password cannot be the same as username'
			}
		}
	},
	cpassword: {
		validators: {
			notEmpty: {
				message: 'Confirm password is required and cannot be empty'
			},
			identical: {
				field: 'pwd',
				message: 'It\'s different from password'
			}
		}
	},
	"firstname": {
		validators: {
			notEmpty: {
				message: 'First name is required and cannot be empty'
	        },
	        stringLength: {
				min: 1,
				max: 200,
				message: 'First name must be more than 1 and less than 200 characters long'
			},
	        regexp: {
				regexp: /^[a-zA-Z]+$/,
				message: 'First name can only consist of alphabetical'
			}
		}
	},
	"lastname": {
		validators: {
			notEmpty: {
				message: 'Last name is required and cannot be empty'
			},
			stringLength: {
				min: 1,
				max: 200,
				message: 'Last name must be more than 1 and less than 200 characters long'
			},
			regexp: {
				regexp: /^[a-zA-Z]+$/,
				message: 'Last name can only consist of alphabetical'
			}
		}
	},
	"phone": {
		validators: {
			notEmpty: {
				message: 'Phone is required and cannot be empty'
			},
			stringLength: {
				min: 6,
				max: 20,
				message: 'Phone number must be more than 6 and less than 50 characters long'
			},
			regexp: {
				regexp: /^[0-9]+$/,
				message: 'Phone can only consist of number'
			}
		}
	},
	"email": {
		validators: {
			notEmpty: {
				message: 'Email is required and cannot be empty'
			},
			emailAddress: {
				message: 'The input is not a valid email address'
			}
		}
	},
	"address": {
		validators: {
			notEmpty: {
				message: 'Address is required and cannot be empty'
			},
			regexp: {
				regexp: /^[a-zA-Z0-9_.]+$/,
				message: 'Address can only consist of alphabetical, number, dot and underscore'
			}
		}
	}
}
});

$('#image').fileinput({
	showUpload: false,
	maxFileCount: 1,
	maxFileSize: 2048,
	allowedFileExtensions : ['jpg','png','gif']
});

function edit(uid,uname,level,fname,lname){
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

function del(uid){
	var r = confirm("Are you sure to remove?");
	if(r==true){
		$('#mytab').bootstrapTable(
			'remove', {
			field: 'uid',
			values: [uid]
		});
		$.post('user_del?uid='+uid);
	}
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