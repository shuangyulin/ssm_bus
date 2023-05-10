package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.BusStation;
import com.chengxusheji.po.BusStation;
import com.chengxusheji.po.StationToStation;

import com.chengxusheji.mapper.StationToStationMapper;
@Service
public class StationToStationService {

	@Resource StationToStationMapper stationToStationMapper;
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

    /*添加站站查询记录*/
    public void addStationToStation(StationToStation stationToStation) throws Exception {
    	stationToStationMapper.addStationToStation(stationToStation);
    }

    /*按照查询条件分页查询站站查询记录*/
    public ArrayList<StationToStation> queryStationToStation(BusStation startStation,BusStation endStation,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != startStation && startStation.getStationId()!= null && startStation.getStationId()!= 0)  where += " and t_stationToStation.startStation=" + startStation.getStationId();
    	if(null != endStation && endStation.getStationId()!= null && endStation.getStationId()!= 0)  where += " and t_stationToStation.endStation=" + endStation.getStationId();
    	int startIndex = (currentPage-1) * this.rows;
    	return stationToStationMapper.queryStationToStation(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<StationToStation> queryStationToStation(BusStation startStation,BusStation endStation) throws Exception  { 
     	String where = "where 1=1";
    	if(null != startStation && startStation.getStationId()!= null && startStation.getStationId()!= 0)  where += " and t_stationToStation.startStation=" + startStation.getStationId();
    	if(null != endStation && endStation.getStationId()!= null && endStation.getStationId()!= 0)  where += " and t_stationToStation.endStation=" + endStation.getStationId();
    	return stationToStationMapper.queryStationToStationList(where);
    }

    /*查询所有站站查询记录*/
    public ArrayList<StationToStation> queryAllStationToStation()  throws Exception {
        return stationToStationMapper.queryStationToStationList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(BusStation startStation,BusStation endStation) throws Exception {
     	String where = "where 1=1";
    	if(null != startStation && startStation.getStationId()!= null && startStation.getStationId()!= 0)  where += " and t_stationToStation.startStation=" + startStation.getStationId();
    	if(null != endStation && endStation.getStationId()!= null && endStation.getStationId()!= 0)  where += " and t_stationToStation.endStation=" + endStation.getStationId();
        recordNumber = stationToStationMapper.queryStationToStationCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取站站查询记录*/
    public StationToStation getStationToStation(int id) throws Exception  {
        StationToStation stationToStation = stationToStationMapper.getStationToStation(id);
        return stationToStation;
    }

    /*更新站站查询记录*/
    public void updateStationToStation(StationToStation stationToStation) throws Exception {
        stationToStationMapper.updateStationToStation(stationToStation);
    }

    /*删除一条站站查询记录*/
    public void deleteStationToStation (int id) throws Exception {
        stationToStationMapper.deleteStationToStation(id);
    }

    /*删除多条站站查询信息*/
    public int deleteStationToStations (String ids) throws Exception {
    	String _ids[] = ids.split(",");
    	for(String _id: _ids) {
    		stationToStationMapper.deleteStationToStation(Integer.parseInt(_id));
    	}
    	return _ids.length;
    }
}
