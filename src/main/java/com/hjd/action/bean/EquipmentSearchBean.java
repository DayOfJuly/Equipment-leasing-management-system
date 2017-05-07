package com.hjd.action.bean;

import com.hjd.base.IFPageRequest;

public class EquipmentSearchBean extends IFPageRequest {

	/**
	 * 资源管理查询所用查询参数 begin
	 */
	private Integer orgFlag;	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
	private String orgCode;	//	所属单位/项目code
	private Long orgPartyId;	//	所属单位/项目id
	private Integer isInclude;	//	是否包含下级单位：1-包含
	private Integer equAtOrgFlag;	//	使用单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
	private Long equAtOrgPartyId;	//	使用单位/项目id
    private String equAtOrgName;	//	使用单位名称
    private Integer isCrecOrg;	//	使用单位是否是中铁用户：1-非中铁用户
    private Integer equState;	//	设备状态（''-全部（不包含已出售和已报废）、1-闲置、2-使用中）
    private Integer isSaled;	//	包含已出售：1-包含
    private Integer isScraped;	//	包含已报废：1-包含
	private String equName;	//	设备名称（模糊查询）
	/**
	 * 资源管理查询所用查询参数 end
	 */

    private String orgName;	//	所属单位名称
	private Integer pubState;	//	发布状态
	private Integer equipmentSourceNo;	//	设备来源分类

	private Long partyId;	//	手机客户端的登录没有做好，所以，提供此属性模拟登录后的查询设备信息的功能
	private Integer isProvider;	//	是否是外部供应商

	private Integer pubType;	//	发布类型，当发布出租、出售的信息的时候使用，1：表示出租、2：表示出售
	
	public Integer getOrgFlag() {
		return orgFlag;
	}
	public void setOrgFlag(Integer orgFlag) {
		this.orgFlag = orgFlag;
	}
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public Long getOrgPartyId() {
		return orgPartyId;
	}
	public void setOrgPartyId(Long orgPartyId) {
		this.orgPartyId = orgPartyId;
	}
	public Integer getIsInclude() {
		return isInclude;
	}
	public void setIsInclude(Integer isInclude) {
		this.isInclude = isInclude;
	}
	public Integer getEquAtOrgFlag() {
		return equAtOrgFlag;
	}
	public void setEquAtOrgFlag(Integer equAtOrgFlag) {
		this.equAtOrgFlag = equAtOrgFlag;
	}
	public Long getEquAtOrgPartyId() {
		return equAtOrgPartyId;
	}
	public void setEquAtOrgPartyId(Long equAtOrgPartyId) {
		this.equAtOrgPartyId = equAtOrgPartyId;
	}
	public String getEquAtOrgName() {
		return equAtOrgName;
	}
	public void setEquAtOrgName(String equAtOrgName) {
		this.equAtOrgName = equAtOrgName;
	}
	public Integer getIsCrecOrg() {
		return isCrecOrg;
	}
	public void setIsCrecOrg(Integer isCrecOrg) {
		this.isCrecOrg = isCrecOrg;
	}
	public Integer getEquState() {
		return equState;
	}
	public void setEquState(Integer equState) {
		this.equState = equState;
	}
	public Integer getIsSaled() {
		return isSaled;
	}
	public void setIsSaled(Integer isSaled) {
		this.isSaled = isSaled;
	}
	public Integer getIsScraped() {
		return isScraped;
	}
	public void setIsScraped(Integer isScraped) {
		this.isScraped = isScraped;
	}
	public String getEquName() {
		return equName;
	}
	public void setEquName(String equName) {
		this.equName = equName;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public Integer getPubState() {
		return pubState;
	}
	public void setPubState(Integer pubState) {
		this.pubState = pubState;
	}
	public Integer getEquipmentSourceNo() {
		return equipmentSourceNo;
	}
	public void setEquipmentSourceNo(Integer equipmentSourceNo) {
		this.equipmentSourceNo = equipmentSourceNo;
	}
	public Long getPartyId() {
		return partyId;
	}
	public void setPartyId(Long partyId) {
		this.partyId = partyId;
	}
	public Integer getIsProvider() {
		return isProvider;
	}
	public void setIsProvider(Integer isProvider) {
		this.isProvider = isProvider;
	}
	public Integer getPubType() {
		return pubType;
	}
	public void setPubType(Integer pubType) {
		this.pubType = pubType;
	}

}
