package com.hjd.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
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
@Table(name="par_party")
@Inheritance(strategy=InheritanceType.JOINED)	//	指定一对一继承关系映射的关联方式
public class Party implements IDomainBase {

	private static final long serialVersionUID = 3283351368423824792L;

	@Transient
	public Object getObjectId() {

		return this.partyId;
		}

	@Id
	@Column(name="partyId", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long partyId;

	@ManyToOne(targetEntity=PartyType.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="parTypeId", nullable=false)
	private PartyType parType;

	@ManyToOne(targetEntity=PartyRegion.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="regionId", nullable=true)
	private PartyRegion region;

	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date createTime;

	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date updateTime;

	private String note;
	/**
	 * 状态：0-启用/2-删除
	 */
	private Integer state;

	public Party() {

		
		}

	public Party(Long partyId) {

		this.partyId = partyId;
		}

	public Long getPartyId() {
		return partyId;
	}

	public void setPartyId(Long partyId) {
		this.partyId = partyId;
	}

	public PartyType getParType() {
		return parType;
	}

	public void setParType(PartyType parType) {
		this.parType = parType;
	}

	public PartyRegion getRegion() {
		return region;
	}

	public void setRegion(PartyRegion region) {
		this.region = region;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	}