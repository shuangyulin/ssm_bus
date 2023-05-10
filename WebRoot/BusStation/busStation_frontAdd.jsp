<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>站点信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>BusStation/frontlist">站点信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#busStationAdd" aria-controls="busStationAdd" role="tab" data-toggle="tab">添加站点信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="busStationList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="busStationAdd"> 
				      	<form class="form-horizontal" name="busStationAddForm" id="busStationAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="busStation_stationName" class="col-md-2 text-right">站点名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="busStation_stationName" name="busStation.stationName" class="form-control" placeholder="请输入站点名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="busStation_longitude" class="col-md-2 text-right">经度:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="busStation_longitude" name="busStation.longitude" class="form-control" placeholder="请输入经度">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="busStation_latitude" class="col-md-2 text-right">纬度:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="busStation_latitude" name="busStation.latitude" class="form-control" placeholder="请输入纬度">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxBusStationAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#busStationAddForm .form-group {margin:10px;}  </style>
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
	//提交添加站点信息信息
	function ajaxBusStationAdd() { 
		//提交之前先验证表单
		$("#busStationAddForm").data('bootstrapValidator').validate();
		if(!$("#busStationAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "BusStation/add",
			dataType : "json" , 
			data: new FormData($("#busStationAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#busStationAddForm").find("input").val("");
					$("#busStationAddForm").find("textarea").val("");
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
	//验证站点信息添加表单字段
	$('#busStationAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"busStation.stationName": {
				validators: {
					notEmpty: {
						message: "站点名称不能为空",
					}
				}
			},
			"busStation.longitude": {
				validators: {
					notEmpty: {
						message: "经度不能为空",
					},
					numeric: {
						message: "经度不正确"
					}
				}
			},
			"busStation.latitude": {
				validators: {
					notEmpty: {
						message: "纬度不能为空",
					},
					numeric: {
						message: "纬度不正确"
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
