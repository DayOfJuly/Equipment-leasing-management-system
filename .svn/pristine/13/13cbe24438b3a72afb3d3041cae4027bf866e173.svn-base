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
@Table(name="par_relation")
public class PartyRelation implements IDomainBase {

	private static final long serialVersionUID = -2511668208480030075L;

	@Transient
	public Object getObjectId() {

		return this.relationId;
		}

	@Id
	@Column(name="relationId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long relationId;

	@ManyToOne(targetEntity=Party.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="partyId1", nullable=false)
	private Party party1;

	@ManyToOne(targetEntity=Party.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="partyId2", nullable=false)
	private Party party2;

	@ManyToOne(targetEntity=PartyRelationType.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="relationType", nullable=false)
	private PartyRelationType relationType;

	public Long getRelationId() {
		return relationId;
	}

	public void setRelationId(Long relationId) {
		this.relationId = relationId;
	}

	public Party getParty1() {
		return party1;
	}

	public void setParty1(Party party1) {
		this.party1 = party1;
	}

	public Party getParty2() {
		return party2;
	}

	public void setParty2(Party party2) {
		this.party2 = party2;
	}

	public PartyRelationType getRelationType() {
		return relationType;
	}

	public void setRelationType(PartyRelationType relationType) {
		this.relationType = relationType;
	}

	}
