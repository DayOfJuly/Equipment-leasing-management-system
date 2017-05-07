package com.hjd.util;

public enum RentType {

	RENTTYPE1(1, "月"),
	RENTTYPE2(2, "天"),
	RENTTYPE3(3, "台班"),
	RENTTYPE4(4, "小时");

	private Integer typeValue;	//	标记值
	private String typeName;	//	标记名称

	private RentType(int typeValue, String typeName) {

		this.typeValue = typeValue;
		this.typeName = typeName;
	}

	public static RentType getInstance(int mode) {

		RentType result = null;
		for(RentType value : values()){
			if(value.typeValue==mode){
				result = value;
				break;
			}
		}

		return result;
	}

	public static RentType getInstance(String typeName) {

		RentType result = null;
		for(RentType value : values()){
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
