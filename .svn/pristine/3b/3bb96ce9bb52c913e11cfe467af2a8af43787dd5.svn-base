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
@Table(name="biz_type")
public class BizType implements IDomainBase {

	private static final long serialVersionUID = -5510957935752832557L;

	@Transient
	public Object getObjectId() {

		return this.bizTypeId;
		}

	@Id
	@Column(name="bizTypeId", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer bizTypeId;

	private String note;

	public Integer getBizTypeId() {
		return bizTypeId;
	}

	public void setBizTypeId(Integer bizTypeId) {
		this.bizTypeId = bizTypeId;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	}
