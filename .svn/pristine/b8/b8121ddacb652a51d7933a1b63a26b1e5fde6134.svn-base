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
@Table(name="view_deal_info_user")
public class ViewDealInfoUser implements Serializable {
	
		/**
		 * 
		 */
		private static final long serialVersionUID = 4478274421668524973L;

		//数据的ID，记录主键 我想交易的记录ID
		@Id
		private Long id;
		//我想交易的业务id，出租、出售、求租、求购
		private Long dataId;
		//我想交易时填写的单位名称
		private String depName;
		//我想交易时填写的联系人姓名
		private String linkName;
		//我想交易时填写的联系方式
		private String linkPhone;
		//我想交易人的登录名
		private String loginId;
		//我想交易人的电话
		private String mobile;
		//我想交易人的的名称
		private String personName;
		//我想交易人的单位名称
		private String orgName;
		public Long getId() {
			return id;
		}
		public void setId(Long id) {
			this.id = id;
		}
		public Long getDataId() {
			return dataId;
		}
		public void setDataId(Long dataId) {
			this.dataId = dataId;
		}
		public String getDepName() {
			return depName;
		}
		public void setDepName(String depName) {
			this.depName = depName;
		}
		public String getLinkName() {
			return linkName;
		}
		public void setLinkName(String linkName) {
			this.linkName = linkName;
		}
		public String getLinkPhone() {
			return linkPhone;
		}
		public void setLinkPhone(String linkPhone) {
			this.linkPhone = linkPhone;
		}
		public String getLoginId() {
			return loginId;
		}
		public void setLoginId(String loginId) {
			this.loginId = loginId;
		}
		public String getMobile() {
			return mobile;
		}
		public void setMobile(String mobile) {
			this.mobile = mobile;
		}
		public String getPersonName() {
			return personName;
		}
		public void setPersonName(String personName) {
			this.personName = personName;
		}
		public String getOrgName() {
			return orgName;
		}
		public void setOrgName(String orgName) {
			this.orgName = orgName;
		}
		
	}
