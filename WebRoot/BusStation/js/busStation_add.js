$(function () {
	$("#busStation_stationName").validatebox({
		required : true, 
		missingMessage : '请输入站点名称',
	});

	$("#busStation_longitude").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入经度',
		invalidMessage : '经度输入不对',
	});

	$("#busStation_latitude").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入纬度',
		invalidMessage : '纬度输入不对',
	});

	//单击添加按钮
	$("#busStationAddButton").click(function () {
		//验证表单 
		if(!$("#busStationAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#busStationAddForm").form({
			    url:"BusStation/add",
			    onSubmit: function(){
					if($("#busStationAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#busStationAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#busStationAddForm").submit();
		}
	});

	//单击清空按钮
	$("#busStationClearButton").click(function () { 
		$("#busStationAddForm").form("clear"); 
	});
});
