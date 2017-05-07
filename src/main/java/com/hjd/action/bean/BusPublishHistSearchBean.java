package com.hjd.action.bean;

import java.util.Date;

import com.hjd.base.IFPageRequest;
public class BusPublishHistSearchBean extends IFPageRequest{

		private Integer state;//流程状态
		
		private Date startReleaseDate;//开始发布日期
		
		private Date endReleaseDate;//结束发布日期
		
		

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

		public Integer getState() {
			return state;
		}

		public void setState(Integer state) {
			this.state = state;
		}
		
	}
