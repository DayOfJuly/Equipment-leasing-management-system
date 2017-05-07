package com.hjd.action.bean;


import com.hjd.base.IFPageRequest;
public class BusDepreciationHistSearchBean extends IFPageRequest{
	
		private String orgName;//单位名称
		
		private String month;//登记月份
		
		private Long orgId;//当事人ID，用于外部供应商的查询
		
		private Integer orgFlag;	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
		private String orgCode;	//	所属单位/项目code
		private Long orgPartyId;	//	所属单位/项目id
		private Integer isInclude;	//	是否包含下级单位：1-包含

		public String getOrgName() {
			return orgName;
		}

		public void setOrgName(String orgName) {
			this.orgName = orgName;
		}

		public String getMonth() {
			return month;
		}

		public void setMonth(String month) {
			this.month = month;
		}

		public Integer getIsInclude() {
			return isInclude;
		}

		public void setIsInclude(Integer isInclude) {
			this.isInclude = isInclude;
		}

		public String getOrgCode() {
			return orgCode;
		}

		public void setOrgCode(String orgCode) {
			this.orgCode = orgCode;
		}

		public Long getOrgId() {
			return orgId;
		}

		public void setOrgId(Long orgId) {
			this.orgId = orgId;
		}

		public Integer getOrgFlag() {
			return orgFlag;
		}

		public void setOrgFlag(Integer orgFlag) {
			this.orgFlag = orgFlag;
		}

		public Long getOrgPartyId() {
			return orgPartyId;
		}

		public void setOrgPartyId(Long orgPartyId) {
			this.orgPartyId = orgPartyId;
		}

		
	}
