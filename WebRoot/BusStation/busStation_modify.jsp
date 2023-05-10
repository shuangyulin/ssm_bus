<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/busStation.css" />
<div id="busStation_editDiv">
	<form id="busStationEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busStation_stationId_edit" name="busStation.stationId" value="<%=request.getParameter("stationId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="busStationModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/BusStation/js/busStation_modify.js"></script> 
