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
@Table(name="prod_funset")
public class ProdFunSet implements IDomainBase {

	private static final long serialVersionUID = -3846376732248191281L;

	@Transient
	public Object getObjectId() {

		return this.functionId;
		}

	@Id
	@Column(name="functionId", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long functionId;

	@ManyToOne(targetEntity=BizType.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="bizTypeId", nullable=true)
	private BizType bizType;

	private String name;
	private String note;
	private String config;
	private String dicConf;
	private Integer funType;
	private Integer beforeStatus;
	private Integer afterStatus;

	public ProdFunSet() {

		
		}

	public ProdFunSet(Long functionId) {

		this.functionId = functionId;
		}

	public Long getFunctionId() {
		return functionId;
	}
	public void setFunctionId(Long functionId) {
		this.functionId = functionId;
	}
	public BizType getBizType() {
		return bizType;
	}
	public void setBizType(BizType bizType) {
		this.bizType = bizType;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getConfig() {
		return config;
	}
	public void setConfig(String config) {
		this.config = config;
	}
	public String getDicConf() {
		return dicConf;
	}
	public void setDicConf(String dicConf) {
		this.dicConf = dicConf;
	}
	public Integer getFunType() {
		return funType;
	}
	public void setFunType(Integer funType) {
		this.funType = funType;
	}
	public Integer getBeforeStatus() {
		return beforeStatus;
	}
	public void setBeforeStatus(Integer beforeStatus) {
		this.beforeStatus = beforeStatus;
	}
	public Integer getAfterStatus() {
		return afterStatus;
	}
	public void setAfterStatus(Integer afterStatus) {
		this.afterStatus = afterStatus;
	}

	}
