<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/busLine.css" />
<div id="busLineAddDiv">
	<form id="busLineAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">线路名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_name" name="busLine.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">起点站:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_startStation_stationId" name="busLine.startStation.stationId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">终到站:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_endStation_stationId" name="busLine.endStation.stationId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">首班车时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_startTime" name="busLine.startTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">末班车时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_endTime" name="busLine.endTime" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所属公司:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_company" name="busLine.company" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">途径站点:</span>
			<span class="inputControl">
				<textarea id="busLine_tjzd" name="busLine.tjzd" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">地图线路坐标:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busLine_polylinePoints" name="busLine.polylinePoints" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="busLineAddButton" class="easyui-linkbutton">添加</a>
			<a id="busLineClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/BusLine/js/busLine_add.js"></script> 
