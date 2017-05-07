package com.hjd.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.hjd.base.JsonDateSerializer;
/**
 * 创建视图的注意之处：
 * 1：当成一个单表，仅进行查询的操作
 * 2：MYSQL数据库不区分大小写
 * 3：创建对应的视图对象的时候有主键的概念，注意时间类型、浮点类型的数据需要特殊的说明一下，属性和字段名一致时不需要特殊的匹配说明，否则需要指定匹配的规则
 * @author Qian
 *
 */
@Entity
@Table(name="view_depreciation_hist")
public class ViewDepreciationHist implements Serializable { //now not use
	
		/**
		 * 
		 */
		private static final long serialVersionUID = 4478274421668524973L;
		    //设备的ID
		    @Id
		    private Long equipmentId;
		    
		     //设备编号
			private String equNo;
			
			//资产编号
			private String asset;
			
			//出厂日期
			@Temporal(TemporalType.TIMESTAMP)
			@JsonSerialize(using=JsonDateSerializer.class)
			private Date productionDate;
			
		    //机械设备类型的ID
		    private Integer categoryId;
		    
			//设备名称的ID
			private Integer equNameId;
			
			//设备名称
			private String equipmentName;
			
		    //品牌No
			private Integer brandNo;
			
			//品牌名称
			private String brandName;
			
			private long id;//折旧费登记的记录ID
			
			//折旧费登记的月份
			private String month;
			
			//折旧费
			private BigDecimal depreciation;
			
			//设备资源所在单位
			private Long partyId;

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

			public String getAsset() {
				return asset;
			}

			public void setAsset(String asset) {
				this.asset = asset;
			}

			public Date getProductionDate() {
				return productionDate;
			}

			public void setProductionDate(Date productionDate) {
				this.productionDate = productionDate;
			}

			public Integer getCategoryId() {
				return categoryId;
			}

			public void setCategoryId(Integer categoryId) {
				this.categoryId = categoryId;
			}

			public Integer getEquNameId() {
				return equNameId;
			}

			public void setEquNameId(Integer equNameId) {
				this.equNameId = equNameId;
			}

			public String getEquipmentName() {
				return equipmentName;
			}

			public void setEquipmentName(String equipmentName) {
				this.equipmentName = equipmentName;
			}

			public Integer getBrandNo() {
				return brandNo;
			}

			public void setBrandNo(Integer brandNo) {
				this.brandNo = brandNo;
			}

			public String getBrandName() {
				return brandName;
			}

			public void setBrandName(String brandName) {
				this.brandName = brandName;
			}

			public Long getId() {
				return id;
			}

			public void setId(Long id) {
				this.id = id;
			}

			public String getMonth() {
				return month;
			}

			public void setMonth(String month) {
				this.month = month;
			}

			public BigDecimal getDepreciation() {
				return depreciation;
			}

			public void setDepreciation(BigDecimal depreciation) {
				this.depreciation = depreciation;
			}

			public Long getPartyId() {
				return partyId;
			}

			public void setPartyId(Long partyId) {
				this.partyId = partyId;
			}
	}
