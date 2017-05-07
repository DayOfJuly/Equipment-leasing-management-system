package com.hjd.domain;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.hjd.base.IDomainBase;

/**
 * 创建视图的注意之处：
 * 1：当成一个单表，仅进行查询的操作
 * 2：MYSQL数据库不区分大小写
 * 3：创建对应的视图对象的时候有主键的概念，注意时间类型、浮点类型的数据需要特殊的说明一下，属性和字段名一致时不需要特殊的匹配说明，否则需要指定匹配的规则
 * @author Qian
 *
 */
@Entity
@Table(name="view_equ_info")
public class ViewEquInfo implements IDomainBase {

	private static final long serialVersionUID = 4478274421668524973L;

	@Transient
	public Object getObjectId() {

		return this.equipmentId;
		}

	/**
	 * 设备信息
	 */
	@Id
	private Long equipmentId;//	设备资源ID
	private Integer modelsId;//型号Id
	private String models;//型号
	private String specificationsId;//规格Id
	private String specifications;//规格
	private BigDecimal power;//功率（Kw）
	private Integer equipmentSourceNo;//设备来源No（1-自有，2-外租，3-外协）
	private String equipmentSourceName;	//	设备来源说明
	private String leaseModeName;	//	租赁方式Name
	private String settlementModeName;	//	结算方式Name
	private String onProvince;	//	资源使用单位所在省名称
	private String onCity;	//	资源使用单位所在市名称
	private String onDistrict;	//	资源使用单位区县名称
	private Long onProvinceId;	//	增加：资源使用单位所在省Id
	private Long onCityId;	//	增加：资源使用单位所在市Id
	private Long onDistrictId;	//	增加：资源使用单位区县Id
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
	private BigDecimal leasePrice;	//	租赁单价
	private String contractNo;	//	合同编号
	private String remark;	//	备注
	private String facortyNo;	//	出厂编号
	private Integer delFlag;	//	删除标志（0或者null正常，1-已删除）
	private Date delDate;	//	删除时间
	@Temporal(TemporalType.DATE)
	private Date productionDate;	//	出厂日期
	private BigDecimal equipmentCost;	//	设备原值（万元）
	@Temporal(TemporalType.DATE)
	private Date purchaseDate;	//	购置日期
	@Temporal(TemporalType.DATE)
	private Date approachDate;	//	进场日期
	@Temporal(TemporalType.DATE)
	private Date exitDate;	//	出场日期
	private BigDecimal scrapPrice;	//	报废残值
	private BigDecimal sellPrice;	//	出售价格
	private BigDecimal totalDepreciation;	//	累计折旧
	private Date createTime;	//	创建时间
	private Long createUser;	//	创建人
	private Long categoryId;//	增加：设备分类标识
	/**
	 * 设备大类信息
	 */
	private Long equCategoryId;
	private String equipmentCategoryName;
	/**
	 * 设备小类信息
	 */
	private Long equNameId;
	private String second;	//	设备：计量单位
	private String equName;
	/**
	 * 设备品牌信息
	 */
	private Integer brandNo;
	private String brandName;
	/**
	 * 设备生产厂家信息
	 */
	private Integer manufacturerNo;
	private String manufacturerName;
	/**
	 * 设备所属局级单位信息
	 */
	private Integer bureauOrgParTypeId;
	private Long bureauOrgPartyId;
	private String bureauOrgCode;
	private String bureauOrgPartyName;
	/**
	 * 设备所属处级单位信息
	 */
	private Integer sonOrgParTypeId;
	private Long sonOrgPartyId;
	private String sonOrgCode;
	private String sonOrgName;
	/**
	 * 设备所属项目信息
	 */
	private Integer proOrgParTypeId;
	private Long  proOrgPartyId ;
	private String proOrgCode ;
	private String proOrgName;
	/**
	 * 设备登记单位信息
	 */
	private Long orgPartyId;
	/**
	 * 设备使用局级单位信息
	 */
	private Integer equAtOrgParTypeId;
	private Long equAtOrgId;
	private String equAtOrgCode;
	private String equAtOrgName;	//	资源使用局级单位name/外部单位名称
	/**
	 * 设备使用处级单位信息
	 */
	private Integer equAtSubOrgParTypeId;
	private Long equAtSubOrgId;
	private String equAtSubOrgCode;
	private String equAtSubOrgName;
	/**
	 * 设备使用项目信息
	 */
	private Integer equAtProjectParTypeId;
	private Long equAtProjectId;
	private String equAtProjectCode;
	private String equAtProjectName;

	@Transient
	private Integer equFlag;	//	拥有单位/使用单位标志
	@Transient
	private String disEquAtName;	//	显示使用单位名称
	@Transient
	private Integer equTrsType;	//	资源明细 - 来源

