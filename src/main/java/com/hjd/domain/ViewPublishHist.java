package com.hjd.domain;

import java.io.Serializable;
import java.math.BigDecimal;
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
@Table(name="view_publish_hist")
public class ViewPublishHist implements Serializable {
		/**
		 * 
		 */
		private static final long serialVersionUID = 4478274421668524973L;
		
	        /**
	         * 发布的相关信息，源自扩展表
	         */
		    @Id
		    private Long dataId;//发布数据ID
			private Long pubLoginUserId;//我已发布的人
		    private Integer dataState;//信息发布的状态
			private Integer state;//流程状态	
			private String busState;//业务状态
			private String note;//备注
			private String depName;//设备成交单位
		    private Long equipmentId;//设备的ID
			@Temporal(TemporalType.TIMESTAMP)
			@JsonSerialize(using=JsonDateSerializer.class)
			private Date releaseDate;//发布日期
			/**
			 * 设备相关信息，源自设备、设备名称、品牌表
			 */
			private String equNo;//设备编号
			private String asset;//资产编号
			private String equipmentName;//设备名称
			private String brandName;//品牌名称
			private BigDecimal forecastSum;//预估金额
			
			public Long getEquipmentId() {
				return equipmentId;
			}

			public void setEquipmentId(Long equipmentId) {
				this.equipmentId = equipmentId;
			}

			public String getEquNo() {
				return equNo;
			}

			public void setEquNo(String equNo) {
				this.equNo = equNo;
			}

			public String getAsset() {
				return asset;
			}

			public void setAsset(String asset) {
				this.asset = asset;
			}

			public String getEquipmentName() {
				return equipmentName;
			}

			public void setEquipmentName(String equipmentName) {
				this.equipmentName = equipmentName;
			}

			public Long getDataId() {
				return dataId;
			}

			public void setDataId(Long dataId) {
				this.dataId = dataId;
			}

			public Integer getDataState() {
				return dataState;
			}

			public void setDataState(Integer dataState) {
				this.dataState = dataState;
			}

			public Integer getState() {
				return state;
			}

			public void setState(Integer state) {
				this.state = state;
			}

			public String getBusState() {
				return busState;
			}

			public void setBusState(String busState) {
				this.busState = busState;
			}

			public String getDepName() {
				return depName;
			}

			public void setDepName(String depName) {
				this.depName = depName;
			}

			public Date getReleaseDate() {
				return releaseDate;
			}

			public void setReleaseDate(Date releaseDate) {
				this.releaseDate = releaseDate;
			}

			public String getBrandName() {
				return brandName;
			}

			public void setBrandName(String brandName) {
				this.brandName = brandName;
			}

			public String getNote() {
				return note;
			}

			public void setNote(String note) {
				this.note = note;
			}

			public Long getPubLoginUserId() {
				return pubLoginUserId;
			}

			public void setPubLoginUserId(Long pubLoginUserId) {
				this.pubLoginUserId = pubLoginUserId;
			}

			public BigDecimal getForecastSum() {
				return forecastSum;
			}

			public void setForecastSum(BigDecimal forecastSum) {
				this.forecastSum = forecastSum;
			}
			
	}
