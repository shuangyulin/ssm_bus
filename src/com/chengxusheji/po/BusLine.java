package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class BusLine {
    /*记录编号*/
    private Integer lineId;
    public Integer getLineId(){
        return lineId;
    }
    public void setLineId(Integer lineId){
        this.lineId = lineId;
    }

    /*线路名称*/
    @NotEmpty(message="线路名称不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*起点站*/
    private BusStation startStation;
    public BusStation getStartStation() {
        return startStation;
    }
    public void setStartStation(BusStation startStation) {
        this.startStation = startStation;
    }

    /*终到站*/
    private BusStation endStation;
    public BusStation getEndStation() {
        return endStation;
    }
    public void setEndStation(BusStation endStation) {
        this.endStation = endStation;
    }

    /*首班车时间*/
    @NotEmpty(message="首班车时间不能为空")
    private String startTime;
    public String getStartTime() {
        return startTime;
    }
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    /*末班车时间*/
    @NotEmpty(message="末班车时间不能为空")
    private String endTime;
    public String getEndTime() {
        return endTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    /*所属公司*/
    @NotEmpty(message="所属公司不能为空")
    private String company;
    public String getCompany() {
        return company;
    }
    public void setCompany(String company) {
        this.company = company;
    }

    /*途径站点*/
    @NotEmpty(message="途径站点不能为空")
    private String tjzd;
    public String getTjzd() {
        return tjzd;
    }
    public void setTjzd(String tjzd) {
        this.tjzd = tjzd;
    }

    /*地图线路坐标*/
    @NotEmpty(message="地图线路坐标不能为空")
    private String polylinePoints;
    public String getPolylinePoints() {
        return polylinePoints;
    }
    public void setPolylinePoints(String polylinePoints) {
        this.polylinePoints = polylinePoints;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonBusLine=new JSONObject(); 
		jsonBusLine.accumulate("lineId", this.getLineId());
		jsonBusLine.accumulate("name", this.getName());
		jsonBusLine.accumulate("startStation", this.getStartStation().getStationName());
		jsonBusLine.accumulate("startStationPri", this.getStartStation().getStationId());
		jsonBusLine.accumulate("endStation", this.getEndStation().getStationName());
		jsonBusLine.accumulate("endStationPri", this.getEndStation().getStationId());
		jsonBusLine.accumulate("startTime", this.getStartTime());
		jsonBusLine.accumulate("endTime", this.getEndTime());
		jsonBusLine.accumulate("company", this.getCompany());
		jsonBusLine.accumulate("tjzd", this.getTjzd());
		jsonBusLine.accumulate("polylinePoints", this.getPolylinePoints());
		return jsonBusLine;
    }}