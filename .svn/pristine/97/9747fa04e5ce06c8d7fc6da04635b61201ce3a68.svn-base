package com.hjd.domain;

import javax.persistence.Entity;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="par_person")
@PrimaryKeyJoinColumn(name="partyId")
public class PartyPerson extends Party implements IDomainBase {

	private static final long serialVersionUID = -7647273586633975471L;

	private String code;
	private String name;
	private String mobile;
	private String email;
	private String qq;//QQ
	private Integer admFlag;//管理员标识  1代表管理员  0或者null 代表非管理员

	private Long parentOrgId;
	private Long parentProId;
	private Long createPartyId;

	public PartyPerson() {

		
		}

	public PartyPerson(Long partyId) {

		super(partyId);
		}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public Integer getAdmFlag() {
		return admFlag;
	}

	public void setAdmFlag(Integer admFlag) {
		this.admFlag = admFlag;
	}

	public Long getParentOrgId() {
		return parentOrgId;
	}

	public void setParentOrgId(Long parentOrgId) {
		this.parentOrgId = parentOrgId;
	}

	public Long getParentProId() {
		return parentProId;
	}

	public void setParentProId(Long parentProId) {
		this.parentProId = parentProId;
	}

	public Long getCreatePartyId() {
		return createPartyId;
	}

	public void setCreatePartyId(Long createPartyId) {
		this.createPartyId = createPartyId;
	}

	}
