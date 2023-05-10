<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/busStation.css" />
<div id="busStationAddDiv">
	<form id="busStationAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">站点名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busStation_stationName" name="busStation.stationName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">经度:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busStation_longitude" name="busStation.longitude" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">纬度:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="busStation_latitude" name="busStation.latitude" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="busStationAddButton" class="easyui-linkbutton">添加</a>
			<a id="busStationClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/BusStation/js/busStation_add.js"></script> 
