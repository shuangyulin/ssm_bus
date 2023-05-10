var stationToStation_manage_tool = null; 
$(function () { 
	initStationToStationManageTool(); //建立StationToStation管理对象
	stationToStation_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#stationToStation_manage").datagrid({
		url : 'StationToStation/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "id",
		sortOrder : "desc",
		toolbar : "#stationToStation_manage_tool",
		columns : [[
			{
				field : "id",
				title : "记录编号",
				width : 70,
			},
			{
				field : "startStation",
				title : "起始站",
				width : 140,
			},
			{
				field : "endStation",
				title : "终到站",
				width : 140,
			},
		]],
	});

	$("#stationToStationEditDiv").dialog({
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
				if ($("#stationToStationEditForm").form("validate")) {
					//验证表单 
					if(!$("#stationToStationEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#stationToStationEditForm").form({
						    url:"StationToStation/" + $("#stationToStation_id_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#stationToStationEditDiv").dialog("close");
			                        stationToStation_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#stationToStationEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#stationToStationEditDiv").dialog("close");
				$("#stationToStationEditForm").form("reset"); 
			},
		}],
	});
});

function initStationToStationManageTool() {
	stationToStation_manage_tool = {
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
			$("#stationToStation_manage").datagrid("reload");
		},
		redo : function () {
			$("#stationToStation_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#stationToStation_manage").datagrid("options").queryParams;
			queryParams["startStation.stationId"] = $("#startStation_stationId_query").combobox("getValue");
			queryParams["endStation.stationId"] = $("#endStation_stationId_query").combobox("getValue");
			$("#stationToStation_manage").datagrid("options").queryParams=queryParams; 
			$("#stationToStation_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#stationToStationQueryForm").form({
			    url:"StationToStation/OutToExcel",
			});
			//提交表单
			$("#stationToStationQueryForm").submit();
		},
		remove : function () {
			var rows = $("#stationToStation_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var ids = [];
						for (var i = 0; i < rows.length; i ++) {
							ids.push(rows[i].id);
						}
						$.ajax({
							type : "POST",
							url : "StationToStation/deletes",
							data : {
								ids : ids.join(","),
							},
							beforeSend : function () {
								$("#stationToStation_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#stationToStation_manage").datagrid("loaded");
									$("#stationToStation_manage").datagrid("load");
									$("#stationToStation_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#stationToStation_manage").datagrid("loaded");
									$("#stationToStation_manage").datagrid("load");
									$("#stationToStation_manage").datagrid("unselectAll");
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
			var rows = $("#stationToStation_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "StationToStation/" + rows[0].id +  "/update",
					type : "get",
					data : {
						//id : rows[0].id,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (stationToStation, response, status) {
						$.messager.progress("close");
						if (stationToStation) { 
							$("#stationToStationEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
