package com.hjd.base;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.hjd.base.IFException;
import com.hjd.dao.ISysLoginUserDao;
import com.hjd.domain.SysLoginUser;

@Repository
public class SystemInterceptor extends HandlerInterceptorAdapter {
	/**
	 * 日志
	 */
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());  
	
	@Autowired
	private ISysLoginUserDao sysLoginUserDao;
	
	 /* (non-Javadoc)
	 * 
	 * @see
	 * org.springframework.web.servlet.handler.HandlerInterceptorAdapter#preHandle
	 * (javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse, java.lang.Object)
	*/ 
	@SuppressWarnings("unchecked")
	@Override
	public boolean preHandle(HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse, Object handler) throws Exception
	{
			//需要过滤的请求资源路径
			String[] filters = new String[] {"/WebSite/Audit"};
			//请求资源的路径
			String uri = httpServletRequest.getRequestURI();
			//判断对请求是否进行过滤
			boolean beFilter = false;
			for (String s : filters) 
			{
				if ((uri.startsWith(s) && uri.endsWith(".jsp")) || uri.startsWith("/AUDIT"))//注意：这个拦截器不拦截.jsp文件
				{
					beFilter = true;
					break;
				}
			}
			HttpSession httpSession=httpServletRequest.getSession();
logger.debug(this.getClass().getName()+"+++++++++++++++是否为我们想要过滤的路径："+beFilter);
logger.debug(this.getClass().getName()+"++++++++++++++++++++拦截的请求地址是："+uri+"\n");	
			//判断访问资源是否进行过滤
			if (beFilter) 
			{
				HashMap<Object, Object> userInfo =(HashMap<Object, Object>)httpSession.getAttribute("userInfo");
				// 未登录，弹出提示信息，并且跳转到登录页面
				if (null == userInfo) {System.out.println("USER_NOT_LOGIN");throw new IFException("530","USER_NOT_LOGIN");}
				String loginId=(String)userInfo.get("loginId");
				SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId,0);
				// 未登录，弹出提示信息，并且跳转到登录页面
				if (null == user) {System.out.println("USER_NOT_EXIST");throw new IFException("530","USER_NOT_LOGIN");}
				
				//已经在登录的时候现在非审核人员不能登录，这里近一步限制非审核人员不能通过通过浏览器共享session的方法来看到审核系统的页面
				Integer parTypeId=user.getParty().getParType().getParTypeId();
				if(!"/WebSite/Audit/index.jsp".equals(uri))
				{
					if (((uri.startsWith("/WebSite/Audit") && uri.endsWith(".jsp")) || uri.startsWith("/AUDIT")) && parTypeId!=7) {System.out.println("RIGHT_USER_NOT_LOGIN");throw new IFException("530","RIGHT_USER_NOT_LOGIN");}
				}
				
/*				//限制审核系统的人员通过浏览器共享session的方法进入后台管理系统
				if (((uri.startsWith("/WebSite/Back") && uri.endsWith(".jsp")) || uri.startsWith("/BG")) && (parTypeId!=3 || parTypeId!=6)) {System.out.println("RIGHT_USER_NOT_LOGIN");throw new IFException("530","RIGHT_USER_NOT_LOGIN");}
*/
			}
		
		return super.preHandle(httpServletRequest, httpServletResponse, handler);
	}
	
}