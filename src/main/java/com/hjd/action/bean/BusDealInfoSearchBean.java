package com.hjd.action.bean;

import java.util.Date;

import com.hjd.base.IFPageRequest;
public class BusDealInfoSearchBean extends IFPageRequest{

	    private Long dataId;//信息发布的ID
	    
		private Integer dataType;//发布类型
		
		private Integer dataState;//发布状态
		
		private Integer equState;//设备状态
		
		private Date startReleaseDate;
		
		private Date endReleaseDate;

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

		public Integer getEquState() {
			return equState;
		}

		public void setEquState(Integer equState) {
			this.equState = equState;
		}

		public Long getDataId() {
			return dataId;
		}

		public void setDataId(Long dataId) {
			this.dataId = dataId;
		}
		

	}
