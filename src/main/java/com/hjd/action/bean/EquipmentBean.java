package com.hjd.action.bean;

import java.math.BigDecimal;
import java.util.Date;

import com.hjd.base.BeanAbs;

public class EquipmentBean extends BeanAbs {

	private Long equipmentId;
    /**
     * 局级单位	
     */
    private Long bureauId;	//	设备资源所属局级单位ID
	private Long subsidiaryId;	//	设备资源所属子公司ID
	private Long projectId;	//	设备资源所属项目ID

	private Integer brandNo;	//	品牌id
	private String brandName;	//	品牌
	private Integer manufacturerId;	//	生产厂家id
	private String manufacturer;	//	生产厂家
	private Integer modelsId;	//	型号id
	private String models;	//	型号
	private Integer specificationsId;	//	规格id
	private String specifications;	//	规格

    private Long equAtOrgId;	//	设备资源使用局级单位ID/外部单位ID
    private String equAtOrgName;	//	设备资源使用局级单位name/外部单位名称
	private Long equAtSubOrgId;	//	设备资源使用子公司ID
	private Long equAtProjectId;	//	设备资源使用项目ID

	private Integer equipmentSourceNo;	//	设备来源分类（1-自有，2-外租，3-外协）
	private String equipmentSourceName;	//	设备来源说明

	private String onProvince;	//	设备资源使用单位所在省名称
	private String onCity;	//	设备资源使用单位所在市名称
	private String onDistrict;	//	设备资源使用单位区县名称
	private String onProvinceId;	//	资源使用单位所在省id
	private String onCityId;	//	资源使用单位所在市id
	private String onDistrictId;	//	资源使用单位区县id

	private String leaseModeName;	//	租赁方式
	private String settlementModeName;	//	结算方式
	private BigDecimal power;	//	功率（KW）
	private String address;	//	设备资源使用单位详细地址
	private String equNo;	//	设备编号
	private String asset;	//	资产编号
	private String technicalStatus;	//	技术状况
	private String licenseNo;	//	牌照号码
	private Integer powerType;	//	动力种类
	private Integer equState;	//	设备状态（1-闲置，2-使用中，3-已出售，4-已报废）
	private Integer busState;	//	业务状态（1-自用，2-调拨，3-局内租，4-外局租，5-外租）
	private Integer pubState;	//	发布状态（1-未发布，2-出租发布中，3-出售发布中，4-租售发布中）
	private String custodian;	//	保管人
	private String contactPersonPhone;	//	联系电话
	private BigDecimal leasePrice;	//	租赁单价
	private String contractNo;	//	合同编号
	private String remark;	//	备注
	private String facortyNo;	//	出厂编号
	private Date productionDate;	//	出厂日期
	private BigDecimal equipmentCost;	//	设备原值（万元）
	private Date purchaseDate;	//	购置日期
	private Date approachDate;	//	进场日期
    private Date exitDate;	//	出场日期
	private BigDecimal scrapPrice;	//	报废残值
	private BigDecimal sellPrice;	//	出售价格
	private BigDecimal totalDepreciation;	//	累计折旧费（万元）
	private Long createUser;	//	创建人

	private Integer delFlag;	//	删除标志（0或者null正常，1-已删除）
	private Date delDate;	//	删除时间

	private Long categoryId;//	设备分类标识
	private Long assetOwnersId;//	设备资源登记单位标识

    private String [] fpy;//设备名称的首字母

