package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.BusStationService;
import com.chengxusheji.po.BusStation;

//BusStation管理控制层
@Controller
@RequestMapping("/BusStation")
public class BusStationController extends BaseController {

    /*业务层对象*/
    @Resource BusStationService busStationService;

	@InitBinder("busStation")
	public void initBinderBusStation(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("busStation.");
	}
	/*跳转到添加BusStation视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new BusStation());
		return "BusStation_add";
	}

	/*客户端ajax方式提交添加站点信息信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated BusStation busStation, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        busStationService.addBusStation(busStation);
        message = "站点信息添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询站点信息信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String stationName,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (stationName == null) stationName = "";
		if(rows != 0)busStationService.setRows(rows);
		List<BusStation> busStationList = busStationService.queryBusStation(stationName, page);
	    /*计算总的页数和总的记录数*/
	    busStationService.queryTotalPageAndRecordNumber(stationName);
	    /*获取到总的页码数目*/
	    int totalPage = busStationService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = busStationService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(BusStation busStation:busStationList) {
			JSONObject jsonBusStation = busStation.getJsonObject();
			jsonArray.put(jsonBusStation);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询站点信息信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<BusStation> busStationList = busStationService.queryAllBusStation();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(BusStation busStation:busStationList) {
			JSONObject jsonBusStation = new JSONObject();
			jsonBusStation.accumulate("stationId", busStation.getStationId());
			jsonBusStation.accumulate("stationName", busStation.getStationName());
			jsonArray.put(jsonBusStation);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询站点信息信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String stationName,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (stationName == null) stationName = "";
		List<BusStation> busStationList = busStationService.queryBusStation(stationName, currentPage);
	    /*计算总的页数和总的记录数*/
	    busStationService.queryTotalPageAndRecordNumber(stationName);
	    /*获取到总的页码数目*/
	    int totalPage = busStationService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = busStationService.getRecordNumber();
	    request.setAttribute("busStationList",  busStationList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("stationName", stationName);
		return "BusStation/busStation_frontquery_result"; 
	}

     /*前台查询BusStation信息*/
	@RequestMapping(value="/{stationId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer stationId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键stationId获取BusStation对象*/
        BusStation busStation = busStationService.getBusStation(stationId);

        request.setAttribute("busStation",  busStation);
        return "BusStation/busStation_frontshow";
	}

	/*ajax方式显示站点信息修改jsp视图页*/
	@RequestMapping(value="/{stationId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer stationId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键stationId获取BusStation对象*/
        BusStation busStation = busStationService.getBusStation(stationId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonBusStation = busStation.getJsonObject();
		out.println(jsonBusStation.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新站点信息信息*/
	@RequestMapping(value = "/{stationId}/update", method = RequestMethod.POST)
	public void update(@Validated BusStation busStation, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			busStationService.updateBusStation(busStation);
			message = "站点信息更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "站点信息更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除站点信息信息*/
	@RequestMapping(value="/{stationId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer stationId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  busStationService.deleteBusStation(stationId);
	            request.setAttribute("message", "站点信息删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "站点信息删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条站点信息记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String stationIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = busStationService.deleteBusStations(stationIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出站点信息信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String stationName, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(stationName == null) stationName = "";
        List<BusStation> busStationList = busStationService.queryBusStation(stationName);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "BusStation信息记录"; 
        String[] headers = { "记录编号","站点名称","经度","纬度"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<busStationList.size();i++) {
        	BusStation busStation = busStationList.get(i); 
        	dataset.add(new String[]{busStation.getStationId() + "",busStation.getStationName(),busStation.getLongitude() + "",busStation.getLatitude() + ""});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"BusStation.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
