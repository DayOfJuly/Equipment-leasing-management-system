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
@Table(name="biz_datastate")
public class BizDataState implements IDomainBase {

	private static final long serialVersionUID = -249806010592740997L;

	@Transient
	public Object getObjectId() {

		return this.dataState;
		}

	@Id
	@Column(name="dataState", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer dataState;

	private String note;

	public BizDataState() {

		
		}

	public BizDataState(Integer dataState) {

		this.dataState = dataState;
		}

	public Integer getDataState() {
		return dataState;
	}

	public void setDataState(Integer dataState) {
		this.dataState = dataState;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	}
