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
@Table(name="par_region_relation")
public class PartyRegionRelation implements IDomainBase {

	private static final long serialVersionUID = 2808597267036625041L;

	@Transient
	public Object getObjectId() {

		return this.regionReId;
		}

	@Id
	@Column(name="regionReId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long regionReId;

	@ManyToOne(targetEntity=PartyRegion.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="regionId1", nullable=false)
	private PartyRegion region1;

	@ManyToOne(targetEntity=PartyRegion.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="regionId2", nullable=false)
	private PartyRegion region2;

	@ManyToOne(targetEntity=PartyRegionRelationType.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="regionReType", nullable=false)
	private PartyRegionRelationType relationType;

	public Long getRegionReId() {
		return regionReId;
	}

	public void setRegionReId(Long regionReId) {
		this.regionReId = regionReId;
	}

	public PartyRegion getRegion1() {
		return region1;
	}

	public void setRegion1(PartyRegion region1) {
		this.region1 = region1;
	}

	public PartyRegion getRegion2() {
		return region2;
	}

	public void setRegion2(PartyRegion region2) {
		this.region2 = region2;
	}

	public PartyRegionRelationType getRelationType() {
		return relationType;
	}

	public void setRelationType(PartyRegionRelationType relationType) {
		this.relationType = relationType;
	}

	}
