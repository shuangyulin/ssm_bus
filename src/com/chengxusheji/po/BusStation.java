package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class BusStation {
    /*记录编号*/
    private Integer stationId;
    public Integer getStationId(){
        return stationId;
    }
    public void setStationId(Integer stationId){
        this.stationId = stationId;
    }

    /*站点名称*/
    @NotEmpty(message="站点名称不能为空")
    private String stationName;
    public String getStationName() {
        return stationName;
    }
    public void setStationName(String stationName) {
        this.stationName = stationName;
    }

    /*经度*/
    @NotNull(message="必须输入经度")
    private Float longitude;
    public Float getLongitude() {
        return longitude;
    }
    public void setLongitude(Float longitude) {
        this.longitude = longitude;
    }

    /*纬度*/
    @NotNull(message="必须输入纬度")
    private Float latitude;
    public Float getLatitude() {
        return latitude;
    }
    public void setLatitude(Float latitude) {
        this.latitude = latitude;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonBusStation=new JSONObject(); 
		jsonBusStation.accumulate("stationId", this.getStationId());
		jsonBusStation.accumulate("stationName", this.getStationName());
		jsonBusStation.accumulate("longitude", this.getLongitude());
		jsonBusStation.accumulate("latitude", this.getLatitude());
		return jsonBusStation;
    }}