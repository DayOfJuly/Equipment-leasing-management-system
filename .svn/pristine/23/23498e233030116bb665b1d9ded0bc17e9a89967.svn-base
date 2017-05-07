package com.hjd.domain;

import java.io.Serializable;

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
@Table(name="view_rent_hist_owner")
public class ViewRentHistOwner implements Serializable {
	
		/**
		 * 
		 */
		private static final long serialVersionUID = 4478274421668524973L;
		
		/**
		 * 设备租赁费——拥有者的台帐信息
		 */
		@Id
	    private Long equId;//设备租赁，拥有者登记的设备ID
		private String month;//拥有者租赁登记的月份
		private Integer amount;//结算金额（统计的同一个设备同一个年月登记的总值）
		private Integer cost;//进出场费/安拆费（统计的同一个设备同一个年月登记的总值）
		private Integer deductCost;//折扣费（统计的同一个设备同一个年月登记的总值）
//		private Long equAtOrgId;//设备所属单位的ID
//		private String equAtOrgCode;//设备所属单位的CODE
		
		/**
		 * 设备的相关信息
		 */
		private String equNo; //设备编号
		private String asset;//资产编号
		private String equipmentName;//设备名称
		private String brandName;//品牌名称
		
		
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
			
			public Long getEquId() {
				return equId;
			}
			public void setEquId(Long equId) {
				this.equId = equId;
			}
			public String getMonth() {
				return month;
			}
			public void setMonth(String month) {
				this.month = month;
			}
			public Integer getAmount() {
				return amount;
			}
			public void setAmount(Integer amount) {
				this.amount = amount;
			}
			public Integer getCost() {
				return cost;
			}
			public void setCost(Integer cost) {
				this.cost = cost;
			}
			public Integer getDeductCost() {
				return deductCost;
			}
			public void setDeductCost(Integer deductCost) {
				this.deductCost = deductCost;
			}
//			public Long getEquAtOrgId() {
//				return equAtOrgId;
//			}
//			public void setEquAtOrgId(Long equAtOrgId) {
//				this.equAtOrgId = equAtOrgId;
//			}
//			public String getEquAtOrgCode() {
//				return equAtOrgCode;
//			}
//			public void setEquAtOrgCode(String equAtOrgCode) {
//				this.equAtOrgCode = equAtOrgCode;
//			}
			public String getEquNo() {
				return equNo;
			}
			public void setEquNo(String equNo) {
				this.equNo = equNo;
			}
			public String getAsset() {
				return asset;
			}
			public void setAsset(String asset) {
				this.asset = asset;
			}
			public String getEquipmentName() {
				return equipmentName;
			}
			public void setEquipmentName(String equipmentName) {
				this.equipmentName = equipmentName;
			}
			public String getBrandName() {
				return brandName;
			}
			public void setBrandName(String brandName) {
				this.brandName = brandName;
			}
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
