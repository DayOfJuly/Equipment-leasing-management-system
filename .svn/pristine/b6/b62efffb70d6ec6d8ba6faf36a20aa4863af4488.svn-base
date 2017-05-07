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
@Table(name="bus_equ_standard")
@Inheritance(strategy=InheritanceType.JOINED)	//	指定一对一继承关系映射的关联方式
public class BusEquStandardTable implements IDomainBase {

	private static final long serialVersionUID = 3283351368423824792L;

	@Transient
	public Object getObjectId() {return this.id;}

	@Id
	@Column(name="id", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;//规格ID

	@ManyToOne(targetEntity=BusEquBrandTable.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="brandId", nullable=false)
	private BusEquBrandTable equBrand;//规格所属的设备品牌
	
	private String name;//规格的名称

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public BusEquBrandTable getEquBrand() {
		return equBrand;
	}

	public void setEquBrand(BusEquBrandTable equBrand) {
		this.equBrand = equBrand;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}