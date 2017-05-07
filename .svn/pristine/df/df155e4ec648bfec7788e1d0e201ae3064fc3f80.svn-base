package com.hjd.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.xml.sax.SAXException;

import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.ISysLoginUserDao;
import com.hjd.domain.SysLoginUser;
import com.hjd.util.BeanUtil;
import com.hjd.util.SendToTransport;
import com.hjd.util.Util;

import groovy.util.XmlSlurper;
import groovy.util.slurpersupport.GPathResult;
import groovy.util.slurpersupport.NodeChildren;

@RestController
public class ExternalCommAction extends BaseAction {

	@Value("${wsclient.clientid}")
	private String clientId = null;
	@Value("${wsclient.clientsecret}")
	private String clientSecret = null;

	@Autowired
	private ISysLoginUserDao sysLoginUserDao;

	/**
	 * 内部员工信息维护 - 根据用户登录名查询，客户是否在统一用户认证系统中注册（外部通讯接口）
	 * 1：判断输入的用户登录名，是否已在设备租赁系统中注册
	 * 2：判断输入的用户登录名，是否已在统一用户认证系统中注册
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/BG/Party/CheckSysUser/{loginId}", method={RequestMethod.GET})
	public Map checkSysUser(@PathVariable String loginId) {

		//	1：判断输入的用户登录名，是否已在设备租赁系统中注册
		verifyNotEmpty(loginId,"用户登录名");
		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId,0);
		if(!"".equals(Util.toStringAndTrim(user)))
			throw new IFException("用户登录名重复，请重新输入");

		//	2：判断输入的用户登录名，是否已在统一用户认证系统中注册
		StringBuffer sb = new  StringBuffer();

		sb.append("checkSysUser~&~").append(loginId);
		sb.append("~!~").append(clientId);
		sb.append("~!~").append(clientSecret);

		SendToTransport transport = new SendToTransport();

		Map<String,Object> data = new HashMap<String,Object>();
		try{
			String returnData = transport.send(sb.toString());
			data = BeanUtil.toObjectFromJson(returnData, Map.class);

			//	去掉字符串为null的数据，改为null
			Iterator<String> it = data.keySet().iterator();

			String key;
			while(it.hasNext()){
				key = it.next();
				if("null".equals(data.get(key)))
					data.put(key, "");
				}
			}
		catch(Exception e){
			e.printStackTrace();
			throw new IFException("通讯异常，请稍后再试");
			}

		if(!"1".equals(Util.toStringAndTrim(data.get("status")))){
			throw new IFException(Util.toStringAndTrim(data.get("user_backMsg")));
		}
		return data;
		}

	/**
	 * 外部员工信息维护 - 根据用户登录名查询，客户的供应商信息（外部通讯接口）
	 * 1：判断输入的用户登录名，是否已在设备租赁系统中注册
	 * 2：判断输入的用户登录名，是否是GS系统供应商，且返回GS系统供应商信息
	 */
	@RequestMapping(value="/BG/Party/GetVmappInfoByUserCode/{loginId}", method={RequestMethod.GET})
	public Map<String,Object> getVmappInfoByUserCode(@PathVariable String loginId) {

		//	1：判断输入的用户登录名，是否已在设备租赁系统中注册
		verifyNotEmpty(loginId,"用户登录名");
		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId,0);
		if(!"".equals(Util.toStringAndTrim(user))){throw new IFException("用户登录名重复，请重新输入");}

		//	2：判断输入的用户登录名，是否是GS系统供应商，且返回GS系统供应商信息
		Map<String,Object> requestMap = new HashMap<String,Object>();

		requestMap.put("code",loginId);

		String requestStr = BeanUtil.toJsonString(requestMap);

		StringBuffer sb = new  StringBuffer();

		sb.append("interfaceList~&~GetVmappInfoByUserCode~!~").append(requestStr);
		sb.append("~!~1~!~").append(clientId);
		sb.append("~!~").append(clientSecret);

		SendToTransport transport = new SendToTransport();

		@SuppressWarnings("rawtypes")
		Map response = new HashMap();
		try{
			String returnData = transport.send(sb.toString());
			response = BeanUtil.toObjectFromJson(returnData, Map.class);
			}
		catch(Exception e){
			e.printStackTrace();
			throw new IFException("通讯异常，请稍后再试");
			}

		if(!"TRUE".equals(Util.toStringAndTrim(response.get("result")))){
			throw new IFException(Util.toStringAndTrim(response.get("detail")));
		}
		String packet = Util.toStringAndTrim(response.get("detail"));

		Map<String,Object> data = new HashMap<String,Object>();
		try{
			GPathResult parseObj = (GPathResult)new XmlSlurper().parseText(packet);

			NodeChildren diffgram = (NodeChildren)parseObj.getProperty("diffgram");
			NodeChildren newDataSet = (NodeChildren)diffgram.getProperty("NewDataSet");
			NodeChildren table = (NodeChildren)newDataSet.getProperty("Table");

			String name = ((NodeChildren)table.getProperty("VFNAME")).text();
			if(Util.isNullOrEmpty(name)){throw new IFException("无此供应商信息");}

			String vfname = ((NodeChildren)table.getProperty("VFNAME")).text();
			String contact = ((NodeChildren)table.getProperty("CONTACT")).text();
			String contacttel = ((NodeChildren)table.getProperty("CONTACTTEL")).text();
			String email = ((NodeChildren)table.getProperty("EMAIL")).text();
			
			data.put("name","null".equals(vfname) ? "" : vfname);
			data.put("contact","null".equals(contact)? "" : contact);
			data.put("contactTel","null".equals(contacttel) ? "" : contacttel);
			data.put("email","null".equals(email) ? "" : email);
			data.put("userName", loginId);
			}
		catch(IOException | SAXException | ParserConfigurationException e){
			e.printStackTrace();
			throw new IFException("通讯异常，请稍后再试");
			}

		return data;
		}

	}
