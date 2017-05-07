package com.hjd.action.bean;

import java.math.BigDecimal;

import com.hjd.base.BeanAbs;
public class BusPublishHistBean extends BeanAbs{
	
	//发布信息的记录ID
	private Long id;
	
    // 信息发布的ID
    private Long dataId;
    
	//流程状态
	private Integer state;
	
	//业务状态
	private String busState;
	
	//备注
	private String note;
	
	//设备成交单位
	private String depName;
	
	private BigDecimal forecastSum;//预估金额

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getDataId() {
		return dataId;
	}

	public void setDataId(Long dataId) {
		this.dataId = dataId;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getBusState() {
		return busState;
	}

	public void setBusState(String busState) {
		this.busState = busState;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public BigDecimal getForecastSum() {
		return forecastSum;
	}

	public void setForecastSum(BigDecimal forecastSum) {
		this.forecastSum = forecastSum;
	}

	}
