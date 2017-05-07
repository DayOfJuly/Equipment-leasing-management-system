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
@Table(name="par_relation_type")
public class PartyRelationType implements IDomainBase {

	private static final long serialVersionUID = 6449015321707799484L;

	@Transient
	public Object getObjectId() {

		return this.relationType;
		}

	@Id
	@Column(name="relationType", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer relationType;

	private String name;
	private String note;

	public PartyRelationType() {

		
		}

	public PartyRelationType(Integer relationType) {

		this.relationType = relationType;
		}

	public Integer getRelationType() {
		return relationType;
	}
	public void setRelationType(Integer relationType) {
		this.relationType = relationType;
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
