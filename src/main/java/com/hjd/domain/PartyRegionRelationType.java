package com.hjd.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="par_regionrelation_type")
public class PartyRegionRelationType implements IDomainBase {

	private static final long serialVersionUID = 1851763960813477312L;

	@Transient
	public Object getObjectId() {

		return this.regionReType;
		}

	@Id
	@Column(name="regionReType", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer regionReType;

	private String name;
	private String note;

	public PartyRegionRelationType() {

		
		}

	public PartyRegionRelationType(Integer regionReType) {

		this.regionReType = regionReType;
		}

	public Integer getRegionReType() {
		return regionReType;
	}
	public void setRegionReType(Integer regionReType) {
		this.regionReType = regionReType;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}

	}
