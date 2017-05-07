package com.hjd.action.bean;

import java.util.List;

import com.hjd.base.BeanAbs;
public class BusRentHistBean extends BeanAbs{
	
	   private List<BusRentHistBeanTemp> brhtList;//租赁登记信息的集合
	
        private Long equipmentId;//资源设备的ID
		
		private String month_;//租赁费登记的月份
		
	    private Long  equAtOrgId;//设备所在单位
		

		public String getMonth_() {
			return month_;
		}

		public void setMonth_(String month_) {
			this.month_ = month_;
		}

		public List<BusRentHistBeanTemp> getBrhtList() {
			return brhtList;
		}

		public void setBrhtList(List<BusRentHistBeanTemp> brhtList) {
			this.brhtList = brhtList;
		}

		public Long getEquipmentId() {
			return equipmentId;
		}

		public void setEquipmentId(Long equipmentId) {
			this.equipmentId = equipmentId;
		}

		public Long getEquAtOrgId() {
			return equAtOrgId;
		}

		public void setEquAtOrgId(Long equAtOrgId) {
			this.equAtOrgId = equAtOrgId;
		}

		
	}
