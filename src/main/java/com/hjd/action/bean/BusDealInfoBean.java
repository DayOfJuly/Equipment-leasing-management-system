package com.hjd.action.bean;

import com.hjd.base.BeanAbs;
public class BusDealInfoBean extends BeanAbs{

		private Long dataId;//我想交易的业务
		
		//2016-08-04 新需求添加的新字段
		//单位名称
		private String depName;
		//联系人姓名
		private String linkName;
		//联系方式
		private String linkPhone;

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

	}
