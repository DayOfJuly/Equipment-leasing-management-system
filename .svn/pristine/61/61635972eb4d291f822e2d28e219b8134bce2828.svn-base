package com.hjd.action.bean;

import java.math.BigDecimal;
import java.util.Date;

import com.hjd.base.BeanAbs;

public class BusRentHistBeanTemp extends BeanAbs{
	
	private Long id;//租赁费登记的ID 0 rent

	private String depName;//使用单位 0 rent
	
	private BigDecimal rent;//租赁费  1
	
	private BigDecimal rentCount;//租期数量 1 
	
	private String note;//备注 1
	 
	private Integer rentType;//租期单位 1
	
	private  BigDecimal amount;//结算金额 1
	
	private BigDecimal cost;//进出场费/安拆费 1
	
	private BigDecimal deductCost;//折扣费 1
	
	private String month;//登记月份 0
	
	private Long operator;//操作人 0
	
	private Date operateDate;//操作时间 0
	
	private Long equipmentId;//租赁的设备 1
	
	private String startEndDate;//起止时间 1
	
	private Integer regFlag;//登记标识 0： 代表拥有者登记的 1：代表使用者登记的
	
	private Long equAtOrgId;//设备所在	/属单位的ID
	
	private String equAtOrgCode;//设备所在/属单位的CODE
	
	private String equAtOrgName;//设备所在/属单位的名称
	
	/**
	 * 用于记录设备的拥有单位或者使用单位
	 * 1：拥有者，记录设备的拥有单位，有局、处、项目，处可能存在为空的时候
	 * 2：使用者，记录设备的使用单位，也有局、处、项目，三者都可能为空，但是当使用者的单位是在系统中有注册的话，局级单位不会是空的
	 */
	private Long bureauOrgPartyId;	//	资源所属/在局级单位ID
	private Long sonOrgPartyId;	//	资源所属/在子公司ID
	private Long proOrgPartyId;	//	资源所属/在项目ID

	public String getEquAtOrgName() {
		return equAtOrgName;
	}

	public void setEquAtOrgName(String equAtOrgName) {
		this.equAtOrgName = equAtOrgName;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
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

	public Long getOperator() {
		return operator;
	}

	public void setOperator(Long operator) {
		this.operator = operator;
	}

	public Date getOperateDate() {
		return operateDate;
	}

	public void setOperateDate(Date operateDate) {
		this.operateDate = operateDate;
	}

	public Long getEquipmentId() {
		return equipmentId;
	}

	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}

	public String getStartEndDate() {
		return startEndDate;
	}

	public void setStartEndDate(String startEndDate) {
		this.startEndDate = startEndDate;
	}

	public Integer getRegFlag() {
		return regFlag;
	}

	public void setRegFlag(Integer regFlag) {
		this.regFlag = regFlag;
	}

	public Long getEquAtOrgId() {
		return equAtOrgId;
	}

	public void setEquAtOrgId(Long equAtOrgId) {
		this.equAtOrgId = equAtOrgId;
	}

	public String getEquAtOrgCode() {
		return equAtOrgCode;
	}

	public void setEquAtOrgCode(String equAtOrgCode) {
		this.equAtOrgCode = equAtOrgCode;
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
