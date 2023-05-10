$(function () {
	$.ajax({
		url : "BusStation/" + $("#busStation_stationId_edit").val() + "/update",
		type : "get",
		data : {
			//stationId : $("#busStation_stationId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (busStation, response, status) {
			$.messager.progress("close");
			if (busStation) { 
				$("#busStation_stationId_edit").val(busStation.stationId);
				$("#busStation_stationId_edit").validatebox({
					required : true,
					missingMessage : "请输入记录编号",
					editable: false
				});
				$("#busStation_stationName_edit").val(busStation.stationName);
				$("#busStation_stationName_edit").validatebox({
					required : true,
					missingMessage : "请输入站点名称",
				});
				$("#busStation_longitude_edit").val(busStation.longitude);
				$("#busStation_longitude_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入经度",
					invalidMessage : "经度输入不对",
				});
				$("#busStation_latitude_edit").val(busStation.latitude);
				$("#busStation_latitude_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入纬度",
					invalidMessage : "纬度输入不对",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#busStationModifyButton").click(function(){ 
		if ($("#busStationEditForm").form("validate")) {
			$("#busStationEditForm").form({
			    url:"BusStation/" +  $("#busStation_stationId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#busStationEditForm").form("validate"))  {
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
			$("#busStationEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
