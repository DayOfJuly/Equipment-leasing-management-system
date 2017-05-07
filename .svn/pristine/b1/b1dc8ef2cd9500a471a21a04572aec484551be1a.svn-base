package com.hjd.domain;

import java.io.Serializable;
import java.util.Date;

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
@Table(name="view_deal_info")
public class ViewDealInfo implements Serializable {
	
		/**
		 * 
		 */
		private static final long serialVersionUID = 4478274421668524973L;
		
		
		//数据的ID，记录主键
		@Id
		private Long id;//我想交易的记录ID

		private Long partyId;//我想交易的人的所在单位
		
		private Long proId;//我想交易的人的所在项目

		private Long dataId;//我想交易的业务

		private Long loginUserId;//我想交易的人

		private Integer operateFlag;//操作标识
		
		private Integer dataType;//发布类型
		
		private Integer dataState;//发布状态
		
		/*private String note;//发布状态说明
*/		
/*		private Integer equipmentId;//设备资源的ID
*/
		private Integer equState;//设备状态
		
		private String infoTitle;//信息标题
		
		private String contactPerson;//联系人
		
		private String contactPhone;//联系手机
		
		@Temporal(TemporalType.TIMESTAMP)
		@JsonSerialize(using=JsonDateSerializer.class)
		private Date releaseDate;//发布日期

		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public Long getPartyId() {
			return partyId;
		}

		public void setPartyId(Long partyId) {
			this.partyId = partyId;
		}

		public Long getDataId() {
			return dataId;
		}

		public void setDataId(Long dataId) {
			this.dataId = dataId;
		}

		public Long getLoginUserId() {
			return loginUserId;
		}

		public void setLoginUserId(Long loginUserId) {
			this.loginUserId = loginUserId;
		}

		public Integer getOperateFlag() {
			return operateFlag;
		}

		public void setOperateFlag(Integer operateFlag) {
			this.operateFlag = operateFlag;
		}

		public Integer getDataType() {
			return dataType;
		}

		public void setDataType(Integer dataType) {
			this.dataType = dataType;
		}

		public Integer getDataState() {
			return dataState;
		}

		public void setDataState(Integer dataState) {
			this.dataState = dataState;
		}

/*		public String getNote() {
			return note;
		}

		public void setNote(String note) {
			this.note = note;
		}*/

/*		public Integer getEquipmentId() {
			return equipmentId;
		}

		public void setEquipmentId(Integer equipmentId) {
			this.equipmentId = equipmentId;
		}*/

		public Integer getEquState() {
			return equState;
		}

		public void setEquState(Integer equState) {
			this.equState = equState;
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

		public Date getReleaseDate() {
			return releaseDate;
		}

		public void setReleaseDate(Date releaseDate) {
			this.releaseDate = releaseDate;
		}

		public Long getProId() {
			return proId;
		}

		public void setProId(Long proId) {
			this.proId = proId;
		}

	}
