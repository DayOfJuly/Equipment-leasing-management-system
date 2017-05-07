package com.hjd.domain;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="bus_depreciation_hist")
@Inheritance(strategy=InheritanceType.JOINED)	//	指定一对一继承关系映射的关联方式
public class BusDepreciationHistTable implements IDomainBase {

	private static final long serialVersionUID = 3283351368423824792L;

	@Transient
	public Object getObjectId() {return this.id;}

	@Id
	@Column(name="id", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;//折旧费登记的记录ID

/*	@ManyToOne(targetEntity=EquipmentTable.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="equipmentId", nullable=false)
	private EquipmentTable depEqu;//折旧的设备
*/	
	private Long equipmentId;
	
	private String month;//折旧费登记的月份
	
	private BigDecimal depreciation;//折旧费
	

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

/*	public EquipmentTable getDepEqu() {
		return depEqu;
	}

	public void setDepEqu(EquipmentTable depEqu) {
		this.depEqu = depEqu;
	}*/

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public BigDecimal getDepreciation() {
		return depreciation;
	}

	public void setDepreciation(BigDecimal depreciation) {
		this.depreciation = depreciation;
	}

	public Long getEquipmentId() {
		return equipmentId;
	}

	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}

}