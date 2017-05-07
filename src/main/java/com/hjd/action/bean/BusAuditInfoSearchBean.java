package com.hjd.action.bean;

import java.util.Date;

import com.hjd.base.IFPageRequest;
public class BusAuditInfoSearchBean extends IFPageRequest{

		private Integer dataType;//发布类型
		
		private Integer dataState;//发布状态
		
		private Date startReleaseDate;//开始发布日期
		
		private Date endReleaseDate;//结束发布日期

		
		
		private Long [] dataIds;//发布信息的ID，用于批量审批
		
		public Integer getDataType() {
			return dataType;
		}

		public void setDataType(Integer dataType) {
			this.dataType = dataType;
		}

		public Integer getDataState() {
			return dataState;
		}

		public void setDataState(Integer dataState) {
			this.dataState = dataState;
		}

		public Date getStartReleaseDate() {
			return startReleaseDate;
		}

		public void setStartReleaseDate(Date startReleaseDate) {
			this.startReleaseDate = startReleaseDate;
		}

		public Date getEndReleaseDate() {
			return endReleaseDate;
		}

		public void setEndReleaseDate(Date endReleaseDate) {
			this.endReleaseDate = endReleaseDate;
		}

		public Long[] getDataIds() {
			return dataIds;
		}

		public void setDataIds(Long[] dataIds) {
			this.dataIds = dataIds;
		}
		

	}
