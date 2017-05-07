package com.hjd.util;

public enum PubType {

	PUBTYPE1(1, "出租"),
	PUBTYPE2(2, "出售"),
	PUBTYPE3(3, "求租"),
	PUBTYPE4(4, "求购");

	private Integer typeValue;	//	标记值
	private String typeName;	//	标记名称

	private PubType(int typeValue, String typeName) {

		this.typeValue = typeValue;
		this.typeName = typeName;
	}

	public static PubType getInstance(int mode) {

		PubType result = null;
		for(PubType value : values()){
			if(value.typeValue==mode){
				result = value;
				break;
			}
		}

		return result;
	}

	public static PubType getInstance(String typeName) {

		PubType result = null;
		for(PubType value : values()){
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
