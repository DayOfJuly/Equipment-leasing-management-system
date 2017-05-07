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
@Table(name="view_par_org")
public class ViewParOrg implements Serializable {
			
		/**
		 * 
		 */
		private static final long serialVersionUID = 1L;
		@Id
		private Long partyId;//当事人标识

		private Integer parTypeId;//当事人类型，这里主要是查询企业的信息
		private String code;//企业代码
		private String name;//企业名称
		private Integer orgLevel;//组织级别
		private String parentCode;//上级单位代码
		private String note;//备注
		private Integer state;//当事人的状态
		private String fpy;//设备名称的大写首字母
		public Long getPartyId() {
			return partyId;
		}
		public void setPartyId(Long partyId) {
			this.partyId = partyId;
		}
		public Integer getParTypeId() {
			return parTypeId;
		}
		public void setParTypeId(Integer parTypeId) {
			this.parTypeId = parTypeId;
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
		public Integer getOrgLevel() {
			return orgLevel;
		}
		public void setOrgLevel(Integer orgLevel) {
			this.orgLevel = orgLevel;
		}
		public String getParentCode() {
			return parentCode;
		}
		public void setParentCode(String parentCode) {
			this.parentCode = parentCode;
		}
		public String getNote() {
			return note;
		}
		public void setNote(String note) {
			this.note = note;
		}
		public Integer getState() {
			return state;
		}
		public void setState(Integer state) {
			this.state = state;
		}
		public String getFpy() {
			return fpy;
		}
		public void setFpy(String fpy) {
			this.fpy = fpy;
		}

	}
