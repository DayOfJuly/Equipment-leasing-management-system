package com.hjd.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 创建视图的注意之处：
 * 1：当成一个单表，仅进行查询的操作
 * 2：MYSQL数据库不区分大小写
 * 3：创建对应的视图对象的时候有主键的概念，注意时间类型、浮点类型的数据需要特殊的说明一下，属性和字段名一致时不需要特殊的匹配说明，否则需要指定匹配的规则
 * @author Qian
 *
 */
@Entity
@Table(name="view_rent_hist_user")
public class ViewRentHistUser implements Serializable {

	private static final long serialVersionUID = 3283351368423824792L;
	
	//租赁费的信息
	 @Id
	private Long id;//租赁费登记的ID
	private String startEndDate;//起止时间	  
	private BigDecimal rent;//租赁单价
	private BigDecimal rentCount;//租期数量
	private String note;//备注
	private Integer rentType;//租期单位
	private BigDecimal amount;//结算金额
	private BigDecimal cost;//进出场费/安拆费
	private BigDecimal deductCost;//折扣费
	private String month;//登记月份
	private Integer regFlag;//登记标识 0： 代表拥有者登记的 1：代表使用者登记的
	
	//设备的信息
	private Long equipmentId;//租赁的设备
	private String equNo;//设备编号
	private String EquName;//设备名称
	private String brandName;//品牌名称
	private String licenseNo;//牌照号码
	private String models;//型号
	
	//设备所在单位的信息
//	private Long equAtOrgId;//设备所在/属单位的ID
//	private String equAtOrgCode;//设备所在/属单位的CODE
//	private String equAtOrgName;//设备所在/属单位的名称
	
	/**
	 * 设备所属/在局级单位信息
	 */
	private Integer bureauOrgParTypeId;
	private Long bureauOrgPartyId;

	/**
	 * 设备所属/在处级单位信息
	 */
	private Long sonOrgPartyId;
	/**
	 * 设备所属/在项目信息
	 */
	private Long  proOrgPartyId ;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getStartEndDate() {
		return startEndDate;
	}
	public void setStartEndDate(String startEndDate) {
		this.startEndDate = startEndDate;
	}
	public BigDecimal getRent() {
		return rent;
	}
	public void setRent(BigDecimal rent) {
		this.rent = rent;
	}
	public BigDecimal getRentCount() {
		return rentCount;
	}
	public void setRentCount(BigDecimal rentCount) {
		this.rentCount = rentCount;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Integer getRentType() {
		return rentType;
	}
	public void setRentType(Integer rentType) {
		this.rentType = rentType;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public BigDecimal getCost() {
		return cost;
	}
	public void setCost(BigDecimal cost) {
		this.cost = cost;
	}
	public BigDecimal getDeductCost() {
		return deductCost;
	}
	public void setDeductCost(BigDecimal deductCost) {
		this.deductCost = deductCost;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public Integer getRegFlag() {
		return regFlag;
	}
	public void setRegFlag(Integer regFlag) {
		this.regFlag = regFlag;
	}
	public Long getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}
	public String getEquNo() {
		return equNo;
	}
	public void setEquNo(String equNo) {
		this.equNo = equNo;
	}
	public String getEquName() {
		return EquName;
	}
	public void setEquName(String equName) {
		EquName = equName;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public String getLicenseNo() {
		return licenseNo;
	}
	public void setLicenseNo(String licenseNo) {
		this.licenseNo = licenseNo;
	}
	public String getModels() {
		return models;
	}
	public void setModels(String models) {
		this.models = models;
	}
//	public Long getEquAtOrgId() {
//		return equAtOrgId;
//	}
//	public void setEquAtOrgId(Long equAtOrgId) {
//		this.equAtOrgId = equAtOrgId;
//	}
//	public String getEquAtOrgCode() {
//		return equAtOrgCode;
//	}
//	public void setEquAtOrgCode(String equAtOrgCode) {
//		this.equAtOrgCode = equAtOrgCode;
//	}
//	public String getEquAtOrgName() {
//		return equAtOrgName;
//	}
//	public void setEquAtOrgName(String equAtOrgName) {
//		this.equAtOrgName = equAtOrgName;
//	}
	public Integer getBureauOrgParTypeId() {
		return bureauOrgParTypeId;
	}
	public void setBureauOrgParTypeId(Integer bureauOrgParTypeId) {
		this.bureauOrgParTypeId = bureauOrgParTypeId;
	}
	public Long getBureauOrgPartyId() {
		return bureauOrgPartyId;
	}
	public void setBureauOrgPartyId(Long bureauOrgPartyId) {
		this.bureauOrgPartyId = bureauOrgPartyId;
	}
	public Long getSonOrgPartyId() {
		return sonOrgPartyId;
	}
	public void setSonOrgPartyId(Long sonOrgPartyId) {
		this.sonOrgPartyId = sonOrgPartyId;
	}
	public Long getProOrgPartyId() {
		return proOrgPartyId;
	}
	public void setProOrgPartyId(Long proOrgPartyId) {
		this.proOrgPartyId = proOrgPartyId;
	}

	
}