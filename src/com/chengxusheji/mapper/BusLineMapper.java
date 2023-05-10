package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.BusLine;

public interface BusLineMapper {
	/*添加公交线路信息*/
	public void addBusLine(BusLine busLine) throws Exception;

	/*按照查询条件分页查询公交线路记录*/
	public ArrayList<BusLine> queryBusLine(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有公交线路记录*/
	public ArrayList<BusLine> queryBusLineList(@Param("where") String where) throws Exception;

	/*按照查询条件的公交线路记录数*/
	public int queryBusLineCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条公交线路记录*/
	public BusLine getBusLine(int lineId) throws Exception;

	/*更新公交线路记录*/
	public void updateBusLine(BusLine busLine) throws Exception;

	/*删除公交线路记录*/
	public void deleteBusLine(int lineId) throws Exception;

}
