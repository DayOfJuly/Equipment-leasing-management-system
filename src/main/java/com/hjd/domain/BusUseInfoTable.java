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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="bus_use_info")
@Inheritance(strategy=InheritanceType.JOINED)	//	指定一对一继承关系映射的关联方式
public class BusUseInfoTable implements IDomainBase {

		private static final long serialVersionUID = 3283351368423824792L;
	
		@Transient
		public Object getObjectId() {return this.id;}
	
		@Id
		@Column(name="id", unique=true, nullable=false)
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private Long id;//设备使用情况ID
		
		//使用的设备ID
		private Long equipmentId;
		//设备来源分类
		private Integer equipmentSourceNo;
		//设备来源说明
		private String equipmentSourceName;
		//设备状态
		private Integer equState;
		//可出租
		private Integer rentFlag;
		//可出售
		private Integer saleFlag;
		//业务状态
		private Integer busState;
		//发布状态
		private Integer pubState;
		//设备所在单位
	    private Long  equAtOrgId;
		//设备所在单位
	    private String equAtOrgName;
	   //所在城市
		private Integer atCity;
		//详细地址
	    private String address;
	    //保管人
		private String custodian;
		//联系电话
		private String contactPersonPhone;
		//进场日期
		@Column(name = "ApproachDate")
		@Temporal(TemporalType.TIMESTAMP)
		private Date approachDate;
		//出场日期
		@Column(name = "exitDate")
		@Temporal(TemporalType.TIMESTAMP)
	    private Date exitDate;
		//租赁方式No
		private Integer leaseModeNo;
		//租赁单价
		private BigDecimal leasePrice;
		//结算方式No
		private Integer settlementModeNo;
		//合同编号
		private String contractNo;
		//备注
		private String remark;
		
		private Long operator;//操作人
		
		private Date operateDate;//操作时间
		
		private Integer exitFlag;//是否已退场、0 未退场、1 已退场
		
		private Date exeuntDate;//退场时间，用于控制重复跑批功能是否插入租赁费的信息
		
		private String month;//设备使用年月

		private Long bureauOrgPartyId;
		private Long sonOrgPartyId;
		private Long proOrgPartyId;

		public Long getId() {
			return id;
		}
		public void setId(Long id) {
			this.id = id;
		}
		public Long getEquipmentId() {
			return equipmentId;
		}
		public void setEquipmentId(Long equipmentId) {
			this.equipmentId = equipmentId;
		}
		public Integer getEquipmentSourceNo() {
			return equipmentSourceNo;
		}
		public void setEquipmentSourceNo(Integer equipmentSourceNo) {
			this.equipmentSourceNo = equipmentSourceNo;
		}
		public String getEquipmentSourceName() {
			return equipmentSourceName;
		}
		public void setEquipmentSourceName(String equipmentSourceName) {
			this.equipmentSourceName = equipmentSourceName;
		}
		public Integer getEquState() {
			return equState;
		}
		public void setEquState(Integer equState) {
			this.equState = equState;
		}
		public Integer getRentFlag() {
			return rentFlag;
		}
		public void setRentFlag(Integer rentFlag) {
			this.rentFlag = rentFlag;
		}
		public Integer getSaleFlag() {
			return saleFlag;
		}
		public void setSaleFlag(Integer saleFlag) {
			this.saleFlag = saleFlag;
		}
		public Integer getBusState() {
			return busState;
		}
		public void setBusState(Integer busState) {
			this.busState = busState;
		}
		public Integer getPubState() {
			return pubState;
		}
		public void setPubState(Integer pubState) {
			this.pubState = pubState;
		}
		public Long getEquAtOrgId() {
			return equAtOrgId;
		}
		public void setEquAtOrgId(Long equAtOrgId) {
			this.equAtOrgId = equAtOrgId;
		}
		public String getEquAtOrgName() {
			return equAtOrgName;
		}
		public void setEquAtOrgName(String equAtOrgName) {
			this.equAtOrgName = equAtOrgName;
		}
		public Integer getAtCity() {
			return atCity;
		}
		public void setAtCity(Integer atCity) {
			this.atCity = atCity;
		}
		public String getAddress() {
			return address;
		}
		public void setAddress(String address) {
			this.address = address;
		}
		public String getCustodian() {
			return custodian;
		}
		public void setCustodian(String custodian) {
			this.custodian = custodian;
		}
		public String getContactPersonPhone() {
			return contactPersonPhone;
		}
		public void setContactPersonPhone(String contactPersonPhone) {
			this.contactPersonPhone = contactPersonPhone;
		}
		public Date getApproachDate() {
			return approachDate;
		}
		public void setApproachDate(Date approachDate) {
			this.approachDate = approachDate;
		}
		public Date getExitDate() {
			return exitDate;
		}
		public void setExitDate(Date exitDate) {
			this.exitDate = exitDate;
		}
		public Integer getLeaseModeNo() {
			return leaseModeNo;
		}
		public void setLeaseModeNo(Integer leaseModeNo) {
			this.leaseModeNo = leaseModeNo;
		}
		public BigDecimal getLeasePrice() {
			return leasePrice;
		}
		public void setLeasePrice(BigDecimal leasePrice) {
			this.leasePrice = leasePrice;
		}
		public Integer getSettlementModeNo() {
			return settlementModeNo;
		}
		public void setSettlementModeNo(Integer settlementModeNo) {
			this.settlementModeNo = settlementModeNo;
		}
		public String getContractNo() {
			return contractNo;
		}
		public void setContractNo(String contractNo) {
			this.contractNo = contractNo;
		}
		public String getRemark() {
			return remark;
		}
		public void setRemark(String remark) {
			this.remark = remark;
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
		public Integer getExitFlag() {
			return exitFlag;
		}
		public void setExitFlag(Integer exitFlag) {
			this.exitFlag = exitFlag;
		}
		public Date getExeuntDate() {
			return exeuntDate;
		}
		public void setExeuntDate(Date exeuntDate) {
			this.exeuntDate = exeuntDate;
		}
		public String getMonth() {
			return month;
		}
		public void setMonth(String month) {
			this.month = month;
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