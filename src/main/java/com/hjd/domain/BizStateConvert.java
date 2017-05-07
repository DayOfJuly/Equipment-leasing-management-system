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
@Table(name="biz_stateconvert")
public class BizStateConvert implements IDomainBase {

	private static final long serialVersionUID = 4206665202254786909L;

	@Transient
	public Object getObjectId() {

		return this.convertId;
		}

	@Id
	@Column(name="convertId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long convertId;

	@ManyToOne(targetEntity=Party.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="partyId", nullable=false)
	private Party party;

	@ManyToOne(targetEntity=ProdFunSet.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="functionId", nullable=false)
	private ProdFunSet function;

	@ManyToOne(targetEntity=BizType.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="bizTypeId", nullable=false)
	private BizType bizType;

	private boolean sysAutoFlag;
	private Integer strategyType;

	public Long getConvertId() {
		return convertId;
	}
	public void setConvertId(Long convertId) {
		this.convertId = convertId;
	}
	public Party getParty() {
		return party;
	}
	public void setParty(Party party) {
		this.party = party;
	}
	public ProdFunSet getFunction() {
		return function;
	}
	public void setFunction(ProdFunSet function) {
		this.function = function;
	}
	public BizType getBizType() {
		return bizType;
	}
	public void setBizType(BizType bizType) {
		this.bizType = bizType;
	}
	public boolean getSysAutoFlag() {
		return sysAutoFlag;
	}
	public void setSysAutoFlag(boolean sysAutoFlag) {
		this.sysAutoFlag = sysAutoFlag;
	}
	public Integer getStrategyType() {
		return strategyType;
	}
	public void setStrategyType(Integer strategyType) {
		this.strategyType = strategyType;
	}

	}
