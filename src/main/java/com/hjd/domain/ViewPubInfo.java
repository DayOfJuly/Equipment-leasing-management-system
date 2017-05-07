package com.hjd.domain;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.hjd.base.IDomainBase;
import com.hjd.base.JsonDateSerializer;

@Entity
@Table(name="view_pub_info")
public class ViewPubInfo implements IDomainBase {

	private static final long serialVersionUID = -5621123606819907275L;

	@Transient
	public Object getObjectId() {

		return this.pubId;
	}

	@Id
	private Long pubId;	//	发布id
	private Integer pubType;	//	发布类型
	private Integer authState;	//	发布审核状态
	private Long equCategoryId;	//	设备分类id
	private String equCategoryName;	//	设备分类名称
	private Long equNameId;	//	设备名称id
	private String equName;	//	设备名称
	private Long equipmentId;	//	设备资源id
	private String standardNameEx;	//	规格名称
	private String modelNameEx;	//	型号名称
	private String infoTitle;	//	信息标题

	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date releaseDate;	//	发布时间

	private String onProvinceEx;	//	省名称
	private String onCityEx;	//	市名称
	private String onDistrictEx;	//	区县名称
	private Long depResponseCount;	//	响应单位数
	private Integer state;	//	成交状态

	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date dealDate;	//	成交时间

	private String depName;	//	成交单位
	private BigDecimal forecastSum;	//	预估金额
	private String equNo;	//	设备编号
	private String asset;	//	资产编号
	/**
	 * 发布单位信息
	 */
	private Integer orgParTypeId;	//	发布单位类型
	private Long orgId;	//	发布单位id
	private String orgCode;	//	发布单位编码
	private String orgName;	//	发布单位名称
	/**
	 * 发布项目信息
	 */
	private Integer proParTypeId;	//	发布项目类型
	private Long proId;	//	发布项目id
	private String proCode;	//	发布项目编码
	private String proName;	//	发布项目名称

	@Transient
	private String disOrgName;

	public Long getPubId() {
		return pubId;
	}

	public void setPubId(Long pubId) {
		this.pubId = pubId;
	}

	public Integer getPubType() {
		return pubType;
	}

	public void setPubType(Integer pubType) {
		this.pubType = pubType;
	}

	public Integer getAuthState() {
		return authState;
	}

	public void setAuthState(Integer authState) {
		this.authState = authState;
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

	public String getEquName() {
		return equName;
	}

	public void setEquName(String equName) {
		this.equName = equName;
	}

	public Long getEquipmentId() {
		return equipmentId;
	}

	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}

	public String getStandardNameEx() {
		return standardNameEx;
	}

	public void setStandardNameEx(String standardNameEx) {
		this.standardNameEx = standardNameEx;
	}

	public String getModelNameEx() {
		return modelNameEx;
	}

	public void setModelNameEx(String modelNameEx) {
		this.modelNameEx = modelNameEx;
	}

	public String getInfoTitle() {
		return infoTitle;
	}

	public void setInfoTitle(String infoTitle) {
		this.infoTitle = infoTitle;
	}

	public Date getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
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

	public Long getDepResponseCount() {
		return depResponseCount;
	}

	public void setDepResponseCount(Long depResponseCount) {
		this.depResponseCount = depResponseCount;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Date getDealDate() {
		return dealDate;
	}

	public void setDealDate(Date dealDate) {
		this.dealDate = dealDate;
	}

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	public BigDecimal getForecastSum() {
		return forecastSum;
	}

	public void setForecastSum(BigDecimal forecastSum) {
		this.forecastSum = forecastSum;
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

	public Integer getOrgParTypeId() {
		return orgParTypeId;
	}

	public void setOrgParTypeId(Integer orgParTypeId) {
		this.orgParTypeId = orgParTypeId;
	}

	public Long getOrgId() {
		return orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
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

	public Integer getProParTypeId() {
		return proParTypeId;
	}

	public void setProParTypeId(Integer proParTypeId) {
		this.proParTypeId = proParTypeId;
	}

	public Long getProId() {
		return proId;
	}

	public void setProId(Long proId) {
		this.proId = proId;
	}

	public String getProCode() {
		return proCode;
	}

	public void setProCode(String proCode) {
		this.proCode = proCode;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getDisOrgName() {
		return disOrgName;
	}

	public void setDisOrgName(String disOrgName) {
		this.disOrgName = disOrgName;
	}

}
