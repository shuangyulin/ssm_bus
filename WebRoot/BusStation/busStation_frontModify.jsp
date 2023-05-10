<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BusStation" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    BusStation busStation = (BusStation)request.getAttribute("busStation");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改站点信息信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">站点信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="busStationEditForm" id="busStationEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="busStation_stationId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="busStation_stationId_edit" name="busStation.stationId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="busStation_stationName_edit" class="col-md-3 text-right">站点名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="busStation_stationName_edit" name="busStation.stationName" class="form-control" placeholder="请输入站点名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="busStation_longitude_edit" class="col-md-3 text-right">经度:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="busStation_longitude_edit" name="busStation.longitude" class="form-control" placeholder="请输入经度">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="busStation_latitude_edit" class="col-md-3 text-right">纬度:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="busStation_latitude_edit" name="busStation.latitude" class="form-control" placeholder="请输入纬度">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxBusStationModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#busStationEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改站点信息界面并初始化数据*/
function busStationEdit(stationId) {
	$.ajax({
		url :  basePath + "BusStation/" + stationId + "/update",
		type : "get",
		dataType: "json",
		success : function (busStation, response, status) {
			if (busStation) {
				$("#busStation_stationId_edit").val(busStation.stationId);
				$("#busStation_stationName_edit").val(busStation.stationName);
				$("#busStation_longitude_edit").val(busStation.longitude);
				$("#busStation_latitude_edit").val(busStation.latitude);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交站点信息信息表单给服务器端修改*/
function ajaxBusStationModify() {
	$.ajax({
		url :  basePath + "BusStation/" + $("#busStation_stationId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#busStationEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#busStationQueryForm").submit();
            }else{
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
    busStationEdit("<%=request.getParameter("stationId")%>");
 })
 </script> 
</body>
</html>

