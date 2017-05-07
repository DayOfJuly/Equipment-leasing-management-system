package com.hjd.domain;

import java.math.BigDecimal;
import java.util.Date;

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
@Table(name="bus_rent_hist")
@Inheritance(strategy=InheritanceType.JOINED)	//	指定一对一继承关系映射的关联方式
public class BusRentHistTable implements IDomainBase {

	private static final long serialVersionUID = 3283351368423824792L;

	@Transient
	public Object getObjectId() {return this.id;}

	@Id
	@Column(name="id", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;//租赁费登记的ID

	private String depName;//使用单位
	
	private BigDecimal rent;//租赁单价
	
	private BigDecimal rentCount;//租期数量
	
	private String note;//备注
	
	private Integer rentType;//租期单位
	
	private BigDecimal amount;//结算金额
	
	private BigDecimal cost;//进出场费/安拆费
	
	private BigDecimal deductCost;//折扣费
	
	private String month;//登记月份
	
	private Long operator;//操作人
	
	private Date operateDate;//操作时间
	
	private Long equipmentId;//租赁的设备
	
	private String startEndDate;//起止时间
	
	private Integer regFlag;//登记标识 0： 代表拥有者登记的 1：代表使用者登记的

	private Long equAtOrgId;//设备所在/属单位的ID
	
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
	
	
	
	public Integer getManualFlag() {
		return manualFlag;
	}

	public void setManualFlag(Integer manualFlag) {
		this.manualFlag = manualFlag;
	}

	private Integer manualFlag;//跑批标识，0 非跑批插入的数据，1 跑批程序插入的数据
	
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

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public BigDecimal getRentCount() {
		return rentCount;
	}

	public void setRentCount(BigDecimal rentCount) {
		this.rentCount = rentCount;
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

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
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

	public String getEquAtOrgName() {
		return equAtOrgName;
	}

	public void setEquAtOrgName(String equAtOrgName) {
		this.equAtOrgName = equAtOrgName;
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