package com.hjd.base;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.hjd.dao.ISysLoginUserDao;
import com.hjd.domain.SysLoginUser;
import com.hjd.util.Util;

public class CheckMobileUserLoginFilter implements Filter {

	private static final Logger logger = LoggerFactory.getLogger("com.hjd.base.CheckMobileUserLoginFilter");

	@Autowired
	private ISysLoginUserDao sysLoginUserDao;

	public void init(FilterConfig filterConfig) throws ServletException {

		}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,FilterChain filterChain) throws IOException, ServletException {

        //	拦截移动端客户需要登录后，才允许访问的请求
		//	如果session中的userInfo信息不存在，则设置返回码为530；移动端的angularjsFilter会根据错误码，判断是否需要跳转到移动端登录页面进行登录操作
		//	反之，则不拦截，继续访问该请求
		boolean flag = mobileUserLoginCheck((HttpServletRequest)servletRequest);

		if(flag){
			filterChain.doFilter(servletRequest, servletResponse);
			}
		else{
			HttpServletResponse response = (HttpServletResponse)servletResponse;

			response.setStatus(530);

			filterChain.doFilter(servletRequest, response);
			}
		}

	public void destroy() {
		
		}

	public boolean mobileUserLoginCheck(HttpServletRequest httpServletRequest) {

		String uri = httpServletRequest.getRequestURI();	//	请求资源的路径
		if(!(uri.startsWith("/WebSite/Mobile/Login") && uri.endsWith(".jsp")) && !uri.startsWith("/BG"))
			return true;

		logger.debug("----- -----拦截移动端的请求是：{}",new Object[]{uri});

		HttpSession session = httpServletRequest.getSession();

		Map<String, Object> userInfo =(HashMap<String, Object>)session.getAttribute("userInfo");
		if(userInfo==null || userInfo.isEmpty())
			return false;

		String loginId = Util.toStringAndTrim(userInfo.get("loginId"));
		if("".equals(loginId))
			return false;

		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId,0);
		if(user==null)
			return false;

		return true;
		}

	}
