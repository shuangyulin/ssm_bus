<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BusStation" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>公交线路添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>BusLine/frontlist">公交线路列表</a></li>
			    	<li role="presentation" class="active"><a href="#busLineAdd" aria-controls="busLineAdd" role="tab" data-toggle="tab">添加公交线路</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="busLineList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="busLineAdd"> 
				      	<form class="form-horizontal" name="busLineAddForm" id="busLineAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="busLine_name" class="col-md-2 text-right">线路名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="busLine_name" name="busLine.name" class="form-control" placeholder="请输入线路名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="busLine_startStation_stationId" class="col-md-2 text-right">起点站:</label>
						  	 <div class="col-md-8">
							    <select id="busLine_startStation_stationId" name="busLine.startStation.stationId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="busLine_endStation_stationId" class="col-md-2 text-right">终到站:</label>
						  	 <div class="col-md-8">
							    <select id="busLine_endStation_stationId" name="busLine.endStation.stationId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="busLine_startTime" class="col-md-2 text-right">首班车时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="busLine_startTime" name="busLine.startTime" class="form-control" placeholder="请输入首班车时间">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="busLine_endTime" class="col-md-2 text-right">末班车时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="busLine_endTime" name="busLine.endTime" class="form-control" placeholder="请输入末班车时间">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="busLine_company" class="col-md-2 text-right">所属公司:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="busLine_company" name="busLine.company" class="form-control" placeholder="请输入所属公司">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="busLine_tjzd" class="col-md-2 text-right">途径站点:</label>
						  	 <div class="col-md-8">
							    <textarea id="busLine_tjzd" name="busLine.tjzd" rows="8" class="form-control" placeholder="请输入途径站点"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="busLine_polylinePoints" class="col-md-2 text-right">地图线路坐标:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="busLine_polylinePoints" name="busLine.polylinePoints" class="form-control" placeholder="请输入地图线路坐标">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxBusLineAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#busLineAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加公交线路信息
	function ajaxBusLineAdd() { 
		//提交之前先验证表单
		$("#busLineAddForm").data('bootstrapValidator').validate();
		if(!$("#busLineAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "BusLine/add",
			dataType : "json" , 
			data: new FormData($("#busLineAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#busLineAddForm").find("input").val("");
					$("#busLineAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证公交线路添加表单字段
	$('#busLineAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"busLine.name": {
				validators: {
					notEmpty: {
						message: "线路名称不能为空",
					}
				}
			},
			"busLine.startTime": {
				validators: {
					notEmpty: {
						message: "首班车时间不能为空",
					}
				}
			},
			"busLine.endTime": {
				validators: {
					notEmpty: {
						message: "末班车时间不能为空",
					}
				}
			},
			"busLine.company": {
				validators: {
					notEmpty: {
						message: "所属公司不能为空",
					}
				}
			},
			"busLine.tjzd": {
				validators: {
					notEmpty: {
						message: "途径站点不能为空",
					}
				}
			},
			"busLine.polylinePoints": {
				validators: {
					notEmpty: {
						message: "地图线路坐标不能为空",
					}
				}
			},
		}
	}); 
	//初始化起点站下拉框值 
	$.ajax({
		url: basePath + "BusStation/listAll",
		type: "get",
		success: function(busStations,response,status) { 
			$("#busLine_startStation_stationId").empty();
			var html="";
    		$(busStations).each(function(i,busStation){
    			html += "<option value='" + busStation.stationId + "'>" + busStation.stationName + "</option>";
    		});
    		$("#busLine_startStation_stationId").html(html);
    	}
	});
	//初始化终到站下拉框值 
	$.ajax({
		url: basePath + "BusStation/listAll",
		type: "get",
		success: function(busStations,response,status) { 
			$("#busLine_endStation_stationId").empty();
			var html="";
    		$(busStations).each(function(i,busStation){
    			html += "<option value='" + busStation.stationId + "'>" + busStation.stationName + "</option>";
    		});
    		$("#busLine_endStation_stationId").html(html);
    	}
	});
})
</script>
</body>
</html>
