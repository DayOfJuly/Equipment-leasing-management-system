package com.hjd.action;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.PartyPersonBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IPartyRelationDao;
import com.hjd.dao.IPerPersonDao;
import com.hjd.dao.ISysLoginFunDao;
import com.hjd.dao.ISysLoginUserDao;
import com.hjd.domain.PartyOrg;
import com.hjd.domain.PartyPerson;
import com.hjd.domain.PartyRelation;
import com.hjd.domain.PartyRelationType;
import com.hjd.domain.PartyType;
import com.hjd.domain.ProdFunSet;
import com.hjd.domain.SysLoginFun;
import com.hjd.domain.SysLoginUser;
import com.hjd.util.Util;

@RestController
public class UserAction extends BaseAction {
	
		@Autowired
		private ISysLoginUserDao sysLoginUserDao;
		@Autowired
		private IPartyRelationDao partyRelationDao;
		@Autowired
		private ISysLoginFunDao sysLoginFunDao;
		@Autowired
		private IPerPersonDao iPerPersonDao;
		

	    /**
	     *  用户登录
	     * @param reqParamsMap
	     * @param httpSession
	     * @return
	     */
		@RequestMapping(value="/Sys/User",method={RequestMethod.GET},params={"Action=Login"})
		public Map<Object, Object> login(@RequestParam Map<?, ?> reqParamsMap,HttpSession httpSession)
		{
			//获取从前端页面输入的用户名和密码
			String userName = (String)reqParamsMap.get("userName");
			String password = (String)reqParamsMap.get("password");
			verifyNotEmpty(userName,"用户名");
			verifyNotEmpty(password,"密码");
			SysLoginUser user=null;
			
			String isAudit = (String)reqParamsMap.get("isAudit");
			if(Util.isNotNullOrEmpty(isAudit) && "TRUE".equals(isAudit))
			{
				user = sysLoginUserDao.findAduitUserByLoginId(userName,0,7);
			}
			else
			{
				user = sysLoginUserDao.findSysLoginUserByLoginId(userName,0);
			}
			
			if(Util.isNullOrEmpty(user))
			{
				throw new IFException("您无权限登录到此系统，请与系统管理员联系");
			}
//			if(!MD5Util.MD5(userName, password).equals(user.getPassword()))
//			{
//				throw new IFException("登录名或密码错误，请重新输入！！");
//			};
			if(!password.equals(user.getPassword()))
			{
				throw new IFException("登录名或密码错误，请重新输入！！");
			};
			
			HashMap<Object, Object> map=new HashMap<Object, Object>();
			//这里先简单处理，一般是先根据用户名，获取用户，然后在验证密码，注意密码存到数据库中是密文的，然后再进一步的获取用户的各项初始化信息，主要是权限信息、所属企业等
			if(user!=null)
			{
				//用户成功登录后，返回给前端使用的信息，
				//目前统计需要返回：登录人的ID/登录人的名称/登录人所在的企业ID/登录人所在企业名称/登录人对应的功能
				map.put("loginId",user.getLoginId());//用户登录ID
				map.put("loginUserId",user.getLoginUserId());//系统用户标识
				
				PartyPerson pp =iPerPersonDao.findPartyPersonByPartyId(user.getParty().getPartyId());
				map.put("perName",pp.getName());//用户名称
				map.put("perMobile",pp.getMobile());//用户的联系方式
				map.put("perQq",pp.getQq());//用户的QQ
				map.put("perPartyId",pp.getPartyId());//员工的当事人ID
				map.put("partyTypeId",pp.getParType().getParTypeId());//员工的当事人ID
				map.put("admFlag",pp.getAdmFlag());//管理员标识
				
				/*map.put("cityName", pp.getRegion().getName());*/
				
				map.put("funs",sysLoginFunDao.findSysLoginFunByLoginUser(user.getLoginUserId()));//获取企业员工的功能权限
				
				PartyOrg po_ = partyRelationDao.findPartyOrgByPartyId2(1,user.getParty().getPartyId());//注意，应该拿企业的信息
				
				if(po_!=null)
				{
					map.put("orgParTypeId",po_.getParType().getParTypeId());//	用户所属组织类型
					map.put("orgId",po_.getPartyId());//用户所属组织ID
					map.put("orgName",po_.getName());//用户所属组织名称
					map.put("orgCode",po_.getCode());//用户所属组织编码
					map.put("orgLevel",po_.getOrgLevel());//用户所属组织级别
					map.put("orgParentCode",po_.getParentCode());//用户所属上级组织编码
				}
				
               PartyOrg pro_ = partyRelationDao.findPartyProByPartyId2(1,user.getParty().getPartyId());//注意，应该拿项目的信息
				
				if(pro_!=null)
				{
					map.put("proId",pro_.getPartyId());//用户所属项目ID
					map.put("proName",pro_.getName());//用户所属项目名称
					map.put("proAtProvince",pro_.getAtProvince());	//	用户所属项目省id
					map.put("proAtProvinceName",pro_.getAtProvinceName());	//	用户所属项目省名称
					map.put("proAtCity",pro_.getAtCity());	//	用户所属项目市id
					map.put("proAtCityName",pro_.getAtCityName());	//	用户所属项目市名称
					map.put("proAtDistrict",pro_.getAtDistrict());	//	用户所属项目区id
					map.put("proAtDistrictName",pro_.getAtDistrictName());	//	用户所属项目区名称
					map.put("proOffAddr",pro_.getOffAddr());	//	用户所属项目详细地址
					map.put("proContacts",pro_.getContacts());	//	用户所属项目负责人
					map.put("proContactsMobile",pro_.getContactsMobile());	//	用户所属项目联系电话
				}
			}
			httpSession.setAttribute("userInfo", map);
			httpSession.setMaxInactiveInterval(900);
			return map;
		}
		
