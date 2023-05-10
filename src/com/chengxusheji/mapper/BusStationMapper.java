package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.BusStation;

public interface BusStationMapper {
	/*添加站点信息信息*/
	public void addBusStation(BusStation busStation) throws Exception;

	/*按照查询条件分页查询站点信息记录*/
	public ArrayList<BusStation> queryBusStation(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有站点信息记录*/
	public ArrayList<BusStation> queryBusStationList(@Param("where") String where) throws Exception;

	/*按照查询条件的站点信息记录数*/
	public int queryBusStationCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条站点信息记录*/
	public BusStation getBusStation(int stationId) throws Exception;

	/*更新站点信息记录*/
	public void updateBusStation(BusStation busStation) throws Exception;

	/*删除站点信息记录*/
	public void deleteBusStation(int stationId) throws Exception;

}
