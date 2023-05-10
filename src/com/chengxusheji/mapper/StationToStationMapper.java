package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.StationToStation;

public interface StationToStationMapper {
	/*添加站站查询信息*/
	public void addStationToStation(StationToStation stationToStation) throws Exception;

	/*按照查询条件分页查询站站查询记录*/
	public ArrayList<StationToStation> queryStationToStation(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有站站查询记录*/
	public ArrayList<StationToStation> queryStationToStationList(@Param("where") String where) throws Exception;

	/*按照查询条件的站站查询记录数*/
	public int queryStationToStationCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条站站查询记录*/
	public StationToStation getStationToStation(int id) throws Exception;

	/*更新站站查询记录*/
	public void updateStationToStation(StationToStation stationToStation) throws Exception;

	/*删除站站查询记录*/
	public void deleteStationToStation(int id) throws Exception;

}
