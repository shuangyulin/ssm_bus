$(function () {
	$.ajax({
		url : "StationToStation/" + $("#stationToStation_id_edit").val() + "/update",
		type : "get",
		data : {
			//id : $("#stationToStation_id_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (stationToStation, response, status) {
			$.messager.progress("close");
			if (stationToStation) { 
				$("#stationToStation_id_edit").val(stationToStation.id);
				$("#stationToStation_id_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#stationToStation_startStation_stationId_edit").combobox({
					url:"BusStation/listAll",
					valueField:"stationId",
					textField:"stationName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#stationToStation_startStation_stationId_edit").combobox("select", stationToStation.startStationPri);
						//var data = $("#stationToStation_startStation_stationId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#stationToStation_startStation_stationId_edit").combobox("select", data[0].stationId);
						//}
					}
				});
				$("#stationToStation_endStation_stationId_edit").combobox({
					url:"BusStation/listAll",
					valueField:"stationId",
					textField:"stationName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#stationToStation_endStation_stationId_edit").combobox("select", stationToStation.endStationPri);
						//var data = $("#stationToStation_endStation_stationId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#stationToStation_endStation_stationId_edit").combobox("select", data[0].stationId);
						//}
					}
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#stationToStationModifyButton").click(function(){ 
		if ($("#stationToStationEditForm").form("validate")) {
			$("#stationToStationEditForm").form({
			    url:"StationToStation/" +  $("#stationToStation_id_edit").val() + "/update",
			    onSubmit: function(){
					if($("#stationToStationEditForm").form("validate"))  {
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
			$("#stationToStationEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
