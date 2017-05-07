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

import org.jasig.cas.client.authentication.AttributePrincipal;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.hjd.dao.IPartyRelationDao;
import com.hjd.dao.IPerPersonDao;
import com.hjd.dao.ISysLoginFunDao;
import com.hjd.dao.ISysLoginUserDao;
import com.hjd.domain.PartyOrg;
import com.hjd.domain.PartyPerson;
import com.hjd.domain.SysLoginUser;
import com.hjd.util.BeanUtil;
import com.hjd.util.SendToTransport;
import com.hjd.util.Util;

public class CheckUserLoginFilter implements Filter {

	private static final Logger logger = LoggerFactory.getLogger("com.hjd.base.CheckUserLoginFilter");

	@Value("${wsclient.clientid}")
	private String clientId = null;
	@Value("${wsclient.clientsecret}")
	private String clientSecret = null;

	@Autowired
	private ISysLoginUserDao sysLoginUserDao;
	@Autowired
	private IPartyRelationDao partyRelationDao;
	@Autowired
	private ISysLoginFunDao sysLoginFunDao;
	@Autowired
	private IPerPersonDao iPerPersonDao;

	public void init(FilterConfig arg0) throws ServletException {

		}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,FilterChain filterChain) throws IOException, ServletException {

		HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
		//	拦截经过oauth cas后的请求，判断userInfo信息是否为空？是否过期？
		//	如果需要重新获取userInfo信息的话，则重新获取
		//	否则，继续访问该请求
		boolean flag = userLoginCheck(httpServletRequest);

		if(flag){
			filterChain.doFilter(servletRequest, servletResponse);
			}
		else{
			HttpServletResponse response = (HttpServletResponse)servletResponse;

			response.setStatus(531);

			filterChain.doFilter(servletRequest, response);
			}
		}

	public void destroy() {

		}

