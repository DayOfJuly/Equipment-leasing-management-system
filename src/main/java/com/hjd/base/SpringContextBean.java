package com.hjd.base;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

public class SpringContextBean implements ApplicationContextAware {

	private static ApplicationContext applicationContext;
	
	public void ApplicationContext(){}

	public static ApplicationContext getApplicationContext() {
		return applicationContext;
	}
	
	@Override
	public void setApplicationContext(ApplicationContext ac)throws BeansException  {
		applicationContext = ac;
	}

	public static Object getBean(String beanName){
		if(applicationContext==null){
			return null;
		}else{
			return applicationContext.getBean(beanName);
		}
	}
	
	
	
	
}
