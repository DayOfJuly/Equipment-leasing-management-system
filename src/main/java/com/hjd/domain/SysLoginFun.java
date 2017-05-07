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
@Table(name="sys_login_fun")
public class SysLoginFun implements IDomainBase {

	private static final long serialVersionUID = -1226142971141472240L;

	@Transient
	public Object getObjectId() {

		return this.userLoginFunId;
		}

	@Id
	@Column(name="userLoginFunId", unique=true, nullable=false) 
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long userLoginFunId;

	@ManyToOne(targetEntity=ProdFunSet.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="functionId", nullable=false)
	private ProdFunSet functionId;
	
	@ManyToOne(targetEntity=SysLoginUser.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="loginUserId", nullable=false)
	private SysLoginUser loginUser;

	public Long getUserLoginFunId() {
		return userLoginFunId;
	}

	public void setUserLoginFunId(Long userLoginFunId) {
		this.userLoginFunId = userLoginFunId;
	}



	public ProdFunSet getFunctionId() {
		return functionId;
	}

	public void setFunctionId(ProdFunSet functionId) {
		this.functionId = functionId;
	}

	public SysLoginUser getLoginUser() {
		return loginUser;
	}

	public void setLoginUser(SysLoginUser loginUser) {
		this.loginUser = loginUser;
	}

	}
