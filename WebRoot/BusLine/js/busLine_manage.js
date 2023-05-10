var busLine_manage_tool = null; 
$(function () { 
	initBusLineManageTool(); //建立BusLine管理对象
	busLine_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#busLine_manage").datagrid({
		url : 'BusLine/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "lineId",
		sortOrder : "desc",
		toolbar : "#busLine_manage_tool",
		columns : [[
			{
				field : "name",
				title : "线路名称",
				width : 140,
			},
			{
				field : "startStation",
				title : "起点站",
				width : 140,
			},
			{
				field : "endStation",
				title : "终到站",
				width : 140,
			},
			{
				field : "startTime",
				title : "首班车时间",
				width : 140,
			},
			{
				field : "endTime",
				title : "末班车时间",
				width : 140,
			},
			{
				field : "company",
				title : "所属公司",
				width : 140,
			},
		]],
	});

	$("#busLineEditDiv").dialog({
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
				if ($("#busLineEditForm").form("validate")) {
					//验证表单 
					if(!$("#busLineEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#busLineEditForm").form({
						    url:"BusLine/" + $("#busLine_lineId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#busLineEditDiv").dialog("close");
			                        busLine_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#busLineEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#busLineEditDiv").dialog("close");
				$("#busLineEditForm").form("reset"); 
			},
		}],
	});
});

function initBusLineManageTool() {
	busLine_manage_tool = {
		init: function() {
			$.ajax({
				url : "BusStation/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#startStation_stationId_query").combobox({ 
					    valueField:"stationId",
					    textField:"stationName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{stationId:0,stationName:"不限制"});
					$("#startStation_stationId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "BusStation/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#endStation_stationId_query").combobox({ 
					    valueField:"stationId",
					    textField:"stationName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{stationId:0,stationName:"不限制"});
					$("#endStation_stationId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#busLine_manage").datagrid("reload");
		},
		redo : function () {
			$("#busLine_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#busLine_manage").datagrid("options").queryParams;
			queryParams["name"] = $("#name").val();
			queryParams["startStation.stationId"] = $("#startStation_stationId_query").combobox("getValue");
			queryParams["endStation.stationId"] = $("#endStation_stationId_query").combobox("getValue");
			queryParams["company"] = $("#company").val();
			$("#busLine_manage").datagrid("options").queryParams=queryParams; 
			$("#busLine_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#busLineQueryForm").form({
			    url:"BusLine/OutToExcel",
			});
			//提交表单
			$("#busLineQueryForm").submit();
		},
		remove : function () {
			var rows = $("#busLine_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var lineIds = [];
						for (var i = 0; i < rows.length; i ++) {
							lineIds.push(rows[i].lineId);
						}
						$.ajax({
							type : "POST",
							url : "BusLine/deletes",
							data : {
								lineIds : lineIds.join(","),
							},
							beforeSend : function () {
								$("#busLine_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#busLine_manage").datagrid("loaded");
									$("#busLine_manage").datagrid("load");
									$("#busLine_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#busLine_manage").datagrid("loaded");
									$("#busLine_manage").datagrid("load");
									$("#busLine_manage").datagrid("unselectAll");
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
			var rows = $("#busLine_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "BusLine/" + rows[0].lineId +  "/update",
					type : "get",
					data : {
						//lineId : rows[0].lineId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (busLine, response, status) {
						$.messager.progress("close");
						if (busLine) { 
							$("#busLineEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
