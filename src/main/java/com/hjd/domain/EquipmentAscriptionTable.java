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

import com.hjd.base.IDomainBase;

@Entity
@Table(name="bus_equipment_ascription")
public class EquipmentAscriptionTable implements IDomainBase{

	private static final long serialVersionUID = 5948946955133370672L;
	
	@Id
	@Column(name = "EquipmentAscriptionId", unique = true, nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer equipmentAscriptionId;
	
	@Column(name = "EquipmentId")
	private Long equipmentId;
	
	@ManyToOne(targetEntity=Party.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="PartyId", nullable=false)
	private Party party;//当事人

	public Integer getEquipmentAscriptionId() {
		return equipmentAscriptionId;
	}

	public void setEquipmentAscriptionId(Integer equipmentAscriptionId) {
		this.equipmentAscriptionId = equipmentAscriptionId;
	}

	public Long getEquipmentId() {
		return equipmentId;
	}

	public void setEquipmentId(Long equipmentId) {
		this.equipmentId = equipmentId;
	}

	public Party getParty() {
		return party;
	}

	public void setParty(Party party) {
		this.party = party;
	}

	@Override
	public Object getObjectId() {
		// TODO Auto-generated method stub
		return this.equipmentAscriptionId;
	}
	
}
