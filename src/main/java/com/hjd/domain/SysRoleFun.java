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
@Table(name="sys_rolefun")
public class SysRoleFun implements IDomainBase {

	private static final long serialVersionUID = 7526484357613666640L;

	@Override
	public Object getObjectId() {

		return this.roleFunId;
		}

	@Id
	@Column(name="roleFunId", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long roleFunId;

	@ManyToOne(targetEntity=SysLoginRoleType.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="role", nullable=false)
	private SysLoginRoleType role;

	@ManyToOne(targetEntity=ProdFunSet.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="functionId", nullable=false)
	private ProdFunSet function;

	public Long getRoleFunId() {
		return roleFunId;
	}

	public void setRoleFunId(Long roleFunId) {
		this.roleFunId = roleFunId;
	}

	public SysLoginRoleType getRole() {
		return role;
	}

	public void setRole(SysLoginRoleType role) {
		this.role = role;
	}

	public ProdFunSet getFunction() {
		return function;
	}

	public void setFunction(ProdFunSet function) {
		this.function = function;
	}

	}
