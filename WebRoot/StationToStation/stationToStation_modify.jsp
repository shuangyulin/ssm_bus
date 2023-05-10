<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/stationToStation.css" />
<div id="stationToStation_editDiv">
	<form id="stationToStationEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">记录编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="stationToStation_id_edit" name="stationToStation.id" value="<%=request.getParameter("id") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">起始站:</span>
			<span class="inputControl">
				<input class="textbox"  id="stationToStation_startStation_stationId_edit" name="stationToStation.startStation.stationId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">终到站:</span>
			<span class="inputControl">
				<input class="textbox"  id="stationToStation_endStation_stationId_edit" name="stationToStation.endStation.stationId" style="width: auto"/>
			</span>
		</div>
		<div class="operation">
			<a id="stationToStationModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/StationToStation/js/stationToStation_modify.js"></script> 
