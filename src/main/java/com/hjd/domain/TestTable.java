package com.hjd.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.hjd.base.JsonDateSerializer;

@Entity
@Table(name="test_table")
public class TestTable implements Serializable{

	private static final long serialVersionUID = -8047434576758812468L;

	@Id
	@Column(name = "testId", unique = true, nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer testId;
	
	private String name;
	
	private BigDecimal amount;
	
	
	
	public TestTable(String name, BigDecimal amount) {
		this.name = name;
		this.amount = amount;
	}

	public TestTable() {
	}


	@Lob
	private String longTextTest;
	
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=JsonDateSerializer.class)
	private Date timestampTest;
	
	@Temporal(TemporalType.DATE)
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
