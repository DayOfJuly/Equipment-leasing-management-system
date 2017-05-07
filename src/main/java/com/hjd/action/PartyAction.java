package com.hjd.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.CifInfoMsgBean;
import com.hjd.action.bean.CifInfoSearchMsgBean;
import com.hjd.action.bean.PartyOrgBean;
import com.hjd.action.bean.PartyOrgSearchBean;
import com.hjd.action.bean.PartyPersonBean;
import com.hjd.action.bean.PartyPersonSearchBean;
import com.hjd.action.bean.PartyRegionSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IPartyOrgDao;
import com.hjd.dao.IPartyRegionRelationDao;
import com.hjd.dao.IPartyRelationDao;
import com.hjd.dao.IPartyUploadFileDao;
import com.hjd.dao.IPerPersonDao;
import com.hjd.dao.ISysLoginRoleDao;
import com.hjd.dao.ISysLoginUserDao;
import com.hjd.domain.Party;
import com.hjd.domain.PartyOrg;
import com.hjd.domain.PartyPerson;
import com.hjd.domain.PartyRegion;
import com.hjd.domain.PartyRegionRelation;
import com.hjd.domain.PartyRegionRelationType;
import com.hjd.domain.PartyRelation;
import com.hjd.domain.PartyRelationType;
import com.hjd.domain.PartyType;
import com.hjd.domain.PartyUploadFile;
import com.hjd.domain.SysLoginRole;
import com.hjd.domain.SysLoginRoleType;
import com.hjd.domain.SysLoginUser;
import com.hjd.domain.UploadFileInfo;
import com.hjd.util.Util;

@RestController
public class PartyAction extends BaseAction {

	@Autowired
	private ISysLoginUserDao sysLoginUserDao;
	@Autowired
	private ISysLoginRoleDao sysLoginRoleDao;
	@Autowired
	private IPartyUploadFileDao partyUploadFileDao;
	@Autowired
	private IPartyOrgDao partyOrgDao;
	@Autowired
	private IPartyRelationDao partyRelationDao;
	@Autowired
	private IPartyRegionRelationDao partyRegionRelationDao;
	@Autowired
	private IPerPersonDao iPerPersonDao;

	/********************************************************************************/

