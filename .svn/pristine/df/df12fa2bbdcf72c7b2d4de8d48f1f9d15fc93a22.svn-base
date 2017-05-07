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

public class CheckAuthUserLoginFilter implements Filter {

	private static final Logger logger = LoggerFactory.getLogger("com.hjd.base.CheckAuthUserLoginFilter");

	@Autowired
	private ISysLoginUserDao sysLoginUserDao;

	public void init(FilterConfig filterConfig) throws ServletException {

		}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,FilterChain filterChain) throws IOException, ServletException {

		//	拦截审核系统客户需要登录后，才允许访问的请求
		//	如果session中的userInfo信息不存在，则设置返回码为532；angularjsAuditFilter会根据错误码，判断是否需要跳转到审核系统登录页面进行登录操作
		//	反之，则不拦截，继续访问该请求
		boolean flag = authUserLoginCheck((HttpServletRequest)servletRequest);

		if(flag){
			filterChain.doFilter(servletRequest, servletResponse);
			}
		else{
			HttpServletResponse response = (HttpServletResponse)servletResponse;

			response.setStatus(532);

			filterChain.doFilter(servletRequest, response);
			}
		}

	public void destroy() {
		
		}

	public boolean authUserLoginCheck(HttpServletRequest httpServletRequest) {

		String uri = httpServletRequest.getRequestURI();	//	请求资源的路径
		if(!(uri.startsWith("/WebSite/Audit") && uri.endsWith(".jsp")) && !uri.startsWith("/AUDIT") && !uri.startsWith("/WebSite/Audit/index.jsp"))
			return true;

		logger.info("----- -----拦截审核的请求是：{}",new Object[]{uri});

		HttpSession session = httpServletRequest.getSession();

		Map<String, Object> userInfo =(HashMap<String, Object>)session.getAttribute("userInfo");
		if(userInfo==null || userInfo.isEmpty())
			return false;

		String loginId = Util.toStringAndTrim(userInfo.get("loginId"));
		if("".equals(loginId))
			return false;

		//	查询是否是审核系统客户，非审核系统客户也不允许登录
		SysLoginUser user = user = sysLoginUserDao.findAduitUserByLoginId(loginId,0,7);
		if(user==null)
			return false;

		return true;
		}

	}
