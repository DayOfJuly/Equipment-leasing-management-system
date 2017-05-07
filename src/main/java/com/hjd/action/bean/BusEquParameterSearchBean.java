package com.hjd.action.bean;

import com.hjd.base.IFPageRequest;

public class BusEquParameterSearchBean extends IFPageRequest {
	
	/**
	 * 设备参数的ID
	 */
	private Long parameterId;
	
	/**
	 * 设备参数的类型，1：品牌，2：生产厂家，3：型号，4：规格
	 */
	private String type;
	
	/**
	 * 设备参数的名称
	 */
	private String name;
	
	/**
	 * 设备参数的状态，0：删除，1：正常
	 */
	private String status;
	
	/**
	 * 设备参数的备注
	 */
	private String note;
	
	/**
	 * 品牌的Logo图片
	 */
	private String logoPic;

	public Long getParameterId() {
		return parameterId;
	}

	public void setParameterId(Long parameterId) {
		this.parameterId = parameterId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getLogoPic() {
		return logoPic;
	}

	public void setLogoPic(String logoPic) {
		this.logoPic = logoPic;
	}

}