	/**
	 * 员工信息 - 列表分页查询
	 */
	@RequestMapping(value="/Party/Per", method={RequestMethod.POST})
	public Page<?> searchPartyPerson(@RequestBody PartyPersonSearchBean partyPersonSearchBean) {

		Integer parTypeId = partyPersonSearchBean.getParTypeId();
		if(parTypeId==null)
			throw new IFException("当事人类型不能为空");
		else if(1!=parTypeId && 2!=parTypeId && 3!=parTypeId)
			throw new IFException("不支持此当事人类型");

		Long currOrgId = partyPersonSearchBean.getCurrOrgId();
		if(currOrgId==null && (2==parTypeId || 3==parTypeId))
			throw new IFException("当前登录人员的机构标识不能为空");

		Map<String,Object> params = new HashMap<String,Object>();

		StringBuffer listSql = new StringBuffer();

		if(3==parTypeId){
			listSql.append("select view ");
			listSql.append("from ViewPersonRelationSysLoginUser view ");
			listSql.append("where view.parTypeId=3 and view.deptId=").append(currOrgId);
			}
		else if(2==parTypeId){
			listSql.append("select view ");
			listSql.append("from ViewOrgRelationSysLoginUser view ");
			listSql.append("where view.parentState=0 and view.relationType=1 and view.name!=null and view.parentOrgId=").append(currOrgId);
			}
		else{
			listSql.append("select view ");
			listSql.append("from ViewOrgRelationSysLoginUser view ");
			listSql.append("where view.parentState=0 and view.relationType=1 and view.name!=null");
			}

		StringBuffer countSql = new StringBuffer();

		if(3==parTypeId){
			countSql.append("select count(1) ");
			countSql.append("from ViewPersonRelationSysLoginUser view ");
			countSql.append("where view.parTypeId=3 and view.deptId=").append(currOrgId);
			}
		else if(2==parTypeId){
			countSql.append("select count(1) ");
			countSql.append("from ViewOrgRelationSysLoginUser view ");
			countSql.append("where view.parentState=0 and view.relationType=1 and view.name!=null and view.parentOrgId=").append(currOrgId);
			}
		else{
			countSql.append("select count(1) ");
			countSql.append("from ViewOrgRelationSysLoginUser view ");
			countSql.append("where view.parentState=0 and view.relationType=1 and view.name!=null");
			}

		if(3==parTypeId){
			String fuzzyData = partyPersonSearchBean.getFuzzyData();
			if(!"".equals(Util.toStringAndTrim(fuzzyData))){
				listSql.append(" and (");
				listSql.append("view.code like '%").append(fuzzyData).append("%'");
				listSql.append(" or view.name like '%").append(fuzzyData).append("%'");
				listSql.append(" or view.mobile like '%").append(fuzzyData).append("%'");
				listSql.append(")");

				countSql.append(" and (");
				countSql.append("view.code like '%").append(fuzzyData).append("%'");
				countSql.append(" or view.name like '%").append(fuzzyData).append("%'");
				countSql.append(" or view.mobile like '%").append(fuzzyData).append("%'");
				countSql.append(")");
				}
			
				String deptName = partyPersonSearchBean.getDepartmentName();
				if(!"".equals(Util.toStringAndTrim(deptName)))
				{
					listSql.append(" AND view.deptName LIKE '%").append(deptName).append("%'");
					countSql.append(" AND view.deptName LIKE '%").append(deptName).append("%'");
				}
			}

		listSql.append(" ORDER BY view.updateTime DESC ");
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),params,partyPersonSearchBean.getPageRequest());

		return datas;
		}

	/**
	 * 员工信息 - 详细查询
	 */
	@RequestMapping(value="/Party/Per/{partyId}", method={RequestMethod.GET})
	public Map<String,Object> searchPartyPersonDetail(@PathVariable Long partyId) {

		if(partyId==null)
			throw new IFException("当事人标识不能为空");

		Map<String,Object> data = new HashMap<String,Object>();

		Party party = new Party(partyId);

		PartyRelation baseParty = partyRelationDao.findByRelationTypeAndParty2(new PartyRelationType(1),party);

		if(baseParty!=null){
			SysLoginUser loginUser = sysLoginUserDao.findByParty(party);

			Integer parTypeId = baseParty.getParty2().getParType().getParTypeId();
			if(4==parTypeId){//	系统管理员
				PartyOrg org = queryOne(party);

				data.put("parTypeId",2);
				data.put("name",org.getContacts());
				data.put("mobile",org.getContactsMobile());
				data.put("email",org.getContactsEmail());
				data.put("orgName",org.getName());
				data.put("parentOrgId",baseParty.getParty1().getPartyId());

				if(loginUser!=null){
					data.put("loginId",loginUser.getLoginId());
					data.put("updateTime",Util.convertDateToStr(loginUser.getUpdateTime(),"yyyy-MM-dd HH:mm:ss"));
					data.put("note",loginUser.getNote());
					data.put("uId",loginUser.getUId());
					data.put("openId",loginUser.getOpenId());
					data.put("state",loginUser.getState());
					}
				}
			else if(3==parTypeId){//	员工
				PartyPerson person = queryOne(party);

				data.put("parTypeId",3);
				data.put("name",person.getName());
				data.put("code",person.getCode());
				data.put("mobile",person.getMobile());
				data.put("email",person.getEmail());
				data.put("deptId",baseParty.getParty1().getPartyId());
				data.put("note",person.getNote());

				if(loginUser!=null){
					data.put("loginId",loginUser.getLoginId());
					data.put("updateTime",Util.convertDateToStr(loginUser.getUpdateTime(),"yyyy-MM-dd HH:mm:ss"));
					data.put("uId",loginUser.getUId());
					data.put("openId",loginUser.getOpenId());
					data.put("state",loginUser.getState());

					data.put("roleInfo",sysLoginRoleDao.findSysLoginRoleByLoginUser(loginUser.getLoginUserId(),0));
					}

				data.put("uploadFileInfo",partyUploadFileDao.findUploadFileByParty(party));
				}
			else{
				throw new IFException("没有此当事人");
				}

			data.put("partyId",partyId);
			}

		return data;
		}

	/**
	 * 检查用户编号是否存在，如果不存在返回FALSE，前端添加页面可以使用
	 */
	@RequestMapping(value="/Party/Per", method={RequestMethod.GET})
	public Map<String,String> checkCodeExist(@RequestParam Map<?, ?> reqParamsMap) 
	{
		String code=(String)reqParamsMap.get("code");
		Map<String, String> map = new HashMap<String, String>();
		String searchResult="FALSE";
		if(Util.isNotNullOrEmpty(code))
		{
			PartyPerson pp =iPerPersonDao.findPartyPersonByCode(code);
			if(pp!=null){searchResult="TRUE";}
		}
		map.put("msg", searchResult);
		return map;
	}
	
	/**
	 * 员工信息 - 添加
	 * 系统管理员无个人实体，与企业绑定，信息记录在partyOrg中
	 * 员工有个人实体，与企业内的部门关联，信息记录在partyPerson中
	 */
	@Transactional
	@RequestMapping(value="/Party/Per", method={RequestMethod.PUT})
	public Long addPartyPerson(@RequestBody PartyPersonBean partyPersonBean)
	{
		//	校验统一身份认证平台 - 登录名 不能重复
		String loginId = partyPersonBean.getLoginId();
		if("".equals(Util.toStringAndTrim(loginId))) {throw new IFException("请输入登录名");}

		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId,0);
		if(user!=null) { throw new IFException("登录名重复，请重新输入"); }

		String uId = partyPersonBean.getLoginUId();
		if("".equals(Util.toStringAndTrim(uId))) {throw new IFException("uId不能为空");}

		String openId = partyPersonBean.getOpenId();
		if("".equals(Util.toStringAndTrim(openId))) {throw new IFException("openId不能为空");}

		String name = partyPersonBean.getName();
		if("".equals(Util.toStringAndTrim(name))){throw new IFException("名称不能为空");}

		String mobile = partyPersonBean.getMobile();
		if("".equals(Util.toStringAndTrim(mobile))){throw new IFException("手机号码不能为空");}

		String email = partyPersonBean.getEmail();
		if("".equals(Util.toStringAndTrim(email))){throw new IFException("电子邮箱不能为空");}

		Integer parTypeId = partyPersonBean.getParTypeId();
		if(parTypeId==null){throw new IFException("当事人类型不能为空");}
		else if(1!=parTypeId && 2!=parTypeId && 3!=parTypeId){throw new IFException("不支持此当事人类型");}

		Long partyId = null;

		if(1==parTypeId)//	超级系统管理员
		{
			//	根据企业名称，判断企业是否存在
			String orgName = partyPersonBean.getOrgName();
			if("".equals(Util.toStringAndTrim(orgName))){throw new IFException("企业名称不能为空");}

			PartyOrg org = partyOrgDao.findByNameAndState(orgName,0);
			if(org==null){throw new IFException("该企业不存在");}

			if(!"".equals(Util.toStringAndTrim(org.getContacts()))){throw new IFException("该企业已存在系统管理员");}

			partyId = org.getPartyId();

			//	1.1-新增系统管理员
			org.setContacts(partyPersonBean.getName());
			org.setContactsMobile(partyPersonBean.getMobile());
			org.setContactsEmail(partyPersonBean.getEmail());
			org.setUpdateTime(new Date());
			update(org);
		}
		else if(2==parTypeId)//	系统管理员
		{
			//	根据企业名称，判断企业是否存在
			String orgName = partyPersonBean.getOrgName();
			if("".equals(Util.toStringAndTrim(orgName))){throw new IFException("企业名称不能为空");}

			Long parentOrgId = partyPersonBean.getParentOrgId();
			if(parentOrgId==null){throw new IFException("上级企业标识不能为空");}

			PartyOrg org = partyRelationDao.findPartyOrgByPartyId1AndName(1,parentOrgId,orgName,0);
			if(org==null){throw new IFException("该企业不存在或者不在管辖范围之内");}

			if(!"".equals(Util.toStringAndTrim(org.getContacts()))){throw new IFException("该企业已存在系统管理员");}

			partyId = org.getPartyId();

			//	1.1-新增系统管理员
			org.setContacts(partyPersonBean.getName());
			org.setContactsMobile(partyPersonBean.getMobile());
			org.setContactsEmail(partyPersonBean.getEmail());
			org.setUpdateTime(new Date());
			update(org);
		}
		else if(3==parTypeId)//	员工
		{
			Long parentPartyId = partyPersonBean.getDeptId();	//	所属部门标识

			//	判断角色与用户是否在同一部门
			checkPerDeptAndRoleDept(parentPartyId,partyPersonBean.getRoleInfo());

			String code = partyPersonBean.getCode();
			if("".equals(Util.toStringAndTrim(code))){throw new IFException("员工编号不能为空");}

			Integer authLv = partyPersonBean.getAuthLv();
			if(authLv==null){throw new IFException("审批级别不能为空");}

			//	1.1-新增员工
			PartyPerson person = new PartyPerson();

			partyPersonBean.copyPropertyToDestBean(person);

			person.setCreateTime(new Date());
			person.setParType(new PartyType(parTypeId));
			person.setState(0);	//	0-启用

			insert(person);

			partyId = person.getPartyId();

			//	1.2-新增员工与部门关系
			PartyRelation relation = new PartyRelation();

			relation.setRelationType(new PartyRelationType(1));
			relation.setParty1(new Party(parentPartyId));
			relation.setParty2(new Party(partyId));

			insert(relation);
		}

		//	2-新增系统用户
		SysLoginUser loginUser = new SysLoginUser();

		loginUser.setParty(new Party(partyId));
		loginUser.setState(0);	//	0-启用
		loginUser.setLoginId(loginId);
		loginUser.setUId(uId);
		loginUser.setOpenId(openId);
		loginUser.setUpdateTime(new Date());
		if(1==parTypeId || 2==parTypeId)//	系统管理员
		{
			loginUser.setNote(partyPersonBean.getNote());
		}
		insert(loginUser);

		//	3-新增系统用户与角色关系
		if(1==parTypeId || 2==parTypeId)//	系统管理员
		{
			SysLoginRole loginRoleRelation = new SysLoginRole();

			loginRoleRelation.setLoginUser(loginUser);
			loginRoleRelation.setRole(new SysLoginRoleType(2L));	//	系统管理员角色

			insert(loginRoleRelation);
		}
		else if(3==parTypeId)//	员工
		{
			SysLoginRole loginRoleRelation;
			for(Map<String,Object> role : partyPersonBean.getRoleInfo())
			{
				loginRoleRelation = new SysLoginRole();

				loginRoleRelation.setLoginUser(loginUser);
				loginRoleRelation.setRole(new SysLoginRoleType(Long.valueOf(Util.toStringAndTrim(role.get("roleId")))));

				insert(loginRoleRelation);
			}
		}

		//	4-保存上传文件信息，并且新增系统管理员/员工上传文件关系
		List<Map<String,Object>> uploadFileInfo = partyPersonBean.getUploadFileInfo();
		if(uploadFileInfo!=null && uploadFileInfo.size()>0)
		{
			UploadFileInfo file;
			PartyUploadFile partyFile;
			for(Map<String,Object> uploadFile : uploadFileInfo){
				file = new UploadFileInfo();

				file.setUploadName(Util.toStringAndTrim(uploadFile.get("uploadName")));
				file.setSaveName(Util.toStringAndTrim(uploadFile.get("saveName")));
				file.setSaveDir(Util.toStringAndTrim(uploadFile.get("saveDir")));
				file.setType(1);	//	2-员工证件类

				insert(file);

				partyFile = new PartyUploadFile();

				partyFile.setUploadFile(file);
				partyFile.setParty(new Party(partyId));

				insert(partyFile);
				}
			}

		return partyId;
	}

	private void checkPerDeptAndRoleDept(Long deptId, List<Map<String,Object>> roleInfo) {

		if(deptId==null)
			throw new IFException("请选择部门");

		if(roleInfo==null || roleInfo.size()<=0){
			throw new IFException("请选择角色");
			}

		for(Map<String,Object> role : roleInfo){
			Long partyId = Long.valueOf(Util.toStringAndTrim(role.get("partyId")));

			if(!deptId.equals(partyId))
				throw new IFException("角色与员工不在同一部门，请选择员工所在部门的角色");
			}
		}

	/**
	 * 员工信息 - 修改
	 * 系统管理员无个人实体，与企业绑定，信息记录在partyOrg中
	 * 员工有个人实体，与企业内的部门关联，信息记录在partyPerson中
	 */
	/**
	 * @param partyId
	 * @param partyPersonBean
	 * @return
	 */
	@Transactional
	@RequestMapping(value="/Party/Per/{partyId}", method={RequestMethod.POST})
	public Long modifyPartyPerson(@PathVariable Long partyId, @RequestBody PartyPersonBean partyPersonBean)
	{
		//	校验统一身份认证平台 - 登录名 不能重复
		String loginId = partyPersonBean.getLoginId();
		if("".equals(Util.toStringAndTrim(loginId))){throw new IFException("请输入登录名");}

		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId,0);
		if(user!=null && !partyId.equals(user.getParty().getPartyId())){throw new IFException("登录名重复，请重新输入");}

		String uId = partyPersonBean.getLoginUId();
		if("".equals(Util.toStringAndTrim(uId))){throw new IFException("uId不能为空");}

		String openId = partyPersonBean.getOpenId();
		if("".equals(Util.toStringAndTrim(openId))){throw new IFException("openId不能为空");}

		String name = partyPersonBean.getName();
		if("".equals(Util.toStringAndTrim(name))){throw new IFException("名称不能为空");}

		String mobile = partyPersonBean.getMobile();
		if("".equals(Util.toStringAndTrim(mobile))){throw new IFException("手机号码不能为空");}

		String email = partyPersonBean.getEmail();
		if("".equals(Util.toStringAndTrim(email))){throw new IFException("电子邮箱不能为空");}

		Integer parTypeId = partyPersonBean.getParTypeId();
		if(parTypeId==null){throw new IFException("当事人类型不能为空");}
		else if(1!=parTypeId && 2!=parTypeId && 3!=parTypeId){throw new IFException("不支持此当事人类型");}

		if(1==parTypeId)//	超级系统管理员
		{
			//	根据企业名称，判断企业是否存在
			String orgName = partyPersonBean.getOrgName();
			if("".equals(Util.toStringAndTrim(orgName))){throw new IFException("企业名称不能为空");}

			PartyOrg org = partyOrgDao.findByNameAndState(orgName,0);
			if(org==null){throw new IFException("该企业不存在");}

			if("".equals(Util.toStringAndTrim(org.getContacts()))){throw new IFException("该企业没有系统管理员，请先添加");}

			//	1.1-修改不同企业系统管理员/修改同企业系统管理员
			if(!partyId.equals(org.getPartyId()))
			{
				//	删除原企业系统管理员
				PartyOrg originParty = new PartyOrg();

				originParty.setPartyId(partyId);

				PartyOrg originOrg = queryOne(originParty);
				if(originOrg==null){throw new IFException("没有此当事人");}

				originOrg.setContacts(null);
				originOrg.setContactsMobile(null);
				originOrg.setContactsEmail(null);

				update(originOrg);
			}

			//	新增/修改企业系统管理员
			org.setContacts(partyPersonBean.getName());
			org.setContactsMobile(partyPersonBean.getMobile());
			org.setContactsEmail(partyPersonBean.getEmail());
			org.setUpdateTime(new Date());
			update(org);

			partyId = org.getPartyId();
		}
		else if(2==parTypeId)//	系统管理员
		{
			//	根据企业名称，判断企业是否存在
			String orgName = partyPersonBean.getOrgName();
			if("".equals(Util.toStringAndTrim(orgName))){throw new IFException("企业名称不能为空");}

			Long parentOrgId = partyPersonBean.getParentOrgId();
			if(parentOrgId==null){throw new IFException("上级企业标识不能为空");}

			PartyOrg org = partyRelationDao.findPartyOrgByPartyId1AndName(1,parentOrgId,orgName,0);
			if(org==null){throw new IFException("该企业不存在或者不在管辖范围之内");}

			if("".equals(Util.toStringAndTrim(org.getContacts()))){throw new IFException("该企业没有系统管理员，请先添加");}

			//	1.1-修改不同企业系统管理员/修改同企业系统管理员
			if(!partyId.equals(org.getPartyId()))
			{
				//	删除原企业系统管理员
				PartyOrg originParty = new PartyOrg();

				originParty.setPartyId(partyId);

				PartyOrg originOrg = queryOne(originParty);
				if(originOrg==null){throw new IFException("没有此当事人");}

				originOrg.setContacts(null);
				originOrg.setContactsMobile(null);
				originOrg.setContactsEmail(null);

				update(originOrg);
			}

			//	新增/修改企业系统管理员
			org.setContacts(partyPersonBean.getName());
			org.setContactsMobile(partyPersonBean.getMobile());
			org.setContactsEmail(partyPersonBean.getEmail());
			org.setUpdateTime(new Date());
			update(org);

			partyId = org.getPartyId();
		}
		else if(3==parTypeId)//	员工
		{
			Long parentPartyId = partyPersonBean.getDeptId();	//	所属部门标识

			//	判断角色与用户是否在同一部门
			checkPerDeptAndRoleDept(parentPartyId,partyPersonBean.getRoleInfo());

			String code = partyPersonBean.getCode();
			if("".equals(Util.toStringAndTrim(code))){throw new IFException("员工编号不能为空");}

			Integer authLv = partyPersonBean.getAuthLv();
			if(authLv==null){throw new IFException("审批级别不能为空");}

			//	1.1-修改员工
			PartyPerson person = new PartyPerson();

			partyPersonBean.copyPropertyToDestBean(person);

			person.setPartyId(partyId);

			PartyPerson originParty = queryOne(person);
			if(originParty==null){throw new IFException("没有此当事人");}

			person.setCreateTime(originParty.getCreateTime());
			person.setParType(originParty.getParType());
			person.setState(originParty.getState());//	0-启用
			person.setUpdateTime(new Date());
			update(person);

			//	1.2-删除原有系统管理员/员工与企业或部门关系；
			PartyRelationType relationType = new PartyRelationType(1);

			partyRelationDao.deleteByRelationTypeAndParty2(relationType,new Party(partyId));
			//	并且新增系统管理员/员工与企业或部门关系
			PartyRelation relation = new PartyRelation();

			relation.setRelationType(relationType);
			relation.setParty1(new Party(parentPartyId));
			relation.setParty2(person);

			insert(relation);
		}

		//	2-修改系统用户
		Party party = new Party();

		party.setPartyId(partyId);

		SysLoginUser originLoginUser = sysLoginUserDao.findByParty(party);
		if(originLoginUser==null){throw new IFException("没有此当事人");}

		SysLoginUser loginUser = new SysLoginUser();

		loginUser.setParty(party);
		loginUser.setState(originLoginUser.getState());
		loginUser.setLoginId(loginId);
		loginUser.setUId(uId);
		loginUser.setOpenId(openId);
		loginUser.setLoginUserId(originLoginUser.getLoginUserId());
		loginUser.setUpdateTime(new Date());
        //		系统管理员
		if(1==parTypeId || 2==parTypeId){loginUser.setNote(partyPersonBean.getNote());}

		update(loginUser);

		//	3-删除原有系统用户与角色关系；
		sysLoginRoleDao.deleteByLoginUser(new SysLoginUser(originLoginUser.getLoginUserId()));
		//	并且新增系统用户与角色关系
		if(1==parTypeId || 2==parTypeId)//	系统管理员
		{
			SysLoginRole loginRoleRelation = new SysLoginRole();

			loginRoleRelation.setLoginUser(loginUser);
			loginRoleRelation.setRole(new SysLoginRoleType(2L));	//	系统管理员角色

			insert(loginRoleRelation);
		}
		else if(3==parTypeId)//	员工
		{
			SysLoginRole loginRoleRelation;
			for(Map<String,Object> role : partyPersonBean.getRoleInfo())
			{
				loginRoleRelation = new SysLoginRole();

				loginRoleRelation.setLoginUser(loginUser);
				loginRoleRelation.setRole(new SysLoginRoleType(Long.valueOf(Util.toStringAndTrim(role.get("roleId")))));

				insert(loginRoleRelation);
				}
			}

		//	4-删除原有系统管理员/员工上传文件关系，并且删除原有上传文件信息；
		List<UploadFileInfo> originUploadFiles = partyUploadFileDao.findUploadFileByParty(party);

		partyUploadFileDao.deleteByParty(party);

		for(UploadFileInfo originUploadFile : originUploadFiles)
		{
			delete(originUploadFile);
		}
		//	保存上传文件信息，并且新增系统管理员/员工上传文件关系
		List<Map<String,Object>> uploadFileInfo = partyPersonBean.getUploadFileInfo();
		if(uploadFileInfo!=null && uploadFileInfo.size()>0)
		{
			UploadFileInfo file;
			PartyUploadFile partyFile;
			for(Map<String,Object> uploadFile : uploadFileInfo)
			{
				file = new UploadFileInfo();

				file.setUploadName(Util.toStringAndTrim(uploadFile.get("uploadName")));
				file.setSaveName(Util.toStringAndTrim(uploadFile.get("saveName")));
				file.setSaveDir(Util.toStringAndTrim(uploadFile.get("saveDir")));
				file.setType(1);	//	2-员工证件类

				insert(file);

				partyFile = new PartyUploadFile();

				partyFile.setUploadFile(file);
				partyFile.setParty(party);

				insert(partyFile);
			}
		}

		return partyId;
	}

	/**
	 * 员工删除
	 */
	@RequestMapping(value="/Party/Per/{partyId}/{state}", method={RequestMethod.DELETE})
	public Long deletePartyPerson(@PathVariable Long partyId, @PathVariable Integer state) {

		if(partyId==null)
			throw new IFException("当事人标识不能为空");

		if(state==null)
			throw new IFException("状态不能为空");

		Party party = new Party();

		party.setPartyId(partyId);

		Party originParty = queryOne(party);
		if(originParty==null)
			throw new IFException("没有此当事人");

		SysLoginUser loginUser = sysLoginUserDao.findByParty(originParty);
		if(loginUser==null)
			return partyId;

		loginUser.setState(state);	//	0-启用，1-停用
		loginUser.setUpdateTime(new Date());

		update(loginUser);

		return partyId;
		}

	/**
	 * 个人信息 - 根据登录名查询（外部通讯接口）供系统管理，添加企业管理员使用
	 */
	@RequestMapping(value="/Party/Per/Msg", method={RequestMethod.POST})
	public Map<String,Object> searchCifInfoByLoginId(@RequestBody CifInfoSearchMsgBean cifInfoSearchMsgBean) {

		String loginId = cifInfoSearchMsgBean.getLoginId();
		
		Long orgId=cifInfoSearchMsgBean.getOrgId();
		
		if("".equals(Util.toStringAndTrim(loginId)))
			throw new IFException("登录名不能为空");
		Map<String,Object> data = new HashMap<String,Object>();
		
		List<PartyOrg> orgList = partyRelationDao.findPartyOrgByPartyId1AndName_test(orgId);
		if(!orgList.isEmpty())
		{
			data.put("orgName",orgList.get(0).getName());
			Long round=Math.round(Math.random()*1000);
			data.put("loginId","系统企业管理员"+round);
			data.put("perName","苏哲"+round);
			data.put("mobile","12312345"+round);
			data.put("email","email@"+round+".com");
			//data.put("orgName","企业");
			/*data.put("orgName","2132313");*/
			//data.put("uId","uId");
			data.put("openId","openId"+round);
			data.put("loginUId","loginUId"+round);
		}
		return data;
		}
	
	/**
	 * 个人信息 - 根据登录名查询（外部通讯接口）供企业管理，员工信息维护使用，规则：获取的员工信息是当前登录用户所属企业的下级企业的员工，并且该下级企业已经有管理员了
	 */
	@RequestMapping(value="/Party/Per/Msg", method={RequestMethod.GET})
	public Map<String,Object> searchCifInfosByLoginId(@RequestParam Map<?, ?> reqParamsMap) {

		String loginId = (String)reqParamsMap.get("loginId");
		
		String orgId=(String)reqParamsMap.get("orgId");
		Long orgId_=Long.valueOf(orgId);
		if("".equals(Util.toStringAndTrim(loginId)))
			throw new IFException("登录名不能为空");
		Map<String,Object> data = new HashMap<String,Object>();
		
		List<PartyOrg> orgList = partyRelationDao.findPartyOrgByPartyId1AndName_test2(orgId_);
		if(!orgList.isEmpty())
		{
			data.put("orgName",orgList.get(0).getName());
			Long round=Math.round(Math.random()*1000);
			data.put("loginId","i"+round);
			data.put("perName","员工"+round);
			data.put("mobile","12312345"+round);
			data.put("email","email@"+round+".com");
			//data.put("orgName","企业");
			/*data.put("orgName","2132313");*/
			//data.put("uId","uId");
			data.put("openId","openId"+round);
			data.put("loginUId","loginUId"+round);
		}
		return data;
		}

	/********************************************************************************/ /********************************************************************************/

	/**
	 * 企业信息/部门信息 - 列表分页查询
	 */
	@RequestMapping(value="/Party/Ent", method={RequestMethod.POST})
	public Page<?> searchPartyOrg(@RequestBody PartyOrgSearchBean partyOrgSearchBean) {

		Integer parTypeId = partyOrgSearchBean.getParTypeId();
		if(parTypeId==null)
			throw new IFException("当事人类型不能为空");

		Long currOrgId = partyOrgSearchBean.getCurrOrgId();
		if(currOrgId==null)
			throw new IFException("当前查询当事人标识不能为空");

		boolean qryParentFlag = partyOrgSearchBean.getQryParentFlag();

		Map<String,Object> params = new HashMap<String,Object>();

		StringBuffer listSql = new StringBuffer();

		listSql.append("select new Map(org.partyId as currOrgId,org.code as code,org.name as name,org.budget as budget,");

		if(qryParentFlag){
			listSql.append("(select relation3.party1.partyId from PartyRelation relation3 where relation3.relationType.relationType=").append(1);
			listSql.append(" and relation3.party2.partyId=").append(currOrgId).append(") as parentOrgId,");
			listSql.append("(select parentOrg3.name from PartyOrg parentOrg3 where parentOrg3.partyId=(select relation4.party1.partyId from PartyRelation relation4 where relation4.relationType.relationType=").append(1);
			listSql.append(" and relation4.party2.partyId=").append(currOrgId).append(")) as parentOrgName,");
			}
		else{
			listSql.append("(select parentOrg1.partyId from PartyOrg parentOrg1 where parentOrg1.partyId=").append(currOrgId).append(") as parentOrgId,");
			listSql.append("(select parentOrg2.name from PartyOrg parentOrg2 where parentOrg2.partyId=").append(currOrgId).append(") as parentOrgName,");
			}

		listSql.append("date_format(org.updateTime,'%Y-%m-%d %H:%i:%S') as updateTime) ");
		listSql.append("from PartyOrg org ");
		listSql.append("where org.state=0 and org.parType.parTypeId=").append(parTypeId);

		if(qryParentFlag){
			listSql.append(" and org.partyId in (select relation.party2.partyId from PartyRelation relation where relation.relationType.relationType=").append(1);
			listSql.append(" and relation.party1.partyId=(select relation1.party1.partyId from PartyRelation relation1 where relation1.relationType.relationType=").append(1);
			listSql.append(" and relation1.party2.partyId=").append(currOrgId).append(")").append(")");
			}
		else{
			listSql.append(" and org.partyId in (select relation.party2.partyId from PartyRelation relation where relation.relationType.relationType=").append(1);
			listSql.append(" and relation.party1.partyId=").append(currOrgId).append(")");
			}

		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(1) ");
		countSql.append("from PartyOrg org ");
		countSql.append("where org.state=0 and org.parType.parTypeId=").append(parTypeId);

		if(qryParentFlag){
			countSql.append(" and org.partyId in (select relation.party2.partyId from PartyRelation relation where relation.relationType.relationType=").append(1);
			countSql.append(" and relation.party1.partyId=(select relation1.party1.partyId from PartyRelation relation1 where relation1.relationType.relationType=").append(1);
			countSql.append(" and relation1.party2.partyId=").append(currOrgId).append(")").append(")");
			}
		else{
			countSql.append(" and org.partyId in (select relation.party2.partyId from PartyRelation relation where relation.relationType.relationType=").append(1);
			countSql.append(" and relation.party1.partyId=").append(currOrgId).append(")");
			}

		String fuzzyData = partyOrgSearchBean.getFuzzyData();
		if(!"".equals(Util.toStringAndTrim(fuzzyData))){
			listSql.append(" and (");
			listSql.append("org.code like '%").append(fuzzyData).append("%'");
			listSql.append(" or org.name like '%").append(fuzzyData).append("%'");
			listSql.append(")");

			countSql.append(" and (");
			countSql.append("org.code like '%").append(fuzzyData).append("%'");
			countSql.append(" or org.name like '%").append(fuzzyData).append("%'");
			countSql.append(")");
			}

		listSql.append(" ORDER BY org.updateTime DESC ");
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),params,partyOrgSearchBean.getPageRequest());

		return datas;
		}

	/**
	 * 企业信息/部门信息 - 详细查询
	 */
	@RequestMapping(value="/Party/Ent/{partyId}", method={RequestMethod.GET})
	public Map<String,Object> searchPartyOrgDetail(@PathVariable Long partyId) {

		if(partyId==null)
			throw new IFException("当事人标识不能为空");

		Map<String,Object> data = new HashMap<String,Object>();

		PartyOrg party = new PartyOrg();

		party.setPartyId(partyId);

		PartyOrg detail = queryOne(party);

		if(detail!=null){
			data.put("partyId",detail.getPartyId());
			data.put("parTypeId",detail.getParType().getParTypeId());
			data.put("createTime",Util.convertDateToStr(detail.getCreateTime(),"yyyy-MM-dd HH:mm:ss"));
			data.put("updateTime",Util.convertDateToStr(detail.getUpdateTime(),"yyyy-MM-dd HH:mm:ss"));
			data.put("note",detail.getNote());
			data.put("state",detail.getState());
			data.put("budget",detail.getBudget());
			data.put("code",detail.getCode());
			data.put("name",detail.getName());
			data.put("offAddr",detail.getOffAddr());
			data.put("zip",detail.getZip());
			data.put("phone",detail.getPhone());
			data.put("fax",detail.getFax());
			data.put("type",detail.getType());

			PartyOrg parentParty = partyRelationDao.findPartyOrgByPartyId2(1,partyId);
			if(parentParty!=null){
				data.put("parentOrgId",parentParty.getPartyId());
				data.put("parentOrgName",parentParty.getName());
				}

			PartyRegion region = detail.getRegion();
			if(region!=null){
				List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();

				Map<String,Object> map = new HashMap<String,Object>();

				Long regionId = region.getRegionId();

				map.put("regionId",regionId);
				map.put("code",region.getCode());
				map.put("name",region.getName());
				map.put("note",region.getNote());

				list.add(map);

				getAllRegions(list,region,new PartyRegionRelationType(1));

				int count = list.size() - 1;
				for(int i=count;i>=0;i--){
					Map<String,Object> rec = (Map<String,Object>)list.get(i);
					if(i==count)
						data.put("province",rec);
					else if(i==(count - 1))
						data.put("city",rec);
					else if(i==(count - 2))
						data.put("district",rec);
					}
				}
			}

		return data;
		}

	private void getAllRegions(List<Map<String,Object>> list, PartyRegion region, PartyRegionRelationType relationType) {

		if(region==null)
			return;

		PartyRegionRelation partyRegion = partyRegionRelationDao.findByRelationTypeAndRegion2(relationType,region);
		if(partyRegion==null){
			return;
			}
		else{
			PartyRegion newRegion = partyRegion.getRegion1();
			Long regionId = newRegion.getRegionId();
			if(regionId==1)
				return;

			Map<String,Object> map = new HashMap<String,Object>();

			map.put("regionId",regionId);
			map.put("code",newRegion.getCode());
			map.put("name",newRegion.getName());
			map.put("note",newRegion.getNote());

			list.add(map);

			getAllRegions(list,newRegion,relationType);
			}
		}

	/**
	 * 企业添加/部门添加
	 */
	@Transactional
	@RequestMapping(value="/Party/Ent", method={RequestMethod.PUT})
	public Long addPartyOrg_copy(@RequestBody PartyOrgBean partyOrgBean) {

		//	校验企业名称/部门名称 不能重复
		String name = partyOrgBean.getName();
		if("".equals(Util.toStringAndTrim(name)))
			throw new IFException("请输入名称");

		//	1-新增企业/部门
		PartyOrg party = new PartyOrg();

		partyOrgBean.copyPropertyToDestBean(party);

		Integer parTypeId = partyOrgBean.getParTypeId();
		if(parTypeId==null)
			throw new IFException("当事人类型不能为空");
		else if(4!=parTypeId && 5!=parTypeId)
			throw new IFException("不支持此当事人类型");

		Long parentPartyId = partyOrgBean.getParentOrgId();

		if(4==parTypeId){//	企业 添加行政地区
			if(partyOrgDao.findByNameAndState(name,0)!=null)
				throw new IFException("名称重复，请重新输入");

			//	校验企业编号不能重复
			String code = partyOrgBean.getCode();
			if("".equals(Util.toStringAndTrim(code)))
				throw new IFException("请输入编号");

			if(partyOrgDao.findByCodeAndState(code,0)!=null)
				throw new IFException("编号重复，请重新输入");

			Long regionId = partyOrgBean.getRegionId();
/*			if(regionId==null)
				throw new IFException("行政地区不能为空");
*/
			if(regionId!=null)
			{
				party.setRegion(new PartyRegion(regionId));
			}
			
			}
		else{
			if(partyRelationDao.findPartyOrgByPartyId1AndName(1,parentPartyId,name,0)!=null)
				throw new IFException("名称重复，请重新输入");
			}

		party.setCreateTime(new Date());
		party.setParType(new PartyType(parTypeId));
		party.setState(0);//	0-启用
		party.setUpdateTime(new Date());

		insert(party);

		Long partyId = party.getPartyId();

		//	2-新增企业/部门关系
		if(parentPartyId!=null){
			PartyRelation relation = new PartyRelation();

			relation.setRelationType(new PartyRelationType(1));
			relation.setParty1(new Party(parentPartyId));
			relation.setParty2(party);

			insert(relation);
			}

		return partyId;
		}

	/**
	 * 企业修改/部门修改
	 */
	@Transactional
	@RequestMapping(value="/Party/Ent/{partyId}", method={RequestMethod.POST})
	public Long modifyPartyOrg_copy(@PathVariable Long partyId, @RequestBody PartyOrgBean partyOrgBean) {

		if(partyId==null)
			throw new IFException("当事人标识不能为空");

		//	校验企业名称/部门名称 不能重复
		String name = partyOrgBean.getName();
		if("".equals(Util.toStringAndTrim(name)))
			throw new IFException("请输入名称");

		//	1-修改企业/部门
		PartyOrg party = new PartyOrg();

		partyOrgBean.copyPropertyToDestBean(party);

		party.setPartyId(partyId);

		PartyOrg originParty = queryOne(party);
		if(originParty==null)
			throw new IFException("没有此当事人");

		party.setCreateTime(originParty.getCreateTime());
		party.setParType(originParty.getParType());
		party.setState(originParty.getState());//	0-启用
		//这里修改，不判断为空不修改，所以原来有的数据是需要全部的添加上的，否则有些数据可能莫名其妙的就给清空了
		party.setContacts(originParty.getContacts());
		party.setContactsMobile(originParty.getContactsMobile());
		party.setContactsEmail(originParty.getContactsEmail());

		Integer parTypeId = partyOrgBean.getParTypeId();
		if(parTypeId==null)
			throw new IFException("当事人类型不能为空");
		else if(4!=parTypeId && 5!=parTypeId)
			throw new IFException("不支持此当事人类型");

		Long parentPartyId = partyOrgBean.getParentOrgId();

		if(4==parTypeId){//	企业 添加行政地区
			PartyOrg orgName = partyOrgDao.findByNameAndState(name,0);
			if(orgName!=null && !partyId.equals(orgName.getPartyId()))
				throw new IFException("名称重复，请重新输入");

			//	校验企业编号不能重复
			String code = partyOrgBean.getCode();
			if("".equals(Util.toStringAndTrim(code)))
				throw new IFException("请输入编号");

			PartyOrg orgCode = partyOrgDao.findByCodeAndState(code,0);
			if(orgCode!=null && !partyId.equals(orgCode.getPartyId()))
				throw new IFException("编号重复，请重新输入");

			Long regionId = partyOrgBean.getRegionId();
/*			if(regionId==null)
				throw new IFException("行政地区不能为空");*/

			if(regionId!=null)
			{
				party.setRegion(new PartyRegion(regionId));
			}
			
			}
		else{
			PartyOrg orgName = partyRelationDao.findPartyOrgByPartyId1AndName(1,parentPartyId,name,0);
			if(orgName!=null && !partyId.equals(orgName.getPartyId()) )
				throw new IFException("名称重复，请重新输入");
			}

		party.setUpdateTime(new Date());

		update(party);

		//	2-删除企业/部门关系
		PartyRelationType relationType = new PartyRelationType(1);

		partyRelationDao.deleteByRelationTypeAndParty2(relationType,new Party(partyId));

		//	3-新增企业/部门关系
		if(parentPartyId!=null){
			PartyRelation relation = new PartyRelation();

			relation.setRelationType(relationType);
			relation.setParty1(new Party(parentPartyId));
			relation.setParty2(party);

			insert(relation);
			}

		return partyId;
		}
	



	/**
	 * 企业删除/部门删除
	 */
	@RequestMapping(value="/Party/Ent/{partyId}", method={RequestMethod.DELETE})
	public Long deletePartyOrg_copy(@PathVariable Long partyId) {

		if(partyId==null)
			throw new IFException("当事人标识不能为空");

		PartyOrg party = new PartyOrg();

		party.setPartyId(partyId);

		//	检查企业下是否还有下级企业、部门或员工，若有则不允许删除
		if(partyRelationDao.findPartyByPartyId1(1,party,0)!=0)
			throw new IFException("当前企业下存在相关部门或人员，无法做删除操作");

		// 企业删除/部门删除
		PartyOrg originParty = queryOne(party);
		if(originParty==null)
			return partyId;

		originParty.setState(2);	//	2-删除
		originParty.setUpdateTime(new Date());

		update(originParty);

		return partyId;
		}
	

	/**
	 * 企业信息 - 列表查询（外部通讯接口）
	 */
	@RequestMapping(value="/Party/Ent/Msg", method={RequestMethod.POST})
	public List<Map<String,Object>> searchCifInfo(@RequestBody CifInfoSearchMsgBean cifInfoSearchMsgBean) {

		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();

		Map<String,Object> data1 = new HashMap<String,Object>();

		data1.put("loginId","1");
		data1.put("perName","个人1");
		data1.put("mobile","12312345678");
		data1.put("email","email@163.com");
		data1.put("orgCode","000001");
		data1.put("orgName","企业1");
		data1.put("createTime","2015-07-10 09:00:00");
		data1.put("state", "0");
		list.add(data1);

		Map<String,Object> data2 = new HashMap<String,Object>();

		data2.put("loginId","2");
		data2.put("perName","个人2");
		data2.put("mobile","12312345678");
		data2.put("email","email@163.com");
		data2.put("orgCode","000002");
		data2.put("orgName","企业2");
		data2.put("createTime","2015-07-10 09:00:00");
		data2.put("state", "1");
		list.add(data2);

		return list;
		}

	/**
	 * 企业信息 - 详细查询（外部通讯接口）
	 */
	@RequestMapping(value="/Party/Ent/Msg/{loginId}", method={RequestMethod.POST})
	public Map<String,Object> searchCifInfoDetail(@PathVariable Long loginId) {

		if("".equals(Util.toStringAndTrim(loginId)))
			throw new IFException("登录名不能为空");

		Map<String,Object> data = new HashMap<String,Object>();

		if(loginId==1){
			data.put("loginId","1");
			data.put("perName","个人1");
			data.put("mobile","12312345678");
			data.put("email","email@163.com");
			data.put("orgCode","000001");
			data.put("orgName","企业1");
			data.put("createTime","2015-07-10 09:00:00");
			data.put("state", "0");
		}else{
			data.put("loginId","2");
			data.put("perName","个人2");
			data.put("mobile","12312345678");
			data.put("email","email@163.com");
			data.put("orgCode","000002");
			data.put("orgName","企业2");
			data.put("createTime","2015-07-10 09:00:00");
			data.put("state", "1");
		}

		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();

		Map<String,Object> map = new HashMap<String,Object>();

		map.put("uploadId",1);
		map.put("uploadName","模拟文件");
		map.put("saveDir","保存路径");
		map.put("saveName","保存名称");

		list.add(map);

		data.put("uploadFileInfo",list);

		return data;
		}

	/**
	 * 企业信息 - 修改（外部通讯接口）
	 */
	@Transactional
	@RequestMapping(value="/Party/Ent/Msg", method={RequestMethod.PUT})
	public Long modifyCifInfo(@RequestBody CifInfoMsgBean cifInfoMsgBean) {

		return 13L;
		}

	/********************************************************************************/ /********************************************************************************/

	/**
	 * 行政地区信息 - 列表查询
	 */
	@RequestMapping(value="/Party/Region", method={RequestMethod.POST})
	public List<Map<String,Object>> searchPartyRegion(@RequestBody PartyRegionSearchBean partyRegionSearchBean) {

		Long regionId = partyRegionSearchBean.getRegionId();
		if(regionId==null)
			regionId = 1L;

		return partyRegionRelationDao.findRegionByRegionId1(1,regionId);
		}

	}
