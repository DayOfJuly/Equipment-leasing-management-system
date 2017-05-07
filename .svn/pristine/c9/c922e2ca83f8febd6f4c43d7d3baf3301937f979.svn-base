package com.hjd.util;

public enum EquState {

	EQUSTATE1(1, "闲置"),
	EQUSTATE2(2, "使用中"),
	EQUSTATE3(3, "已出售"),
	EQUSTATE4(4, "已报废");

	private Integer typeValue;	//	标记值
	private String typeName;	//	标记名称

	private EquState(int typeValue, String typeName) {

		this.typeValue = typeValue;
		this.typeName = typeName;
	}

	public static EquState getInstance(int mode) {

		EquState result = null;
		for(EquState value : values()){
			if(value.typeValue==mode){
				result = value;
				break;
			}
		}

		return result;
	}

	public static EquState getInstance(String typeName) {

		EquState result = null;
		for(EquState value : values()){
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
