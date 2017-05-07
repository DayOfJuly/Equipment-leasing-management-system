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
@Table(name="bus_equ_name_parameter")
public class BusEquNameParameterTable implements IDomainBase {

	private static final long serialVersionUID = -8047434576758812468L;
	/**
	 * 设备销量和设备参数的关系表的ID
	 */
	@Id
	@Column(name = "Id", unique = true, nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@ManyToOne(targetEntity=EquNameManageTable.class) 
	@JoinColumn(name="equNameId", nullable=false)
	private EquNameManageTable equName;//设备小类

	
	@ManyToOne(targetEntity=BusEquParameterTable.class) 
	@JoinColumn(name="parameterId", nullable=false)
	private BusEquParameterTable equParameter;//设备参数
	
	@Override
	public Object getObjectId() {
		return this.id;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public EquNameManageTable getEquName() {
		return equName;
	}

	public void setEquName(EquNameManageTable equName) {
		this.equName = equName;
	}

	public BusEquParameterTable getEquParameter() {
		return equParameter;
	}

	public void setEquParameter(BusEquParameterTable equParameter) {
		this.equParameter = equParameter;
	}

}
