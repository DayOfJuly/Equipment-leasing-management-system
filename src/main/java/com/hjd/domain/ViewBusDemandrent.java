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
@Table(name="view_bus_demandrent")
public class ViewBusDemandrent implements Serializable {
			
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		
		/**
		 * 扩展数据的信息
		 */
		@Id
		private Long dataId;
		private Integer dataType;//数据类型——四种发布数据的类型
		private Long originOrg;//数据所属人所在的企业
		private Integer operateFlag;//操作标识
		private Integer dataState;//发布状态
		private String orgCode;//数据所属人所在单位的编码
		/**
		 * 出租发布的信息
		 */
		private String infoTitle;//信息标题
		private String onProvince;//省
		private String onCity;//市
		private String onDistrict;//区	
		private BigDecimal price;//价格
		private Integer priceType;//价格类型
		@Temporal(TemporalType.TIMESTAMP)
		@JsonSerialize(using=JsonDateSerializer.class)
		private Date releaseDate;//发布日期
		//租期
		private Integer tenancy; //new add
		//租期类型
		private Integer tenancyType; //new add
		private BigDecimal quantity;//数量
	    //计量单位
		private String second;// new add

		/**
		 * 设备资源的信息
		 */
		private String equName;//设备名称  
		private String brandName;//品牌
		private String modelName; //型号
		private String standardName; //规格
		//设备大类ID
		private Long equCategoryId;
		//设备小类ID
		private Long equNameId;
		/**
		 * 企业的信息
		 */
		private String enterpriseName;//企业名称 --- 类型改变  输入变成回显  改名成--联系单位--单位名称
		
		
		/**
		 * 信息发布人的单位信息，一定存在
		 */
		private Integer bureauOrgParTypeId;
		private Long bureauOrgPartyId;
		private String bureauOrgCode;
		private String bureauOrgPartyName;
		/**
		 * 信息发布人的项目信息，可能存在
		 */
		private Integer proOrgParTypeId;
		private Long proOrgPartyId;
		private String proOrgCode;
		private String proOrgName;
		
		public Long getDataId() {
			return dataId;
		}
		public void setDataId(Long dataId) {
			this.dataId = dataId;
		}
		public Integer getDataType() {
			return dataType;
		}
		public void setDataType(Integer dataType) {
			this.dataType = dataType;
		}
		public Long getOriginOrg() {
			return originOrg;
		}
		public void setOriginOrg(Long originOrg) {
			this.originOrg = originOrg;
		}
		public Integer getOperateFlag() {
			return operateFlag;
		}
		public void setOperateFlag(Integer operateFlag) {
			this.operateFlag = operateFlag;
		}
		public Integer getDataState() {
			return dataState;
		}
		public void setDataState(Integer dataState) {
			this.dataState = dataState;
		}
		public String getOrgCode() {
			return orgCode;
		}
		public void setOrgCode(String orgCode) {
			this.orgCode = orgCode;
		}
		public String getInfoTitle() {
			return infoTitle;
		}
		public void setInfoTitle(String infoTitle) {
			this.infoTitle = infoTitle;
		}
		public String getOnProvince() {
			return onProvince;
		}
		public void setOnProvince(String onProvince) {
			this.onProvince = onProvince;
		}
		public String getOnCity() {
			return onCity;
		}
		public void setOnCity(String onCity) {
			this.onCity = onCity;
		}
		public String getOnDistrict() {
			return onDistrict;
		}
		public void setOnDistrict(String onDistrict) {
			this.onDistrict = onDistrict;
		}
		public BigDecimal getPrice() {
			return price;
		}
		public void setPrice(BigDecimal price) {
			this.price = price;
		}
		public Integer getPriceType() {
			return priceType;
		}
		public void setPriceType(Integer priceType) {
			this.priceType = priceType;
		}
		public Date getReleaseDate() {
			return releaseDate;
		}
		public void setReleaseDate(Date releaseDate) {
			this.releaseDate = releaseDate;
		}
		public String getEquName() {
			return equName;
		}
		public void setEquName(String equName) {
			this.equName = equName;
		}
		public String getBrandName() {
			return brandName;
		}
		public void setBrandName(String brandName) {
			this.brandName = brandName;
		}
		public String getModelName() {
			return modelName;
		}
		public void setModelName(String modelName) {
			this.modelName = modelName;
		}
		public String getStandardName() {
			return standardName;
		}
		public void setStandardName(String standardName) {
			this.standardName = standardName;
		}
		public String getEnterpriseName() {
			return enterpriseName;
		}
		public void setEnterpriseName(String enterpriseName) {
			this.enterpriseName = enterpriseName;
		}
		public Integer getTenancy() {
			return tenancy;
		}
		public void setTenancy(Integer tenancy) {
			this.tenancy = tenancy;
		}
		public Integer getTenancyType() {
			return tenancyType;
		}
		public void setTenancyType(Integer tenancyType) {
			this.tenancyType = tenancyType;
		}
		public BigDecimal getQuantity() {
			return quantity;
		}
		public void setQuantity(BigDecimal quantity) {
			this.quantity = quantity;
		}
		public String getSecond() {
			return second;
		}
		public void setSecond(String second) {
			this.second = second;
		}
		public Long getEquCategoryId() {
			return equCategoryId;
		}
		public void setEquCategoryId(Long equCategoryId) {
			this.equCategoryId = equCategoryId;
		}
		public Long getEquNameId() {
			return equNameId;
		}
		public void setEquNameId(Long equNameId) {
			this.equNameId = equNameId;
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
		public String getBureauOrgCode() {
			return bureauOrgCode;
		}
		public void setBureauOrgCode(String bureauOrgCode) {
			this.bureauOrgCode = bureauOrgCode;
		}
		public String getBureauOrgPartyName() {
			return bureauOrgPartyName;
		}
		public void setBureauOrgPartyName(String bureauOrgPartyName) {
			this.bureauOrgPartyName = bureauOrgPartyName;
		}
		public Integer getProOrgParTypeId() {
			return proOrgParTypeId;
		}
		public void setProOrgParTypeId(Integer proOrgParTypeId) {
			this.proOrgParTypeId = proOrgParTypeId;
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
