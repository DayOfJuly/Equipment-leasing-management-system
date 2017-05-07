package com.hjd.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.hjd.base.IDomainBase;

@Entity
@Table(name="bus_equ_parameter")
public class BusEquParameterTable implements IDomainBase {
	
	private static final long serialVersionUID = 2355220182605448378L;
	
	/**
	 * 设备参数的ID
	 */
	@Id
	@Column(name = "ParameterId", unique = true, nullable = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long parameterId;
	
	/**
	 * 设备参数的类型，1：品牌，2：生产厂家，3：型号，4：规格
	 */
	@Column(name = "Type")
	private Integer type;
	
	/**
	 * 设备参数的名称
	 */
	@Column(name = "name")
	private String name;
	
	/**
	 * 设备参数的名称的汉语拼音，全部大写去每个汉字的首字母拼音
	 */
	@Column(name = "NamePy")
	private String namePy;
	
	
	/**
	 * 设备参数的状态，0：删除，1：正常
	 */
	@Column(name = "Status")
	private Integer status;
	
	/**
	 * 设备参数的备注
	 */
	@Column(name = "Note")
	private String note;
	
	/**
	 * 品牌的Logo图片
	 */
	@Column(name = "LogoPic")
	private String logoPic;

	@Override
	public Object getObjectId() {
		return this.parameterId;
	}

	public Long getParameterId() {
		return parameterId;
	}

	public void setParameterId(Long parameterId) {
		this.parameterId = parameterId;
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

	public String getLogoPic() {
		return logoPic;
	}

	public void setLogoPic(String logoPic) {
		this.logoPic = logoPic;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getNamePy() {
		return namePy;
	}

	public void setNamePy(String namePy) {
		this.namePy = namePy;
	}

}
