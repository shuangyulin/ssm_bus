$(function () {
	$("#busLine_name").validatebox({
		required : true, 
		missingMessage : '请输入线路名称',
	});

	$("#busLine_startStation_stationId").combobox({
	    url:'BusStation/listAll',
	    valueField: "stationId",
	    textField: "stationName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#busLine_startStation_stationId").combobox("getData"); 
            if (data.length > 0) {
                $("#busLine_startStation_stationId").combobox("select", data[0].stationId);
            }
        }
	});
	$("#busLine_endStation_stationId").combobox({
	    url:'BusStation/listAll',
	    valueField: "stationId",
	    textField: "stationName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#busLine_endStation_stationId").combobox("getData"); 
            if (data.length > 0) {
                $("#busLine_endStation_stationId").combobox("select", data[0].stationId);
            }
        }
	});
	$("#busLine_startTime").validatebox({
		required : true, 
		missingMessage : '请输入首班车时间',
	});

	$("#busLine_endTime").validatebox({
		required : true, 
		missingMessage : '请输入末班车时间',
	});

	$("#busLine_company").validatebox({
		required : true, 
		missingMessage : '请输入所属公司',
	});

	$("#busLine_tjzd").validatebox({
		required : true, 
		missingMessage : '请输入途径站点',
	});

	$("#busLine_polylinePoints").validatebox({
		required : true, 
		missingMessage : '请输入地图线路坐标',
	});

	//单击添加按钮
	$("#busLineAddButton").click(function () {
		//验证表单 
		if(!$("#busLineAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#busLineAddForm").form({
			    url:"BusLine/add",
			    onSubmit: function(){
					if($("#busLineAddForm").form("validate"))  { 
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
                        $("#busLineAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#busLineAddForm").submit();
		}
	});

	//单击清空按钮
	$("#busLineClearButton").click(function () { 
		$("#busLineAddForm").form("clear"); 
	});
});
