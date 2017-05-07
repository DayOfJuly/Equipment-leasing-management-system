package com.hjd.base;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

/**
 * json序列化转换器，在要转换的实体属性上使用注解JsonSerialize，如下，可以控制返回前台的日期json序列化格式
 * <p>
 * @JsonSerialize(using=JsonDateSerializer.class)//控制返回前台的日期json序列化格式
 * private Date startTime;
 * </p>
 */
public class JsonDateSerializer extends JsonSerializer<Date> {

	private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	@Override
	public void serialize(Date date, JsonGenerator gen, SerializerProvider provider) throws IOException, JsonProcessingException {

		String value = dateFormat.format(date);
		gen.writeString(value);
		}

	}
