package com.hjd.domain;

import java.io.Serializable;

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
@Table(name="view_par_region")
public class ViewParRegion implements Serializable {
			
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		@Id
		private Long regionId;//区域ID

		private String code;//区域代码
		private String name;//区域名称
		private String note;//备注
		private Integer type;//区域类型
		private String fpy;//设备名称的大写首字母
		public Long getRegionId() {
			return regionId;
		}
		public void setRegionId(Long regionId) {
			this.regionId = regionId;
		}
		public String getCode() {
			return code;
		}
		public void setCode(String code) {
			this.code = code;
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
		public Integer getType() {
			return type;
		}
		public void setType(Integer type) {
			this.type = type;
		}
		public String getFpy() {
			return fpy;
		}
		public void setFpy(String fpy) {
			this.fpy = fpy;
		}


	}
