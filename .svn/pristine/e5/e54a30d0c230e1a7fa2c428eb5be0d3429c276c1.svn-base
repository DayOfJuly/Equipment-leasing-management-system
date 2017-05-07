package com.hjd.domain;

import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="view_rent_info")
public class ViewRentInfo implements IDomainBase {

	private static final long serialVersionUID = 2618694470455417590L;

	@Transient
	public Object getObjectId() {

		return this.rentId;
	}

	@Id
	private Long rentId;	//	租赁id
	private BigDecimal rent;	//	租赁单价
	private Integer rentType;	//	租期单位
	private BigDecimal rentCount;	//	租期数量
	private String month;	//	登记月份
	private Integer regFlag;	//	登记标识：1-使用者
	private Long equipmentId;	//	设备资源id
	private BigDecimal deductCost;	//	结算金额
	private BigDecimal cost;	//	进出场费
	private BigDecimal amount;	//	扣除金额
	/**
	 * 使用局级单位信息
	 */
	private Integer bureauParTypeId;	//	使用局级单位类型
	private Long bureauOrgPartyId;	//	使用局级单位id
	private String bureauOrgCode;	//	使用局级单位编码
	private String bureauOrgName;	//	使用局级单位名称
	/**
	 * 使用处级单位信息
	 */
	private Integer sonParTypeId;	//	使用处级单位类型
	private Long sonOrgPartyId;	//	使用处级单位id
	private String sonOrgCode;	//	使用处级单位编码
	private String sonOrgName;	//	使用处级单位名称
	/**
	 * 使用项目信息
	 */
	private Integer proParTypeId;	//	使用项目类型
	private Long proOrgPartyId;	//	使用项目id
	private String proOrgCode;	//	使用项目编码
	private String proOrgName;	//	使用项目名称

	public Long getRentId() {
		return rentId;
	}
	public void setRentId(Long rentId) {
		this.rentId = rentId;
	}
	public BigDecimal getRent() {
		return rent;
	}
	public void setRent(BigDecimal rent) {
		this.rent = rent;
	}
	public Integer getRentType() {
		return rentType;
	}
	public void setRentType(Integer rentType) {
		this.rentType = rentType;
	}
	public BigDecimal getRentCount() {
		return rentCount;
	}
	public void setRentCount(BigDecimal rentCount) {
		this.rentCount = rentCount;
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
	public BigDecimal getDeductCost() {
		return deductCost;
	}
	public void setDeductCost(BigDecimal deductCost) {
		this.deductCost = deductCost;
	}
	public BigDecimal getCost() {
		return cost;
	}
	public void setCost(BigDecimal cost) {
		this.cost = cost;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public Integer getBureauParTypeId() {
		return bureauParTypeId;
	}
	public void setBureauParTypeId(Integer bureauParTypeId) {
		this.bureauParTypeId = bureauParTypeId;
	}
	public Long getBureauOrgPartyId() {
		return bureauOrgPartyId;
	}
	public void setBureauOrgPartyId(Long bureauOrgPartyId) {
		this.bureauOrgPartyId = bureauOrgPartyId;
	}
	public String getBureauOrgCode() {
		return bureauOrgCode;
	}
	public void setBureauOrgCode(String bureauOrgCode) {
		this.bureauOrgCode = bureauOrgCode;
	}
	public String getBureauOrgName() {
		return bureauOrgName;
	}
	public void setBureauOrgName(String bureauOrgName) {
		this.bureauOrgName = bureauOrgName;
	}
	public Integer getSonParTypeId() {
		return sonParTypeId;
	}
	public void setSonParTypeId(Integer sonParTypeId) {
		this.sonParTypeId = sonParTypeId;
	}
	public Long getSonOrgPartyId() {
		return sonOrgPartyId;
	}
	public void setSonOrgPartyId(Long sonOrgPartyId) {
		this.sonOrgPartyId = sonOrgPartyId;
	}
	public String getSonOrgCode() {
		return sonOrgCode;
	}
	public void setSonOrgCode(String sonOrgCode) {
		this.sonOrgCode = sonOrgCode;
	}
	public String getSonOrgName() {
		return sonOrgName;
	}
	public void setSonOrgName(String sonOrgName) {
		this.sonOrgName = sonOrgName;
	}
	public Integer getProParTypeId() {
		return proParTypeId;
	}
	public void setProParTypeId(Integer proParTypeId) {
		this.proParTypeId = proParTypeId;
	}
	public Long getProOrgPartyId() {
		return proOrgPartyId;
	}
	public void setProOrgPartyId(Long proOrgPartyId) {
		this.proOrgPartyId = proOrgPartyId;
	}
	public String getProOrgCode() {
		return proOrgCode;
	}
	public void setProOrgCode(String proOrgCode) {
		this.proOrgCode = proOrgCode;
	}
	public String getProOrgName() {
		return proOrgName;
	}
	public void setProOrgName(String proOrgName) {
		this.proOrgName = proOrgName;
	}

}
