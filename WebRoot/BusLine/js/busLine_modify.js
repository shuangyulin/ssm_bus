$(function () {
	$.ajax({
		url : "BusLine/" + $("#busLine_lineId_edit").val() + "/update",
		type : "get",
		data : {
			//lineId : $("#busLine_lineId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (busLine, response, status) {
			$.messager.progress("close");
			if (busLine) { 
				$("#busLine_lineId_edit").val(busLine.lineId);
				$("#busLine_lineId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#busLine_name_edit").val(busLine.name);
				$("#busLine_name_edit").validatebox({
					required : true,
					missingMessage : "请输入线路名称",
				});
				$("#busLine_startStation_stationId_edit").combobox({
					url:"BusStation/listAll",
					valueField:"stationId",
					textField:"stationName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#busLine_startStation_stationId_edit").combobox("select", busLine.startStationPri);
						//var data = $("#busLine_startStation_stationId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#busLine_startStation_stationId_edit").combobox("select", data[0].stationId);
						//}
					}
				});
				$("#busLine_endStation_stationId_edit").combobox({
					url:"BusStation/listAll",
					valueField:"stationId",
					textField:"stationName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#busLine_endStation_stationId_edit").combobox("select", busLine.endStationPri);
						//var data = $("#busLine_endStation_stationId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#busLine_endStation_stationId_edit").combobox("select", data[0].stationId);
						//}
					}
				});
				$("#busLine_startTime_edit").val(busLine.startTime);
				$("#busLine_startTime_edit").validatebox({
					required : true,
					missingMessage : "请输入首班车时间",
				});
				$("#busLine_endTime_edit").val(busLine.endTime);
				$("#busLine_endTime_edit").validatebox({
					required : true,
					missingMessage : "请输入末班车时间",
				});
				$("#busLine_company_edit").val(busLine.company);
				$("#busLine_company_edit").validatebox({
					required : true,
					missingMessage : "请输入所属公司",
				});
				$("#busLine_tjzd_edit").val(busLine.tjzd);
				$("#busLine_tjzd_edit").validatebox({
					required : true,
					missingMessage : "请输入途径站点",
				});
				$("#busLine_polylinePoints_edit").val(busLine.polylinePoints);
				$("#busLine_polylinePoints_edit").validatebox({
					required : true,
					missingMessage : "请输入地图线路坐标",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#busLineModifyButton").click(function(){ 
		if ($("#busLineEditForm").form("validate")) {
			$("#busLineEditForm").form({
			    url:"BusLine/" +  $("#busLine_lineId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#busLineEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#busLineEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