		/**
		 *注销用户的方法 
		 * @param httpSession
		 * @return
		 * @throws IOException 
		 */
		@RequestMapping(value="/Sys/User",method={RequestMethod.GET},params={"Action=Logout"})
		public Map<String, Object> logout(HttpSession httpSession)
		{   
			httpSession.removeAttribute("userInfo");
			httpSession.invalidate();
			httpSession=null;
			Map<String,Object> map=new HashMap<String, Object>();
			map.put("msg","注销成功");
			return map;
		}

	/**
	 * 移动端客户自助注册（仅实现外部员工信息注册）
	 * 1-校验客户注册的输入信息，登录名、手机号码和设置的登录密码
	 * 2-添加新注册客户的企业信息，移动端客户注册的企业编码统一为“mobile”
	 * 3-添加新注册客户的个人信息
	 * 4-添加新注册客户的企业与新注册客户的关系
	 * 5-添加新注册客户的登录信息
	 * 6-添加新注册客户可操作的功能
	 */
	@Transactional
	@RequestMapping(value="/BG/Party/MobileUserReg", method={RequestMethod.PUT})
	public Long mobileUserReg(@RequestBody PartyPersonBean partyPersonBean, HttpSession httpSession) {

		Date currDate = new Date();

		//	1-校验客户注册的输入信息，登录名
		String loginId = partyPersonBean.getLoginId();
		verifyNotEmpty(loginId, "账号");

		SysLoginUser userByLoginId = sysLoginUserDao.findSysLoginUserByLoginId(loginId,0);
		if(!"".equals(Util.toStringAndTrim(userByLoginId)))
			throw new IFException("账号重复，请重新输入");

		String mobile = partyPersonBean.getMobile();
		verifyNotEmpty(mobile, "手机号码");

		//	校验设置的登录密码不为空，且两次输入是否相同
		String pwd = partyPersonBean.getPwd();
		verifyNotEmpty(pwd, "密码");
		String confPwd = partyPersonBean.getConfPwd();
		verifyNotEmpty(confPwd, "重新输入密码");

		if(!pwd.equals(confPwd))
			throw new IFException("两次输入的登录密码不一致，请重新输入");

		//	2-添加新注册客户的企业信息，移动端客户注册的企业编码统一为“mobile”
		PartyOrg org = new PartyOrg();

		org.setCode("mobile");	//	企业编码
		org.setName(partyPersonBean.getMobile());	//	单位名称，手机端注册取手机号
		org.setOrgLevel(6);	//	组织级别，手机端注册组织级别
		org.setParentCode("mobile");
		org.setCreateTime(currDate);
		org.setParType(new PartyType(8));	//	手机端注册企业类型
		org.setState(0);	//	0-启用
		org.setUpdateTime(currDate);

		insert(org);

		/*Long orgPartyId = org.getPartyId();	//	新添加的企业标识
*/
		//	3-添加新注册客户的个人信息
		PartyPerson person = new PartyPerson();
		partyPersonBean.copyPropertyToDestBean(person);

		person.setName(partyPersonBean.getMobile());	//	个人名称，手机端注册取手机号
		person.setCreateTime(currDate);
		person.setParType(new PartyType(6));	//	手机端注册企业员工类型
		person.setState(0);	//	0-启用
		person.setUpdateTime(currDate);

		insert(person);

		Long partyId = person.getPartyId();	//	新添加的企业员工标识

		//	4-添加新注册客户的企业与新注册客户的关系
		PartyRelation orgRelation = new PartyRelation();

		orgRelation.setRelationType(new PartyRelationType(1));
		orgRelation.setParty1(org);
		orgRelation.setParty2(person);

		insert(orgRelation);

		//	5-添加新注册客户的登录信息
		SysLoginUser loginUser = new SysLoginUser();

		loginUser.setParty(person);
		loginUser.setState(0);	//	0-启用
		loginUser.setLoginId(loginId);
		loginUser.setUpdateTime(currDate);
		loginUser.setPassword(pwd);	//	初始密码，暂时用明文，后续修改需要做序列化或加密保存

		loginUser.setPhoneNo(partyPersonBean.getMobile());	//	注册电话号
		loginUser.setMail(partyPersonBean.getMail());	//	注册电子邮箱

		insert(loginUser);

		//	6-添加新注册客户可操作的功能
		//	10（外部资源管理）；11（联系方式维护）；12（折旧费登记）；
		//	13（租赁费登记--设备拥有者）；14（发布结果登记）；17（租赁费登记--设备使用者）；
		Long[] funcInfo = new Long[]{10L,11L,12L,13L,14L,17L};
		SysLoginFun loginFunRelation;
		for(Long func : funcInfo){
			loginFunRelation = new SysLoginFun();

			loginFunRelation.setLoginUser(loginUser);
			loginFunRelation.setFunctionId(new ProdFunSet(func));

			insert(loginFunRelation);
			}

		return partyId;
		}

	}