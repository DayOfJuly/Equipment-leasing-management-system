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
@Table(name="biz_party")
public class BizParty implements IDomainBase {

	private static final long serialVersionUID = 2822013181168314310L;

	@Transient
	public Object getObjectId() {

		return this.bizPartyId;
		}

	@Id
	@Column(name="bizPartyId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long bizPartyId;

	@ManyToOne(targetEntity=Party.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="partyId", nullable=false)
	private Party party;

	@ManyToOne(targetEntity=BizProcess.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="processId", nullable=false)
	private BizProcess process;

	@ManyToOne(targetEntity=BizRoleType.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="bizRoleTypeId", nullable=false)
	private BizRoleType roleType;

	public Long getBizPartyId() {
		return bizPartyId;
	}

	public void setBizPartyId(Long bizPartyId) {
		this.bizPartyId = bizPartyId;
	}

	public Party getParty() {
		return party;
	}

	public void setParty(Party party) {
		this.party = party;
	}

	public BizProcess getProcess() {
		return process;
	}

	public void setProcess(BizProcess process) {
		this.process = process;
	}

	public BizRoleType getRoleType() {
		return roleType;
	}

	public void setRoleType(BizRoleType roleType) {
		this.roleType = roleType;
	}

	}
