package com.hjd.util;

public enum BusState {

	BUSSTATE1(1, "自用"),
	BUSSTATE2(2, "调拨"),
	BUSSTATE3(3, "局内租"),
	BUSSTATE4(4, "外局租"),
	BUSSTATE5(5, "外租");

	private Integer typeValue;	//	标记值
	private String typeName;	//	标记名称

	private BusState(int typeValue, String typeName) {

		this.typeValue = typeValue;
		this.typeName = typeName;
	}

	public static BusState getInstance(int mode) {

		BusState result = null;
		for(BusState value : values()){
			if(value.typeValue==mode){
				result = value;
				break;
			}
		}

		return result;
	}

	public static BusState getInstance(String typeName) {

		BusState result = null;
		for(BusState value : values()){
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
