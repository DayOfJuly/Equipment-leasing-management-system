package com.hjd.base;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

/**
 * 针对RequestMapping注解了的方法拦截切面
 */
@Aspect
@Component
public class IFAspect {

	/**
	 * 拦截注解了@RequestMapping的方法
	 */
	@Pointcut("@annotation(org.springframework.web.bind.annotation.RequestMapping)")  
	public void requestMappingAspect() {  

		
		}  

	@Before("requestMappingAspect()") 
	public void doBeforeController(JoinPoint joinPoint){

		
		}

	}
