package com.hjd.util;

import java.util.HashMap;
import java.util.Map;

public enum EquTrsType {

	EQUTRSTYPE1(1, "自有"),
	EQUTRSTYPE2(2, "内租"),
	EQUTRSTYPE3(3, "外租"),
	EQUTRSTYPE4(4, "外协");

	private Integer typeValue;	//	标记值
	private String typeName;	//	标记名称

	private EquTrsType(int typeValue, String typeName) {

		this.typeValue = typeValue;
		this.typeName = typeName;
	}

	public static EquTrsType getInstance(int mode) {

		EquTrsType result = null;
		for(EquTrsType value : values()){
			if(value.typeValue==mode){
				result = value;
				break;
			}
		}

		return result;
	}

	public static EquTrsType getInstance(String typeName) {

		EquTrsType result = null;
		for(EquTrsType value : values()){
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
