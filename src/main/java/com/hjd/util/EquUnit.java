package com.hjd.util;

public enum EquUnit {

	EQUUNIT1(1, "台"),
	EQUUNIT2(2, "辆"),
	EQUUNIT3(3, "套");

	private Integer typeValue;	//	标记值
	private String typeName;	//	标记名称

	private EquUnit(int typeValue, String typeName) {

		this.typeValue = typeValue;
		this.typeName = typeName;
	}

	public static EquUnit getInstance(int mode) {

		EquUnit result = null;
		for(EquUnit value : values()){
			if(value.typeValue==mode){
				result = value;
				break;
			}
		}

		return result;
	}

	public static EquUnit getInstance(String typeName) {

		EquUnit result = null;
		for(EquUnit value : values()){
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