	public Long getEquipmentId() {
		return equipmentId;
	}
	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
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
	public String getSpecificationsId() {
		return specificationsId;
	}
	public void setSpecificationsId(String specificationsId) {
		this.specificationsId = specificationsId;
	}
	public String getSpecifications() {
		return specifications;
	}
	public void setSpecifications(String specifications) {
		this.specifications = specifications;
	}
	public BigDecimal getPower() {
		return power;
	}
	public void setPower(BigDecimal power) {
		this.power = power;
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
	public Long getOnProvinceId() {
		return onProvinceId;
	}
	public void setOnProvinceId(Long onProvinceId) {
		this.onProvinceId = onProvinceId;
	}
	public Long getOnCityId() {
		return onCityId;
	}
	public void setOnCityId(Long onCityId) {
		this.onCityId = onCityId;
	}
	public Long getOnDistrictId() {
		return onDistrictId;
	}
	public void setOnDistrictId(Long onDistrictId) {
		this.onDistrictId = onDistrictId;
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
	public Long getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}
	public Long getEquCategoryId() {
		return equCategoryId;
	}
	public void setEquCategoryId(Long equCategoryId) {
		this.equCategoryId = equCategoryId;
	}
	public String getEquipmentCategoryName() {
		return equipmentCategoryName;
	}
	public void setEquipmentCategoryName(String equipmentCategoryName) {
		this.equipmentCategoryName = equipmentCategoryName;
	}
	public Long getEquNameId() {
		return equNameId;
	}
	public void setEquNameId(Long equNameId) {
		this.equNameId = equNameId;
	}
	public String getSecond() {
		return second;
	}
	public void setSecond(String second) {
		this.second = second;
	}
	public String getEquName() {
		return equName;
	}
	public void setEquName(String equName) {
		this.equName = equName;
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
	public Integer getManufacturerNo() {
		return manufacturerNo;
	}
	public void setManufacturerNo(Integer manufacturerNo) {
		this.manufacturerNo = manufacturerNo;
	}
	public String getManufacturerName() {
		return manufacturerName;
	}
	public void setManufacturerName(String manufacturerName) {
		this.manufacturerName = manufacturerName;
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
	public Integer getSonOrgParTypeId() {
		return sonOrgParTypeId;
	}
	public void setSonOrgParTypeId(Integer sonOrgParTypeId) {
		this.sonOrgParTypeId = sonOrgParTypeId;
	}
	public Long getSonOrgPartyId() {
		return sonOrgPartyId;
	}
	public void setSonOrgPartyId(Long sonOrgPartyId) {
		this.sonOrgPartyId = sonOrgPartyId;
	}
	public String getSonOrgCode() {
		return sonOrgCode;
	}
	public void setSonOrgCode(String sonOrgCode) {
		this.sonOrgCode = sonOrgCode;
	}
	public String getSonOrgName() {
		return sonOrgName;
	}
	public void setSonOrgName(String sonOrgName) {
		this.sonOrgName = sonOrgName;
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
	public Long getOrgPartyId() {
		return orgPartyId;
	}
	public void setOrgPartyId(Long orgPartyId) {
		this.orgPartyId = orgPartyId;
	}
	public Integer getEquAtOrgParTypeId() {
		return equAtOrgParTypeId;
	}
	public void setEquAtOrgParTypeId(Integer equAtOrgParTypeId) {
		this.equAtOrgParTypeId = equAtOrgParTypeId;
	}
	public Long getEquAtOrgId() {
		return equAtOrgId;
	}
	public void setEquAtOrgId(Long equAtOrgId) {
		this.equAtOrgId = equAtOrgId;
	}
	public String getEquAtOrgCode() {
		return equAtOrgCode;
	}
	public void setEquAtOrgCode(String equAtOrgCode) {
		this.equAtOrgCode = equAtOrgCode;
	}
	public String getEquAtOrgName() {
		return equAtOrgName;
	}
	public void setEquAtOrgName(String equAtOrgName) {
		this.equAtOrgName = equAtOrgName;
	}
	public Integer getEquAtSubOrgParTypeId() {
		return equAtSubOrgParTypeId;
	}
	public void setEquAtSubOrgParTypeId(Integer equAtSubOrgParTypeId) {
		this.equAtSubOrgParTypeId = equAtSubOrgParTypeId;
	}
	public Long getEquAtSubOrgId() {
		return equAtSubOrgId;
	}
	public void setEquAtSubOrgId(Long equAtSubOrgId) {
		this.equAtSubOrgId = equAtSubOrgId;
	}
	public String getEquAtSubOrgCode() {
		return equAtSubOrgCode;
	}
	public void setEquAtSubOrgCode(String equAtSubOrgCode) {
		this.equAtSubOrgCode = equAtSubOrgCode;
	}
	public String getEquAtSubOrgName() {
		return equAtSubOrgName;
	}
	public void setEquAtSubOrgName(String equAtSubOrgName) {
		this.equAtSubOrgName = equAtSubOrgName;
	}
	public Integer getEquAtProjectParTypeId() {
		return equAtProjectParTypeId;
	}
	public void setEquAtProjectParTypeId(Integer equAtProjectParTypeId) {
		this.equAtProjectParTypeId = equAtProjectParTypeId;
	}
	public Long getEquAtProjectId() {
		return equAtProjectId;
	}
	public void setEquAtProjectId(Long equAtProjectId) {
		this.equAtProjectId = equAtProjectId;
	}
	public String getEquAtProjectCode() {
		return equAtProjectCode;
	}
	public void setEquAtProjectCode(String equAtProjectCode) {
		this.equAtProjectCode = equAtProjectCode;
	}
	public String getEquAtProjectName() {
		return equAtProjectName;
	}
	public void setEquAtProjectName(String equAtProjectName) {
		this.equAtProjectName = equAtProjectName;
	}
	public Integer getEquFlag() {
		return equFlag;
	}
	public void setEquFlag(Integer equFlag) {
		this.equFlag = equFlag;
	}
	public String getDisEquAtName() {
		return disEquAtName;
	}
	public void setDisEquAtName(String disEquAtName) {
		this.disEquAtName = disEquAtName;
	}
	public Integer getEquTrsType() {
		return equTrsType;
	}
	public void setEquTrsType(Integer equTrsType) {
		this.equTrsType = equTrsType;
	}

}
