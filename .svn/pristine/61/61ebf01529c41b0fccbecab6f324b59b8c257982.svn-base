package main.startup;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CrossFilter implements Filter {
	/**
	 * 日志
	 */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());  
	
	@Override
	public void init(FilterConfig arg0) throws ServletException 
	{
		logger.debug(this.getClass().getName()+"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++拦截器初始化！");
	}

	/**
	 * 用于支持跨域访问
	 */
	@Override
	public void doFilter(ServletRequest req, ServletResponse res,FilterChain chain) throws IOException, ServletException 
	{
        HttpServletResponse httpRes = (HttpServletResponse) res;
        httpRes.setHeader("Access-Control-Allow-Origin", "*");
        httpRes.setHeader("Access-Control-Allow-Methods", "DELETE, GET, POST, PUT");
        httpRes.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization, Accept,X-Requested-With");
        httpRes.setHeader("Access-Control-Max-Age", "43200");
        chain.doFilter(req, res);
	}
	@Override
	public void destroy()
	{
		logger.debug(this.getClass().getName()+"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++拦截器终结化！");
	}
	
}
