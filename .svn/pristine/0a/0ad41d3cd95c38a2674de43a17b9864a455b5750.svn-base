package com.hjd.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.hjd.base.JsonDateSerializer;

@Entity
@Table(name="view_per_person")
public class ViewPerPerson implements Serializable {

		private static final long serialVersionUID = 7147081415060910990L;
	
		/**
		 * 个人信息
		 */
		private String code;//员工编号
		private String name;//真实姓名
		private String mobile;//手机号码
		private String email;//电子邮箱
	    private String qq;//QQ
	    private Long orgPartyId;
	    private Long proPartyId;

	    /**
	     * 系统用户的信息
	     */
		@Id
		private Long loginUserId;//系统用户标识
		@Temporal(TemporalType.TIMESTAMP)
		@JsonSerialize(using=JsonDateSerializer.class)
		private Date updateTime;//最新更新时间
		private String loginId;//登录用户名
		private Long partyId;//当事人ID
		private String note;//备注
		private String phoneNo;//注册的电话号
		private String mail;//注册的电子邮件
		private Integer state;//系统管理员状态：0-启用/1-停用
		  
		/**
		 * 当事人，父表的信息
		 */
		private String perNote;//备注
		private Integer perState;
		@Temporal(TemporalType.TIMESTAMP)
		@JsonSerialize(using=JsonDateSerializer.class)
		private Date perUpdateTime;//最新更新时间
			
		/**
		  * 企业信息
		*/
		private String orgCode;
		private String orgName;
		private Integer orgLevel;
		private String orgParentCode;
		
		/**
		 * 项目信息
		 */
		private String proName;

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

		public Long getOrgPartyId() {
			return orgPartyId;
		}

		public void setOrgPartyId(Long orgPartyId) {
			this.orgPartyId = orgPartyId;
		}

		public Long getProPartyId() {
			return proPartyId;
		}

		public void setProPartyId(Long proPartyId) {
			this.proPartyId = proPartyId;
		}

		public Long getLoginUserId() {
			return loginUserId;
		}

		public void setLoginUserId(Long loginUserId) {
			this.loginUserId = loginUserId;
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

		public Long getPartyId() {
			return partyId;
		}

		public void setPartyId(Long partyId) {
			this.partyId = partyId;
		}

		public String getNote() {
			return note;
		}

		public void setNote(String note) {
			this.note = note;
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

		public Integer getState() {
			return state;
		}

		public void setState(Integer state) {
			this.state = state;
		}

		public String getPerNote() {
			return perNote;
		}

		public void setPerNote(String perNote) {
			this.perNote = perNote;
		}

		public Integer getPerState() {
			return perState;
		}

		public void setPerState(Integer perState) {
			this.perState = perState;
		}

		public Date getPerUpdateTime() {
			return perUpdateTime;
		}

		public void setPerUpdateTime(Date perUpdateTime) {
			this.perUpdateTime = perUpdateTime;
		}

		public String getOrgCode() {
			return orgCode;
		}

		public void setOrgCode(String orgCode) {
			this.orgCode = orgCode;
		}

		public String getOrgName() {
			return orgName;
		}

		public void setOrgName(String orgName) {
			this.orgName = orgName;
		}

		public Integer getOrgLevel() {
			return orgLevel;
		}

		public void setOrgLevel(Integer orgLevel) {
			this.orgLevel = orgLevel;
		}

		public String getOrgParentCode() {
			return orgParentCode;
		}

		public void setOrgParentCode(String orgParentCode) {
			this.orgParentCode = orgParentCode;
		}

		public String getProName() {
			return proName;
		}

		public void setProName(String proName) {
			this.proName = proName;
		}

	}
