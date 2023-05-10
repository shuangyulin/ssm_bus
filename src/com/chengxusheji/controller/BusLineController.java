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
import com.chengxusheji.service.BusLineService;
import com.chengxusheji.po.BusLine;
import com.chengxusheji.service.BusStationService;
import com.chengxusheji.po.BusStation;

//BusLine管理控制层
@Controller
@RequestMapping("/BusLine")
public class BusLineController extends BaseController {

    /*业务层对象*/
    @Resource BusLineService busLineService;

    @Resource BusStationService busStationService;
	@InitBinder("startStation")
	public void initBinderstartStation(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("startStation.");
	}
	@InitBinder("endStation")
	public void initBinderendStation(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("endStation.");
	}
	@InitBinder("busLine")
	public void initBinderBusLine(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("busLine.");
	}
	/*跳转到添加BusLine视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new BusLine());
		/*查询所有的BusStation信息*/
		List<BusStation> busStationList = busStationService.queryAllBusStation();
		request.setAttribute("busStationList", busStationList);
		return "BusLine_add";
	}

	/*客户端ajax方式提交添加公交线路信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated BusLine busLine, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        busLineService.addBusLine(busLine);
        message = "公交线路添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询公交线路信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String name,@ModelAttribute("startStation") BusStation startStation,@ModelAttribute("endStation") BusStation endStation,String company,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (name == null) name = "";
		if (company == null) company = "";
		if(rows != 0)busLineService.setRows(rows);
		List<BusLine> busLineList = busLineService.queryBusLine(name, startStation, endStation, company, page);
	    /*计算总的页数和总的记录数*/
	    busLineService.queryTotalPageAndRecordNumber(name, startStation, endStation, company);
	    /*获取到总的页码数目*/
	    int totalPage = busLineService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = busLineService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(BusLine busLine:busLineList) {
			JSONObject jsonBusLine = busLine.getJsonObject();
			jsonArray.put(jsonBusLine);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询公交线路信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<BusLine> busLineList = busLineService.queryAllBusLine();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(BusLine busLine:busLineList) {
			JSONObject jsonBusLine = new JSONObject();
			jsonBusLine.accumulate("lineId", busLine.getLineId());
			jsonBusLine.accumulate("name", busLine.getName());
			jsonArray.put(jsonBusLine);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询公交线路信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String name,@ModelAttribute("startStation") BusStation startStation,@ModelAttribute("endStation") BusStation endStation,String company,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (name == null) name = "";
		if (company == null) company = "";
		List<BusLine> busLineList = busLineService.queryBusLine(name, startStation, endStation, company, currentPage);
	    /*计算总的页数和总的记录数*/
	    busLineService.queryTotalPageAndRecordNumber(name, startStation, endStation, company);
	    /*获取到总的页码数目*/
	    int totalPage = busLineService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = busLineService.getRecordNumber();
	    request.setAttribute("busLineList",  busLineList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("name", name);
	    request.setAttribute("startStation", startStation);
	    request.setAttribute("endStation", endStation);
	    request.setAttribute("company", company);
	    List<BusStation> busStationList = busStationService.queryAllBusStation();
	    request.setAttribute("busStationList", busStationList);
		return "BusLine/busLine_frontquery_result"; 
	}

     /*前台查询BusLine信息*/
	@RequestMapping(value="/{lineId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer lineId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键lineId获取BusLine对象*/
        BusLine busLine = busLineService.getBusLine(lineId);

        List<BusStation> busStationList = busStationService.queryAllBusStation();
        request.setAttribute("busStationList", busStationList);
        request.setAttribute("busLine",  busLine);
        return "BusLine/busLine_frontshow";
	}

	/*ajax方式显示公交线路修改jsp视图页*/
	@RequestMapping(value="/{lineId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer lineId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键lineId获取BusLine对象*/
        BusLine busLine = busLineService.getBusLine(lineId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonBusLine = busLine.getJsonObject();
		out.println(jsonBusLine.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新公交线路信息*/
	@RequestMapping(value = "/{lineId}/update", method = RequestMethod.POST)
	public void update(@Validated BusLine busLine, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			busLineService.updateBusLine(busLine);
			message = "公交线路更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "公交线路更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除公交线路信息*/
	@RequestMapping(value="/{lineId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer lineId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  busLineService.deleteBusLine(lineId);
	            request.setAttribute("message", "公交线路删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "公交线路删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条公交线路记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String lineIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = busLineService.deleteBusLines(lineIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出公交线路信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String name,@ModelAttribute("startStation") BusStation startStation,@ModelAttribute("endStation") BusStation endStation,String company, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(name == null) name = "";
        if(company == null) company = "";
        List<BusLine> busLineList = busLineService.queryBusLine(name,startStation,endStation,company);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "BusLine信息记录"; 
        String[] headers = { "线路名称","起点站","终到站","首班车时间","末班车时间","所属公司"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<busLineList.size();i++) {
        	BusLine busLine = busLineList.get(i); 
        	dataset.add(new String[]{busLine.getName(),busLine.getStartStation().getStationName(),busLine.getEndStation().getStationName(),busLine.getStartTime(),busLine.getEndTime(),busLine.getCompany()});
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
			response.setHeader("Content-disposition","attachment; filename="+"BusLine.xls");//filename是下载的xls的名，建议最好用英文 
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
