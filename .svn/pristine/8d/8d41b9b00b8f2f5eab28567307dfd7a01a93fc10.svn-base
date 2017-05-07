package com.hjd.util;


import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.BigDecimalConverter;
import org.apache.commons.beanutils.locale.converters.DateLocaleConverter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hjd.base.IFException;


public class BeanUtil {
	
	static{
		//注册日期转换器，如果为空则默认null，不会报 No value specified for 'Date'的错误
		ConvertUtils.register(new DateLocaleConverter(null), Date.class);
		ConvertUtils.register(new BigDecimalConverter(null), BigDecimal.class);
	}

	/**
	 * 将Object对象转化成json字符串
	 * @param object
	 * @return
	 */
	public static String  toJsonString(Object object){
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = null;
		try {
			jsonStr = mapper.writeValueAsString(object);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
			throw new IFException(e);
		} // 返回字符串
		return jsonStr;
	}

	/**
	 * 将json字符串转换成指定的bean类型
	 * @param value
	 * @param calsz
	 * @return T
	 */
	public static <T> T toObjectFromJson  (String value,Class<T> calsz){
		if(value==null||"".equals(value))
			return null;
		ObjectMapper mapper = new ObjectMapper();
		T object = null;

		try {
			object = mapper.readValue(value, calsz);
		} catch (IOException e) {
			e.printStackTrace();
			throw new IFException(e);
		}
		return object;

	}

	}
