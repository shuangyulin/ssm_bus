package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.BusStation;
import com.chengxusheji.po.BusStation;
import com.chengxusheji.po.BusLine;

import com.chengxusheji.mapper.BusLineMapper;
@Service
public class BusLineService {

	@Resource BusLineMapper busLineMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加公交线路记录*/
    public void addBusLine(BusLine busLine) throws Exception {
    	busLineMapper.addBusLine(busLine);
    }

    /*按照查询条件分页查询公交线路记录*/
    public ArrayList<BusLine> queryBusLine(String name,BusStation startStation,BusStation endStation,String company,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!name.equals("")) where = where + " and t_busLine.name like '%" + name + "%'";
    	if(null != startStation && startStation.getStationId()!= null && startStation.getStationId()!= 0)  where += " and t_busLine.startStation=" + startStation.getStationId();
    	if(null != endStation && endStation.getStationId()!= null && endStation.getStationId()!= 0)  where += " and t_busLine.endStation=" + endStation.getStationId();
    	if(!company.equals("")) where = where + " and t_busLine.company like '%" + company + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return busLineMapper.queryBusLine(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<BusLine> queryBusLine(String name,BusStation startStation,BusStation endStation,String company) throws Exception  { 
     	String where = "where 1=1";
    	if(!name.equals("")) where = where + " and t_busLine.name like '%" + name + "%'";
    	if(null != startStation && startStation.getStationId()!= null && startStation.getStationId()!= 0)  where += " and t_busLine.startStation=" + startStation.getStationId();
    	if(null != endStation && endStation.getStationId()!= null && endStation.getStationId()!= 0)  where += " and t_busLine.endStation=" + endStation.getStationId();
    	if(!company.equals("")) where = where + " and t_busLine.company like '%" + company + "%'";
    	return busLineMapper.queryBusLineList(where);
    }

    /*查询所有公交线路记录*/
    public ArrayList<BusLine> queryAllBusLine()  throws Exception {
        return busLineMapper.queryBusLineList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String name,BusStation startStation,BusStation endStation,String company) throws Exception {
     	String where = "where 1=1";
    	if(!name.equals("")) where = where + " and t_busLine.name like '%" + name + "%'";
    	if(null != startStation && startStation.getStationId()!= null && startStation.getStationId()!= 0)  where += " and t_busLine.startStation=" + startStation.getStationId();
    	if(null != endStation && endStation.getStationId()!= null && endStation.getStationId()!= 0)  where += " and t_busLine.endStation=" + endStation.getStationId();
    	if(!company.equals("")) where = where + " and t_busLine.company like '%" + company + "%'";
        recordNumber = busLineMapper.queryBusLineCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取公交线路记录*/
    public BusLine getBusLine(int lineId) throws Exception  {
        BusLine busLine = busLineMapper.getBusLine(lineId);
        return busLine;
    }

    /*更新公交线路记录*/
    public void updateBusLine(BusLine busLine) throws Exception {
        busLineMapper.updateBusLine(busLine);
    }

    /*删除一条公交线路记录*/
    public void deleteBusLine (int lineId) throws Exception {
        busLineMapper.deleteBusLine(lineId);
    }

    /*删除多条公交线路信息*/
    public int deleteBusLines (String lineIds) throws Exception {
    	String _lineIds[] = lineIds.split(",");
    	for(String _lineId: _lineIds) {
    		busLineMapper.deleteBusLine(Integer.parseInt(_lineId));
    	}
    	return _lineIds.length;
    }
}
