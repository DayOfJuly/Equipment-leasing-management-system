package com.hjd.domain;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="bus_equipment_category")
public class EquipmentCategoryTable  implements IDomainBase{
private static final long serialVersionUID = -8047434576758812468L;
	
	@Id
	@Column(name = "EquipmentCategoryId", unique = true, nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer equipmentCategoryId;
	
	@Column(name = "EquipmentId")
	private Long equipmentId;//设备资源（台账）
	
	@ManyToOne(targetEntity=CategoryTable.class) 
	@JoinColumn(name="CategoryId", nullable=false)
	private CategoryTable categoryTable;//设备分类信息

	public Integer getEquipmentCategoryId() {
		return equipmentCategoryId;
	}

	public void setEquipmentCategoryId(Integer equipmentCategoryId) {
		this.equipmentCategoryId = equipmentCategoryId;
	}


	public Long getEquipmentId() {
		return equipmentId;
	}

	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}

	public CategoryTable getCategoryTable() {
		return categoryTable;
	}

	public void setCategoryTable(CategoryTable categoryTable) {
		this.categoryTable = categoryTable;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public Object getObjectId() {
		// TODO Auto-generated method stub
		return equipmentCategoryId;
	}
	
	
}
