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
@Table(name="sys_login_role")
public class SysLoginRole implements IDomainBase {

	private static final long serialVersionUID = -1226142971141472240L;

	@Transient
	public Object getObjectId() {

		return this.userLoginRoleId;
		}

	@Id
	@Column(name="userLoginRoleId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long userLoginRoleId;

	@ManyToOne(targetEntity=SysLoginRoleType.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="role", nullable=false)
	private SysLoginRoleType role;

	@ManyToOne(targetEntity=SysLoginUser.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="loginUserId", nullable=false)
	private SysLoginUser loginUser;

	public Long getUserLoginRoleId() {
		return userLoginRoleId;
	}

	public void setUserLoginRoleId(Long userLoginRoleId) {
		this.userLoginRoleId = userLoginRoleId;
	}

	public SysLoginRoleType getRole() {
		return role;
	}

	public void setRole(SysLoginRoleType role) {
		this.role = role;
	}

	public SysLoginUser getLoginUser() {
		return loginUser;
	}

	public void setLoginUser(SysLoginUser loginUser) {
		this.loginUser = loginUser;
	}

	}
