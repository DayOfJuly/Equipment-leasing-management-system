package com.hjd.base;

import java.util.Map;
import java.util.TreeMap;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.UnsatisfiedServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.hjd.base.IFException;
import com.hjd.util.Util;

/**
 * aop的Exception处理，该方式可以比基于单个Controller的拦截方式处理更多的异常情况
 */
@ControllerAdvice
public class WebExceptionHandler {

	/**
	 * 自定义错误，统一按500处理
	 * @param IfException
	 * @return
	 */
	@ExceptionHandler(IFException.class)
	@ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
	public @ResponseBody Map<String,Object> runtimeExceptionHandler(IFException ifException) {

		ifException.printStackTrace();

		Map<String, Object> model = new TreeMap<String, Object>();
		/**
		 * 这里“错误代码”和“错误信息描述”的名字与浏览器原有定义保持一致，方便浏览器端统一处理
		 * error-错误代码
		 * message-错误信息描述
		 */
		model.put("error", ifException.getErrCode());
		if(!"".equals(Util.toStringAndTrim(ifException.getErrMsg())))
			model.put("message", ifException.getErrMsg());
		else
			model.put("message", ifException.getStackTrace());

		return model;
		}

	/**
	 * 参数错误
	 * @param UnsatisfiedServletRequestParameterException
	 * @return
	 */
	@ExceptionHandler(UnsatisfiedServletRequestParameterException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST)
	public @ResponseBody Map<String,Object> unsatisfiedServletRequestParameterExceptionHandler(UnsatisfiedServletRequestParameterException exception) {

		exception.printStackTrace();

		Map<String, Object> model = new TreeMap<String, Object>();
		/**
		 * 这里“错误代码”和“错误信息描述”的名字与浏览器原有定义保持一致，方便浏览器端统一处理
		 * error-错误代码
		 * message-错误信息描述
		 */
		model.put("error", "Bad Request");
		model.put("message", "请求参数错误！"+exception.getStackTrace());
		return model;
		}

	/**
	 * 其他错误
	 * @param Exception
	 * @return
	 */
	@ExceptionHandler(Exception.class)
	@ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
	public @ResponseBody Map<String,Object> exceptionHandler(Exception exception) {

		exception.printStackTrace();

		Map<String, Object> model = new TreeMap<String, Object>();
		/**
		 * 这里“错误代码”和“错误信息描述”的名字与浏览器原有定义保持一致，方便浏览器端统一处理
		 * error-错误代码
		 * message-错误信息描述
		 */
		model.put("error", "Exception");
		if(!"".equals(Util.toStringAndTrim(exception.getMessage())))
			model.put("message", exception.getMessage());
		else
			model.put("message", exception.getStackTrace());

		return model;
		}

	}
