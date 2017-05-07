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
@Table(name="par_region")
public class PartyRegion implements IDomainBase {

	private static final long serialVersionUID = -1390042054535570669L;

	@Transient
	public Object getObjectId() {

		return this.regionId;
		}

	@Id
	@Column(name="regionId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long regionId;

	private String code;
	private String name;
	private String note;
	private Integer type;
	private String fpy;//设备名称的大写首字母

	public String getFpy() {
		return fpy;
	}

	public void setFpy(String fpy) {
		this.fpy = fpy;
	}

	public PartyRegion() {

		
		}

	public PartyRegion(Long regionId) {

		this.regionId = regionId;
		}

	public Long getRegionId() {
		return regionId;
	}
	public void setRegionId(Long regionId) {
		this.regionId = regionId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
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

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	}
