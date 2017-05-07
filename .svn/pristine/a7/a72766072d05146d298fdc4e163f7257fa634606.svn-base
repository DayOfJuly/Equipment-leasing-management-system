package com.hjd.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="biz_relation")
public class BizRelation implements IDomainBase {

	private static final long serialVersionUID = -1998752761441801669L;

	@Transient
	public Object getObjectId() {

		return this.bizRelationId;
		}

	@Id
	@Column(name="bizRelationId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long bizRelationId;

	@ManyToOne(targetEntity=BizProcess.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="firstProcessId", nullable=false)
	private BizProcess firstProcess;

	@ManyToOne(targetEntity=BizProcess.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="secProcessId", nullable=false)
	private BizProcess secProcess;

	@ManyToOne(targetEntity=BizRelationType.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="reType", nullable=false)
	private BizRelationType relationType;

	public Long getBizRelationId() {
		return bizRelationId;
	}

	public void setBizRelationId(Long bizRelationId) {
		this.bizRelationId = bizRelationId;
	}

	public BizProcess getFirstProcess() {
		return firstProcess;
	}

	public void setFirstProcess(BizProcess firstProcess) {
		this.firstProcess = firstProcess;
	}

	public BizProcess getSecProcess() {
		return secProcess;
	}

	public void setSecProcess(BizProcess secProcess) {
		this.secProcess = secProcess;
	}

	public BizRelationType getRelationType() {
		return relationType;
	}

	public void setRelationType(BizRelationType relationType) {
		this.relationType = relationType;
	}

	}
