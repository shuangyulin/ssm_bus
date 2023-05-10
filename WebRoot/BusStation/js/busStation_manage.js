var busStation_manage_tool = null; 
$(function () { 
	initBusStationManageTool(); //建立BusStation管理对象
	busStation_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#busStation_manage").datagrid({
		url : 'BusStation/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "stationId",
		sortOrder : "desc",
		toolbar : "#busStation_manage_tool",
		columns : [[
			{
				field : "stationId",
				title : "记录编号",
				width : 70,
			},
			{
				field : "stationName",
				title : "站点名称",
				width : 140,
			},
			{
				field : "longitude",
				title : "经度",
				width : 70,
			},
			{
				field : "latitude",
				title : "纬度",
				width : 70,
			},
		]],
	});

	$("#busStationEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#busStationEditForm").form("validate")) {
					//验证表单 
					if(!$("#busStationEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#busStationEditForm").form({
						    url:"BusStation/" + $("#busStation_stationId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#busStationEditDiv").dialog("close");
			                        busStation_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#busStationEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#busStationEditDiv").dialog("close");
				$("#busStationEditForm").form("reset"); 
			},
		}],
	});
});

function initBusStationManageTool() {
	busStation_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#busStation_manage").datagrid("reload");
		},
		redo : function () {
			$("#busStation_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#busStation_manage").datagrid("options").queryParams;
			queryParams["stationName"] = $("#stationName").val();
			$("#busStation_manage").datagrid("options").queryParams=queryParams; 
			$("#busStation_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#busStationQueryForm").form({
			    url:"BusStation/OutToExcel",
			});
			//提交表单
			$("#busStationQueryForm").submit();
		},
		remove : function () {
			var rows = $("#busStation_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var stationIds = [];
						for (var i = 0; i < rows.length; i ++) {
							stationIds.push(rows[i].stationId);
						}
						$.ajax({
							type : "POST",
							url : "BusStation/deletes",
							data : {
								stationIds : stationIds.join(","),
							},
							beforeSend : function () {
								$("#busStation_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#busStation_manage").datagrid("loaded");
									$("#busStation_manage").datagrid("load");
									$("#busStation_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#busStation_manage").datagrid("loaded");
									$("#busStation_manage").datagrid("load");
									$("#busStation_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#busStation_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "BusStation/" + rows[0].stationId +  "/update",
					type : "get",
					data : {
						//stationId : rows[0].stationId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (busStation, response, status) {
						$.messager.progress("close");
						if (busStation) { 
							$("#busStationEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
