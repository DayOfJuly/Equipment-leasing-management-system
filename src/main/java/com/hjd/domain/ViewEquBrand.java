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
@Table(name="view_equ_brand")
public class ViewEquBrand implements Serializable {
			
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		@Id
		private Long id;//品牌ID

//		private Integer equNameId;//对应品牌所属的设备名称
		
		private String name;//品牌名称
		
//		private Integer nameOrder;//品牌名称排序
		
		private String fpy;//品牌名称的大写首字母

		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getFpy() {
			return fpy;
		}

		public void setFpy(String fpy) {
			this.fpy = fpy;
		}

	}
