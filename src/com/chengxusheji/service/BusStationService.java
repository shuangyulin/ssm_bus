package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.BusStation;

import com.chengxusheji.mapper.BusStationMapper;
@Service
public class BusStationService {

	@Resource BusStationMapper busStationMapper;
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

    /*添加站点信息记录*/
    public void addBusStation(BusStation busStation) throws Exception {
    	busStationMapper.addBusStation(busStation);
    }

    /*按照查询条件分页查询站点信息记录*/
    public ArrayList<BusStation> queryBusStation(String stationName,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!stationName.equals("")) where = where + " and t_busStation.stationName like '%" + stationName + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return busStationMapper.queryBusStation(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<BusStation> queryBusStation(String stationName) throws Exception  { 
     	String where = "where 1=1";
    	if(!stationName.equals("")) where = where + " and t_busStation.stationName like '%" + stationName + "%'";
    	return busStationMapper.queryBusStationList(where);
    }

    /*查询所有站点信息记录*/
    public ArrayList<BusStation> queryAllBusStation()  throws Exception {
        return busStationMapper.queryBusStationList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String stationName) throws Exception {
     	String where = "where 1=1";
    	if(!stationName.equals("")) where = where + " and t_busStation.stationName like '%" + stationName + "%'";
        recordNumber = busStationMapper.queryBusStationCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取站点信息记录*/
    public BusStation getBusStation(int stationId) throws Exception  {
        BusStation busStation = busStationMapper.getBusStation(stationId);
        return busStation;
    }

    /*更新站点信息记录*/
    public void updateBusStation(BusStation busStation) throws Exception {
        busStationMapper.updateBusStation(busStation);
    }

    /*删除一条站点信息记录*/
    public void deleteBusStation (int stationId) throws Exception {
        busStationMapper.deleteBusStation(stationId);
    }

    /*删除多条站点信息信息*/
    public int deleteBusStations (String stationIds) throws Exception {
    	String _stationIds[] = stationIds.split(",");
    	for(String _stationId: _stationIds) {
    		busStationMapper.deleteBusStation(Integer.parseInt(_stationId));
    	}
    	return _stationIds.length;
    }
}
