package com.hjd.domain;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.hjd.base.IDomainBase;
import com.hjd.base.JsonDateSerializer;


@Entity
@Table(name="bus_sale")
@PrimaryKeyJoinColumn(name="dataId")
public class SaleTable extends BizExData implements IDomainBase {
	
	private static final long serialVersionUID = -8181572144678441621L;

	/*为了查询效率以及发布后不需要变动，所以将对应的字段添加到出售出租的表中*/
	private String equNo;//设备编号
	private BigDecimal power;//功率
	private String technicalStatus;//技术状况
	private String manufacturer;
	@Column(name = "ProductionDate")
	@Temporal(TemporalType.DATE)
	private Date productionDate;//出厂日期
	private String equName;//设备名称  
	private String brandName;//品牌
	private String modelName; //型号
	private String standardName; //规格
	/*将所在城市分成了三个字段*/
	private String onProvince;//省
	private String onCity;//市
	private String onDistrict;//区	
	
	@Column(name = "EnterpriseName")
	private String enterpriseName;//企业名称  --- 类型改变  输入变成回显  改名成--联系单位--单位名称
	
	//--------------------暂时不用------------------------------
	@Column(name = "PriceType")
	private Integer priceType;//价格类型
	
	@Column(name = "ShortestLease")
	private Integer shortestLease;//最短租期
	
	@Column(name = "ElectronicMail")
	private String electronicMail;//电子邮箱
	
	@Column(name = "FixedTelephone")
	private String fixedTelephone;//固定电话
	//--------------------暂时不用------------------------------
	
	
	
	
	
	

	@Column(name = "InfoTitle")
	private String infoTitle;//信息标题

	@ManyToOne(targetEntity=EquipmentTable.class) 
	@JoinColumn(name="EquipmentId", nullable=false)
	private EquipmentTable equipmentTable;//设备资源管理表主键
	
	@Column(name = "Price")
	private BigDecimal price;//价格

	@Column(name = "DetailedDescription")
	private String detailedDescription;//详细说明
	
	@Column(name = "EquipmentPic")
	private String equipmentPic;//设备图片（名称）
	
	@Column(name = "ReleaseDate")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date releaseDate;//发布日期
	
	@Column(name = "ContactPerson")
	private String contactPerson;//联系人
	
	@Column(name = "ContactPhone")
	private String contactPhone;//联系手机--联系电话
	
	@Column(name = "QQNo")
	private String qqNo;//QQ
	
	@Column(name = "ContactAddress")
	private String contactAddress;//联系地址
	
	@JoinColumn(name="AtCity")
	private Long atCity;//所在城市--设备所在城市
	
	public String getInfoTitle() {
		return infoTitle;
	}

	public void setInfoTitle(String infoTitle) {
		this.infoTitle = infoTitle;
	}

	public EquipmentTable getEquipmentTable() {
		return equipmentTable;
	}

	public void setEquipmentTable(EquipmentTable equipmentTable) {
		this.equipmentTable = equipmentTable;
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
	//与数据库不对应的字段，仅用于显示数据
	@Transient 
	private String atCityDesc;
	public String getAtCityDesc() {
		return atCityDesc;
	}

	public void setAtCityDesc(String atCityDesc) {
		this.atCityDesc = atCityDesc;
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

	public String getStandardName() {
		return standardName;
	}

	public void setStandardName(String standardName) {
		this.standardName = standardName;
	}
	

}
