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
@Table(name="sys_loginuser")
public class SysLoginUser implements IDomainBase {

	private static final long serialVersionUID = 7931042386446111312L;

	@Transient
	public Object getObjectId() {

		return this.loginUserId;
		}

	@Id
	@Column(name="loginUserId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long loginUserId;

	@ManyToOne(targetEntity=Party.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="partyId", nullable=false)
	private Party party;

	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date updateTime;

	private String loginId;
	private String password;
	private String uId;
	private String openId;
	private String note;
	
	private String phoneNo;//注册的电话号
	private String mail;//注册的电子邮件
	
	/**
	 * 系统管理员状态：0-启用/1-停用
	 */
	private Integer state;

	public SysLoginUser() {

		
		}

	public SysLoginUser(Long loginUserId) {

		this.loginUserId = loginUserId;
		}

	public Long getLoginUserId() {
		return loginUserId;
	}
	public void setLoginUserId(Long loginUserId) {
		this.loginUserId = loginUserId;
	}
	public Party getParty() {
		return party;
	}
	public void setParty(Party party) {
		this.party = party;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUId() {
		return uId;
	}
	public void setUId(String uId) {
		this.uId = uId;
	}
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
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

	public String getuId() {
		return uId;
	}

	public void setuId(String uId) {
		this.uId = uId;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	//与数据库不对应的字段，仅用于记录用户登录的时间
	@Transient 
	private Date currentTime;

	public Date getCurrentTime() {
		return currentTime;
	}

	public void setCurrentTime(Date currentTime) {
		this.currentTime = currentTime;
	}
	
	}
