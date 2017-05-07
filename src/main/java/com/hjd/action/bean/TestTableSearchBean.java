package com.hjd.action.bean;

import java.math.BigDecimal;

import com.hjd.base.IFPageRequest;

public class TestTableSearchBean extends IFPageRequest{

	private String name;
	
	private BigDecimal amount;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
}
