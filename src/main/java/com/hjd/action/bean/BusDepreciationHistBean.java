package com.hjd.action.bean;

import java.util.List;

import com.hjd.base.BeanAbs;
public class BusDepreciationHistBean extends BeanAbs{
		
	    private List<BusDepreciationHistBeanTemp> bdhbtList;//租赁登记信息的集合
		private String month_;//折旧费登记的月份
		
		public List<BusDepreciationHistBeanTemp> getBdhbtList() {
			return bdhbtList;
		}
	
		public void setBdhbtList(List<BusDepreciationHistBeanTemp> bdhbtList) {
			this.bdhbtList = bdhbtList;
		}

		public String getMonth_() {
			return month_;
		}

		public void setMonth_(String month_) {
			this.month_ = month_;
		}
		

	}
