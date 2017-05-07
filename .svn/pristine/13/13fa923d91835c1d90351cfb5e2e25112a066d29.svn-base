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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.hjd.base.IDomainBase;
import com.hjd.base.JsonDateSerializer;

@Entity
@Table(name="biz_exdata")
@Inheritance(strategy=InheritanceType.JOINED)	//	指定一对一继承关系映射的关联方式
public class BizExData implements IDomainBase {

	private static final long serialVersionUID = -8248826404866001394L;

	@Transient
	public Object getObjectId() {

		return this.dataId;
		}

	@Id
	@Column(name="dataId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long dataId;
	
	private Long processId;
	
	
	@ManyToOne(targetEntity=BizDataState.class) 
	@JoinColumn(name="dataState", nullable=false)
	private BizDataState dataState;

	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date updateTime;

	private Integer dataType;//数据类型——四种发布数据的类型 1：出租、2：出售、3：求租、4：求购
	private Long managerId;//数据的所属人
	private Long originOrg;//数据所属人所在的企业
	private String district;
	private Long lastOper;//最后操作人
	private Long viewCount;//发布信息查看的次数
	private Integer operateFlag;//操作标识，控制对已发布的信息进行逻辑删除，默认为0正常，从已发布的信息中删除是1，从我想发布的信息中删除是2
/*	private String refuseReason;*/

	private String orgCode;//数据所属人所在单位的编码

	/**
	 * 为了提高SQL语句的查询速度，将求租、求购、出租、出售四张表中公共的在审核列表和我已发布的信息列表中展现的字段作为冗余字段迁移到扩展表中
	 */
	private String equName;//设备名称

	private String infoTitle;//信息标题

	private String contactPerson;//联系人

	private String contactPhone;//联系手机--联系电话

	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date releaseDate;//发布日期

	private String enterpriseName;//企业名称  --- 类型改变  输入变成回显  改名成--联系单位--单位名称
	  
	private String infoTitlePy;//信息标题的拼音
	
	private Long equipmentId;//出租、出售设备的ID
	/**
	 * 发现我已发布的信息，发布结果登记，分成多个表的话，查询的速度比较慢，所以，现在采用添加冗余字段的方式来提高查询的效率
	 */
	private Integer state;//交易状态1：已成交、2：未成交、3：作废
	
	private String busState;//业务状态
	
	private String depName;//设备成交单位
	
	private String note;//备注
	
	private BigDecimal forecastSum;//预估金额
	
	/**
	 * 求租、求购、出租、出售的需求做出的变更，也要根据设备的大类名称查询，以及为了保持添加设备信息时和添加资源时一致，添加个字段
	 */
	//设备大类ID
	private Long equCategoryId;
	//设备大类名称
	private String equCategoryName;
	//设备小类ID
	private Long equNameId;
	//设备小类名称

	//生产厂家的ID
	private Long manufacturerId;
	//生产厂家的名称
	private String manufacturerName;
	//品牌的ID
	private Long brandId;
	//品牌的名称
	private String brandName;
	//项目的Id
	private Long proId;
	
	//成交日期-发布结果登记的日期
	private Date dealDate;
	//响应单位数-为了佳佳那边统计报表使用
	private Long depResponseCount;
	
	
	
	/**
	 * 为了统计报表好查询，添加几个冗余字段
	 */
	private String modelNameEx; //型号
	private String standardNameEx; //规格
	/*将所在城市分成了三个字段*/
	private String onProvinceEx;//省
	private String onCityEx;//市
	private String onDistrictEx;//区	
	/*将使用城市分成了三个字段*/
	public BizExData() {

		}

	public BizExData(Long dataId) {

		this.dataId = dataId;
		}

	public Long getDataId() {
		return dataId;
	}

	public void setDataId(Long dataId) {
		this.dataId = dataId;
	}

	public Long getProcessId() {
		return processId;
	}

	public void setProcessId(Long processId) {
		this.processId = processId;
	}

	public BizDataState getDataState() {
		return dataState;
	}

	public void setDataState(BizDataState dataState) {
		this.dataState = dataState;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getDataType() {
		return dataType;
	}

	public void setDataType(Integer dataType) {
		this.dataType = dataType;
	}

	public Long getManagerId() {
		return managerId;
	}

	public void setManagerId(Long managerId) {
		this.managerId = managerId;
	}

	public Long getOriginOrg() {
		return originOrg;
	}

	public void setOriginOrg(Long originOrg) {
		this.originOrg = originOrg;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public Long getLastOper() {
		return lastOper;
	}

	public void setLastOper(Long lastOper) {
		this.lastOper = lastOper;
	}

	public Long getViewCount() {
		return viewCount;
	}

	public void setViewCount(Long viewCount) {
		this.viewCount = viewCount;
	}

	public Integer getOperateFlag() {
		return operateFlag;
	}

	public void setOperateFlag(Integer operateFlag) {
		this.operateFlag = operateFlag;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getEquName() {
		return equName;
	}

	public void setEquName(String equName) {
		this.equName = equName;
	}

	public String getInfoTitle() {
		return infoTitle;
	}

	public void setInfoTitle(String infoTitle) {
		this.infoTitle = infoTitle;
	}

	public String getContactPerson() {
		return contactPerson;
	}

	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}

	public String getContactPhone() {
		return contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	public Date getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public String getInfoTitlePy() {
		return infoTitlePy;
	}

	public void setInfoTitlePy(String infoTitlePy) {
		this.infoTitlePy = infoTitlePy;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getBusState() {
		return busState;
	}

	public void setBusState(String busState) {
		this.busState = busState;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Long getEquipmentId() {
		return equipmentId;
	}

	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}

	public BigDecimal getForecastSum() {
		return forecastSum;
	}

	public void setForecastSum(BigDecimal forecastSum) {
		this.forecastSum = forecastSum;
	}

	public Long getEquCategoryId() {
		return equCategoryId;
	}

	public void setEquCategoryId(Long equCategoryId) {
		this.equCategoryId = equCategoryId;
	}

	public String getEquCategoryName() {
		return equCategoryName;
	}

	public void setEquCategoryName(String equCategoryName) {
		this.equCategoryName = equCategoryName;
	}

	public Long getEquNameId() {
		return equNameId;
	}

	public void setEquNameId(Long equNameId) {
		this.equNameId = equNameId;
	}

	public Long getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(Long manufacturerId) {
		this.manufacturerId = manufacturerId;
	}

	public String getManufacturerName() {
		return manufacturerName;
	}

	public void setManufacturerName(String manufacturerName) {
		this.manufacturerName = manufacturerName;
	}

	public Long getBrandId() {
		return brandId;
	}

	public void setBrandId(Long brandId) {
		this.brandId = brandId;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public Long getProId() {
		return proId;
	}

	public void setProId(Long proId) {
		this.proId = proId;
	}

	public Date getDealDate() {
		return dealDate;
	}

	public void setDealDate(Date dealDate) {
		this.dealDate = dealDate;
	}

	public Long getDepResponseCount() {
		return depResponseCount;
	}

	public void setDepResponseCount(Long depResponseCount) {
		this.depResponseCount = depResponseCount;
	}

	public String getModelNameEx() {
		return modelNameEx;
	}

	public void setModelNameEx(String modelNameEx) {
		this.modelNameEx = modelNameEx;
	}

	public String getStandardNameEx() {
		return standardNameEx;
	}

	public void setStandardNameEx(String standardNameEx) {
		this.standardNameEx = standardNameEx;
	}

	public String getOnProvinceEx() {
		return onProvinceEx;
	}

	public void setOnProvinceEx(String onProvinceEx) {
		this.onProvinceEx = onProvinceEx;
	}

	public String getOnCityEx() {
		return onCityEx;
	}

	public void setOnCityEx(String onCityEx) {
		this.onCityEx = onCityEx;
	}

	public String getOnDistrictEx() {
		return onDistrictEx;
	}

	public void setOnDistrictEx(String onDistrictEx) {
		this.onDistrictEx = onDistrictEx;
	}

	}
