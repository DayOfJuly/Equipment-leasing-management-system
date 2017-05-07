package com.hjd.action.bean;

import com.hjd.base.IFPageRequest;

public class PartyOrgSearchBean extends IFPageRequest {

	/**
	 * 类型：4-企业，5-部门
	 */
	private Integer parTypeId;
	
	/**
	 * 企业编号/（企业名称/部门名称）（非必输）
	 */
	private String fuzzyData;
	/**
	 * 企业标识/部门标识
	 * 初始查询时，送当前登录人员的企业标识
	 * 后续查询时，送选中的企业标识/部门标识
	 */
	private Long currOrgId;
	/**
	 * 查询上级标志
	 */
	private Boolean qryParentFlag = false;
	
	/**
	 * 单位编号，用于模糊查询，其下的所有子节点
	 */
	private String orgCode;
	
	/**
	 * 企业名称，用于模糊查询
	 */
	private String orgName;
	
	/**
	 * 是否包含下级单位
	 */
	private Integer isInclude;
	
	/**
	 * 状态：0-启用/2-删除
	 */
	private Integer state;

	/**
	 * 项目标识
	 */
	private Long proId;

	/**
	 * 不含此项目标识
	 */
	private Long nonProId;

	/**
	 * 不含此单位标识
	 */
	private Long nonCurrOrgId;

	public Integer getParTypeId() {
		return parTypeId;
	}

	public void setParTypeId(Integer parTypeId) {
		this.parTypeId = parTypeId;
	}

	public String getFuzzyData() {
		return fuzzyData;
	}

	public void setFuzzyData(String fuzzyData) {
		this.fuzzyData = fuzzyData;
	}

	public Long getCurrOrgId() {
		return currOrgId;
	}

	public void setCurrOrgId(Long currOrgId) {
		this.currOrgId = currOrgId;
	}

	public Boolean getQryParentFlag() {
		return qryParentFlag;
	}

	public void setQryParentFlag(Boolean qryParentFlag) {
		this.qryParentFlag = qryParentFlag;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public Integer getIsInclude() {
		return isInclude;
	}

	public void setIsInclude(Integer isInclude) {
		this.isInclude = isInclude;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Long getProId() {
		return proId;
	}

	public void setProId(Long proId) {
		this.proId = proId;
	}

	public Long getNonProId() {
		return nonProId;
	}

	public void setNonProId(Long nonProId) {
		this.nonProId = nonProId;
	}

	public Long getNonCurrOrgId() {
		return nonCurrOrgId;
	}

	public void setNonCurrOrgId(Long nonCurrOrgId) {
		this.nonCurrOrgId = nonCurrOrgId;
	}

	}
