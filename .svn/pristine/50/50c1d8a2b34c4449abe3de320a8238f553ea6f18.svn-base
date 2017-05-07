package com.hjd.base;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jasig.cas.client.authentication.AttributePrincipal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.hjd.base.IFException;
import com.hjd.dao.ISysLoginUserDao;
import com.hjd.domain.SysLoginUser;
import com.hjd.util.SendToTransport;
import com.hjd.util.Util;

@Repository
public class SystemInterceptorCopy extends HandlerInterceptorAdapter {
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
		
		
		AttributePrincipal principal = (AttributePrincipal) httpServletRequest.getUserPrincipal();
		Map<String,Object> attribute = principal.getAttributes();
		String accessToken = (String)attribute.get("access_token");
		String[] tokens = accessToken.split("~");

		Map<String,String> dataMap =new HashMap<String,String>();
		dataMap.put("oauthToken", tokens[0]);
		dataMap.put("refreshToken", tokens[1]);
		dataMap.put("clientId", "clientId");
		dataMap.put("clientSecret", "clientSecret");
				
		StringBuffer data = new StringBuffer();
		data.append("getUserInfos~&~");//服务或者方法名、目前是固定值
		data.append(Util.toStringAndTrim(dataMap.get("oauthToken"))).append("~!~");
		data.append(Util.toStringAndTrim(dataMap.get("oauthToken"))).append("~!~");//OAuth令牌
		data.append(Util.toStringAndTrim(dataMap.get("refreshToken"))).append("~!~");//重新刷新令牌
		data.append(Util.toStringAndTrim(dataMap.get("clientId"))).append("~!~");//客户端ID，固定值
		data.append(Util.toStringAndTrim(dataMap.get("clientSecret")));//客户端秘诀、固定值
		
		SendToTransport transport = new SendToTransport();
		for(int i=0;i<5;i++)
		{
			transport.send(data.toString());//注意，拼接发送报文的字符串的格式是有要求的，如下所示：
			/*transport.send("getUserInfos~&~dada~!~~!~~!~1000000050~!~sdnpqQJLwcj7dJI0s7jMA6E1RtWKBYp7");*/
			/*transport.send("interfaceList~&~GetGSPUserInfo~!~{\"userCode\":\"zs001\"}~!~2~!~1000000050~!~sdnpqQJLwcj7dJI0s7jMA6E1RtWKBYp7");*/
		}

		
			//需要过滤的请求资源路径
			String[] filters = new String[] {"/WebSite/Audit","/WebSite/Back"};
			//请求资源的路径
			String uri = httpServletRequest.getRequestURI();
			//判断对请求是否进行过滤
			boolean beFilter = false;
			for (String s : filters) 
			{
				if ((uri.startsWith(s) && uri.endsWith(".jsp")) || uri.startsWith("/BG") || uri.startsWith("/AUDIT"))//注意：这个拦截器不拦截.jsp文件
				{
					beFilter = true;
					break;
				}
			}
			HttpSession httpSession=httpServletRequest.getSession();
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