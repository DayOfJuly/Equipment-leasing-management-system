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
@Table(name="biz_roletype")
public class BizRoleType implements IDomainBase {

	private static final long serialVersionUID = 6475483734519450023L;

	@Transient
	public Object getObjectId() {

		return this.bizRoleTypeId;
		}

	@Id
	@Column(name="bizRoleTypeId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer bizRoleTypeId;

	private String note;

	public Integer getBizRoleTypeId() {
		return bizRoleTypeId;
	}

	public void setBizRoleTypeId(Integer bizRoleTypeId) {
		this.bizRoleTypeId = bizRoleTypeId;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	}
