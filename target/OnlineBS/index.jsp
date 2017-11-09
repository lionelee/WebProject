<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Online BookStore</title>
    <link rel="icon" href="./images/bs.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/main.css">
    <link rel="stylesheet" href="./css/templatemo-style.css">
    <link href='./css/googlefonts.css' rel='stylesheet' type='text/css'>
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
      		<a class="navbar-brand" href="./" style="margin-left: 40px;">
      			Online BookStore
      		</a>
      		<button type="button" class="hamburger is-closed" data-toggle="wrapper">
            	<span class="hamb-top"></span>
				<span class="hamb-middle"></span>
				<span class="hamb-bottom"></span>
          	</button>
		</div>
        <div class="collapse navbar-collapse" id="navbar">
            <ul class="nav navbar-nav navbar-right">
            	<s:if test="#session.usr==null">
            	<li><a href="./JSP/login.jsp"  style="font-size:18px;">
            		Login</a></li>
                <li><a href="./JSP/register.jsp" style="font-size:18px;">
                	Sign up</a></li>
                </s:if>
                <s:else>
                <li class="dropdown">
          			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" 
          			aria-haspopup="true" aria-expanded="false" style="font-size:18px;">
          			  <s:property value="#session.usr.username"/><span class="caret"></span></a>
          			<ul class="dropdown-menu" >
            			<li><a href="./JSP/person.jsp">Personal Center</a></li>
            			<li><a href="user_logout">Logout</a></li>
          			</ul>
        		</li>
        		</s:else>
        		<li><a href="./JSP/cart.jsp" target="_blank"><span class="glyphicon glyphicon-shopping-cart"></span></a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="row">
<div class="col-md-2 overlay">
	<nav class="templatemo-left-nav">
    	<ul id="menu"></ul>  
    </nav>
</div>
<div id="wrapper" class="tab-content" style="margin-top:40px;margin-left:50px;"></div>
</div>
</body>
<script src="./jeasyui/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script src="./js/main.js"></script>
<script src="./js/category.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var html = '<li><a id="A" class="btn active fa" data-toggle="tab" data-target="#tabA">马列主义毛思邓论</a></li>';
		var tabhtml = '<div class="tab-pane fade" id="tabA"></div>';
		for(var i=1;i<26;i++){
			if(i==11 || i==12 || i==22 || i==24)continue;
		    var tmp = String.fromCharCode(65+i);
		    html +='<li><a id="'+tmp+'" class="btn fa" data-toggle="tab" data-target="#tab'+tmp+'">'+cate(tmp)+'</a></li>';
		    tabhtml +='<div class="tab-pane fade" id="tab'+tmp+'"></div>'
		}
		html += '<li><a id="BackToTop" class="btn" style="text-align: left;">Back to top</a></li>';
		document.getElementById("menu").innerHTML += html;
		document.getElementById("wrapper").innerHTML += tabhtml;
		$('#BackToTop').on('click',function(){
			$('body,html').animate({ scrollTop: 0 }, 2);
		})
		
		var page = new Array(26);
		for(var i=0; i<26; ++i)page[i]=0;
		var size = 3;
		var lastele = "A";
		var index = 0;
		
		setTimeout("$('#A').click()", 300);
		
		$('.fa').on('click',function(){
			$('#'+lastele).removeClass('active');
		    lastele = $(this).attr('id');
		    $(this).addClass("active");
			for(var i=0;i<26;++i){
				if(lastele == String.fromCharCode(65+i))
					index = i;
			}
			$(this).tab('show');
			load(page[index], size, lastele);
			page[index]++;
		    $('body,html').animate({ scrollTop: 0 }, 2);
		});
		
		$(window).scroll(function(){
			var scrollTop = $(this).scrollTop();
			var scrollHeight = $(document).height();
			var windowHeight = $(this).height();
			if(scrollTop + windowHeight == scrollHeight){
				load(page[index], size, lastele);
				page[index]++;
			}
		});
		
		/*side menu*/
		var trigger = $('.hamburger'),overlay = $('.overlay'),isClosed = false;
	    trigger.click(function(){
	    	if (isClosed == true) {          
		        overlay.hide();
		        trigger.removeClass('is-open');
		        trigger.addClass('is-closed');
		        isClosed = false;
		      } else {   
		        overlay.show();
		        trigger.removeClass('is-closed');
		        trigger.addClass('is-open');
		        isClosed = true;
		      }    
	    });
	});
	
	function load(page, size, cate){
	 	$.ajax({
         type: 'post',
         url: 'book_load',
         data: 'page='+page+'&size='+size+'&cate='+cate,
         async: false,
         dataType: 'json',
         success: function(book){
        	 var result = "";
             var arrLen = book.length;
             if(arrLen > 0){
                 for(var i=0; i<arrLen; i++){
                 	result += '<div class="box"><a href="./JSP/book.jsp?bid='
                 		      +book[i].bid+'" target="_blank" onclick="book('+book[i].bid+')">\
                 		      <img src="book_image?i='+book[i].image+'" alt="${book.title }"/></a>\
     						  <p><a href="./JSP/book.jsp?bid='+book[i].bid+'" target="_blank">Title: '
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
</script>
</html>