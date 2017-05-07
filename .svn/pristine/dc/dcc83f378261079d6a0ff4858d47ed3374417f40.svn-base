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
@Table(name="biz_state")
public class BizState implements IDomainBase {

	private static final long serialVersionUID = -3354887283013563697L;

	@Transient
	public Object getObjectId() {

		return this.stateId;
		}

	@Id
	@Column(name="stateId", unique=true, nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public Long stateId;

	@ManyToOne(targetEntity=BizProcess.class, fetch=FetchType.EAGER) 
	@JoinColumn(name="processId", nullable=false)
	private BizProcess process;

	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date stateTime;

	private String stateDesc;
	private boolean runningFlag;
	private Integer agreeNum;
	private boolean currFlag;
	private Integer desentNum;
	private boolean finishFlag;
	private Integer strategyType;
	private Integer status;
	private Integer exeNum;

	public Long getStateId() {
		return stateId;
	}
	public void setStateId(Long stateId) {
		this.stateId = stateId;
	}
	public BizProcess getProcess() {
		return process;
	}
	public void setProcess(BizProcess process) {
		this.process = process;
	}
	public String getStateDesc() {
		return stateDesc;
	}
	public void setStateDesc(String stateDesc) {
		this.stateDesc = stateDesc;
	}
	public Date getStateTime() {
		return stateTime;
	}
	public void setStateTime(Date stateTime) {
		this.stateTime = stateTime;
	}
	public boolean getRunningFlag() {
		return runningFlag;
	}
	public void setRunningFlag(boolean runningFlag) {
		this.runningFlag = runningFlag;
	}
	public Integer getAgreeNum() {
		return agreeNum;
	}
	public void setAgreeNum(Integer agreeNum) {
		this.agreeNum = agreeNum;
	}
	public boolean getCurrFlag() {
		return currFlag;
	}
	public void setCurrFlag(boolean currFlag) {
		this.currFlag = currFlag;
	}
	public Integer getDesentNum() {
		return desentNum;
	}
	public void setDesentNum(Integer desentNum) {
		this.desentNum = desentNum;
	}
	public boolean getFinishFlag() {
		return finishFlag;
	}
	public void setFinishFlag(boolean finishFlag) {
		this.finishFlag = finishFlag;
	}
	public Integer getStrategyType() {
		return strategyType;
	}
	public void setStrategyType(Integer strategyType) {
		this.strategyType = strategyType;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getExeNum() {
		return exeNum;
	}
	public void setExeNum(Integer exeNum) {
		this.exeNum = exeNum;
	}

	}
