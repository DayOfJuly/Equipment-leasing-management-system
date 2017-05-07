package com.hjd.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 创建视图的注意之处：
 * 1：当成一个单表，仅进行查询的操作
 * 2：MYSQL数据库不区分大小写
 * 3：创建对应的视图对象的时候有主键的概念，注意时间类型、浮点类型的数据需要特殊的说明一下，属性和字段名一致时不需要特殊的匹配说明，否则需要指定匹配的规则
 * @author Qian
 *
 */
@Entity
@Table(name="view_rent_hist_sum")
public class ViewRentHistSum implements Serializable {

	private static final long serialVersionUID = 3283351368423824792L;

/*	@Id
	private Long id;//租赁费登记的ID
*/	@Id
	private Long equId;//租赁的设备
	
	private String month;//登记月份
	
	private BigDecimal amount;//结算金额
	
	private BigDecimal cost;//进出场费/安拆费
	
	private BigDecimal deductCost;//折扣费
	
	private Long equAtOrgId;//设备所属单位的ID
	
	private String equAtOrgCode;//设备所属单位的CODE
	
//	private String equAtOrgName;//设备所属单位的名称

/*	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}*/

	public Long getEquId() {
		return equId;
	}

	public void setEquId(Long equId) {
		this.equId = equId;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}


	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public BigDecimal getCost() {
		return cost;
	}

	public void setCost(BigDecimal cost) {
		this.cost = cost;
	}

	public BigDecimal getDeductCost() {
		return deductCost;
	}

	public void setDeductCost(BigDecimal deductCost) {
		this.deductCost = deductCost;
	}

	public Long getEquAtOrgId() {
		return equAtOrgId;
	}

	public void setEquAtOrgId(Long equAtOrgId) {
		this.equAtOrgId = equAtOrgId;
	}

	public String getEquAtOrgCode() {
		return equAtOrgCode;
	}

	public void setEquAtOrgCode(String equAtOrgCode) {
		this.equAtOrgCode = equAtOrgCode;
	}

//	public String getEquAtOrgName() {
//		return equAtOrgName;
//	}
//
//	public void setEquAtOrgName(String equAtOrgName) {
//		this.equAtOrgName = equAtOrgName;
//	}
	
}