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
<title>站站查询添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>StationToStation/frontlist">站站查询列表</a></li>
			    	<li role="presentation" class="active"><a href="#stationToStationAdd" aria-controls="stationToStationAdd" role="tab" data-toggle="tab">添加站站查询</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="stationToStationList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="stationToStationAdd"> 
				      	<form class="form-horizontal" name="stationToStationAddForm" id="stationToStationAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="stationToStation_startStation_stationId" class="col-md-2 text-right">起始站:</label>
						  	 <div class="col-md-8">
							    <select id="stationToStation_startStation_stationId" name="stationToStation.startStation.stationId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="stationToStation_endStation_stationId" class="col-md-2 text-right">终到站:</label>
						  	 <div class="col-md-8">
							    <select id="stationToStation_endStation_stationId" name="stationToStation.endStation.stationId" class="form-control">
							    </select>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxStationToStationAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#stationToStationAddForm .form-group {margin:10px;}  </style>
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
	//提交添加站站查询信息
	function ajaxStationToStationAdd() { 
		//提交之前先验证表单
		$("#stationToStationAddForm").data('bootstrapValidator').validate();
		if(!$("#stationToStationAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "StationToStation/add",
			dataType : "json" , 
			data: new FormData($("#stationToStationAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#stationToStationAddForm").find("input").val("");
					$("#stationToStationAddForm").find("textarea").val("");
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
	//验证站站查询添加表单字段
	$('#stationToStationAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
		}
	}); 
	//初始化起始站下拉框值 
	$.ajax({
		url: basePath + "BusStation/listAll",
		type: "get",
		success: function(busStations,response,status) { 
			$("#stationToStation_startStation_stationId").empty();
			var html="";
    		$(busStations).each(function(i,busStation){
    			html += "<option value='" + busStation.stationId + "'>" + busStation.stationName + "</option>";
    		});
    		$("#stationToStation_startStation_stationId").html(html);
    	}
	});
	//初始化终到站下拉框值 
	$.ajax({
		url: basePath + "BusStation/listAll",
		type: "get",
		success: function(busStations,response,status) { 
			$("#stationToStation_endStation_stationId").empty();
			var html="";
    		$(busStations).each(function(i,busStation){
    			html += "<option value='" + busStation.stationId + "'>" + busStation.stationName + "</option>";
    		});
    		$("#stationToStation_endStation_stationId").html(html);
    	}
	});
})
</script>
</body>
</html>
