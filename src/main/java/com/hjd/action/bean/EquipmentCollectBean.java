package com.hjd.action.bean;

import java.math.BigDecimal;

public class EquipmentCollectBean {
	private BigDecimal equipmentCost;//原值
	private Long quantity;//数量
	
	public  EquipmentCollectBean(){
		
	}
	
	public  EquipmentCollectBean(BigDecimal equipmentCost,Long quantity){
		setQuantity(quantity);
		setEquipmentCost(equipmentCost);
	}
	
	public BigDecimal getEquipmentCost() {
		return equipmentCost;
	}
	public void setEquipmentCost(BigDecimal equipmentCost) {
		this.equipmentCost = equipmentCost;
	}
	public Long getQuantity() {
		return quantity;
	}
	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}
	
	
}
