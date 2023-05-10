<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BusLine" %>
<%@ page import="com.chengxusheji.po.BusStation" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的startStation信息
    List<BusStation> busStationList = (List<BusStation>)request.getAttribute("busStationList");
    BusLine busLine = (BusLine)request.getAttribute("busLine");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改公交线路信息</TITLE>
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
  		<li class="active">公交线路信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="busLineEditForm" id="busLineEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="busLine_lineId_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="busLine_lineId_edit" name="busLine.lineId" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="busLine_name_edit" class="col-md-3 text-right">线路名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="busLine_name_edit" name="busLine.name" class="form-control" placeholder="请输入线路名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="busLine_startStation_stationId_edit" class="col-md-3 text-right">起点站:</label>
		  	 <div class="col-md-9">
			    <select id="busLine_startStation_stationId_edit" name="busLine.startStation.stationId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="busLine_endStation_stationId_edit" class="col-md-3 text-right">终到站:</label>
		  	 <div class="col-md-9">
			    <select id="busLine_endStation_stationId_edit" name="busLine.endStation.stationId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="busLine_startTime_edit" class="col-md-3 text-right">首班车时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="busLine_startTime_edit" name="busLine.startTime" class="form-control" placeholder="请输入首班车时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="busLine_endTime_edit" class="col-md-3 text-right">末班车时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="busLine_endTime_edit" name="busLine.endTime" class="form-control" placeholder="请输入末班车时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="busLine_company_edit" class="col-md-3 text-right">所属公司:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="busLine_company_edit" name="busLine.company" class="form-control" placeholder="请输入所属公司">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="busLine_tjzd_edit" class="col-md-3 text-right">途径站点:</label>
		  	 <div class="col-md-9">
			    <textarea id="busLine_tjzd_edit" name="busLine.tjzd" rows="8" class="form-control" placeholder="请输入途径站点"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="busLine_polylinePoints_edit" class="col-md-3 text-right">地图线路坐标:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="busLine_polylinePoints_edit" name="busLine.polylinePoints" class="form-control" placeholder="请输入地图线路坐标">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxBusLineModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#busLineEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改公交线路界面并初始化数据*/
function busLineEdit(lineId) {
	$.ajax({
		url :  basePath + "BusLine/" + lineId + "/update",
		type : "get",
		dataType: "json",
		success : function (busLine, response, status) {
			if (busLine) {
				$("#busLine_lineId_edit").val(busLine.lineId);
				$("#busLine_name_edit").val(busLine.name);
				$.ajax({
					url: basePath + "BusStation/listAll",
					type: "get",
					success: function(busStations,response,status) { 
						$("#busLine_startStation_stationId_edit").empty();
						var html="";
		        		$(busStations).each(function(i,busStation){
		        			html += "<option value='" + busStation.stationId + "'>" + busStation.stationName + "</option>";
		        		});
		        		$("#busLine_startStation_stationId_edit").html(html);
		        		$("#busLine_startStation_stationId_edit").val(busLine.startStationPri);
					}
				});
				$.ajax({
					url: basePath + "BusStation/listAll",
					type: "get",
					success: function(busStations,response,status) { 
						$("#busLine_endStation_stationId_edit").empty();
						var html="";
		        		$(busStations).each(function(i,busStation){
		        			html += "<option value='" + busStation.stationId + "'>" + busStation.stationName + "</option>";
		        		});
		        		$("#busLine_endStation_stationId_edit").html(html);
		        		$("#busLine_endStation_stationId_edit").val(busLine.endStationPri);
					}
				});
				$("#busLine_startTime_edit").val(busLine.startTime);
				$("#busLine_endTime_edit").val(busLine.endTime);
				$("#busLine_company_edit").val(busLine.company);
				$("#busLine_tjzd_edit").val(busLine.tjzd);
				$("#busLine_polylinePoints_edit").val(busLine.polylinePoints);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交公交线路信息表单给服务器端修改*/
function ajaxBusLineModify() {
	$.ajax({
		url :  basePath + "BusLine/" + $("#busLine_lineId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#busLineEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#busLineQueryForm").submit();
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
    busLineEdit("<%=request.getParameter("lineId")%>");
 })
 </script> 
</body>
</html>

