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
@Table(name="par_partytype")
public class PartyType implements IDomainBase {

	private static final long serialVersionUID = -1985845605305282817L;

	@Transient
	public Object getObjectId() {

		return this.parTypeId;
		}

	@Id
	@Column(name="parTypeId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer parTypeId;

	private String note;
	private String name;

	public PartyType() {

		
		}

	public PartyType(Integer parTypeId) {

		this.parTypeId = parTypeId;
		}

	public Integer getParTypeId() {
		return parTypeId;
	}

	public void setParTypeId(Integer parTypeId) {
		this.parTypeId = parTypeId;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	}