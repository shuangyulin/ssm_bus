package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class StationToStation {
    /*记录编号*/
    private Integer id;
    public Integer getId(){
        return id;
    }
    public void setId(Integer id){
        this.id = id;
    }

    /*起始站*/
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

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonStationToStation=new JSONObject(); 
		jsonStationToStation.accumulate("id", this.getId());
		jsonStationToStation.accumulate("startStation", this.getStartStation().getStationName());
		jsonStationToStation.accumulate("startStationPri", this.getStartStation().getStationId());
		jsonStationToStation.accumulate("endStation", this.getEndStation().getStationName());
		jsonStationToStation.accumulate("endStationPri", this.getEndStation().getStationId());
		return jsonStationToStation;
    }}