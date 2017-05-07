package com.hjd.action.bean;

import java.math.BigDecimal;




import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.hjd.base.BeanAbs;

public class RentBean extends BeanAbs{
	
	/*为了查询效率以及发布后不需要变动，所以将对应的字段添加到出售出租的表中*/
	private String equNo;//设备编号
	private BigDecimal power;//功率
	private String technicalStatus;//技术状况
	private String manufacturer;//生产厂家
	@Column(name = "ProductionDate")
	@Temporal(TemporalType.DATE)
	private Date productionDate;//出厂日期
	private String equName;//设备名称  
	private String brandName;//品牌
	private String modelName; //型号
	private String standardName; //规格
	
	private Integer dataId;
	private String infoTitle;//信息标题
	private Long equipmentId;//设备资源管理表主键
	private BigDecimal price;//价格
	private Integer priceType;//价格类型 （1：元/月  2：元/天  3：元/小时）
	private Integer shortestLease;//最短租期 （1：一周，2：半个月，3：一个月，4：三个月，5：半年，6：一年，7：其他）
	private String detailedDescription;//详细说明
	private String equipmentPic;//设备图片（名称）
	private String enterpriseName;//企业名称
	private String contactPerson;//联系人
	private String contactPhone;//联系手机
	private String qqNo;//QQ
	private String electronicMail;//电子邮箱
	private String fixedTelephone;//固定电话
	private String contactAddress;//联系地址
	private Long atCity;//所在城市
	

	/*将所在城市分成了三个字段*/
	private String onProvince;//省
	private String onCity;//市
	private String onDistrict;//区	
	
	
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
	
	public Integer getDataId() {
		return dataId;
	}
	public void setDataId(Integer dataId) {
		this.dataId = dataId;
	}
	public String getInfoTitle() {
		return infoTitle;
	}
	public void setInfoTitle(String infoTitle) {
		this.infoTitle = infoTitle;
	}
	public Long getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
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
	public Integer getShortestLease() {
		return shortestLease;
	}
	public void setShortestLease(Integer shortestLease) {
		this.shortestLease = shortestLease;
	}
	public String getDetailedDescription() {
		return detailedDescription;
	}
	public void setDetailedDescription(String detailedDescription) {
		this.detailedDescription = detailedDescription;
	}
	public String getEquipmentPic() {
		return equipmentPic;
	}
	public void setEquipmentPic(String equipmentPic) {
		this.equipmentPic = equipmentPic;
	}
	public String getEnterpriseName() {
		return enterpriseName;
	}
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
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
	public String getQqNo() {
		return qqNo;
	}
	public void setQqNo(String qqNo) {
		this.qqNo = qqNo;
	}
	public String getElectronicMail() {
		return electronicMail;
	}
	public void setElectronicMail(String electronicMail) {
		this.electronicMail = electronicMail;
	}
	public String getFixedTelephone() {
		return fixedTelephone;
	}
	public void setFixedTelephone(String fixedTelephone) {
		this.fixedTelephone = fixedTelephone;
	}
	public String getContactAddress() {
		return contactAddress;
	}
	public void setContactAddress(String contactAddress) {
		this.contactAddress = contactAddress;
	}
	public Long getAtCity() {
		return atCity;
	}
	public void setAtCity(Long atCity) {
		this.atCity = atCity;
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
	public String getEquNo() {
		return equNo;
	}
	public void setEquNo(String equNo) {
		this.equNo = equNo;
	}
	public BigDecimal getPower() {
		return power;
	}
	public void setPower(BigDecimal power) {
		this.power = power;
	}
	public String getTechnicalStatus() {
		return technicalStatus;
	}
	public void setTechnicalStatus(String technicalStatus) {
		this.technicalStatus = technicalStatus;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public Date getProductionDate() {
		return productionDate;
	}
	public void setProductionDate(Date productionDate) {
		this.productionDate = productionDate;
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
	public String getStandardName() {
		return standardName;
	}
	public void setStandardName(String standardName) {
		this.standardName = standardName;
	}
	
	
}
