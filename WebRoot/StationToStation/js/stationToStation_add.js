$(function () {
	$("#stationToStation_startStation_stationId").combobox({
	    url:'BusStation/listAll',
	    valueField: "stationId",
	    textField: "stationName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#stationToStation_startStation_stationId").combobox("getData"); 
            if (data.length > 0) {
                $("#stationToStation_startStation_stationId").combobox("select", data[0].stationId);
            }
        }
	});
	$("#stationToStation_endStation_stationId").combobox({
	    url:'BusStation/listAll',
	    valueField: "stationId",
	    textField: "stationName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#stationToStation_endStation_stationId").combobox("getData"); 
            if (data.length > 0) {
                $("#stationToStation_endStation_stationId").combobox("select", data[0].stationId);
            }
        }
	});
	//单击添加按钮
	$("#stationToStationAddButton").click(function () {
		//验证表单 
		if(!$("#stationToStationAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#stationToStationAddForm").form({
			    url:"StationToStation/add",
			    onSubmit: function(){
					if($("#stationToStationAddForm").form("validate"))  { 
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
                        $("#stationToStationAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#stationToStationAddForm").submit();
		}
	});

	//单击清空按钮
	$("#stationToStationClearButton").click(function () { 
		$("#stationToStationAddForm").form("clear"); 
	});
});
