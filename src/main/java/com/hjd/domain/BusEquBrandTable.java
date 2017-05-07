package com.hjd.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="bus_equ_brand")
@Inheritance(strategy=InheritanceType.JOINED)	//	指定一对一继承关系映射的关联方式
public class BusEquBrandTable implements IDomainBase {

	private static final long serialVersionUID = 3283351368423824792L;

	@Transient
	public Object getObjectId() {return this.id;}

	@Id
	@Column(name="id", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;//品牌ID
	
	@ManyToOne(targetEntity=EquNameManageTable.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="equNameId", nullable=false)
	private EquNameManageTable equName;//对应品牌所属的设备名称
	
	private String name;//品牌名称
	
	private Integer nameOrder;//品牌名称排序

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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getNameOrder() {
		return nameOrder;
	}

	public void setNameOrder(Integer nameOrder) {
		this.nameOrder = nameOrder;
	}

}