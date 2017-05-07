package com.hjd.action.bean;

import java.math.BigDecimal;
import java.util.Date;

import com.hjd.base.BeanAbs;

public class TestTableBean extends BeanAbs{

	private Integer testId;
	
	private String name;
	
	private BigDecimal amount;
	
	private String longTextTest;
	
	private Date timestampTest;
	
	private Date dateTest;

	public Integer getTestId() {
		return testId;
	}

	public void setTestId(Integer testId) {
		this.testId = testId;
	}

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

	public String getLongTextTest() {
		return longTextTest;
	}

	public void setLongTextTest(String longTextTest) {
		this.longTextTest = longTextTest;
	}

	public Date getTimestampTest() {
		return timestampTest;
	}

	public void setTimestampTest(Date timestampTest) {
		this.timestampTest = timestampTest;
	}

	public Date getDateTest() {
		return dateTest;
	}

	public void setDateTest(Date dateTest) {
		this.dateTest = dateTest;
	}
	
}
