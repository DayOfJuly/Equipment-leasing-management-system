package com.hjd.domain;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="par_contact_info")
@Inheritance(strategy=InheritanceType.JOINED)	//	指定一对一继承关系映射的关联方式
public class ParContactInfoTable implements IDomainBase {

	private static final long serialVersionUID = 3283351368423824792L;

	@Transient
	public Object getObjectId() {return this.contactId;}

	@Id
	@Column(name="contactId", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long contactId;//联系人记录ID
	
	private Long atCity;//所在城市
	
	/*将所在城市分成了三个字段*/
	private String onProvince;//省
	private Long onProvinceId;//省id
	private String onCity;//市
	private Long onCityId;//市id
	private String onDistrict;//区
	private Long onDistrictId;//区id
	
	private Long partyId;//联系人信息所属的供应商
	
	private String address;//详细地址
	
	private String partyName;//单位名称--联系单位
	
	private String name;//联系人
	
	private String tel;//联系电话
	
	private String qq;//qq
	
	private Integer defConFlag;//默认联系人标识，只能有一个默认的联系人标识

	public Long getContactId() {
		return contactId;
	}

	public void setContactId(Long contactId) {
		this.contactId = contactId;
	}

	public Long getAtCity() {
		return atCity;
	}

	public void setAtCity(Long atCity) {
		this.atCity = atCity;
	}

	public String getOnProvince() {
		return onProvince;
	}

	public void setOnProvince(String onProvince) {
		this.onProvince = onProvince;
	}

	public Long getOnProvinceId() {
		return onProvinceId;
	}

	public void setOnProvinceId(Long onProvinceId) {
		this.onProvinceId = onProvinceId;
	}

	public String getOnCity() {
		return onCity;
	}

	public void setOnCity(String onCity) {
		this.onCity = onCity;
	}

	public Long getOnCityId() {
		return onCityId;
	}

	public void setOnCityId(Long onCityId) {
		this.onCityId = onCityId;
	}

	public String getOnDistrict() {
		return onDistrict;
	}

	public void setOnDistrict(String onDistrict) {
		this.onDistrict = onDistrict;
	}

	public Long getOnDistrictId() {
		return onDistrictId;
	}

	public void setOnDistrictId(Long onDistrictId) {
		this.onDistrictId = onDistrictId;
	}

	public Long getPartyId() {
		return partyId;
	}

	public void setPartyId(Long partyId) {
		this.partyId = partyId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPartyName() {
		return partyName;
	}

	public void setPartyName(String partyName) {
		this.partyName = partyName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public Integer getDefConFlag() {
		return defConFlag;
	}

	public void setDefConFlag(Integer defConFlag) {
		this.defConFlag = defConFlag;
	}

}