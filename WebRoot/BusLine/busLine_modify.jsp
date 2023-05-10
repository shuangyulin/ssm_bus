<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/busLine.css" />
<div id="busLine_editDiv">
	<form id="busLineEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_lineId_edit" name="busLine.lineId" value="<%=request.getParameter("lineId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="busLineModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/BusLine/js/busLine_modify.js"></script> 
