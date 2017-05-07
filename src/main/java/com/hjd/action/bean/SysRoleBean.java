package com.hjd.action.bean;

import java.util.List;

import com.hjd.base.BeanAbs;

public class SysRoleBean extends BeanAbs {

	/**
	 * 所属部门
	 */
	private Long deptId;
	/**
	 * 角色名称
	 */
	private String name;
	/**
	 * 备注
	 */
	private String note;
	/**
	 * 功能信息
	 */
	private List<Long> funcInfo;

	public Long getDeptId() {
		return deptId;
	}
	public void setDeptId(Long deptId) {
		this.deptId = deptId;
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
	public List<Long> getFuncInfo() {
		return funcInfo;
	}
	public void setFuncInfo(List<Long> funcInfo) {
		this.funcInfo = funcInfo;
	}

	}
