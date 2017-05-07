package com.hjd.util;

public enum PubState {

	PUBSTATE1(1, "已成交"),
	PUBSTATE2(2, "未成交"),
	PUBSTATE3(3, "作废");

	private Integer typeValue;	//	标记值
	private String typeName;	//	标记名称

	private PubState(int typeValue, String typeName) {

		this.typeValue = typeValue;
		this.typeName = typeName;
	}

	public static PubState getInstance(int mode) {

		PubState result = null;
		for(PubState value : values()){
			if(value.typeValue==mode){
				result = value;
				break;
			}
		}

		return result;
	}

	public static PubState getInstance(String typeName) {

		PubState result = null;
		for(PubState value : values()){
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
