package com.hjd.domain;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="bus_equipment")
public class EquipmentTable implements IDomainBase {

	private static final long serialVersionUID = -3959753809837664998L;

	public Object getObjectId() {

		return this.equipmentId;
		}

	@Id
	@Column(name="EquipmentId", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long equipmentId;

    /**
     * 局级单位	
     */
    private Long bureauId;	//	资源所属局级单位ID
	private Long subsidiaryId;	//	资源所属子公司ID
	private Long projectId;	//	资源所属项目ID

	private Integer brandNo;	//	品牌No
	private String brandName;	//	品牌Name

	private Integer manufacturerId;	//	生产厂家Id
	private String manufacturer;	//	生产厂家

	private Integer modelsId;	//	型号Id
	private String models;	//	型号Name

	private Integer specificationsId;	//	规格Id
	private String specifications;	//	规格Name

	private Integer powerId;	//	功率Id（Kw）（废弃字段）
	private BigDecimal power;	//	功率（Kw）

    private Long equAtOrgId;	//	资源使用局级单位ID/外部单位ID
    private String equAtOrgName;	//	资源使用局级单位name/外部单位名称

	private Integer equipmentSourceNo;	//	设备来源分类No（1-自有，2-外租，3-外协）
	private String equipmentSourceName;	//	设备来源说明

	private Integer leaseModeNo;	//	租赁方式No（废弃字段）
	private String leaseModeName;	//	租赁方式Name

	private Integer settlementModeNo;	//	结算方式No（废弃字段）
	private String settlementModeName;	//	结算方式Name

	private Integer atCity;	//	所在城市（废弃字段）
	/**将所在城市分成了三个字段*/
	private String onProvince;	//	资源使用单位所在省名称
	private String onCity;	//	资源使用单位所在市名称
	private String onDistrict;	//	资源使用单位区县名称

	//	可出租
	private Integer rentFlag;	//	可出租标志（废弃字段）
	//	可出售
	private Integer saleFlag;	//	可出售标志（废弃字段）

	private String address;	//	资源使用单位详细地址
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

	@Column(name="LeasePrice", columnDefinition="number(18,6) default 0.00 ")
	private BigDecimal leasePrice;	//	租赁单价

	private String contractNo;	//	合同编号
	private String remark;	//	备注
	private String facortyNo;	//	出厂编号
	private Integer delFlag;	//	删除标志（0或者null正常，1-已删除）

	@Temporal(TemporalType.TIMESTAMP)
	private Date delDate;	//	删除时间

	@Temporal(TemporalType.DATE)
	private Date productionDate;	//	出厂日期

	@Column(name="EquipmentCost", columnDefinition="number(18,6) default 0.00 ")
	private BigDecimal equipmentCost;	//	设备原值（万元）

	@Temporal(TemporalType.DATE)
	private Date purchaseDate;	//	购置日期

	@Temporal(TemporalType.DATE)
	private Date approachDate;	//	进场日期

	@Temporal(TemporalType.DATE)
    private Date exitDate;	//	出场日期

	private Long categoryId;//	增加：设备分类标识
	private Long assetOwnersId;//	增加：资源登记单位标识
	private Long equAtSubOrgId;	//	增加：资源使用子公司ID
	private Long equAtProjectId;	//	增加：资源使用项目ID

	@Column(name="ScrapPrice", columnDefinition="number(18,6) default 0.00 ")
	private BigDecimal scrapPrice;	//	增加：报废残值

	@Column(name="SellPrice", columnDefinition="number(18,6) default 0.00 ")
	private BigDecimal sellPrice;	//	增加：出售价格

	@Column(name="TotalDepreciation", columnDefinition="number(18,6) default 0.00 ")
	private BigDecimal totalDepreciation;	//	增加：累计折旧

	@Temporal(TemporalType.TIMESTAMP)
	private Date createTime;	//	增加：创建时间

	private Long createUser;	//	增加：创建人

	private String onProvinceId;	//	增加：资源使用单位所在省Id
	private String onCityId;	//	增加：资源使用单位所在市Id
	private String onDistrictId;	//	增加：资源使用单位区县Id

	/**
	 * 型号，规格、功率、设备所在单位这四个字段设计的时候既可以选填，又可以手写，这样的设计导致编写代码，比较费事
	 * 1：添加、修改、删除、查看都还可以接受
	 * 2：关键是觉得违背了通过修改码表的名称，既能够改变各处的显示效果的作用
	 */

//============================================================================------暂时不用-----==============================================================================//	
	private Integer quantity;	//	数量（台）
	private String origin;	//	来源
	private String specialNo;	//	特种编号
	private String rentalUnit;	//	出租单位
	private BigDecimal impExpFee;	//	进出场费

//============================================================================------暂时不用-----==============================================================================//		

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
	public Integer getPowerId() {
		return powerId;
	}
	public void setPowerId(Integer powerId) {
		this.powerId = powerId;
	}
	public BigDecimal getPower() {
		return power;
	}
	public void setPower(BigDecimal power) {
		this.power = power;
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
	public Integer getLeaseModeNo() {
		return leaseModeNo;
	}
	public void setLeaseModeNo(Integer leaseModeNo) {
		this.leaseModeNo = leaseModeNo;
	}
	public String getLeaseModeName() {
		return leaseModeName;
	}
	public void setLeaseModeName(String leaseModeName) {
		this.leaseModeName = leaseModeName;
	}
	public Integer getSettlementModeNo() {
		return settlementModeNo;
	}
	public void setSettlementModeNo(Integer settlementModeNo) {
		this.settlementModeNo = settlementModeNo;
	}
	public String getSettlementModeName() {
		return settlementModeName;
	}
	public void setSettlementModeName(String settlementModeName) {
		this.settlementModeName = settlementModeName;
	}
	public Integer getAtCity() {
		return atCity;
	}
	public void setAtCity(Integer atCity) {
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
	public BigDecimal getImpExpFee() {
		return impExpFee;
	}
	public void setImpExpFee(BigDecimal impExpFee) {
		this.impExpFee = impExpFee;
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
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Long getCreateUser() {
		return createUser;
	}
	public void setCreateUser(Long createUser) {
		this.createUser = createUser;
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
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getSpecialNo() {
		return specialNo;
	}
	public void setSpecialNo(String specialNo) {
		this.specialNo = specialNo;
	}
	public String getRentalUnit() {
		return rentalUnit;
	}
	public void setRentalUnit(String rentalUnit) {
		this.rentalUnit = rentalUnit;
	}

}
