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
@Table(name="view_equ_use_info")
public class ViewEquUseInfo implements Serializable {
	
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
			
			//设备所属单位
			private Long partyId;
			
			private Integer exitFlag;//是否已退场
			
			private String month;//设备使用年月
			
			//根据业务逻辑的限定，在视图中这些限制条件已经加上了在 VIEW_EQU_USE_INFO_RIGHT 中
/*			//设备来源分类
			private Integer equipmentSourceNo;
			//设备状态
			private Integer equState;
			//业务状态
			private Integer busState;*/
			
			private String licenseNo;//牌照号码
			
			private String models;//型号
			
			private Integer modelsId;//型号Id
			
			//设备所在单位
		    private Long  equAtOrgId;
		    
		    /**
		     * 设备所在单位的信息
		     */
			private String orgCode;
			private String orgName;
			private Integer orgLevel;
			private String orgParentCode;
			private Integer orgState;

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

			public Long getPartyId() {
				return partyId;
			}

			public void setPartyId(Long partyId) {
				this.partyId = partyId;
			}

			public Integer getExitFlag() {
				return exitFlag;
			}

			public void setExitFlag(Integer exitFlag) {
				this.exitFlag = exitFlag;
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

			public Integer getModelsId() {
				return modelsId;
			}

			public void setModelsId(Integer modelsId) {
				this.modelsId = modelsId;
			}

			public String getOrgCode() {
				return orgCode;
			}

			public void setOrgCode(String orgCode) {
				this.orgCode = orgCode;
			}

			public String getOrgName() {
				return orgName;
			}

			public void setOrgName(String orgName) {
				this.orgName = orgName;
			}

			public Integer getOrgLevel() {
				return orgLevel;
			}

			public void setOrgLevel(Integer orgLevel) {
				this.orgLevel = orgLevel;
			}

			public String getOrgParentCode() {
				return orgParentCode;
			}

			public void setOrgParentCode(String orgParentCode) {
				this.orgParentCode = orgParentCode;
			}

			public Integer getOrgState() {
				return orgState;
			}

			public void setOrgState(Integer orgState) {
				this.orgState = orgState;
			}

/*			public Integer getEquipmentSourceNo() {
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
			*/
			
	}
