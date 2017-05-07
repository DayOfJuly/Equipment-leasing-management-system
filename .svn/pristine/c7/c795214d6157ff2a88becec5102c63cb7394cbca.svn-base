package com.hjd.domain;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.hjd.base.IDomainBase;
import com.hjd.base.JsonDateSerializer;

@Entity
@Table(name="bus_demandsale")
@PrimaryKeyJoinColumn(name="dataId")
public class DemandSaleTable extends BizExData implements IDomainBase{
	
private static final long serialVersionUID = -8540980398997531638L;
	


	//设备选择
	//设备信息
	//    需要四个字段，设备名称、品牌、型号、规格  //new add 
	private String equName;//设备名称  
	private String brandName;//品牌
	private String modelName; //型号
	private String standardName; //规格
	/*将所在城市分成了三个字段*/
	private String onProvince;//省
	private String onCity;//市
	private String onDistrict;//区	
	/*将使用城市分成了三个字段*/
	private String useProvince;//省
	private String useCity;//市
	private String useDistrict;//区
	//详细地址
    private String address; //new add
	//购买单价
    private BigDecimal price;// new add
    //计量单位
	private String second;// new add
    

	//---------------------------暂时不用-----------------------------

	@Column(name = "ExpectedDeposit")
	private BigDecimal expectedDeposit;//期望押金
		
	@Column(name = "ElectronicMail")
	private String electronicMail;//电子邮箱
	
	@Column(name = "FixedTelephone")
	private String fixedTelephone;//固定电话
	
	@Column(name = "ExpectedAmount")
	private BigDecimal expectedAmount;//期望金额
	//---------------------------暂时不用-----------------------------





	@Column(name = "InfoTitle")
	private String infoTitle;//信息标题
	
	@Column(name = "PriceType")
	private Integer priceType;//价格类型
	
	@Column(name = "Quantity")
	private BigDecimal quantity;//数量
	
	@Column(name = "DetailedDescription")
	private String detailedDescription;//详细说明
	
	@Column(name = "EquipmentPic")
	private String equipmentPic;//设备图片（名称）
	
	@Column(name = "ReleaseDate")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date releaseDate;//发布日期
	
	@Column(name = "EnterpriseName")
	private String enterpriseName;//企业名称--单位名称
	
	@Column(name = "ContactPerson")
	private String contactPerson;//联系人
	
	@Column(name = "ContactPhone")
	private String contactPhone;//联系手机--联系电话
	
	@Column(name = "QQNo")
	private String qqNo;//QQ
	
	@Column(name = "ContactAddress")
	private String contactAddress;//联系地址
	
	@JoinColumn(name="FaceCity")
	private Long faceCity;//面向城市
	
	@JoinColumn(name="AtCity")
	private Long atCity;//所在城市

	public String getInfoTitle() {
		return infoTitle;
	}

	public void setInfoTitle(String infoTitle) {
		this.infoTitle = infoTitle;
	}

	public BigDecimal getExpectedAmount() {
		return expectedAmount;
	}

	public void setExpectedAmount(BigDecimal expectedAmount) {
		this.expectedAmount = expectedAmount;
	}

	public BigDecimal getExpectedDeposit() {
		return expectedDeposit;
	}

	public void setExpectedDeposit(BigDecimal expectedDeposit) {
		this.expectedDeposit = expectedDeposit;
	}

	public BigDecimal getQuantity() {
		return quantity;
	}

	public void setQuantity(BigDecimal quantity) {
		this.quantity = quantity;
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

	public Long getFaceCity() {
		return faceCity;
	}

	public void setFaceCity(Long faceCity) {
		this.faceCity = faceCity;
	}

	public Long getAtCity() {
		return atCity;
	}

	public void setAtCity(Long atCity) {
		this.atCity = atCity;
	}

	public Integer getPriceType() {
		return priceType;
	}

	public void setPriceType(Integer priceType) {
		this.priceType = priceType;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
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

	public String getUseProvince() {
		return useProvince;
	}

	public void setUseProvince(String useProvince) {
		this.useProvince = useProvince;
	}

	public String getUseCity() {
		return useCity;
	}

	public void setUseCity(String useCity) {
		this.useCity = useCity;
	}

	public String getUseDistrict() {
		return useDistrict;
	}

	public void setUseDistrict(String useDistrict) {
		this.useDistrict = useDistrict;
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

	public String getSecond() {
		return second;
	}

	public void setSecond(String second) {
		this.second = second;
	}
	
}
