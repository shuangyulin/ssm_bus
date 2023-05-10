<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/stationToStation.css" />
<div id="stationToStationAddDiv">
	<form id="stationToStationAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">起始站:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="stationToStation_startStation_stationId" name="stationToStation.startStation.stationId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">终到站:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="stationToStation_endStation_stationId" name="stationToStation.endStation.stationId" style="width: auto"/>
			</span>
		</div>
		<div class="operation">
			<a id="stationToStationAddButton" class="easyui-linkbutton">添加</a>
			<a id="stationToStationClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/StationToStation/js/stationToStation_add.js"></script> 
