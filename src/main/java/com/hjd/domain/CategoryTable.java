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
@Table(name="bus_category")
public class CategoryTable implements IDomainBase {

	private static final long serialVersionUID = -8047434576758812468L;
	
	@Id
	@Column(name = "CategoryId", unique = true, nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer categoryId;//机械设备类型的ID
	
	@ManyToOne(targetEntity=EquCategoryManageTable.class) 
	@JoinColumn(name="equCategoryId", nullable=false)
	private EquCategoryManageTable equCategory;//设备类别
	
	@ManyToOne(targetEntity=EquNameManageTable.class) 
	@JoinColumn(name="equNameId", nullable=false)
	private EquNameManageTable equName;//设备名称
	
	@Column(name = "TypeNo")
	private String typeNo;//设备类别号
	
	private Integer relationType;//关系类型 1：默认关系类型 2：用户管理的关系

	public CategoryTable() {
		
		}

	public CategoryTable(Integer categoryId) {

		this.categoryId = categoryId;
		}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public EquCategoryManageTable getEquCategory() {
		return equCategory;
	}

	public void setEquCategory(EquCategoryManageTable equCategory) {
		this.equCategory = equCategory;
	}

	public EquNameManageTable getEquName() {
		return equName;
	}

	public void setEquName(EquNameManageTable equName) {
		this.equName = equName;
	}

	public String getTypeNo() {
		return typeNo;
	}

	public void setTypeNo(String typeNo) {
		this.typeNo = typeNo;
	}

	public Integer getRelationType() {
		return relationType;
	}

	public void setRelationType(Integer relationType) {
		this.relationType = relationType;
	}

	@Override
	public Object getObjectId() {
		// TODO Auto-generated method stub
		return this.categoryId;
	}

}
