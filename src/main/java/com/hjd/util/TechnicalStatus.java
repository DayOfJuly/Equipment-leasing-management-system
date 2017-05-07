package com.hjd.util;

public enum TechnicalStatus {

	TECHNICALSTATUS1(1, "一类"),
	TECHNICALSTATUS2(2, "二类"),
	TECHNICALSTATUS3(3, "三类");

	private Integer typeValue;	//	标记值
	private String typeName;	//	标记名称

	private TechnicalStatus(int typeValue, String typeName) {

		this.typeValue = typeValue;
		this.typeName = typeName;
	}

	public static TechnicalStatus getInstance(int mode) {

		TechnicalStatus result = null;
		for(TechnicalStatus value : values()){
			if(value.typeValue==mode){
				result = value;
				break;
			}
		}

		return result;
	}

	public static TechnicalStatus getInstance(String typeName) {

		TechnicalStatus result = null;
		for(TechnicalStatus value : values()){
			if(value.typeName.equalsIgnoreCase(typeName)){
				result =value;
				break;
			}
		}

		return result;
	}

	public Integer getTypeValue() {
		return typeValue;
	}

	public void setTypeValue(Integer typeValue) {
		this.typeValue = typeValue;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

}
