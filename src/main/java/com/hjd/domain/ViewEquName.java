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
@Table(name="view_equ_name")
public class ViewEquName implements Serializable {
			
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		@Id
		private Integer equNameId;//设备名称维护标识

		private String equipmentNo;//设备号
		
		private String equipmentName;//设备名

		private String second;//热词搜索次数

		private Long searchCount;//计量单位
		
		private String fpy;//设备名称的大写首字母

		public Integer getEquNameId() {
			return equNameId;
		}

		public void setEquNameId(Integer equNameId) {
			this.equNameId = equNameId;
		}

		public String getEquipmentNo() {
			return equipmentNo;
		}

		public void setEquipmentNo(String equipmentNo) {
			this.equipmentNo = equipmentNo;
		}

		public String getEquipmentName() {
			return equipmentName;
		}

		public void setEquipmentName(String equipmentName) {
			this.equipmentName = equipmentName;
		}

		public String getSecond() {
			return second;
		}

		public void setSecond(String second) {
			this.second = second;
		}

		public Long getSearchCount() {
			return searchCount;
		}

		public void setSearchCount(Long searchCount) {
			this.searchCount = searchCount;
		}

		public String getFpy() {
			return fpy;
		}

		public void setFpy(String fpy) {
			this.fpy = fpy;
		}
		

	}
