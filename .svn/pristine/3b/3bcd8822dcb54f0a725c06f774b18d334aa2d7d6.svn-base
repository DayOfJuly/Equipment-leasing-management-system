package com.hjd.util;

import java.util.ArrayList;
import java.util.LinkedHashMap;

/**
 * 
 * 报表数据存储用 
 * 
 */
public class ReportData extends LinkedHashMap<Object, Object> {

	private static final long serialVersionUID = 43107479068536632L;

	/**
	 * 工具方法，向Map中添加数据
	 * @param keys
	 * @param key
	 * @param value
	 */
	public void put(ArrayList<?> keys, Object key, Object value) {

		ReportData rData = this;
		for(int i=0;i<keys.size();i++){
			if(rData.containsKey(keys.get(i))){
				rData = (ReportData)rData.get(keys.get(i));
			}
			else{
				ReportData nData = new ReportData();

				rData.put(keys.get(i), nData);
				rData = nData;
			}
		}

		rData.put(key, value);
	}

}
