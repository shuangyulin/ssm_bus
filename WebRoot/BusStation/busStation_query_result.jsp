<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/busStation.css" /> 

<div id="busStation_manage"></div>
<div id="busStation_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="busStation_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="busStation_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="busStation_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="busStation_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="busStation_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="busStationQueryForm" method="post">
			站点名称：<input type="text" class="textbox" id="stationName" name="stationName" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="busStation_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="busStationEditDiv">
	<form id="busStationEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busStation_stationId_edit" name="busStation.stationId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">站点名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busStation_stationName_edit" name="busStation.stationName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">经度:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busStation_longitude_edit" name="busStation.longitude" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">纬度:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busStation_latitude_edit" name="busStation.latitude" style="width:80px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="BusStation/js/busStation_manage.js"></script> 
