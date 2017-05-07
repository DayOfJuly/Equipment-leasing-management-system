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
@Table(name="view_equ_count")
public class ViewEquCount implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/* 内部资源有500台设备原值：有3亿元
		外部资源有400台设备原值：有2亿元
		内部供应商共计500家
		外部供应商共计1000家
		可出租设备100台
		可出售设备50台*/
	
	@Id
	private String uuidTemp;//临时唯一值，作为视图的主键
	//内部企业
	private BigDecimal innerOrg;
	//外部企业
	private BigDecimal outerOrg;
	//可出租设备
	private BigDecimal canRentNum;
	//可出售设备
	private BigDecimal canSaleNum;
	//可求租设备
	private BigDecimal demandRentNum;
	//可求购设备
	private BigDecimal demandSaleNum;
	//内部资源
	private BigDecimal innerEquNum;
	//外部资源
	private BigDecimal outerEquNum;
	//内部原值
	private BigDecimal innerEquCost;
	//外部原值
	private BigDecimal outerEquCost;
	
	public String getUuidTemp() {
		return uuidTemp;
	}
	public void setUuidTemp(String uuidTemp) {
		this.uuidTemp = uuidTemp;
	}
	public BigDecimal getInnerOrg() {
		return innerOrg;
	}
	public void setInnerOrg(BigDecimal innerOrg) {
		this.innerOrg = innerOrg;
	}
	public BigDecimal getOuterOrg() {
		return outerOrg;
	}
	public void setOuterOrg(BigDecimal outerOrg) {
		this.outerOrg = outerOrg;
	}
	public BigDecimal getCanRentNum() {
		return canRentNum;
	}
	public void setCanRentNum(BigDecimal canRentNum) {
		this.canRentNum = canRentNum;
	}
	public BigDecimal getCanSaleNum() {
		return canSaleNum;
	}
	public void setCanSaleNum(BigDecimal canSaleNum) {
		this.canSaleNum = canSaleNum;
	}
	public BigDecimal getInnerEquNum() {
		return innerEquNum;
	}
	public void setInnerEquNum(BigDecimal innerEquNum) {
		this.innerEquNum = innerEquNum;
	}
	public BigDecimal getOuterEquNum() {
		return outerEquNum;
	}
	public void setOuterEquNum(BigDecimal outerEquNum) {
		this.outerEquNum = outerEquNum;
	}
	public BigDecimal getInnerEquCost() {
		return innerEquCost;
	}
	public void setInnerEquCost(BigDecimal innerEquCost) {
		this.innerEquCost = innerEquCost;
	}
	public BigDecimal getOuterEquCost() {
		return outerEquCost;
	}
	public void setOuterEquCost(BigDecimal outerEquCost) {
		this.outerEquCost = outerEquCost;
	}
	public BigDecimal getDemandRentNum() {
		return demandRentNum;
	}
	public void setDemandRentNum(BigDecimal demandRentNum) {
		this.demandRentNum = demandRentNum;
	}
	public BigDecimal getDemandSaleNum() {
		return demandSaleNum;
	}
	public void setDemandSaleNum(BigDecimal demandSaleNum) {
		this.demandSaleNum = demandSaleNum;
	}
	
}