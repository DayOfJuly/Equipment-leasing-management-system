package com.hjd.domain;
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

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.hjd.base.IDomainBase;
import com.hjd.base.JsonDateSerializer;

/**
 * 设备拥有历史表，作为“租赁费登记——拥有者”跑批的基础数据表，往这张表中插入数据的逻辑如下：
 * 1：添加设备，删除设备，直接往这张表中插入数据
 * 2：修改设备的时候，需要拿到此表中该设备的最后一条记录，判断设备来源分类、设备状态、业务状态是否发生改变，如果改变了则插入新的数据，否则不做任何操作
 * @author Q
 *
 */
@Entity
@Table(name="bus_own_hist")
@Inheritance(strategy=InheritanceType.JOINED)	//	指定一对一继承关系映射的关联方式
public class BusOwnHistTable implements IDomainBase {
	
	private static final long serialVersionUID = 3845731783203644810L;


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
		//设备状态
		private Integer equState;
		//业务状态
		private Integer busState;
		//操作人
		private Long operator;
		//操作时间
		@Temporal(TemporalType.TIMESTAMP)
		@JsonSerialize(using=JsonDateSerializer.class)
		private Date operateDate;
		//设备使用年月
		private String month;
		//设备的删除标志
		private Integer delFlag;
		
		private Long equAtOrgid; 
		private String equAtOrgCode;

		private Long bureauOrgPartyId;	//	资源所属局级单位ID
		private Long sonOrgPartyId;	//	资源所属子公司ID
		private Long proOrgPartyId;	//	资源所属项目ID


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
		public Integer getEquState() {
			return equState;
		}
		public void setEquState(Integer equState) {
			this.equState = equState;
		}
		public Integer getBusState() {
			return busState;
		}
		public void setBusState(Integer busState) {
			this.busState = busState;
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
		public String getMonth() {
			return month;
		}
		public void setMonth(String month) {
			this.month = month;
		}
		public Integer getDelFlag() {
			return delFlag;
		}
		public void setDelFlag(Integer delFlag) {
			this.delFlag = delFlag;
		}
		public Long getEquAtOrgid() {
			return equAtOrgid;
		}
		public void setEquAtOrgid(Long equAtOrgid) {
			this.equAtOrgid = equAtOrgid;
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