package com.hjd.util;

public enum SettlementModeName {

	SETTLEMENTMODENAME1(1, "转账"),
	SETTLEMENTMODENAME2(2, "验工计价"),
	SETTLEMENTMODENAME3(3, "台班签认"),
	SETTLEMENTMODENAME4(4, "按月结算");

	private Integer typeValue;	//	标记值
	private String typeName;	//	标记名称

	private SettlementModeName(int typeValue, String typeName) {

		this.typeValue = typeValue;
		this.typeName = typeName;
	}

	public static SettlementModeName getInstance(int mode) {

		SettlementModeName result = null;
		for(SettlementModeName value : values()){
			if(value.typeValue==mode){
				result = value;
				break;
			}
		}

		return result;
	}

	public static SettlementModeName getInstance(String typeName) {

		SettlementModeName result = null;
		for(SettlementModeName value : values()){
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
