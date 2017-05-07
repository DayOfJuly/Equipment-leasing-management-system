package com.hjd.action.bean;


import com.hjd.base.BeanAbs;
public class BusAuditInfoBean extends BeanAbs{

		private Long [] dataIds;//发布信息的ID，用于批量审批
		
		private Integer[] reasonIds;//拒绝原因ID
		
		private String[] reasonNotes;//拒绝原因说明

		public Long[] getDataIds() {
			return dataIds;
		}

		public void setDataIds(Long[] dataIds) {
			this.dataIds = dataIds;
		}

		public Integer[] getReasonIds() {
			return reasonIds;
		}

		public void setReasonIds(Integer[] reasonIds) {
			this.reasonIds = reasonIds;
		}

		public String[] getReasonNotes() {
			return reasonNotes;
		}

		public void setReasonNotes(String[] reasonNotes) {
			this.reasonNotes = reasonNotes;
		}

	

	}
