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
@Table(name="biz_operator")
public class BizOperator implements IDomainBase {

	private static final long serialVersionUID = 7385017638955629774L;

	@Transient
	public Object getObjectId() {

		return this.operatorId;
		}

	@Id
	@Column(name="operatorId", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long operatorId;

	@ManyToOne(targetEntity=SysLoginUser.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="loginUserId", nullable=false)
	private SysLoginUser loginUser;

	@ManyToOne(targetEntity=BizStateConvert.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="convertId", nullable=false)
	private BizStateConvert stateConvert;

	public Long getOperatorId() {
		return operatorId;
	}

	public void setOperatorId(Long operatorId) {
		this.operatorId = operatorId;
	}

	public SysLoginUser getLoginUser() {
		return loginUser;
	}

	public void setLoginUser(SysLoginUser loginUser) {
		this.loginUser = loginUser;
	}

	public BizStateConvert getStateConvert() {
		return stateConvert;
	}

	public void setStateConvert(BizStateConvert stateConvert) {
		this.stateConvert = stateConvert;
	}

	}
