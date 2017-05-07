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
@Table(name="biz_process")
public class BizProcess implements IDomainBase {

	private static final long serialVersionUID = -8239481997392076922L;

	@Transient
	public Object getObjectId() {

		return this.processId;
		}

	@Id
	@Column(name="processId", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long processId;

	private Integer bizType;
	private String bizName;
	private String district;
	private Long originOrg;
	private Long operator;
	private boolean defaultProcFlag;

	public Long getProcessId() {
		return processId;
	}
	public void setProcessId(Long processId) {
		this.processId = processId;
	}
	public Integer getBizType() {
		return bizType;
	}
	public void setBizType(Integer bizType) {
		this.bizType = bizType;
	}
	public String getBizName() {
		return bizName;
	}
	public void setBizName(String bizName) {
		this.bizName = bizName;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public Long getOriginOrg() {
		return originOrg;
	}
	public void setOriginOrg(Long originOrg) {
		this.originOrg = originOrg;
	}
	public Long getOperator() {
		return operator;
	}
	public void setOperator(Long operator) {
		this.operator = operator;
	}
	public boolean getDefaultProcFlag() {
		return defaultProcFlag;
	}
	public void setDefaultProcFlag(boolean defaultProcFlag) {
		this.defaultProcFlag = defaultProcFlag;
	}

	}
