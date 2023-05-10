<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.StationToStation" %>
<%@ page import="com.chengxusheji.po.BusStation" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<StationToStation> stationToStationList = (List<StationToStation>)request.getAttribute("stationToStationList");
    //获取所有的startStation信息
    List<BusStation> busStationList = (List<BusStation>)request.getAttribute("busStationList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    BusStation startStation = (BusStation)request.getAttribute("startStation");
    BusStation endStation = (BusStation)request.getAttribute("endStation");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>站站查询查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#stationToStationListPanel" aria-controls="stationToStationListPanel" role="tab" data-toggle="tab">站站查询列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>StationToStation/stationToStation_frontAdd.jsp" style="display:none;">添加站站查询</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="stationToStationListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>记录编号</td><td>起始站</td><td>终到站</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<stationToStationList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		StationToStation stationToStation = stationToStationList.get(i); //获取到站站查询对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=stationToStation.getId() %></td>
 											<td><%=stationToStation.getStartStation().getStationName() %></td>
 											<td><%=stationToStation.getEndStation().getStationName() %></td>
 											<td>
 												<a href="<%=basePath  %>StationToStation/<%=stationToStation.getId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="stationToStationEdit('<%=stationToStation.getId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="stationToStationDelete('<%=stationToStation.getId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>站站查询查询</h1>
		</div>
		<form name="stationToStationQueryForm" id="stationToStationQueryForm" action="<%=basePath %>StationToStation/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="startStation_stationId">起始站：</label>
                <select id="startStation_stationId" name="startStation.stationId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(BusStation busStationTemp:busStationList) {
	 					String selected = "";
 					if(startStation!=null && startStation.getStationId()!=null && startStation.getStationId().intValue()==busStationTemp.getStationId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=busStationTemp.getStationId() %>" <%=selected %>><%=busStationTemp.getStationName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="endStation_stationId">终到站：</label>
                <select id="endStation_stationId" name="endStation.stationId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(BusStation busStationTemp:busStationList) {
	 					String selected = "";
 					if(endStation!=null && endStation.getStationId()!=null && endStation.getStationId().intValue()==busStationTemp.getStationId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=busStationTemp.getStationId() %>" <%=selected %>><%=busStationTemp.getStationName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="stationToStationEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;站站查询信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="stationToStationEditForm" id="stationToStationEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="stationToStation_id_edit" class="col-md-3 text-right">记录编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="stationToStation_id_edit" name="stationToStation.id" class="form-control" placeholder="请输入记录编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="stationToStation_startStation_stationId_edit" class="col-md-3 text-right">起始站:</label>
		  	 <div class="col-md-9">
			    <select id="stationToStation_startStation_stationId_edit" name="stationToStation.startStation.stationId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="stationToStation_endStation_stationId_edit" class="col-md-3 text-right">终到站:</label>
		  	 <div class="col-md-9">
			    <select id="stationToStation_endStation_stationId_edit" name="stationToStation.endStation.stationId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		</form> 
	    <style>#stationToStationEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxStationToStationModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.stationToStationQueryForm.currentPage.value = currentPage;
    document.stationToStationQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.stationToStationQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.stationToStationQueryForm.currentPage.value = pageValue;
    documentstationToStationQueryForm.submit();
}

/*弹出修改站站查询界面并初始化数据*/
function stationToStationEdit(id) {
	$.ajax({
		url :  basePath + "StationToStation/" + id + "/update",
		type : "get",
		dataType: "json",
		success : function (stationToStation, response, status) {
			if (stationToStation) {
				$("#stationToStation_id_edit").val(stationToStation.id);
				$.ajax({
					url: basePath + "BusStation/listAll",
					type: "get",
					success: function(busStations,response,status) { 
						$("#stationToStation_startStation_stationId_edit").empty();
						var html="";
		        		$(busStations).each(function(i,busStation){
		        			html += "<option value='" + busStation.stationId + "'>" + busStation.stationName + "</option>";
		        		});
		        		$("#stationToStation_startStation_stationId_edit").html(html);
		        		$("#stationToStation_startStation_stationId_edit").val(stationToStation.startStationPri);
					}
				});
				$.ajax({
					url: basePath + "BusStation/listAll",
					type: "get",
					success: function(busStations,response,status) { 
						$("#stationToStation_endStation_stationId_edit").empty();
						var html="";
		        		$(busStations).each(function(i,busStation){
		        			html += "<option value='" + busStation.stationId + "'>" + busStation.stationName + "</option>";
		        		});
		        		$("#stationToStation_endStation_stationId_edit").html(html);
		        		$("#stationToStation_endStation_stationId_edit").val(stationToStation.endStationPri);
					}
				});
				$('#stationToStationEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除站站查询信息*/
function stationToStationDelete(id) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "StationToStation/deletes",
			data : {
				ids : id,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#stationToStationQueryForm").submit();
					//location.href= basePath + "StationToStation/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交站站查询信息表单给服务器端修改*/
function ajaxStationToStationModify() {
	$.ajax({
		url :  basePath + "StationToStation/" + $("#stationToStation_id_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#stationToStationEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#stationToStationQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();

})
</script>
</body>
</html>

