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
@Table(name="view_equ_name_parameter")
public class ViewEquNameParameter implements Serializable {
			
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		/**
		 * 设备小类名称与设备参数的关系表的ID
		 */
		@Id
		private Long id;
		/**
		 * 设备名称维护标识
		 */
		private Integer equNameId;
		/**
		 * 设备参数的ID
		 */
		private Long parameterId;
		
		/**
		 * 设备参数的类型，1：品牌，2：生产厂家，3：型号，4：规格
		 */
		private Integer type;
		
		/**
		 * 设备参数的名称
		 */
		private String name;
		
		/**
		 * 设备参数的状态，0：删除，1：正常
		 */
		private Integer status;
		
		/**
		 * 设备参数的备注
		 */
		private String note;
		
		/**
		 * 品牌的Logo图片
		 */
		private String logoPic;


		public Integer getEquNameId() {
			return equNameId;
		}

		public void setEquNameId(Integer equNameId) {
			this.equNameId = equNameId;
		}

		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public Long getParameterId() {
			return parameterId;
		}

		public void setParameterId(Long parameterId) {
			this.parameterId = parameterId;
		}

		public Integer getType() {
			return type;
		}

		public void setType(Integer type) {
			this.type = type;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public Integer getStatus() {
			return status;
		}

		public void setStatus(Integer status) {
			this.status = status;
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

		

	}
