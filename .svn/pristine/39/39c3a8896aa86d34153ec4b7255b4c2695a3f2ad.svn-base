package com.hjd.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.hjd.base.JsonDateSerializer;
/**
 * 创建视图的注意之处：
 * 1：当成一个单表，仅进行查询的操作
 * 2：MYSQL数据库不区分大小写
 * 3：创建对应的视图对象的时候有主键的概念，注意时间类型、浮点类型的数据需要特殊的说明一下，属性和字段名一致时不需要特殊的匹配说明，否则需要指定匹配的规则
 * @author Qian
 *
 */
@Entity
@Table(name="rent_sale_published_view")
public class RentSalePublishedView implements Serializable {
	
		/**
		 * 
		 */
		private static final long serialVersionUID = 4478274421668524973L;
		
		//数据的ID，记录主键
		@Id
		@Column(name="dataId", unique=true, nullable=false)
		private Long dataId;
		//申请时间
		@Temporal(TemporalType.TIMESTAMP)
		@JsonSerialize(using=JsonDateSerializer.class)
		private Date releaseDate;
		
		 //状态类型ID
		 private Integer dataState;
		 //流程ID
		 private Long processId;
		 //信息标题
		 private String infoTitle;
		 //联系人
		 private String contactPerson;
		 //联系电话
		 private String contactPhone;
		 //状态
		 private String note;
		 //信息类型ID
		 private Integer bizType;
		 //信息类型名称
		 private String bizName;
		  
		public Date getReleaseDate() {
			return releaseDate;
		}
		public void setReleaseDate(Date releaseDate) {
			this.releaseDate = releaseDate;
		}
		public Integer getDataState() {
			return dataState;
		}
		public void setDataState(Integer dataState) {
			this.dataState = dataState;
		}
		public Long getProcessId() {
			return processId;
		}
		public void setProcessId(Long processId) {
			this.processId = processId;
		}
		public String getInfoTitle() {
			return infoTitle;
		}
		public void setInfoTitle(String infoTitle) {
			this.infoTitle = infoTitle;
		}
		public String getContactPerson() {
			return contactPerson;
		}
		public void setContactPerson(String contactPerson) {
			this.contactPerson = contactPerson;
		}
		public String getContactPhone() {
			return contactPhone;
		}
		public void setContactPhone(String contactPhone) {
			this.contactPhone = contactPhone;
		}
		public String getNote() {
			return note;
		}
		public void setNote(String note) {
			this.note = note;
		}
		public Integer getBizType() {
			return bizType;
		}
		public void setBizType(Integer bizType) {
			this.bizType = bizType;
		}
		public String getBizName() {
			return bizName;
		}
		public void setBizName(String bizName) {
			this.bizName = bizName;
		}
		public Long getDataId() {
			return dataId;
		}
		public void setDataId(Long dataId) {
			this.dataId = dataId;
		} 
		
	}
