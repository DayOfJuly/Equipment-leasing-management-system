package com.hjd.base;

import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

//	序列化和反序列化时忽略该属性
@JsonIgnoreProperties(value={"log"})
public abstract class BeanAbs implements ISvcValidBean {

	@JsonIgnore
	protected Logger log = Logger.getLogger(this.getClass());

	/**
	 * 拷贝当前bean的属性到指定bean的同名属性中
	 * @param targetBean 指定的bean
	 * @return targetBean 拷贝完属性后的bean
	 */
	public <T> T  copyPropertyToDestBean(T targetBean){

		BeanUtils.copyProperties(this,targetBean);
		return targetBean;
		}

  	@Override
	public  Logger getLog() {

  		return log;
  		}

	}
