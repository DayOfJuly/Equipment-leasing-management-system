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
@Table(name="biz_relationtype")
public class BizRelationType implements IDomainBase {

	private static final long serialVersionUID = -38911998118585183L;

	@Transient
	public Object getObjectId() {

		return this.reType;
		}

	@Id
	@Column(name="reType", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer reType;

	private String note;

	public Integer getReType() {
		return reType;
	}

	public void setReType(Integer reType) {
		this.reType = reType;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	}
