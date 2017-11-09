function sear(){
	$('#fm')[0].reset();
	$('#Modal').modal('show');
}


$('#Modal').on('hide.bs.modal',function(e){
	$('#uerr').css('display','none');
	$('#serr').css('display','none');
	$('#eerr').css('display','none');
});

function validate(){
	var flag= true;
	var uid=$('#uid').val(), uvalue = parseInt(uid);
	var stime=$('#stime').val(),etime=$('#etime').val();
	if(uid=="" || isNaN(uid) || uvalue<1){
		$('#uerr').css('display','block');
		flag = false;
	}
//	if(stime=="" || stime==null){
//		$('#serr').css('display','block');
//		flag = false;
//	}
//	if(etime=="" || etime==null){
//		$('#eerr').css('display','block');
//		flag = false;
//	}
	return flag;
}

function sub(){
	if(validate()){
		$('#Modal').modal('hide');
		$('#userCharts').show();
		var uid=$('#uid').val(),stime=$('#stime').val(),etime=$('#etime').val();
		$('#title').text('Statistics charts about user '+uid+' between '+stime+' and '+etime);
		//each month's orders of this user
		$.ajax({
			url: 'sale_searchOrdersM',
			data:{
				uid: uid,
				stime: stime,
				etime: etime
			},
			dataType: 'json',
			success: function(data){
				var thisU = $("#thisOrderM").get(0).getContext("2d");
				var datas = {
						labels : data.dates,
						datasets : [{
							label:"Orders of each month",
							backgroundColor : "rgba(80,240,200,0.8)",
							borderColor : "rgba(80,240,200,1)",
							data : data.sales ,//[1,2,3,4,5,6,7,8,9,10,11,12],
							borderWidth: 1
						}]
				};
				new Chart(thisU,{type: 'bar',data: datas,options:{
        				title: {
        					display: true,
        					text: 'Orders of this user each month',
        					fontSize: 20
        				}}
				});
			},
			error: function(xhr,type){ 
				alert('Load error!');
			}
		});
		//each day's orders of this user
		$.ajax({
			url: 'sale_searchOrdersD',
			data:{
				uid: uid,
				stime: stime,
				etime: etime
			},
			dataType: 'json',
			success: function(data){
				var thisU = $("#thisOrderD").get(0).getContext("2d");
				var datas = {
						labels : data.dates,
						datasets : [{
							label:"Orders of each day",
							backgroundColor : "rgba(80,180,200,0.8)",
							borderColor : "rgba(80,180,200,1)",
							data : data.sales ,//[1,2,3,4,5,6,7,8,9,10,11,12],
							borderWidth: 1
						}]
				};
				new Chart(thisU,{type: 'bar',data: datas,options:{
        				title: {
        					display: true,
        					text: 'Orders of this user each day',
        					fontSize: 20
        				}}
				});
			},
			error: function(xhr,type){ 
				alert('Load error!');
			}
		});
		//each month's books of this user
		$.ajax({
			url: 'sale_searchVolumeD',
			data:{
				uid: uid,
				stime: stime,
				etime: etime
			},
			dataType: 'json',
			success: function(data){
				var thisU = $("#thisBookD").get(0).getContext("2d");
				var datas = {
						labels : data.dates,
						datasets : [{
							label:"Books bought of each day",
							backgroundColor : "rgba(80,120,200,0.8)",
							borderColor : "rgba(80,120,200,1)",
							data : data.sales ,//[1,2,3,4,5,6,7,8,9,10,11,12],
							borderWidth: 1
						}]
				};
				new Chart(thisU,{type: 'bar',data: datas,options:{
        				title: {
        					display: true,
        					text: 'Books bought by this user each day',
        					fontSize: 20
        				}}
				});
			},
			error: function(xhr,type){ 
				alert('Load error!');
			}
		});
		//each day's books of this user
		$.ajax({
			url: 'sale_searchVolumeM',
			data:{
				uid: uid,
				stime: stime,
				etime: etime
			},
			dataType: 'json',
			success: function(data){
				var thisU = $("#thisBookM").get(0).getContext("2d");
				var datas = {
						labels : data.dates,
						datasets : [{
							label:"Books bought of each month",
							backgroundColor : "rgba(80,60,200,0.8)",
							borderColor : "rgba(80,60,200,1)",
							data : data.sales ,//[1,2,3,4,5,6,7,8,9,10,11,12],
							borderWidth: 1
						}]
				};
				new Chart(thisU,{type: 'bar',data: datas,options:{
        				title: {
        					display: true,
        					text: 'Books bought by this user each month',
        					fontSize: 20
        				}}
				});
			},
			error: function(xhr,type){ 
				alert('Load error!');
			}
		});
		
		$.ajax({
			url: 'sale_searchCate',
			async: false,
			data:{
				uid: uid,
				stime: stime,
				etime: etime
			},
			dataType: 'json',
			success: function(data){
				var thisCate = $("#thisCate").get(0).getContext("2d");
				var colors=[], clabels=[];
				for(var i=0;i<22;++i){
					colors[i]="rgba("+i*11+",100,255,0.8)";
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
				new Chart(thisCate,{type: 'polarArea',data: datas,options:{
        				title: {
        					display: true,
        					text: 'Categories of books bought by this use this period',
        					fontSize: 20
        				}}
				});
			},
			error: function(xhr,type){ 
				alert('Load error!');
			}
		});
	window.location.hash="#ucharts";
	}
}