	public Long getEquipmentId() {
		return equipmentId;
	}

	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}

	public Long getBureauId() {
		return bureauId;
	}

	public void setBureauId(Long bureauId) {
		this.bureauId = bureauId;
	}

	public Long getSubsidiaryId() {
		return subsidiaryId;
	}

	public void setSubsidiaryId(Long subsidiaryId) {
		this.subsidiaryId = subsidiaryId;
	}

	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
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

	public Integer getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(Integer manufacturerId) {
		this.manufacturerId = manufacturerId;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public Integer getModelsId() {
		return modelsId;
	}

	public void setModelsId(Integer modelsId) {
		this.modelsId = modelsId;
	}

	public String getModels() {
		return models;
	}

	public void setModels(String models) {
		this.models = models;
	}

	public Integer getSpecificationsId() {
		return specificationsId;
	}

	public void setSpecificationsId(Integer specificationsId) {
		this.specificationsId = specificationsId;
	}

	public String getSpecifications() {
		return specifications;
	}

	public void setSpecifications(String specifications) {
		this.specifications = specifications;
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

	public Long getEquAtSubOrgId() {
		return equAtSubOrgId;
	}

	public void setEquAtSubOrgId(Long equAtSubOrgId) {
		this.equAtSubOrgId = equAtSubOrgId;
	}

	public Long getEquAtProjectId() {
		return equAtProjectId;
	}

	public void setEquAtProjectId(Long equAtProjectId) {
		this.equAtProjectId = equAtProjectId;
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

	public String getOnProvinceId() {
		return onProvinceId;
	}

	public void setOnProvinceId(String onProvinceId) {
		this.onProvinceId = onProvinceId;
	}

	public String getOnCityId() {
		return onCityId;
	}

	public void setOnCityId(String onCityId) {
		this.onCityId = onCityId;
	}

	public String getOnDistrictId() {
		return onDistrictId;
	}

	public void setOnDistrictId(String onDistrictId) {
		this.onDistrictId = onDistrictId;
	}

	public String getLeaseModeName() {
		return leaseModeName;
	}

	public void setLeaseModeName(String leaseModeName) {
		this.leaseModeName = leaseModeName;
	}

	public String getSettlementModeName() {
		return settlementModeName;
	}

	public void setSettlementModeName(String settlementModeName) {
		this.settlementModeName = settlementModeName;
	}

	public BigDecimal getPower() {
		return power;
	}

	public void setPower(BigDecimal power) {
		this.power = power;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public String getTechnicalStatus() {
		return technicalStatus;
	}

	public void setTechnicalStatus(String technicalStatus) {
		this.technicalStatus = technicalStatus;
	}

	public String getLicenseNo() {
		return licenseNo;
	}

	public void setLicenseNo(String licenseNo) {
		this.licenseNo = licenseNo;
	}

	public Integer getPowerType() {
		return powerType;
	}

	public void setPowerType(Integer powerType) {
		this.powerType = powerType;
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

	public Integer getPubState() {
		return pubState;
	}

	public void setPubState(Integer pubState) {
		this.pubState = pubState;
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

	public BigDecimal getLeasePrice() {
		return leasePrice;
	}

	public void setLeasePrice(BigDecimal leasePrice) {
		this.leasePrice = leasePrice;
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

	public String getFacortyNo() {
		return facortyNo;
	}

	public void setFacortyNo(String facortyNo) {
		this.facortyNo = facortyNo;
	}

	public Date getProductionDate() {
		return productionDate;
	}

	public void setProductionDate(Date productionDate) {
		this.productionDate = productionDate;
	}

	public BigDecimal getEquipmentCost() {
		return equipmentCost;
	}

	public void setEquipmentCost(BigDecimal equipmentCost) {
		this.equipmentCost = equipmentCost;
	}

	public Date getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
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

	public BigDecimal getScrapPrice() {
		return scrapPrice;
	}

	public void setScrapPrice(BigDecimal scrapPrice) {
		this.scrapPrice = scrapPrice;
	}

	public BigDecimal getSellPrice() {
		return sellPrice;
	}

	public void setSellPrice(BigDecimal sellPrice) {
		this.sellPrice = sellPrice;
	}

	public BigDecimal getTotalDepreciation() {
		return totalDepreciation;
	}

	public void setTotalDepreciation(BigDecimal totalDepreciation) {
		this.totalDepreciation = totalDepreciation;
	}

	public Long getCreateUser() {
		return createUser;
	}

	public void setCreateUser(Long createUser) {
		this.createUser = createUser;
	}

	public Integer getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(Integer delFlag) {
		this.delFlag = delFlag;
	}

	public Date getDelDate() {
		return delDate;
	}

	public void setDelDate(Date delDate) {
		this.delDate = delDate;
	}

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	public Long getAssetOwnersId() {
		return assetOwnersId;
	}

	public void setAssetOwnersId(Long assetOwnersId) {
		this.assetOwnersId = assetOwnersId;
	}

	public String[] getFpy() {
		return fpy;
	}

	public void setFpy(String[] fpy) {
		this.fpy = fpy;
	}

}
