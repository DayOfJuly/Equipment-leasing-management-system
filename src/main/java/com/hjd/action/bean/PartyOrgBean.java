package com.hjd.action.bean;

import java.math.BigDecimal;

import com.hjd.base.BeanAbs;

public class PartyOrgBean extends BeanAbs {

	/**
	 * 企业编号
	 */
	private String code;
	/**
	 * 企业名称/部门名称
	 */
	private String name;
	/**
	 * 组织级别
	 */
	private Integer orgLevel;
	/**
	 * 上级单位编号
	 */
	private String parentCode;
	/**
	 * 备注
	 */
	private String note;
	/**
	 * 上级企业标识/上级部门标识
	 */
	private Long parentOrgId;
	
	
	/**
	 * 类型：4-企业，5-部门
	 */
	private Integer parTypeId;
	/**
	 * 行政地区标识
	 */
	private Long regionId;
	/**
	 * 报销预算（元）
	 */
	private BigDecimal budget;
	/**
	 * 办公地址
	 */
	private String offAddr;
	/**
	 * 邮编
	 */
	private String zip;
	/**
	 * 联系电话
	 */
	private String phone;
	/**
	 * 传真
	 */
	private String fax;
	/**
	 * 部门性质
	 */
	private Integer type;
	/**
	 * 企业标识/部门标识
	 */
	private Long partyId;
	
	
	
	
	private Long atProvince;//省
	private String atProvinceName;
	private Long atCity;//市
	private String atCityName;
	private Long atDistrict;//区
	private String atDistrictName;
	private String contacts;//也用于存储项目的负责人
	private String contactsMobile;//也用于存储项目的联系电话

	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getOrgLevel() {
		return orgLevel;
	}
	public void setOrgLevel(Integer orgLevel) {
		this.orgLevel = orgLevel;
	}
	public String getParentCode() {
		return parentCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Long getParentOrgId() {
		return parentOrgId;
	}
	public void setParentOrgId(Long parentOrgId) {
		this.parentOrgId = parentOrgId;
	}
	public Integer getParTypeId() {
		return parTypeId;
	}
	public void setParTypeId(Integer parTypeId) {
		this.parTypeId = parTypeId;
	}
	public Long getRegionId() {
		return regionId;
	}
	public void setRegionId(Long regionId) {
		this.regionId = regionId;
	}
	public BigDecimal getBudget() {
		return budget;
	}
	public void setBudget(BigDecimal budget) {
		this.budget = budget;
	}
	public String getOffAddr() {
		return offAddr;
	}
	public void setOffAddr(String offAddr) {
		this.offAddr = offAddr;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Long getPartyId() {
		return partyId;
	}
	public void setPartyId(Long partyId) {
		this.partyId = partyId;
	}
	public Long getAtProvince() {
		return atProvince;
	}
	public void setAtProvince(Long atProvince) {
		this.atProvince = atProvince;
	}
	public String getAtProvinceName() {
		return atProvinceName;
	}
	public void setAtProvinceName(String atProvinceName) {
		this.atProvinceName = atProvinceName;
	}
	public Long getAtCity() {
		return atCity;
	}
	public void setAtCity(Long atCity) {
		this.atCity = atCity;
	}
	public String getAtCityName() {
		return atCityName;
	}
	public void setAtCityName(String atCityName) {
		this.atCityName = atCityName;
	}
	public Long getAtDistrict() {
		return atDistrict;
	}
	public void setAtDistrict(Long atDistrict) {
		this.atDistrict = atDistrict;
	}
	public String getAtDistrictName() {
		return atDistrictName;
	}
	public void setAtDistrictName(String atDistrictName) {
		this.atDistrictName = atDistrictName;
	}
	public String getContacts() {
		return contacts;
	}
	public void setContacts(String contacts) {
		this.contacts = contacts;
	}
	public String getContactsMobile() {
		return contactsMobile;
	}
	public void setContactsMobile(String contactsMobile) {
		this.contactsMobile = contactsMobile;
	}

	}
