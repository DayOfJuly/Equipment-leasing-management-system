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
@Table(name="biz_operation")
public class BizOperation implements IDomainBase {

	private static final long serialVersionUID = 7574591259420471705L;

	@Transient
	public Object getObjectId() {

		return this.operationId;
		}

	@Id
	@Column(name="operationId", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long operationId;

	@ManyToOne(targetEntity=BizProcess.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="processId", nullable=false)
	private BizProcess process;

	@ManyToOne(targetEntity=ProdFunSet.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="functionId", nullable=false)
	private ProdFunSet function;

	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date exeTime;

	private String actionName;
	private String actionDesc;
	private Long operRole;
	private Long operLoginId;
	private boolean exeFlag;
	private String functionName;
	private Integer nextState;
	private boolean finishFlag;
	private boolean signFlag;
	private Long originOrg;

	public Long getOperationId() {
		return operationId;
	}
	public void setOperationId(Long operationId) {
		this.operationId = operationId;
	}
	public BizProcess getProcess() {
		return process;
	}
	public void setProcess(BizProcess process) {
		this.process = process;
	}
	public ProdFunSet getFunction() {
		return function;
	}
	public void setFunction(ProdFunSet function) {
		this.function = function;
	}
	public Date getExeTime() {
		return exeTime;
	}
	public void setExeTime(Date exeTime) {
		this.exeTime = exeTime;
	}
	public String getActionName() {
		return actionName;
	}
	public void setActionName(String actionName) {
		this.actionName = actionName;
	}
	public String getActionDesc() {
		return actionDesc;
	}
	public void setActionDesc(String actionDesc) {
		this.actionDesc = actionDesc;
	}
	public Long getOperRole() {
		return operRole;
	}
	public void setOperRole(Long operRole) {
		this.operRole = operRole;
	}
	public Long getOperLoginId() {
		return operLoginId;
	}
	public void setOperLoginId(Long operLoginId) {
		this.operLoginId = operLoginId;
	}
	public boolean getExeFlag() {
		return exeFlag;
	}
	public void setExeFlag(boolean exeFlag) {
		this.exeFlag = exeFlag;
	}
	public String getFunctionName() {
		return functionName;
	}
	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}
	public Integer getNextState() {
		return nextState;
	}
	public void setNextState(Integer nextState) {
		this.nextState = nextState;
	}
	public boolean getFinishFlag() {
		return finishFlag;
	}
	public void setFinishFlag(boolean finishFlag) {
		this.finishFlag = finishFlag;
	}
	public boolean getSignFlag() {
		return signFlag;
	}
	public void setSignFlag(boolean signFlag) {
		this.signFlag = signFlag;
	}
	public Long getOriginOrg() {
		return originOrg;
	}
	public void setOriginOrg(Long originOrg) {
		this.originOrg = originOrg;
	}

	}
