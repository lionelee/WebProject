$(function() {
    //根据窗口调整表格高度
    $(window).resize(function() {
        $('#mytab').bootstrapTable('resetView', {
            height: tableHeight()
        })
    })

    $('#mytab').bootstrapTable({
        url: "book_getAll",//数据源
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
            	title: $('#title').val(),
            	author: $('#author').val(),
            	bid: $('#bookid').val()
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
            	title: "Book ID",
                field: "bid",
                sortable: true
            },
            {
            	title: "ISBN",
                field: "isbn",
                sortable: true
            },
            {
                title: "Title",
                field: "title",
                sortable: true
            },
            {
            	title: "Author",
                field: "author",
                sortable: true
            },
            {
            	title: "Price",
            	field: "price",
            	formatter: function(value, row, index){
            		return value/100.00;
            	}
            },
            {
                title: "Operation",
                field: "operation",
                align: "center",
                formatter: function(value, row, index){
                	return ['<a onclick="edit(\''+row.bid+'\',\''+row.image+'\',\''+row.category+'\',\''+row.title+'\',\''+row.isbn+'\',\
                				\''+row.author+'\',\''+row.press+'\',\''+row.price+'\',\''+row.stock+'\')">',
                			'<i class="glyphicon glyphicon-pencil"></i></a>',
                	        '<a onclick="del(\''+row.bid+'\')" style="padding-left:30px;">',
                	        '<i class="glyphicon glyphicon-remove"></i></a>'].join('');
                }
            }
        ],
        locale: "zh-CN",//中文支持,
        detailView: true, //是否显示详情折叠
        detailFormatter: function(index, row, element) {
            var html = "<div class='row'>";
            html += "<div class='col-md-3' style='padding-left:80px;'><img src='book_image?i="+row.image+"' width='85px' height='125px'/></div>";
            html += "<div class='col-md-4'><p>Category: "+cate(row.category)+"</p><p>Title: "+
            		row.title+"</p><p>Author: "+row.author+"</p><p>Press: "+row.press+"</p></div>";
            html += "<div class='col-md-4'><p>ISBN: "+row.isbn+"</p><p>Price: &yen; "+
    				row.price/100.00+"</p><p>Stock: "+row.stock+"</p></div>";
            html+="</div>";
            return html;
        }
    });
    
    $('#addModal').on('hide.bs.modal',function(e){
    	$('#fm').data('bootstrapValidator').resetForm();
    });
    
    $('#fm').on("submit",function(){
    	var p = $('#pri').val();
    	var s=p.toString();
    	if(s.indexOf(".") > 0){
    		if(parseInt(s.split('.')[1]) == 0){
    			p = parseInt($('#pri').val());
    		}
    	}
    	$('#pri').val(p*10);
    });
       
    $('#fm').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
	    	invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
	fields: {
		"image":{
			message: "Image is not valid",
			validators: {
				notEmpty: {
					message: 'Image is required and cannot be empty'
				}
			}
		},
		"category": {
			message: 'Category is not valid',
			validators: {
				notEmpty: {
					message: 'Category is required'
				}
			}
		},
		"isbn": {
			message: 'ISBN is not valid',
			validators: {
				notEmpty: {
					message: 'ISBN is required and cannot be empty'
				},
				stringLength: {
					min: 8,
					max: 13,
					message: 'ISBN must be more than 13 and less than 200 characters long'
				},
				regexp: {
					regexp: /^[0-9]+$/,
					message: 'ISBN can only consist of number'
				}
			}
		},
		"title": {
			validators: {
				notEmpty: {
					message: 'Title is required and cannot be empty'
				}
			}
		},
		"price": {
			message: 'Price is not valid',
			validators: {
				notEmpty: {
					message: 'Price is required and cannot be empty'
				},
				regexp: {
					regexp: /^[0-9.]+$/,
					message: 'Price can only consist of number and dot'
				}
			}
		},
		"stock": {
			validators: {
				notEmpty: {
					message: 'Stock is required and cannot be empty'
				},
				regexp: {
					regexp: /^[0-9]+$/,
					message: 'Price can only consist of number'
				}
			}
		},
	}
	});
    
    $('#efm').on("submit",function(){
    	var p = $('#Price').val();
    	var s=p.toString();
    	if(s.indexOf(".") > 0){
    		if(parseInt(s.split('.')[1]) == 0){
    			p = parseFloat($('#Price').val());
    		}
    	}
    	$('#Price').val(p*10);
    });
    
    $('#editModal').on('hide.bs.modal',function(e){
    	$('#efm').data('bootstrapValidator').resetForm();
    });
    
    $('#efm').bootstrapValidator({
		message: 'This value is not valid',
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
	    	invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
	fields: {
		"isbn": {
			message: 'ISBN is not valid',
			validators: {
				notEmpty: {
					message: 'ISBN is required and cannot be empty'
				},
				stringLength: {
					min: 8,
					max: 13,
					message: 'ISBN must be more than 13 and less than 200 characters long'
				},
				regexp: {
					regexp: /^[0-9]+$/,
					message: 'ISBN can only consist of number'
				}
			}
		},
		"title": {
			validators: {
				notEmpty: {
					message: 'Title is required and cannot be empty'
				}
			}
		},
		"price": {
			message: 'Price is not valid',
			validators: {
				notEmpty: {
					message: 'Price is required and cannot be empty'
				},
				regexp: {
					regexp: /^[0-9.]+$/,
					message: 'Price can only consist of number and dot'
				}
			}
		},
		"stock": {
			validators: {
				notEmpty: {
					message: 'Stock is required and cannot be empty'
				},
				regexp: {
					regexp: /^[0-9]+$/,
					message: 'Price can only consist of number'
				}
			}
		},
	}
	});

});


