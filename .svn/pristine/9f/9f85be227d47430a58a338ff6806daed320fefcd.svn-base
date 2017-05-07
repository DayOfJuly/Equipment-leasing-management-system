package com.hjd.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="bus_equ_category_manage")
public class EquCategoryManageTable implements IDomainBase {
	
	private static final long serialVersionUID = 2355220182605448378L;
	
/*	@OneToMany(mappedBy = "equCategoryId", fetch = FetchType.EAGER)
	private Set<CategoryTable> equNameManageTable = new HashSet<CategoryTable>();*/

	@Id
	@Column(name = "EquCategoryId", unique = true, nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer equCategoryId;
	
	@Column(name = "EquipmentCategoryNo")
	private String equipmentCategoryNo;
	
	@Column(name = "EquipmentCategoryName")
	private String equipmentCategoryName;
	

	public Integer getEquCategoryId() {
		return equCategoryId;
	}

	public void setEquCategoryId(Integer equCategoryId) {
		this.equCategoryId = equCategoryId;
	}



	public String getEquipmentCategoryNo() {
		return equipmentCategoryNo;
	}

	public void setEquipmentCategoryNo(String equipmentCategoryNo) {
		this.equipmentCategoryNo = equipmentCategoryNo;
	}

	public String getEquipmentCategoryName() {
		return equipmentCategoryName;
	}

	public void setEquipmentCategoryName(String equipmentCategoryName) {
		this.equipmentCategoryName = equipmentCategoryName;
	}

/*	public Set<CategoryTable> getEquNameManageTable() {
		return equNameManageTable;
	}

	public void setEquNameManageTable(Set<CategoryTable> equNameManageTable) {
		this.equNameManageTable = equNameManageTable;
	}*/

	@Override
	public Object getObjectId() {
		// TODO Auto-generated method stub
		return this.equCategoryId;
	}

}
