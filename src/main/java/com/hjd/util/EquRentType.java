package com.hjd.util;

public enum EquRentType {

	EQURENTTYPE1(1, "自有"),
	EQURENTTYPE2(2, "局内租"),
	EQURENTTYPE3(3, "外局租"),
	EQURENTTYPE4(4, "外租"),
	EQURENTTYPE5(5, "报废"),
	EQURENTTYPE6(6, "出售");

	private Integer typeValue;	//	标记值
	private String typeName;	//	标记名称

	private EquRentType(int typeValue, String typeName) {

		this.typeValue = typeValue;
		this.typeName = typeName;
	}

	public static EquRentType getInstance(int mode) {

		EquRentType result = null;
		for(EquRentType value : values()){
			if(value.typeValue==mode){
				result = value;
				break;
			}
		}

		return result;
	}

	public static EquRentType getInstance(String typeName) {

		EquRentType result = null;
		for(EquRentType value : values()){
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
