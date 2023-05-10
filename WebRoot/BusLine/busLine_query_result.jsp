<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/busLine.css" /> 

<div id="busLine_manage"></div>
<div id="busLine_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="busLine_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="busLine_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="busLine_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="busLine_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="busLine_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="busLineQueryForm" method="post">
			线路名称：<input type="text" class="textbox" id="name" name="name" style="width:110px" />
			起点站：<input class="textbox" type="text" id="startStation_stationId_query" name="startStation.stationId" style="width: auto"/>
			终到站：<input class="textbox" type="text" id="endStation_stationId_query" name="endStation.stationId" style="width: auto"/>
			所属公司：<input type="text" class="textbox" id="company" name="company" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="busLine_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="busLineEditDiv">
	<form id="busLineEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_lineId_edit" name="busLine.lineId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">线路名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_name_edit" name="busLine.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">起点站:</span>
			<span class="inputControl">
				<input class="textbox"  id="busLine_startStation_stationId_edit" name="busLine.startStation.stationId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">终到站:</span>
			<span class="inputControl">
				<input class="textbox"  id="busLine_endStation_stationId_edit" name="busLine.endStation.stationId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">首班车时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_startTime_edit" name="busLine.startTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">末班车时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_endTime_edit" name="busLine.endTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所属公司:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_company_edit" name="busLine.company" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">途径站点:</span>
			<span class="inputControl">
				<textarea id="busLine_tjzd_edit" name="busLine.tjzd" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">地图线路坐标:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_polylinePoints_edit" name="busLine.polylinePoints" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="BusLine/js/busLine_manage.js"></script> 