/*************************************************************************************************************************************************************************************************/	

	/**
	 * 1：与oauth配置的拦截处理的请求规则相同——用于判断哪些请求，需要重新获取userInfo信息
	 * 2：在拦截器中做相应的处理——oauth通过验证后，判断userInfo信息是否存在？根据oauth返回的token和userInfo中保存的token，判断userInfo是否过期？
	 * 3：如果需要重新获取userInfo信息的话，则重新获取——发送外部接口请求获取用户登录名（根据oauth返回的token），再根据用户登录名获取userInfo信息，将userInfo信息放置到本地会话中
	 *    需要用户登录后才能操作，每次都需要查看本地会话是否过期，当前用户是否和统一认证平台的会话一致
	 */
	public boolean userLoginCheck(HttpServletRequest httpServletRequest) {	

		//	判断对请求是否进行过滤
		boolean beFilter = false;

		String uri = httpServletRequest.getRequestURI();	//	请求资源的路径
		if(uri.startsWith("/WebSite/Back") || uri.startsWith("/BG"))
			beFilter = true;

		logger.debug("+++++ +++++是否为设备租赁需要过滤的请求：{}",new Object[]{beFilter});

		if(!beFilter)
			return true;

		logger.debug("+++++ +++++拦截设备租赁的请求地址是：{}",new Object[]{uri});

		AttributePrincipal principal = (AttributePrincipal)httpServletRequest.getUserPrincipal();
		if(null==principal)
			return false;	//	未获取到用户统一登录认证信息

		Map<String,Object> attribute = principal.getAttributes();

		String accessToken = Util.toStringAndTrim(attribute.get("access_token"));
		if("".equals(accessToken))
			return false;	//	未获取到用户统一登录认证信息

		//	1：程序运行到这里，证明统一认证平台的会话没过期或者首次登录成功了
		
		//	2：针对本地会话的控制
		HttpSession httpSession=httpServletRequest.getSession();

		Map<Object, Object> userInfo =(HashMap<Object, Object>)httpSession.getAttribute("userInfo");

		//	2-1：本地会话中不存在用户的信息，证明是首次登录需要获取用户信息，并放入到本地会话中
		if(null==userInfo){
			String userName = getUserName(accessToken);
			if(userName==null || "_Get_UserName_Error_".equals(userName))
				return false;

			userInfo = getUserInfo(userName);
			if(Util.isNullOrEmpty(userInfo))
				return false;

			userInfo.put("accessToken", accessToken);

			httpSession.setAttribute("userInfo", userInfo);
			}

		String accessToken_ = (String)userInfo.get("accessToken");

		//	2-2：如果本地会话中的用户Token和统一认证平台会话中的Token不一致，表示统一认证平台的会话可能已经过期，用户重新登录了，此时也需要跟新本地会话中的用户信息
		if(!accessToken.equals(accessToken_)){
			httpSession.removeAttribute("userInfo");

			String userName = getUserName(accessToken);
			if(userName==null || "_Get_UserName_Error_".equals(userName))
				return false;

			userInfo = getUserInfo(userName);
			if(Util.isNullOrEmpty(userInfo))
				return false;

			userInfo.put("accessToken", accessToken);

			httpSession.setAttribute("userInfo", userInfo);
			}

		return true;
		}

	/**
	 * 根据统一认证平台返回的Token，发送报文来获取用户名
	 * @param accessToken
	 * @return
	 */
	private String getUserName(String accessToken) {

		String[] tokens = accessToken.split("~");

		StringBuffer data = new StringBuffer();

		data.append("getUserInfos~&~");//服务或者方法名、目前是固定值
		data.append("~!~");//用户登录名，可以为空
		data.append(tokens[0]).append("~!~");//OAuth令牌，可以为空
		data.append(tokens[1]).append("~!~");//OAuth刷新令牌，可以为空
		data.append(clientId).append("~!~");//oauth系统标识，固定值，在配置文件Action.properties中配置的
		data.append(clientSecret);//oauth系统标识密钥，固定值，在配置文件Action.properties中配置的

		SendToTransport transport = new SendToTransport();

		Map returnData = new HashMap();
		try{
			String returnStr = transport.send(data.toString());
			if(returnStr==null || "".equals(returnStr.trim()))
				return "_Get_UserName_Error_";	//	从统一认证平台获取用户名失败
			returnData = BeanUtil.toObjectFromJson(returnStr, Map.class);
			}
		catch(Exception e){
			e.printStackTrace();
			return "_Get_UserName_Error_";	//	通讯异常，请稍后再试
			}

		return (String)returnData.get("user_name");
		}

	/**
	 * 根据用户名获取用户的信息
	 * @param userName
	 * @return
	 */
	private Map<Object, Object> getUserInfo(String userName) {

		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(userName,0);
		if(Util.isNullOrEmpty(user))
			return null;	//	您无权限登录到此系统，请与系统管理员联系");

		//	这里先简单处理，一般是先根据用户名，获取用户，然后在验证密码，注意密码存到数据库中是密文的，然后再进一步的获取用户的各项初始化信息，主要是权限信息、所属企业等
		HashMap<Object, Object> map = new HashMap<Object, Object>();

		//用户成功登录后，返回给前端使用的信息，
		//目前统计需要返回：登录人的ID/登录人的名称/登录人所在的企业ID/登录人所在企业名称/登录人对应的功能
		map.put("loginId",user.getLoginId());//用户登录ID
		map.put("loginUserId",user.getLoginUserId());//系统用户标识

		PartyPerson person = iPerPersonDao.findPartyPersonByPartyId(user.getParty().getPartyId());

		map.put("perName",person.getName());//用户名称
		map.put("perMobile",person.getMobile());//用户的联系方式
		map.put("perQq",person.getQq());//用户的QQ
		map.put("perPartyId",person.getPartyId());//员工的当事人ID
		map.put("partyTypeId",person.getParType().getParTypeId());//员工的当事人ID
		map.put("admFlag",person.getAdmFlag());//管理员标识

		map.put("funs",sysLoginFunDao.findSysLoginFunByLoginUser(user.getLoginUserId()));//获取企业员工的功能权限

		PartyOrg po_ = partyRelationDao.findPartyOrgByPartyId2(1,user.getParty().getPartyId());//注意，应该拿企业的信息
		if(po_!=null){
			map.put("orgId",po_.getPartyId());//用户所属组织ID
			map.put("orgName",po_.getName());//用户所属组织名称
			map.put("orgCode",po_.getCode());//用户所属组织编码
			map.put("orgLevel",po_.getOrgLevel());//用户所属组织级别
			map.put("orgParentCode",po_.getParentCode());//用户所属组织名称
			}

		return map;
		}

	}
