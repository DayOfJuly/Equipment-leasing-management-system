package com.hjd.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="bus_equ_name_manage")
public class EquNameManageTable implements IDomainBase {

	private static final long serialVersionUID = 8885551612916762262L;

	@Id
	@Column(name = "EquNameId", unique = true, nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer equNameId;
	
	@Column(name = "EquipmentNo")
	private String equipmentNo;
	
	@Column(name = "EquipmentName")
	private String equipmentName;
	
	@Column(name= "Second")
	private String second;
	
	@Column(name= "searchCount")
	private Long searchCount;
	
	public Integer getEquNameId() {
		return equNameId;
	}

	public void setEquNameId(Integer equNameId) {
		this.equNameId = equNameId;
	}

	public String getEquipmentNo() {
		return equipmentNo;
	}

	public void setEquipmentNo(String equipmentNo) {
		this.equipmentNo = equipmentNo;
	}

	public String getEquipmentName() {
		return equipmentName;
	}

	public void setEquipmentName(String equipmentName) {
		this.equipmentName = equipmentName;
	}


	public String getSecond() {
		return second;
	}

	public void setSecond(String second) {
		this.second = second;
	}

	@Override
	public Object getObjectId() {
		// TODO Auto-generated method stub
		return this.equNameId;
	}

	public Long getSearchCount() {
		return searchCount;
	}

	public void setSearchCount(Long searchCount) {
		this.searchCount = searchCount;
	}
	
}