$('#image').fileinput({
	showUpload: false,
	maxFileCount: 1,
	allowedFileExtensions : ['jpg','png','gif']
});

//$("#image").on("change", function() {
//	var blobSlice = File.prototype.slice || File.prototype.mozSlice || File.prototype.webkitSlice,
//		file = this.files[0],
//		chunkSize = 2097152, // read in chunks of 2MB
//		chunks = Math.ceil(file.size / chunkSize),
//		currentChunk = 0,
//		spark = new SparkMD5.ArrayBuffer(),
//		frOnload = function(e){
//			spark.append(e.target.result); // append array buffer
//			currentChunk++;
//			if (currentChunk < chunks)
//				loadNext();
//			else {
//				$.ajax({
//			         type: 'post',
//			         url: 'book_imgcheck',
//			         data: 'md5='+spark.end(),
//			         async: false,
//			         dataType: 'json',
//			         success: function(book){
//			        	 		$('#image').attr("disabled",true);
//			        	 	}
//			         });
//			}
//		};
//	function loadNext() {
//		var fileReader = new FileReader();
//		fileReader.onload = frOnload;
//		var start = currentChunk * chunkSize,
//			end = ((start + chunkSize) >= file.size) ? file.size : start + chunkSize;
//		fileReader.readAsArrayBuffer(blobSlice.call(file, start, end));
//	};
//});


function checkPri(obj){
	var value = obj.value;
	var s = value.toString();
	var i = s.indexOf(".");
	var t = value.charAt(0);
	if(t=='-'){
		obj.value = value.replace(/^\-/g,'');
		return;
	}
	if(isNaN(value) || i == 0){
		obj.value = "";
		return;
	}
	if(i>0){
		var sub = s.split('.');
		if(sub[1].length > 2){
			var tmp = sub[0]+"."+sub[1][0]+sub[1][1];
			obj.value = tmp;
		}
	}
};

function addoption(cat){
	var s=document.getElementById(cat);
	for(var i=0;i<26;i++){
		if(i==11 || i==12 || i==22 || i==24)continue;
	    var tmp = String.fromCharCode(65+i);
	    s.options.add(new Option(cate(tmp),tmp));
	}
}

function add(){
	$('#fm')[0].reset();
	addoption('Category1');
	$('#addModal').modal('show');
}

var image="201706091704083.png";

function edit(bid,img,category,title,isbn,author,press,price,stock){
	addoption('Category2');
	$('#eimage').fileinput('refresh',{
		showUpload: false,
		maxFileCount: 1,
		allowedFileExtensions : ['jpg','png','gif'],
		initialPreview: ['<img src="book_image?i='+img+'" class="file-preview-image"/>']
	});
	$('#Bid').val(bid);
	$('#Category2').val(category);
	$('#Title').val(title);
	$('#Isbn').val(isbn);
	$('#Author').val(author);
	$('#Press').val(press);
	$('#Price').val(price/100.0);
	$('#Stock').val(stock);
	$('#editModal').modal('show');
}

function del(bid){
	var r = confirm("Are you sure to remove?");
	if(r==true){
		$('#mytab').bootstrapTable(
			'remove', {
			field: 'bid',
			values: [bid]
		});
		$.post('book_delete?bid='+bid);
	}
}

function tableHeight() {
    return $(window).height();
}

$('#search').click(function(){
	$('#mytab').bootstrapTable(
		'refresh', 
		{url:'book_getAll'}
	);
});