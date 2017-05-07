package com.hjd.action.bean;


import com.hjd.base.BeanAbs;

public class CategoryBean extends BeanAbs{
	
	private Integer categoryId;//主键
	private String typeNo;//分类号
	private Integer equCategoryId;//设备分类ID
	private Integer equNameId;//设备名称ID
	
	public Integer getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}
	public String getTypeNo() {
		return typeNo;
	}
	public void setTypeNo(String typeNo) {
		this.typeNo = typeNo;
	}
	public Integer getEquCategoryId() {
		return equCategoryId;
	}
	public void setEquCategoryId(Integer equCategoryId) {
		this.equCategoryId = equCategoryId;
	}
	public Integer getEquNameId() {
		return equNameId;
	}
	public void setEquNameId(Integer equNameId) {
		this.equNameId = equNameId;
	}
	
}
