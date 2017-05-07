package com.hjd.domain;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="par_org")
@PrimaryKeyJoinColumn(name="partyId")
public class PartyOrg extends Party implements IDomainBase {

	private static final long serialVersionUID = 4959640369507968739L;

	@Column(columnDefinition="number(10,2) default 0 ", nullable=false)
	private BigDecimal budget;

	private String code;
	private String name;
	private String offAddr;//也用于存储项目的详细地址
	private String zip;
	private String phone;
	private String fax;
	private Integer type;
	private String contacts;//也用于存储项目的负责人
	private String contactsMobile;//也用于存储项目的联系电话
	private String contactsEmail;
	private Integer orgLevel;
	private String parentCode;
	
	/**
	 * 新增字段
	 * 项目的所在城市（省、市、县）”为必填项，将所在城市分成了三个字段
	 */
	private Long atProvince;//省
	private String atProvinceName;
	private Long atCity;//市
	private String atCityName;
	private Long atDistrict;//区
	private String atDistrictName;
	
	public PartyOrg() {
		
		}

	public PartyOrg(Long partyId) {

		super(partyId);
		}

	public BigDecimal getBudget() {
		return budget;
	}

	public void setBudget(BigDecimal budget) {
		this.budget = budget;
	}

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

	public String getContactsEmail() {
		return contactsEmail;
	}

	public void setContactsEmail(String contactsEmail) {
		this.contactsEmail = contactsEmail;
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

	}
