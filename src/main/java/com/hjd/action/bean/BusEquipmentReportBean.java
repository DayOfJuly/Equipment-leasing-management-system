package com.hjd.action.bean;

import com.hjd.base.IFPageRequest;

public class BusEquipmentReportBean extends IFPageRequest {

	private Integer orgFlag;	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	private Long orgPartyId;	//	所属单位/项目id
	private Integer isInclude;	//	是否包含下级单位：1-包含
	private Long equCategoryId;	//	设备分类
	private String equName;	//	设备名称（模糊查询）

	private String orgCode;	//	单位编码

	private Integer equTrsType;	//	资源明细 - 来源：1-自有，2-内租，3-外租，4-外协

	private Integer equRentType;	//	租赁明细 - 业务类型：1-自有，2-局内租，3-外局租，4-外租，5-作废，6-出售

	private String startMonth;	//	起始年月
	private String endMonth;	//	截止年月

	private Integer equPubType;	//	信息发布明细 - 业务类型：1-出租，2-出售，3-求租，4-求购

	private Integer start;	//	从多少条开始取
	private Integer itemCount;	//	取多少条

	public Integer getOrgFlag() {
		return orgFlag;
	}
	public void setOrgFlag(Integer orgFlag) {
		this.orgFlag = orgFlag;
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
	public Long getEquCategoryId() {
		return equCategoryId;
	}
	public void setEquCategoryId(Long equCategoryId) {
		this.equCategoryId = equCategoryId;
	}
	public String getEquName() {
		return equName;
	}
	public void setEquName(String equName) {
		this.equName = equName;
	}
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public Integer getEquTrsType() {
		return equTrsType;
	}
	public void setEquTrsType(Integer equTrsType) {
		this.equTrsType = equTrsType;
	}
	public Integer getEquRentType() {
		return equRentType;
	}
	public void setEquRentType(Integer equRentType) {
		this.equRentType = equRentType;
	}
	public String getStartMonth() {
		return startMonth;
	}
	public void setStartMonth(String startMonth) {
		this.startMonth = startMonth;
	}
	public String getEndMonth() {
		return endMonth;
	}
	public void setEndMonth(String endMonth) {
		this.endMonth = endMonth;
	}
	public Integer getEquPubType() {
		return equPubType;
	}
	public void setEquPubType(Integer equPubType) {
		this.equPubType = equPubType;
	}
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getItemCount() {
		return itemCount;
	}
	public void setItemCount(Integer itemCount) {
		this.itemCount = itemCount;
	}

}
