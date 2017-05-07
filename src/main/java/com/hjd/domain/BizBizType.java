package com.hjd.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.hjd.base.IDomainBase;
import com.hjd.base.JsonDateSerializer;

@Entity
@Table(name="biz_biztype")
public class BizBizType implements IDomainBase {

	private static final long serialVersionUID = -5285916522105789411L;

	@Transient
	public Object getObjectId() {

		return this.bizTypesId;
		}

	@Id
	@Column(name="bizTypesId", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long bizTypesId;

	@ManyToOne(targetEntity=BizProcess.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="processId", nullable=false)
	private BizProcess process;

	@ManyToOne(targetEntity=BizType.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="bizTypeId", nullable=false)
	private BizType bizType;

	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date updateTime;

	private String note;
	private boolean CurrFlag;

	public Long getBizTypesId() {
		return bizTypesId;
	}
	public void setBizTypesId(Long bizTypesId) {
		this.bizTypesId = bizTypesId;
	}
	public BizProcess getProcess() {
		return process;
	}
	public void setProcess(BizProcess process) {
		this.process = process;
	}
	public BizType getBizType() {
		return bizType;
	}
	public void setBizType(BizType bizType) {
		this.bizType = bizType;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public boolean getCurrFlag() {
		return CurrFlag;
	}
	public void setCurrFlag(boolean currFlag) {
		CurrFlag = currFlag;
	}

	}
