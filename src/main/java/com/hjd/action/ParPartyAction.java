package com.hjd.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.EquipmentBean;
import com.hjd.action.bean.PartyOrgBean;
import com.hjd.action.bean.PartyOrgSearchBean;
import com.hjd.action.bean.PartyPersonBean;
import com.hjd.action.bean.PartyPersonSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IEquipmentDao;
import com.hjd.dao.IPartyOrgDao;
import com.hjd.dao.IPartyRegionRelationDao;
import com.hjd.dao.IPartyRelationDao;
import com.hjd.dao.IPartyUploadFileDao;
import com.hjd.dao.IPerPersonDao;
import com.hjd.dao.ISysLoginFunDao;
import com.hjd.dao.ISysLoginUserDao;
import com.hjd.domain.EquipmentTable;
import com.hjd.domain.Party;
import com.hjd.domain.PartyOrg;
import com.hjd.domain.PartyPerson;
import com.hjd.domain.PartyRegion;
import com.hjd.domain.PartyRelation;
import com.hjd.domain.PartyRelationType;
import com.hjd.domain.PartyType;
import com.hjd.domain.PartyUploadFile;
import com.hjd.domain.ProdFunSet;
import com.hjd.domain.SysLoginFun;
import com.hjd.domain.SysLoginUser;
import com.hjd.domain.UploadFileInfo;
import com.hjd.domain.ViewParOrg;
import com.hjd.util.Util;

@RestController
public class ParPartyAction extends BaseAction {

	@Autowired
	private ISysLoginUserDao sysLoginUserDao;
	@Autowired
	private ISysLoginFunDao sysLoginFunDao;
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
	@Autowired
	IEquipmentDao iEquipmentDao;//设备资源管理（台账）Dao
	
	@Value("${tmpInfoFilePath}")
	String tmpInfoFilePath="";
	
	@Value("${realInfofilePath}")
	String realInfofilePath="";

/*企业设置相关+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

	/**
	 * 添加企业
	 * @param partyOrgBean
	 * @return
	 */
	@RequestMapping(value="/BG/Party/Ent", method={RequestMethod.PUT})
	@Transactional
	public Long addPartyEnt(@RequestBody PartyOrgBean partyOrgBean) {

		//	1-校验企业信息
		String name = partyOrgBean.getName();
		verifyNotEmpty(name, "单位名称");
		Integer orgLevel = partyOrgBean.getOrgLevel();
		verifyNotEmpty(orgLevel, "组织级别");
		String parentCode = partyOrgBean.getParentCode();
		verifyNotEmpty(parentCode, "上级单位编号");

		if(partyOrgDao.findByNameAndState(name,0)!=null){throw new IFException("单位名称重复，请重新输入");}

		//	2-新增企业
		//	由于企业编号在并发时会重复，所以添加企业信息改为原生sql
		Party party = new Party();

		partyOrgBean.copyPropertyToDestBean(party);
		party.setCreateTime(new Date());
		party.setParType(new PartyType(4));
		party.setState(0);	//	0-启用
		party.setUpdateTime(new Date());

		insert(party);

		Long partyId = party.getPartyId();	//	新生成主键

		Map<String,Object> params = new HashMap<String,Object>();

		params.put("partyId", partyId);
		params.put("parentCode", parentCode);
		params.put("name", name);
		params.put("orgLevel", orgLevel);
		params.put("offAddr", partyOrgBean.getOffAddr());
		params.put("phone", partyOrgBean.getPhone());
		params.put("zip", partyOrgBean.getZip());
		params.put("fax", partyOrgBean.getFax());
		params.put("budget", partyOrgBean.getBudget());
		params.put("type", partyOrgBean.getType());

		StringBuffer sql = new StringBuffer();

		sql.append("insert into par_org (Name,orgLevel,parentCode,OffAddr,Phone,Zip,PartyId,Fax,Budget,Type,Code) ");
		sql.append("values (:name,:orgLevel,:parentCode,:offAddr,:phone,:zip,:partyId,:fax,:budget,:type,");
		sql.append("ifnull((select concat('00',max(po.code) + 1) as maxCode from par_org po,par_party party where po.partyId=party.partyId and party.parTypeId=4 and po.parentCode=:parentCode group by po.parentCode),concat(:parentCode,'001'))");
		sql.append(")");

		exeNativeUpdateSql(sql.toString(), params);

		//	3-新增企业关系
		Long parentPartyId = partyOrgBean.getParentOrgId();
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
	 * 根据单位Id、单位名称（模糊查询，非必输），查询子一级的所属单位
	 * @author haopeng
	 * @since 2016-08-02
	 * @param currOrgId
	 * @param orgName
	 * @return Page<?>
	 */
	@RequestMapping(value="/BG/Party/Ent", method={RequestMethod.POST})
	public Page<?> searchPartyEnt(@RequestBody PartyOrgSearchBean partyOrgSearchBean) {

		Long currOrgId = partyOrgSearchBean.getCurrOrgId();
		if(currOrgId==null){
			throw new IFException("当前单位信息不能为空");
		}

		String orgName = partyOrgSearchBean.getOrgName();	//	单位名称（模糊查询，非必输）
		Long nonCurrOrgId = partyOrgSearchBean.getNonCurrOrgId();	//	不含此单位标识

		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select new Map(org.partyId as currOrgId, org.code as code, org.name as name, org.orgLevel as orgLevel, org.parentCode as parentCode, ");
		listSql.append("parentOrg.partyId as parentOrgId, parentOrg.name as parentOrgName, date_format(org.updateTime,'%Y-%m-%d %H:%i:%S') as updateTime) ");
		listSql.append("from PartyRelation relation, PartyOrg org, PartyOrg parentOrg ");
		listSql.append("where relation.party2.partyId=org.partyId and relation.party1.partyId=parentOrg.partyId and org.state=0 and org.parType.parTypeId=4 ");
		listSql.append("and relation.relationType.relationType=1 and relation.party1.partyId=").append(currOrgId);

		//	拼写的总数查询语句
		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(1) ");
		countSql.append("from PartyRelation relation, PartyOrg org, PartyOrg parentOrg ");
		countSql.append("where relation.party2.partyId=org.partyId and relation.party1.partyId=parentOrg.partyId and org.state=0 and org.parType.parTypeId=4 ");
		countSql.append("and relation.relationType.relationType=1 and relation.party1.partyId=").append(currOrgId);

		if(Util.isNotNullOrEmpty(orgName)){
			listSql.append(" and org.name like '%").append(orgName).append("%'");
			countSql.append(" and org.name like '%").append(orgName).append("%'");
		}

		if(Util.isNotNullOrEmpty(nonCurrOrgId)){
			listSql.append(" and relation.party2.partyId!=").append(nonCurrOrgId);
			countSql.append(" and relation.party2.partyId!=").append(nonCurrOrgId);
		}

		listSql.append(" order by org.updateTime desc");

		Page<?> datas = (Page<?>)queryList(listSql.toString(), countSql.toString(), new HashMap<String,Object>(), partyOrgSearchBean.getPageRequest());

		return datas;
	}

	/**
	 * 用于模糊查询根据当前登录人下面的子节点进行查询
	 * @param partyOrgSearchBean
	 * @return
	 */
	@RequestMapping(value="/BG/Party/Ent", method={RequestMethod.POST},params={"Action=QueryEnts"})
	public Page<?> queryEntsByCodeAndName(@RequestBody PartyOrgSearchBean partyOrgSearchBean) 
	{
		
		String orgCode = partyOrgSearchBean.getOrgCode();
		if("".equals(Util.toStringAndTrim(orgCode)))throw new IFException("当前登录人员的单位编码不能为空");
/*		Integer isInclude = partyOrgSearchBean.getIsInclude();*/

		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT new Map(org.partyId as currOrgId,org.code as code,org.name as name,org.orgLevel as orgLevel,org.parentCode as parentCode) ");
		listSql.append("FROM PartyOrg org ");
		listSql.append("WHERE org.state=0 and org.parType.parTypeId=4");
		
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) ");
		countSql.append("FROM PartyOrg org ");
		countSql.append("WHERE org.state=0 and org.parType.parTypeId=4");
		
		Map<String,Object> sqlParamsMap = new HashMap<String,Object>();
		
		//如果包含下级单位，就是采用模糊查询的方式，如果不包含下级单位就采用等于查询的方式
/*		if(isInclude!=null && isInclude==1)
		{
			sqlParamsMap.put("orgCode",orgCode+"%");
			listSql.append(" AND org.code LIKE :orgCode");
			countSql.append(" AND org.code LIKE :orgCode");
		}
		else
		{
			sqlParamsMap.put("orgCode",orgCode);
			listSql.append(" AND org.code=:orgCode");
			countSql.append(" AND org.code=:orgCode");	
		}*/
		
		sqlParamsMap.put("orgCode",orgCode+"%");
		listSql.append(" AND org.code LIKE :orgCode");
		countSql.append(" AND org.code LIKE :orgCode");
		
/*		listSql.append("AND org.code LIKE'").append(orgCode).append("%'");
		countSql.append("AND org.code LIKE'").append(orgCode).append("%'");*/

		String orgName=partyOrgSearchBean.getOrgName();
		if(Util.isNotNullOrEmpty(orgName))
		{
			sqlParamsMap.put("name",orgName+"%");
			listSql.append(" AND org.name LIKE :name");
			countSql.append(" AND org.name LIKE :name");
/*			listSql.append("AND org.name LIKE'%").append(orgName).append("%'");
			countSql.append("AND org.name LIKE'%").append(orgName).append("%'");*/
		}
		
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,partyOrgSearchBean.getPageRequest());

		return datas;
	}
	
	/**
	 * 用于模糊查询所有企业信息
	 * @param partyOrgSearchBean
	 * @return
	 */
	@RequestMapping(value="/BG/Party/Ent", method={RequestMethod.POST},params={"Action=QueEnts"})
	public Page<?> queryEnts(@RequestBody PartyOrgSearchBean partyOrgSearchBean) 
	{

		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT new Map(org.partyId as currOrgId,org.code as code,org.name as name,org.orgLevel as orgLevel,org.parentCode as parentCode) ");
		listSql.append("FROM PartyOrg org ");
		listSql.append("WHERE org.state=0 and (org.parType.parTypeId=4 OR org.parType.parTypeId=8)");
		
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) ");
		countSql.append("FROM PartyOrg org ");
		countSql.append("WHERE org.state=0 and (org.parType.parTypeId=4 OR org.parType.parTypeId=8)");
		
		Map<String,Object> sqlParamsMap = new HashMap<String,Object>();
		
		String orgName=partyOrgSearchBean.getOrgName();
		if(Util.isNotNullOrEmpty(orgName))
		{
			sqlParamsMap.put("name",orgName+"%");
			listSql.append(" AND org.name LIKE :name");
			countSql.append(" AND org.name LIKE :name");
			
/*			listSql.append("AND org.name LIKE'%").append(orgName).append("%'");
			countSql.append("AND org.name LIKE'%").append(orgName).append("%'");*/
		}
		

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,partyOrgSearchBean.getPageRequest());

		return datas;
	}
	
	
	/**
	 * 模糊查询当前登录人所属企业的外局租的单位
	 * @param partyOrgSearchBean
	 * @return
	 */
	@RequestMapping(value="/BG/Party/Ent", method={RequestMethod.POST},params={"Action=QueInnerEnts"})
	public Page<?> queryInnerEnts(@RequestBody PartyOrgSearchBean partyOrgSearchBean , HttpSession httpSession) 
	{
		
		
		
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
		String orgCode=(String)userMap.get("orgCode"); //用于压力测试，测试完毕需要恢复
//		String orgCode="000000";
		Page<?> datas =null;
		if(!(Util.isNullOrEmpty(orgCode) || orgCode.length()<6))
		{
			orgCode=orgCode.substring(0, 6);
			StringBuffer listSql = new StringBuffer();
			listSql.append("SELECT new Map(org.partyId as currOrgId,org.code as code,org.name as name,org.orgLevel as orgLevel,org.parentCode as parentCode) ");
			listSql.append("FROM PartyOrg org ");
			listSql.append("WHERE org.state=0 AND ( org.parType.parTypeId!=8 AND org.orgLevel!=1 AND org.code NOT LIKE '").append(orgCode).append("%') ");
			
			
			
			StringBuffer countSql = new StringBuffer();
			countSql.append("SELECT count(1) ");
			countSql.append("FROM PartyOrg org ");
			countSql.append("WHERE org.state=0 AND ( org.parType.parTypeId!=8 AND org.orgLevel!=1 AND org.code NOT LIKE '").append(orgCode).append("%') ");
			
			Map<String,Object> sqlParamsMap = new HashMap<String,Object>();
			
			String orgName=partyOrgSearchBean.getOrgName();
			if(Util.isNotNullOrEmpty(orgName))
			{
				sqlParamsMap.put("name",orgName+"%");
				listSql.append(" AND org.name LIKE :name");
				countSql.append(" AND org.name LIKE :name");
				
	/*			listSql.append("AND org.name LIKE'%").append(orgName).append("%'");
				countSql.append("AND org.name LIKE'%").append(orgName).append("%'");*/
			}
			
			datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,partyOrgSearchBean.getPageRequest());
		}

		return datas;
	}
	
	/**
	 * 查询企业详情
	 * @param partyId
	 * @return
	 */
	@RequestMapping(value="/BG/Party/Ent/{partyId}", method={RequestMethod.GET})
	public Map<String,Object> searchPartyEntDetail(@PathVariable Long partyId) 
	{
		if(partyId==null){throw new IFException("当事人标识不能为空");}
		
		PartyOrg party = new PartyOrg();
		party.setPartyId(partyId);
		PartyOrg detail = queryOne(party);
		
		Map<String,Object> data = new HashMap<String,Object>();
		if(detail!=null)
		{
			data.put("code",detail.getCode());
			data.put("name",detail.getName());
			data.put("orgLevel",detail.getOrgLevel());
			data.put("parentCode",detail.getParentCode());
			data.put("note",detail.getNote());
			data.put("orgId",detail.getPartyId());

			PartyOrg parentParty = partyRelationDao.findPartyOrgByPartyId2(1,partyId);
			if(parentParty!=null)
			{
				data.put("parentOrgId",parentParty.getPartyId());
				data.put("parentOrgName",parentParty.getName());
				data.put("parentOrgLevel",parentParty.getOrgLevel());
				data.put("parentParentCode",parentParty.getParentCode());
			}
		}
		return data;
		}
	
	/**
	 * 修改企业
	 * @param partyId
	 * @param partyOrgBean
	 * @return
	 */
	@RequestMapping(value="/BG/Party/Ent/{partyId}", method={RequestMethod.POST})
	@Transactional
	public Long modifyPartyEnt(@PathVariable Long partyId, @RequestBody PartyOrgBean partyOrgBean)
	{
		//	1-校验企业信息
		if(partyId==null){throw new IFException("当事人标识不能为空");}
		String code = partyOrgBean.getCode();
		verifyNotEmpty(code,"单位编码");
		String name = partyOrgBean.getName();
		verifyNotEmpty(name,"单位名称");
		PartyOrg orgCode = partyOrgDao.findByCodeAndState(code,0);
		if(orgCode!=null && !partyId.equals(orgCode.getPartyId())){throw new IFException("单位编号重复，请重新输入");}
		PartyOrg orgName = partyOrgDao.findByNameAndState(name,0);
		if(orgName!=null && !partyId.equals(orgName.getPartyId())){throw new IFException("单位名称重复，请重新输入");}

		//	2-修改企业
		PartyOrg party = new PartyOrg();
		partyOrgBean.copyPropertyToDestBean(party);

		party.setPartyId(partyId);

		PartyOrg originParty = queryOne(party);
		if(originParty==null){throw new IFException("没有此当事人");}

		party.setCreateTime(originParty.getCreateTime());
		party.setParType(originParty.getParType());
		party.setState(originParty.getState());//	0-启用
		//这里修改，不判断为空不修改，所以原来有的数据是需要全部的添加上的，否则有些数据可能莫名其妙的就给清空了
		
		party.setUpdateTime(new Date());

		update(party);

		//	2-删除企业关系
		PartyRelationType relationType = new PartyRelationType(1);
		partyRelationDao.deleteByRelationTypeAndParty2(relationType,new Party(partyId));

		//	3-新增企业关系
		Long parentPartyId = partyOrgBean.getParentOrgId();
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
	 * 删除企业
	 * @param partyId
	 * @return
	 */
	@RequestMapping(value="/BG/Party/Ent/{partyId}", method={RequestMethod.DELETE})
	@Transactional
	public Long deletePartyEnt(@PathVariable Long partyId)
	{
		if(partyId==null){throw new IFException("当事人标识不能为空");}
		PartyOrg party = new PartyOrg();
		party.setPartyId(partyId);
		//	检查企业下是否还有下级企业、项目或员工，若有则不允许删除
		if(partyRelationDao.findPartyByPartyId1(1,party,0)!=0){throw new IFException("当前企业下存在相关项目或人员，无法做删除操作");}
		// 企业删除/部门删除
		PartyOrg originParty = queryOne(party);
		if(originParty==null){return partyId;}
		originParty.setState(2);	//	2-删除
		originParty.setUpdateTime(new Date());
		update(originParty);
		return partyId;
	 }	
	
/*项目设置相关+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
	
	/**
	 * 添加项目
	 * @param partyOrgBean
	 * @return
	 */
	@RequestMapping(value="/BG/Party/Pro", method={RequestMethod.PUT})
	@Transactional
	public Long addPartyPro(@RequestBody PartyOrgBean partyOrgBean) 
	{
		//	1-校验项目信息
		String code = partyOrgBean.getCode();
		verifyNotEmpty(code,"项目编号");
		String name = partyOrgBean.getName();
		verifyNotEmpty(name,"项目名称");
		String parentCode = partyOrgBean.getParentCode();
		verifyNotEmpty(parentCode,"上级单位编号");

	    if(partyOrgDao.findByNameAndState(name,0)!=null){throw new IFException("项目名称重复或者与企业名称重复，请重新输入");}
		if(partyOrgDao.findByCodeAndState(code,0)!=null){throw new IFException("项目编号重复或者与企业编号重复，请重新输入");}

		//	2-新增企业
		PartyOrg party = new PartyOrg();
		partyOrgBean.copyPropertyToDestBean(party);
		party.setCreateTime(new Date());
		party.setParType(new PartyType(5));
		party.setState(0);//	0-启用
		party.setUpdateTime(new Date());
		
		insert(party);

		//	3-新增项目关系
		Long parentPartyId = partyOrgBean.getParentOrgId();
		if(parentPartyId!=null){
			PartyRelation relation = new PartyRelation();
			relation.setRelationType(new PartyRelationType(1));
			relation.setParty1(new Party(parentPartyId));
			relation.setParty2(party);
			
			insert(relation);
			
			}
		Long partyId = party.getPartyId();
		return partyId;
	 }

	/**
	 * 根据单位Id、状态（非必输）、项目名称（模糊查询，非必输），查询对应的项目
	 * @author haopeng
	 * @since 2016-08-02
	 * @param currOrgId
	 * @param proId
	 * @param orgName
	 * @param state
	 * @return Page<?>
	 */
	@RequestMapping(value="/BG/Party/Pro", method={RequestMethod.POST})
	public Page<?> searchPartyPro(@RequestBody PartyOrgSearchBean partyOrgSearchBean) {

		Long currOrgId = partyOrgSearchBean.getCurrOrgId();
		if(currOrgId==null){
			throw new IFException("当前单位信息不能为空");
		}

		Integer state = partyOrgSearchBean.getState();	//	party状态
		String orgName = partyOrgSearchBean.getOrgName();	//	项目名称（模糊查询，非必输）
		Long proId = partyOrgSearchBean.getProId();	//	项目id
		Long nonProId = partyOrgSearchBean.getNonProId();	//	不含此项目id

		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select new Map(org.partyId as currOrgId, org.code as code, org.name as name, org.parentCode as parentCode, org.state as state, org.contacts as contacts, org.contactsMobile as contactsMobile, org.offAddr as offAddr, ");
		listSql.append("org.atProvince as atProvince, org.atProvinceName as atProvinceName, org.atCity as atCity, org.atCityName as atCityName, org.atDistrict as atDistrict, org.atDistrictName as atDistrictName, ");
		listSql.append("parentOrg.partyId as parentOrgId, parentOrg.name as parentOrgName, date_format(org.updateTime,'%Y-%m-%d %H:%i:%S') as updateTime) ");
		listSql.append("from PartyRelation relation, PartyOrg org, PartyOrg parentOrg ");
		listSql.append("where relation.party2.partyId=org.partyId and relation.party1.partyId=parentOrg.partyId and org.parType.parTypeId=5 ");
		listSql.append("and relation.relationType.relationType=1 and relation.party1.partyId=").append(currOrgId);

		//	拼写的总数查询语句
		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(1) ");
		countSql.append("from PartyRelation relation, PartyOrg org, PartyOrg parentOrg ");
		countSql.append("where relation.party2.partyId=org.partyId and relation.party1.partyId=parentOrg.partyId and org.parType.parTypeId=5 ");
		countSql.append("and relation.relationType.relationType=1 and relation.party1.partyId=").append(currOrgId);

		if(Util.isNotNullOrEmpty(state)){
			listSql.append(" and relation.party1.state=").append(state);
			listSql.append(" and relation.party2.state=").append(state);
			countSql.append(" and relation.party1.state=").append(state);
			countSql.append(" and relation.party2.state=").append(state);
		}

		if(Util.isNotNullOrEmpty(orgName)){
			listSql.append(" and org.name like '%").append(orgName).append("%'");
			countSql.append(" and org.name like '%").append(orgName).append("%'");
		}

		if(Util.isNotNullOrEmpty(proId)){
			listSql.append(" and relation.party2.partyId=").append(proId);
			countSql.append(" and relation.party2.partyId=").append(proId);
		}

		if(Util.isNotNullOrEmpty(nonProId)){
			listSql.append(" and relation.party2.partyId!=").append(nonProId);
			countSql.append(" and relation.party2.partyId!=").append(nonProId);
		}

		listSql.append(" order by org.updateTime desc ");

		Page<?> datas = (Page<?>)queryList(listSql.toString(), countSql.toString(), new HashMap<String,Object>(), partyOrgSearchBean.getPageRequest());

		return datas;
	}

	/**
	 * 查询项目详情
	 */
	@RequestMapping(value="/BG/Party/Pro/{partyId}", method={RequestMethod.GET})
	public Map<String,Object> searchPartyProDetail(@PathVariable Long partyId)
	{
			if(partyId==null){throw new IFException("当事人标识不能为空");}
			
			PartyOrg party = new PartyOrg();
			party.setPartyId(partyId);
			PartyOrg detail = queryOne(party);
			
			Map<String,Object> data = new HashMap<String,Object>();
			if(detail!=null)
			{
				data.put("proId",detail.getPartyId());
				data.put("code",detail.getCode());
				data.put("name",detail.getName());
				data.put("parentCode",detail.getParentCode());
				data.put("note",detail.getNote());
				data.put("state",detail.getState());
				//项目新增的字段
				data.put("offAddr",detail.getOffAddr());
				data.put("contacts",detail.getContacts());
				data.put("contactsMobile",detail.getContactsMobile());
				data.put("atProvince",detail.getAtProvince());
				data.put("atProvinceName",detail.getAtProvinceName());
				data.put("atCity",detail.getAtCity());
				data.put("atCityName",detail.getAtCityName());
				data.put("atDistrict",detail.getAtDistrict());
				data.put("atDistrictName",detail.getAtDistrictName());

				PartyOrg parentParty = partyRelationDao.findPartyOrgByPartyId2(1,partyId);
				if(parentParty!=null)
				{
					data.put("parentOrgId",parentParty.getPartyId());
					data.put("parentOrgName",parentParty.getName());
				}
			}
			return data;
		}	
	
	/**
	 * 修改项目
	 * @param partyId
	 * @param partyOrgBean
	 * @return
	 */
	@RequestMapping(value="/BG/Party/Pro/{partyId}", method={RequestMethod.POST})
	@Transactional
	public Long modifyPartyPro(@PathVariable Long partyId, @RequestBody PartyOrgBean partyOrgBean)
	{
		//	1-校验项目信息
		if(partyId==null){throw new IFException("当事人标识不能为空");}
		String code = partyOrgBean.getCode();
		verifyNotEmpty(code,"项目编码");
		String name = partyOrgBean.getName();
		verifyNotEmpty(name,"项目名称");
		PartyOrg orgCode = partyOrgDao.findByCodeAndState(code,0);
		if(orgCode!=null && !partyId.equals(orgCode.getPartyId())){throw new IFException("项目编号重复，请重新输入");}
		PartyOrg orgName = partyOrgDao.findByNameAndState(name,0);
		if(orgName!=null && !partyId.equals(orgName.getPartyId())){throw new IFException("项目名称重复，请重新输入");}
		
		//	2-修改项目
		PartyOrg party = new PartyOrg();
		partyOrgBean.copyPropertyToDestBean(party);

		party.setPartyId(partyId);

		PartyOrg originParty = queryOne(party);
		if(originParty==null){throw new IFException("没有此当事人");}

		party.setCreateTime(originParty.getCreateTime());
		party.setParType(originParty.getParType());
		party.setState(originParty.getState());//	0-启用
		//这里修改，不判断为空不修改，所以原来有的数据是需要全部的添加上的，否则有些数据可能莫名其妙的就给清空了
		
		party.setUpdateTime(new Date());

		update(party);

		//	2-删除项目关系
		PartyRelationType relationType = new PartyRelationType(1);
		partyRelationDao.deleteByRelationTypeAndParty2(relationType,new Party(partyId));

		//	3-新增项目关系
		Long parentPartyId = partyOrgBean.getParentOrgId();
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
	 * 停用启用项目
	 * @param partyId
	 * @return
	 */
	@Transactional
	@RequestMapping(value="/BG/Party/Pro/{partyId}", method={RequestMethod.DELETE})
	public Long disablePartyPro(@PathVariable Long partyId)
	{
		if(partyId==null){throw new IFException("当事人标识不能为空");}
		PartyOrg party = new PartyOrg();
		party.setPartyId(partyId);
		//	检查项目是否还有参与人员，和诗斌商量不需要判断项目下是否有参与人员
/*		if(partyRelationDao.findPartyByPartyId1(1,party,0)!=0){throw new IFException("当前项目还有参与人员，无法做删除操作");}*/
		PartyOrg originParty = queryOne(party);
		if(originParty==null){return partyId;}
		
	    //如果当前项目中有设备资源在资源管理的使用情况中的状态为“使用中”，当点击”完工”时，需要提示“当前项目下还有设备处于使用中”。
		List<EquipmentTable> equipmentTableList = iEquipmentDao.queryEquStateAndProjectId(2, originParty.getPartyId());
		if(null!=equipmentTableList && equipmentTableList.size()>0){throw new IFException("当前项目下还有设备处于使用中");}
		
		Integer state=originParty.getState()==0?2:0;//项目默认是正常的状态，点击停用启用按钮时将对应的状态反转
		originParty.setState(state);	
		originParty.setUpdateTime(new Date());
		update(originParty);
		return partyId;
	 }	
	
/*员工信息维护相关++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

	/**
	 * 根据企业的id获取该企业下的管理员员工
	 */
	@RequestMapping(value="/BG/Party/Per",method={RequestMethod.GET},params={"Action=GetAdmin"})
	public Map<String, List<PartyPerson>> getAdmin(@RequestParam Map<?, ?> reqParamsMap) {

		String parentOrgId = Util.toStringAndTrim(reqParamsMap.get("parentOrgId"));

		Map<String, List<PartyPerson>> map = new HashMap<String, List<PartyPerson>>();

		map.put("msg", partyRelationDao.findPersonByParentOrgId(Long.parseLong(parentOrgId)));

		return map;
		}

	/**
	 * 员工信息 - 添加
	 * 添加员工信息
	 * 添加员工与企业关系
	 * 添加员工与项目关系
	 * 添加员工登录信息
	 * 添加员工可操作的功能权限
	 * 添加员工附件
	 */
	@RequestMapping(value="/BG/Party/Per", method={RequestMethod.PUT})
	@Transactional
	public Long addPartyPerson(@RequestBody PartyPersonBean partyPersonBean) {

		//	1-检验用户信息
		String loginId = partyPersonBean.getLoginId();
		verifyNotEmpty(loginId, "登录名");
		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId, 0);
		if(Util.isNotNullOrEmpty(user))
			throw new IFException("登录名重复，请重新输入");

		String name = partyPersonBean.getName();
		verifyNotEmpty(name, "名称");
		String mobile = partyPersonBean.getMobile();
		verifyNotEmpty(mobile, "手机号码");
		String code = partyPersonBean.getCode();
		verifyNotEmpty(code, "员工编号");
		Long parentPartyId = partyPersonBean.getDeptId();	//	所属企业标识
		verifyNotEmpty(parentPartyId, "所属企业");

		//	2-新增员工
		PartyPerson person = new PartyPerson();

		partyPersonBean.copyPropertyToDestBean(person);

		person.setCreateTime(new Date());
		person.setParType(new PartyType(3));
		person.setState(0);	//	0-启用
		person.setUpdateTime(new Date());
		//	增加所属企业标识
		person.setParentOrgId(parentPartyId);

		Long proId = partyPersonBean.getProId();	//员工所属项目的ID
		if(Util.isNotNullOrEmpty(proId))
			//	增加所属项目标识
			person.setParentProId(proId);

		insert(person);

		Long partyId = person.getPartyId();

		//	3-新增员工与企业关系
		PartyRelation relation = new PartyRelation();

		relation.setRelationType(new PartyRelationType(1));
		relation.setParty1(new Party(parentPartyId));
		relation.setParty2(new Party(partyId));

		insert(relation);

		//	4-如果项目存在，新增员工与项目的关系
		
		if(Util.isNotNullOrEmpty(proId)){
			PartyRelation relation_ = new PartyRelation();

			relation_.setRelationType(new PartyRelationType(1));
			relation_.setParty1(new Party(proId));
			relation_.setParty2(new Party(partyId));

			insert(relation_);
			}

		//	5-新增系统用户
		SysLoginUser loginUser = new SysLoginUser();

		loginUser.setParty(new Party(partyId));
		loginUser.setState(0);	//	0-启用
		loginUser.setLoginId(loginId);
		loginUser.setUpdateTime(new Date());
		loginUser.setPassword("1");//初始密码

		loginUser.setPhoneNo(partyPersonBean.getPhoneNo());//注册电话号
		loginUser.setMail(partyPersonBean.getMail());//注册电子邮箱

		insert(loginUser);

		//	6-新增系统用户与功能关系
		SysLoginFun loginFunRelation;
		if(partyPersonBean.getFunInfo()!=null){
			for(Map<String,Object> fun : partyPersonBean.getFunInfo()){
				loginFunRelation = new SysLoginFun();
				loginFunRelation.setLoginUser(loginUser);
				loginFunRelation.setFunctionId(new ProdFunSet(Long.valueOf(Util.toStringAndTrim(fun.get("functionId")))));

				insert(loginFunRelation);
				}	
			}

		//	7-保存上传文件信息，并且新增系统管理员/员工上传文件关系
		List<Map<String,Object>> uploadFileInfo = partyPersonBean.getUploadFileInfo();
		if(uploadFileInfo!=null && uploadFileInfo.size()>0){
			UploadFileInfo file;
			PartyUploadFile partyFile;
			for(Map<String,Object> uploadFile : uploadFileInfo){
				file = new UploadFileInfo();

				file.setUploadName(Util.toStringAndTrim(uploadFile.get("uploadName")));
				file.setSaveName(Util.toStringAndTrim(uploadFile.get("saveName")));
				file.setSaveDir(Util.toStringAndTrim(uploadFile.get("saveDir")));
				file.setPicName(Util.toStringAndTrim(uploadFile.get("PicName")));
				file.setPicType(Util.toStringAndTrim(uploadFile.get("PicType")));
				file.setType(1);	//	2-员工证件类
				if(Util.isNotNullOrEmpty(file.getPicName())){
					String[] tmpFileName = new String[]{file.getPicName() + "." + file.getPicType()};
					Util.copyFileToRealPath(tmpInfoFilePath,realInfofilePath, tmpFileName);
					}

				insert(file);

				partyFile = new PartyUploadFile();

				partyFile.setUploadFile(file);
				partyFile.setParty(new Party(partyId));

				insert(partyFile);
				}
			}

		return partyId;
		}

	/**
	 * 员工信息 - 修改
	 * 修改员工信息
	 * 删除员工与企业、项目的关系
	 * 修改员工与企业关系（修改员工时不改变企业信息）
	 * 修改员工与项目关系
	 * 修改员工登录信息
	 * 新增员工附件（未删除员工原有附件？？？）
	 */
	@RequestMapping(value="/BG/Party/Per/{partyId}", method={RequestMethod.POST})
	@Transactional
	public Long modifyPartyPerson(@PathVariable Long partyId, @RequestBody PartyPersonBean partyPersonBean) {

		//	1-验证用户信息
		String loginId = partyPersonBean.getLoginId();
		verifyNotEmpty(loginId, "登录名");
		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId, 0);
		if(user!=null && !partyId.equals(user.getParty().getPartyId()))
			throw new IFException("登录名重复，请重新输入");

		String name = partyPersonBean.getName();
		verifyNotEmpty(name,"名称");
		String mobile = partyPersonBean.getMobile();
		verifyNotEmpty(mobile,"手机号码");
		String code = partyPersonBean.getCode();
		verifyNotEmpty(code,"员工编号");
		Long parentPartyId = partyPersonBean.getDeptId();	//	所属企业标识
		verifyNotEmpty(parentPartyId, "所属企业");

		//	2-修改员工
		PartyPerson person = new PartyPerson();

		partyPersonBean.copyPropertyToDestBean(person);
		person.setPartyId(partyId);

		PartyPerson originParty = queryOne(person);
		if("".equals(Util.toStringAndTrim(originParty)))
			throw new IFException("没有此当事人");

		person.setCreateTime(originParty.getCreateTime());
		person.setParType(originParty.getParType());
		person.setState(originParty.getState());//	0-启用
		person.setUpdateTime(new Date());
		//	增加所属企业标识
		person.setParentOrgId(parentPartyId);

		Long proId = partyPersonBean.getProId();	//员工所属项目的ID
		if(Util.isNotNullOrEmpty(proId))
			//	增加所属项目标识
			person.setParentProId(proId);

		update(person);

        PartyRelationType relationType = new PartyRelationType(1);

		partyRelationDao.deleteByRelationTypeAndParty2(relationType,new Party(partyId));

		//	3-删除员工与企业关系，并且新增员工与企业的关系，这里员工属于那个企业是不变的，当前登录人只能看到本企业所属的员工
		PartyRelation relation = new PartyRelation();

		relation.setRelationType(relationType);
		relation.setParty1(new Party(parentPartyId));
		relation.setParty2(person);

		insert(relation);

		//	4-注意员工属于那个项目是变化的，因为将企业也看作一个组织，所以，先将所有关系删除，然后在重新建立关系
		if(Util.isNotNullOrEmpty(proId)){
			PartyRelation relation_ = new PartyRelation();

			relation_.setRelationType(new PartyRelationType(1));
			relation_.setParty1(new Party(proId));
			relation_.setParty2(new Party(partyId));

			insert(relation_);
			}

		//	5-修改系统用户
		Party party = new Party();

		party.setPartyId(partyId);

		SysLoginUser originLoginUser = sysLoginUserDao.findByParty(party);
		
		if(Util.isNullOrEmpty(originLoginUser))
			throw new IFException("没有此当事人");

		SysLoginUser loginUser = new SysLoginUser();

		loginUser.setParty(party);
		loginUser.setLoginId(loginId);

		loginUser.setState(originLoginUser.getState());
		loginUser.setLoginUserId(originLoginUser.getLoginUserId());
		loginUser.setPassword(originLoginUser.getPassword());
		loginUser.setUpdateTime(new Date());

		loginUser.setPhoneNo(partyPersonBean.getPhoneNo());//注册电话号
		loginUser.setMail(partyPersonBean.getMail());//注册电子邮箱

		update(loginUser);

		//	6-删除原有系统用户与功能的关系；
		sysLoginFunDao.deleteByLoginUser(new SysLoginUser(originLoginUser.getLoginUserId()));

		SysLoginFun loginFunRelation;
		for(Map<String,Object> fun : partyPersonBean.getFunInfo()){
			loginFunRelation = new SysLoginFun();
			loginFunRelation.setLoginUser(loginUser);
			loginFunRelation.setFunctionId(new ProdFunSet(Long.valueOf(Util.toStringAndTrim(fun.get("functionId")))));

			insert(loginFunRelation);
			}

		//	7-删除原有员工上传文件关系，并且删除原有上传文件信息
		//	2015-12-18日修改，在修改员工信息的时候，不删除文件和图片，单独点击删除图片或文件的时候再删除
		/*List<UploadFileInfo> originUploadFiles = partyUploadFileDao.findUploadFileByParty(party);

		partyUploadFileDao.deleteByParty(party);

		for(UploadFileInfo originUploadFile : originUploadFiles)
		{
			delete(originUploadFile);
		}*/
		//	保存上传文件信息，并且新增系统管理员/员工上传文件关系
		List<Map<String,Object>> uploadFileInfo = partyPersonBean.getUploadFileInfo();
		if(uploadFileInfo!=null && uploadFileInfo.size()>0){
			UploadFileInfo file;
			PartyUploadFile partyFile;
			for(Map<String,Object> uploadFile : uploadFileInfo){
				file = new UploadFileInfo();

				file.setUploadName(Util.toStringAndTrim(uploadFile.get("uploadName")));
				file.setSaveName(Util.toStringAndTrim(uploadFile.get("saveName")));
				file.setPicName(Util.toStringAndTrim(uploadFile.get("PicName")));
				file.setPicType(Util.toStringAndTrim(uploadFile.get("PicType")));
				file.setType(1);	//	2-员工证件类
				if(Util.isNotNullOrEmpty(file.getPicName())){
					String[] tmpFileName = new String[]{file.getPicName()+"."+file.getPicType()};
					Util.copyFileToRealPath(tmpInfoFilePath,realInfofilePath,tmpFileName);
					}
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
	 * 员工信息 - 删除员工关联文件
	 */
	@RequestMapping(value="/BG/Party/Per/pic/{partyId}/{upLoadId}", method={RequestMethod.DELETE})
	@Transactional
	public void deletePartyPersonPic(@PathVariable Long partyId, @PathVariable Long upLoadId) {

		//	删除原有员工上传文件关系，并且删除原有上传文件信息
		Party party = new Party();

		party.setPartyId(partyId);
		List<UploadFileInfo> originUploadFiles = partyUploadFileDao.findUploadFileByParty(party);
		for(UploadFileInfo originUploadFile : originUploadFiles){
			if(originUploadFile.getUploadId().equals(upLoadId)){
				delete(originUploadFile);
				partyUploadFileDao.deletePersonPic(upLoadId);
				break;
				}
			}
		}

	/**
	 * 员工删除
	 */
	@RequestMapping(value="/BG/Party/Per/{partyId}/{state}", method={RequestMethod.DELETE})
	@Transactional
	public Long deletePartyPerson(@PathVariable Long partyId, @PathVariable Integer state) {

		verifyNotEmpty(partyId, "当事人标识");
		verifyNotEmpty(state, "状态");

		Party party = new Party();

		party.setPartyId(partyId);

		Party originParty = queryOne(party);
		if("".equals(Util.toStringAndTrim(originParty)))
			throw new IFException("没有此当事人");

		SysLoginUser loginUser = sysLoginUserDao.findByParty(originParty);
		if(Util.isNullOrEmpty(loginUser))
			return partyId;

		loginUser.setState(state);	//	0-启用，1-停用
		loginUser.setUpdateTime(new Date());

		update(loginUser);

		//	停用用户的时候，默认将员工的管理员标识去掉
		PartyPerson pp = iPerPersonDao.findPartyPersonByPartyId(partyId);
		if(Util.isNullOrEmpty(pp))
			return partyId;

		pp.setAdmFlag(0);
		pp.setUpdateTime(new Date());

		update(pp);

		return partyId;
		}

	/**
	 * 员工信息 - 列表分页查询
	 */
	@RequestMapping(value="/BG/Party/Per", method={RequestMethod.POST})
	public Page<?> searchPartyPerson(@RequestBody PartyPersonSearchBean partyPersonSearchBean,HttpSession httpSession) {

		String orgCode = partyPersonSearchBean.getOrgCode();
		if(Util.isNullOrEmpty(orgCode))
			throw new IFException("当前登录人员的单位编码不能为空");

		Integer isInclude = partyPersonSearchBean.getIsInclude();

		StringBuffer listSql = new StringBuffer();

		listSql.append("select view ");
		listSql.append("from ViewPerPerson view ");
		listSql.append("where view.state=0 ");

		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(1) ");
		countSql.append("from ViewPerPerson view ");
		countSql.append("where view.state=0 ");

		Map<String,Object> sqlParamsMap = new HashMap<String,Object>();

		
		//从session中获取登录人信息，过滤掉当前登录人
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
		sqlParamsMap.put("partyId",(Long)userMap.get("perPartyId"));
		listSql.append(" AND view.partyId !=:partyId ");
		countSql.append(" AND view.partyId !=:partyId ");
		
		
		//如果包含下级单位，就是采用模糊查询的方式，如果不包含下级单位就采用等于查询的方式
		if(isInclude!=null && isInclude==1){
			sqlParamsMap.put("orgCode", orgCode + "%");
			listSql.append("and view.orgCode like :orgCode ");
			countSql.append("and view.orgCode like :orgCode ");
			}
		else{
			sqlParamsMap.put("orgCode", orgCode);
			listSql.append("and view.orgCode=:orgCode ");
			countSql.append("and view.orgCode=:orgCode ");	
			}

		String fuzzyData = partyPersonSearchBean.getFuzzyData();
		if(Util.isNotNullOrEmpty(fuzzyData)){
			listSql.append("and (");
			listSql.append("view.name like '%").append(fuzzyData).append("%' ");//姓名
			listSql.append("or view.mobile like '%").append(fuzzyData).append("%'");//注册手机号
			listSql.append(") ");

			countSql.append("and (");
			countSql.append("view.name like '%").append(fuzzyData).append("%' ");
			countSql.append("or view.mobile like '%").append(fuzzyData).append("%'");
			countSql.append(") ");
			}

		Long proPartyId = partyPersonSearchBean.getProPartyId();//项目
		if(Util.isNotNullOrEmpty(proPartyId)){
			listSql.append("and view.proPartyId =").append(proPartyId);
			countSql.append("and view.proPartyId =").append(proPartyId);
			}

		listSql.append(" order by view.updateTime desc ");

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,partyPersonSearchBean.getPageRequest());

		return datas;
		}

	/**
	 * 员工信息 - 详细查询
	 */
	@RequestMapping(value="/BG/Party/Per/{partyId}", method={RequestMethod.GET})
	public Map<String,Object> searchPartyPersonDetail(@PathVariable Long partyId) {

		verifyNotEmpty(partyId, "当事人ID");

		Map<String,Object> data = new HashMap<String,Object>();

		Party party = new Party(partyId);
		PartyOrg baseParty = partyRelationDao.findPartyOrgByPartyId2(1,partyId);//注意，应该拿企业的信息
		
		PartyOrg basePro = partyRelationDao.findPartyProByPartyId2(1,partyId);//注意，应该拿项目的信息
		if(basePro!=null)
		{
			data.put("proId",basePro.getPartyId());
			data.put("proName",basePro.getName());
		}
		else
		{
			data.put("proId","");
			data.put("proName","");
		}


		if(baseParty!=null)
		{
			//获取个人信息
			PartyPerson person = queryOne(party);
			data.put("parTypeId",3);
			data.put("name",person.getName());
			data.put("code",person.getCode());
			data.put("mobile",person.getMobile());
			data.put("email",person.getEmail());
			data.put("deptLv",baseParty.getOrgLevel());
			data.put("deptId",baseParty.getPartyId());
			data.put("deptName",baseParty.getName());
			data.put("note",person.getNote());
			data.put("qq",person.getQq());
			data.put("admFlag",person.getAdmFlag());
			//获取系统用户信息
			SysLoginUser loginUser = sysLoginUserDao.findByParty(party);
			if(loginUser!=null)
			{
				data.put("loginId",loginUser.getLoginId());
				data.put("updateTime",Util.convertDateToStr(loginUser.getUpdateTime(),"yyyy-MM-dd HH:mm:ss"));
				data.put("uId",loginUser.getUId());
				data.put("openId",loginUser.getOpenId());
				data.put("state",loginUser.getState());
				
				data.put("phoneNo",loginUser.getPhoneNo());
				data.put("mail",loginUser.getMail());
				//获取用户功能信息
				data.put("funInfo",sysLoginFunDao.findSysLoginFunByLoginUser(loginUser.getLoginUserId()));
			 }
			    //获取用户文件信息
				data.put("uploadFileInfo",partyUploadFileDao.findUploadFileByParty(party));
			}
			data.put("partyId",partyId);

		  return data;
		}

	/**
	 * 检查用户编号是否存在，如果不存在返回FALSE，前端添加页面可以使用
	 */
	@RequestMapping(value="/BG/Party/Per", method={RequestMethod.GET})
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

	/*区域信息++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
	/**
	 * 根据英文字母查询区域名称首字母相匹配的结果集
	 * @param equipmentBean
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.POST},params={"Action=RegionNameFpy"})
	public Map<String, Object> searchRegionNameFpy(@RequestBody EquipmentBean equipmentBean){
		String [] fpy=equipmentBean.getFpy();
		Map<String,Object> map = new HashMap<String, Object>();
		if(fpy!=null && fpy.length>0)
		{
			for(int i=0;i<fpy.length;i++)
			{
				List<PartyRegion> list=partyRegionRelationDao.queryRegionNameByFpy(fpy[i]);
				map.put(fpy[i], list);
			}
		}
		return map;
	}
	
	/*企业信息++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
	/**
	 * 根据英文字母查询企业名称首字母相匹配的结果集
	 * @param equipmentBean
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=OrgNameFpy"})
	public Map<String, Object> searchOrgNameFpy(@RequestBody EquipmentBean equipmentBean){
		String [] fpy=equipmentBean.getFpy();
		Map<String,Object> map = new HashMap<String, Object>();
		if(fpy!=null && fpy.length>0)
		{
			for(int i=0;i<fpy.length;i++)
			{
				List<ViewParOrg> list=partyRegionRelationDao.queryOrgNameByFpy(fpy[i]);
				map.put(fpy[i], list);
			}
		}
		return map;
	}



/*外部供应商信息++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

	/**
	 * 外部供应商 - 添加
	 * 是否添加外部供应商企业，是根据外部供应商返回的企业名称在数据库中是否有相应的企业来判断是否添加
	 * 若已有外部供应商企业信息，则不添加企业信息，只添加员工与企业关系；否则则添加企业信息和员工与企业关系
	 */
	@RequestMapping(value="/BG/Party/Provider", method={RequestMethod.PUT})
	@Transactional
	public Long addPartyProvider(@RequestBody PartyPersonBean partyPersonBean, HttpSession httpSession) {

		//	1-检验外部供应商信息
		String loginId = partyPersonBean.getLoginId();
		verifyNotEmpty(loginId, "登录名");
		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId,0);
		if(Util.isNotNullOrEmpty(user))
			throw new IFException("登录名重复，请重新输入");

		String name = partyPersonBean.getName();
		verifyNotEmpty(name, "名称");
		String mobile = partyPersonBean.getMobile();
		verifyNotEmpty(mobile, "手机号码");
		String code = partyPersonBean.getCode();
		verifyNotEmpty(code, "员工编号");
		String orgName = partyPersonBean.getOrgName();
		verifyNotEmpty(orgName, "企业名称");

		PartyOrg org = partyOrgDao.findByNameAndState(orgName, 0);
		if(org==null){//新增企业，外部供应商企业
			org = new PartyOrg();

			org.setCode("provider");//单位编号
			org.setName(orgName);//单位名称，此信息是通过接口查询返回的
			org.setOrgLevel(6);//组织级别，外部供应商
			org.setParentCode("provider");
			org.setCreateTime(new Date());
			org.setParType(new PartyType(8));//外部供应商企业
			org.setState(0);//	0-启用
			org.setUpdateTime(new Date());

			insert(org);
			}

		//从session中获取登录人信息
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
		Long parentPartyId =(Long)userMap.get("perPartyId");//	所属操者的当事人ID

//		Long parentPartyId =Long.parseLong("316"); //用于压力测试，测试完毕需要恢复

		//	新增企业关系，模拟创建的外部供应商企业，默认属于创建人
		if(parentPartyId!=null){
			PartyRelation relation = new PartyRelation();
			relation.setRelationType(new PartyRelationType(1));
			relation.setParty1(new Party(parentPartyId));
			relation.setParty2(org);

			insert(relation);
			}

		Long orgPartyId = org.getPartyId();

		//	2-新增员工
		PartyPerson person = new PartyPerson();
		partyPersonBean.copyPropertyToDestBean(person);
		person.setCreateTime(new Date());
		person.setParType(new PartyType(6));//外部供应商员工
		person.setState(0);	//	0-启用
		person.setUpdateTime(new Date());
		//	增加员工所属企业标识
		person.setParentOrgId(orgPartyId);
		//	增加员工创建人
		person.setCreatePartyId(parentPartyId);

		insert(person);

		//	3-新增外部供应商与操作者的关系
		Long partyId = person.getPartyId();

		PartyRelation perRelation = new PartyRelation();
		perRelation.setRelationType(new PartyRelationType(1));
		perRelation.setParty1(new Party(parentPartyId));
		perRelation.setParty2(new Party(partyId));

		insert(perRelation);

		//新增外部供应商用户和模拟的供应商企业的关系
		PartyRelation orgRelation = new PartyRelation();
		orgRelation.setRelationType(new PartyRelationType(1));
		orgRelation.setParty1(new Party(orgPartyId));
		orgRelation.setParty2(new Party(partyId));

		insert(orgRelation);

		//	5-新增系统用户
		SysLoginUser loginUser = new SysLoginUser();

		loginUser.setParty(new Party(partyId));
		loginUser.setState(0);	//	0-启用
		loginUser.setLoginId(loginId);
		loginUser.setUpdateTime(new Date());
		loginUser.setPassword("1");//初始密码

		loginUser.setPhoneNo(partyPersonBean.getPhoneNo());//注册电话号
		loginUser.setMail(partyPersonBean.getMail());//注册电子邮箱

		insert(loginUser);

		//	6-新增系统用户与功能关系
		SysLoginFun loginFunRelation;
		if(partyPersonBean.getFunInfo()!=null){
			for(Map<String,Object> fun : partyPersonBean.getFunInfo()){
				loginFunRelation = new SysLoginFun();
				loginFunRelation.setLoginUser(loginUser);
				loginFunRelation.setFunctionId(new ProdFunSet(Long.valueOf(Util.toStringAndTrim(fun.get("functionId")))));

				insert(loginFunRelation);
				}	
			}

		return partyId;
		}

	/**
	 * 外部供应商 - 修改
	 * 系统管理员无个人实体，与企业绑定，信息记录在partyOrg中
	 * 员工有个人实体，与企业内的部门关联，信息记录在partyPerson中
	 */
	@RequestMapping(value="/BG/Party/Provider/{partyId}", method={RequestMethod.POST})
	@Transactional
	public Long modifyPartyProvider(@PathVariable Long partyId, @RequestBody PartyPersonBean partyPersonBean, HttpSession httpSession) {

		//	1-验证外部供应商信息
		String loginId = partyPersonBean.getLoginId();
		verifyNotEmpty(loginId, "登录名");
		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId, 0);
		if(user!=null && !partyId.equals(user.getParty().getPartyId()))
			throw new IFException("登录名重复，请重新输入");

		String name = partyPersonBean.getName();
		verifyNotEmpty(name, "名称");
		String mobile = partyPersonBean.getMobile();
		verifyNotEmpty(mobile, "手机号码");
		String code = partyPersonBean.getCode();
		verifyNotEmpty(code, "员工编号");

		//	2-修改外部供应商
		PartyPerson person = new PartyPerson();

		partyPersonBean.copyPropertyToDestBean(person);

		person.setPartyId(partyId);
		
		PartyPerson originParty = queryOne(person);
		if(Util.isNullOrEmpty(originParty))
			throw new IFException("没有此当事人");

		person.setCreateTime(originParty.getCreateTime());
		person.setParType(originParty.getParType());
		person.setState(originParty.getState());//	0-启用
		person.setUpdateTime(new Date());
		//	增加员工所属企业标识
		person.setParentOrgId(originParty.getParentOrgId());
		//	增加员工创建人
		person.setCreatePartyId(originParty.getCreatePartyId());

		update(person);

		//	3-修改系统用户
		Party party = new Party();

		party.setPartyId(partyId);

		SysLoginUser originLoginUser = sysLoginUserDao.findByParty(party);
		if(Util.isNullOrEmpty(originLoginUser))
			throw new IFException("没有此当事人");

		SysLoginUser loginUser = new SysLoginUser();

		loginUser.setParty(party);
		loginUser.setLoginId(loginId);

		loginUser.setState(originLoginUser.getState());
		loginUser.setLoginUserId(originLoginUser.getLoginUserId());
		loginUser.setPassword((originLoginUser.getPassword()));
		loginUser.setUpdateTime(new Date());

		loginUser.setPhoneNo(partyPersonBean.getPhoneNo());//注册电话号
		loginUser.setMail(partyPersonBean.getMail());//注册电子邮箱

		update(loginUser);

		//	4-删除原有系统用户与功能的关系；添加新的系统用户与功能的关系
		sysLoginFunDao.deleteByLoginUser(new SysLoginUser(originLoginUser.getLoginUserId()));

		SysLoginFun loginFunRelation;
		for(Map<String,Object> fun : partyPersonBean.getFunInfo()){
			loginFunRelation = new SysLoginFun();
			loginFunRelation.setLoginUser(loginUser);
			loginFunRelation.setFunctionId(new ProdFunSet(Long.valueOf(Util.toStringAndTrim(fun.get("functionId")))));

			insert(loginFunRelation);
			}

		return partyId;
		}

	/**
	* 外部供应商删除
	*/
	@RequestMapping(value="/BG/Party/Provider/{partyId}/{state}", method={RequestMethod.DELETE})
	@Transactional
	public Long deletePartyProvider(@PathVariable Long partyId, @PathVariable Integer state) {

		verifyNotEmpty(partyId,"当事人标识");
		verifyNotEmpty(state,"状态");

		Party party = new Party();

		party.setPartyId(partyId);

		Party originParty = queryOne(party);
		if(Util.isNullOrEmpty(originParty))
			throw new IFException("没有此当事人");

		SysLoginUser loginUser = sysLoginUserDao.findByParty(originParty);
		if(Util.isNullOrEmpty(loginUser))
			return partyId;

		loginUser.setState(state);	//	0-启用，1-停用
		loginUser.setUpdateTime(new Date());

		update(loginUser);

		return partyId;
		}

	/**
	* 外部供应商 - 列表分页查询
	*/
	@RequestMapping(value="/BG/Party/Provider", method={RequestMethod.POST})
	public Page<?> searchPartyPersonProvider(@RequestBody PartyPersonSearchBean partyPersonSearchBean,HttpSession httpSession) {

		StringBuffer listSql = new StringBuffer();
		listSql.append("select view ");
		listSql.append("from ViewPerProvider view ");
	
		StringBuffer countSql = new StringBuffer();
		countSql.append("select count(1) ");
		countSql.append("from ViewPerProvider view ");

		Map<String,Object> sqlParamsMap = new HashMap<String,Object>();

		//从session中获取登录人信息
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");

		sqlParamsMap.put("createPartyId",(Long)userMap.get("perPartyId"));

		//用于压力测试，测试完毕需要恢复
//		sqlParamsMap.put("createPartyId",Long.parseLong("316"));

		listSql.append("where view.createPartyId=:createPartyId ");
		countSql.append("where view.createPartyId=:createPartyId ");

		String fuzzyData = partyPersonSearchBean.getFuzzyData();
		if(Util.isNotNullOrEmpty(fuzzyData)){
			listSql.append("and (");
			listSql.append("view.orgName like '%").append(fuzzyData).append("%' ");//企业名称
			listSql.append("or view.name like '%").append(fuzzyData).append("%' ");//姓名
			listSql.append("or view.phoneNo like '%").append(fuzzyData).append("%'");//注册手机号
			listSql.append(") ");

			countSql.append("and (");
			countSql.append("view.orgName like '%").append(fuzzyData).append("%' ");
			countSql.append("or view.name like '%").append(fuzzyData).append("%' ");
			countSql.append("or view.phoneNo like '%").append(fuzzyData).append("%'");
			countSql.append(") ");
			}

		listSql.append("order by view.updateTime desc ");

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,partyPersonSearchBean.getPageRequest());

		return datas;
		}

	/**
	* 外部供应商 - 详细查询
	*/
	@RequestMapping(value="/BG/Party/Provider/{partyId}", method={RequestMethod.GET})
	public Map<String,Object> searchPartyProviderDetail(@PathVariable Long partyId)
	{
		
		verifyNotEmpty(partyId,"当事人ID");
		Map<String,Object> data = new HashMap<String,Object>();
		
		Party party = new Party(partyId);
		PartyOrg baseParty = partyRelationDao.findPartyOrgByPartyId2(1,partyId);//注意，应该拿企业的信息
		
	/*	PartyOrg basePro = partyRelationDao.findPartyProByPartyId2(1,partyId);//注意，应该拿项目的信息
		if(basePro!=null)
		{
			data.put("proId",basePro.getPartyId());
			data.put("proName",basePro.getName());
		}
		else
		{
			data.put("proId","");
			data.put("proName","");
		}*/
	
	
	/*	if(baseParty!=null)
		{*/
			//获取个人信息
			PartyPerson person = queryOne(party);
			data.put("parTypeId",3);
			data.put("name",person.getName());
			data.put("code",person.getCode());
			data.put("mobile",person.getMobile());
			data.put("email",person.getEmail());
			/*data.put("orgName",person.getEmail());*/
			data.put("deptId",baseParty.getPartyId());
			data.put("deptName",baseParty.getName());
			data.put("note",person.getNote());
			data.put("qq",person.getQq());
			//获取系统用户信息
			SysLoginUser loginUser = sysLoginUserDao.findByParty(party);
			if(loginUser!=null)
			{
				data.put("loginId",loginUser.getLoginId());
				data.put("updateTime",Util.convertDateToStr(loginUser.getUpdateTime(),"yyyy-MM-dd HH:mm:ss"));
				data.put("uId",loginUser.getUId());
				data.put("openId",loginUser.getOpenId());
				data.put("state",loginUser.getState());
				
				data.put("phoneNo",loginUser.getPhoneNo());
				data.put("mail",loginUser.getMail());
				//获取用户功能信息
				data.put("funInfo",sysLoginFunDao.findSysLoginFunByLoginUser(loginUser.getLoginUserId()));
			 }
			    //获取用户文件信息
/*				data.put("uploadFileInfo",partyUploadFileDao.findUploadFileByParty(party));*/
	/*		}*/
			data.put("partyId",partyId);
	
		  return data;
		}

	
	
	
	
	/*外部员工信息维护，提供给外部管理员添加员工使用+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

	/**
	 * 外部员工信息维护 - 添加，某个外部企业管理员添加本企业下的员工信息
	 */
	@RequestMapping(value="/BG/Party/OutEmployee", method={RequestMethod.PUT})
	@Transactional
	public Long addPartyOutEmployee(@RequestBody PartyPersonBean partyPersonBean, HttpSession httpSession) {

		//	1-检验外部供应商信息
		String loginId = partyPersonBean.getLoginId();
		verifyNotEmpty(loginId, "登录名");
		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId,0);
		if(Util.isNotNullOrEmpty(user)){throw new IFException("登录名重复，请重新输入");}

		String name = partyPersonBean.getName();
		verifyNotEmpty(name, "名称");
		String mobile = partyPersonBean.getMobile();
		verifyNotEmpty(mobile, "手机号码");
		String code = partyPersonBean.getCode();
		verifyNotEmpty(code, "员工编号");
		String orgName = partyPersonBean.getOrgName();
		verifyNotEmpty(orgName, "企业名称");

		PartyOrg org = partyOrgDao.findByNameAndState(orgName, 0);
		
//		if(org==null){//新增企业，外部供应商企业
//			org = new PartyOrg();
//
//			org.setCode("provider");//单位编号
//			org.setName(orgName);//单位名称，此信息是通过接口查询返回的
//			org.setOrgLevel(6);//组织级别，外部供应商
//			org.setParentCode("provider");
//			org.setCreateTime(new Date());
//			org.setParType(new PartyType(8));//外部供应商企业
//			org.setState(0);//	0-启用
//			org.setUpdateTime(new Date());
//
//			insert(org);
//			}

		//从session中获取登录人信息
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
		Long parentPartyId =(Long)userMap.get("perPartyId");//	所属操者的当事人ID

//		Long parentPartyId =Long.parseLong("316"); //用于压力测试，测试完毕需要恢复

		//	新增企业关系，模拟创建的外部供应商企业，默认属于创建人
//		if(parentPartyId!=null){
//			PartyRelation relation = new PartyRelation();
//			relation.setRelationType(new PartyRelationType(1));
//			relation.setParty1(new Party(parentPartyId));
//			relation.setParty2(org);
//
//			insert(relation);
//			}

		Long orgPartyId = org.getPartyId();

		//	2-新增员工
		PartyPerson person = new PartyPerson();
		partyPersonBean.copyPropertyToDestBean(person);
		person.setCreateTime(new Date());
		person.setParType(new PartyType(6));//外部供应商员工
		person.setState(0);	//	0-启用
		person.setUpdateTime(new Date());
		//	增加员工所属企业标识
		person.setParentOrgId(orgPartyId);
		//	增加员工创建人
		person.setCreatePartyId(parentPartyId);

		insert(person);

		//	3-新增外部供应商与操作者的关系
		Long partyId = person.getPartyId();

//		PartyRelation perRelation = new PartyRelation();
//		perRelation.setRelationType(new PartyRelationType(1));
//		perRelation.setParty1(new Party(parentPartyId));
//		perRelation.setParty2(new Party(partyId));
//
//		insert(perRelation);

		//新增外部供应商用户和模拟的供应商企业的关系
		PartyRelation orgRelation = new PartyRelation();
		orgRelation.setRelationType(new PartyRelationType(1));
		orgRelation.setParty1(new Party(orgPartyId));
		orgRelation.setParty2(new Party(partyId));

		insert(orgRelation);

		//	5-新增系统用户
		SysLoginUser loginUser = new SysLoginUser();

		loginUser.setParty(new Party(partyId));
		loginUser.setState(0);	//	0-启用
		loginUser.setLoginId(loginId);
		loginUser.setUpdateTime(new Date());
		loginUser.setPassword("1");//初始密码

		loginUser.setPhoneNo(partyPersonBean.getPhoneNo());//注册电话号
		loginUser.setMail(partyPersonBean.getMail());//注册电子邮箱

		insert(loginUser);

		//	6-新增系统用户与功能关系
		SysLoginFun loginFunRelation;
		if(partyPersonBean.getFunInfo()!=null){
			for(Map<String,Object> fun : partyPersonBean.getFunInfo()){
				loginFunRelation = new SysLoginFun();
				loginFunRelation.setLoginUser(loginUser);
				loginFunRelation.setFunctionId(new ProdFunSet(Long.valueOf(Util.toStringAndTrim(fun.get("functionId")))));

				insert(loginFunRelation);
				}	
			}

		return partyId;
		}

	/**
     *外部员工信息维护 - 修改，某个外部企业管理员修改本企业下的员工信息
	 */
	@RequestMapping(value="/BG/Party/OutEmployee/{partyId}", method={RequestMethod.POST})
	@Transactional
	public Long modifyPartyOutEmployee(@PathVariable Long partyId, @RequestBody PartyPersonBean partyPersonBean, HttpSession httpSession) {

		//	1-验证外部供应商信息
		String loginId = partyPersonBean.getLoginId();
		verifyNotEmpty(loginId, "登录名");//现在是不允许修改的了
		SysLoginUser user = sysLoginUserDao.findSysLoginUserByLoginId(loginId, 0);
		if(user!=null && !partyId.equals(user.getParty().getPartyId())){throw new IFException("登录名重复，请重新输入");}

		String name = partyPersonBean.getName();
		verifyNotEmpty(name, "名称");
		String mobile = partyPersonBean.getMobile();
		verifyNotEmpty(mobile, "手机号码");
		String code = partyPersonBean.getCode();
		verifyNotEmpty(code, "员工编号");

		//	2-修改外部供应商
		PartyPerson person = new PartyPerson();

		partyPersonBean.copyPropertyToDestBean(person);

		person.setPartyId(partyId);
		
		PartyPerson originParty = queryOne(person);
		if(Util.isNullOrEmpty(originParty)){throw new IFException("没有此当事人");}

		person.setCreateTime(originParty.getCreateTime());
		person.setParType(originParty.getParType());
		person.setState(originParty.getState());//	0-启用
		person.setUpdateTime(new Date());
		//	增加员工所属企业标识
		person.setParentOrgId(originParty.getParentOrgId());
		//	增加员工创建人
		person.setCreatePartyId(originParty.getCreatePartyId());

		update(person);

//		//	3-修改系统用户
//		Party party = new Party();
//
//		party.setPartyId(partyId);
//
//		SysLoginUser originLoginUser = sysLoginUserDao.findByParty(party);
//		if(Util.isNullOrEmpty(originLoginUser)){throw new IFException("没有此当事人");}
//
//		SysLoginUser loginUser = new SysLoginUser();
//
//		loginUser.setParty(party);
//		loginUser.setLoginId(loginId);
//
//		loginUser.setState(originLoginUser.getState());
//		loginUser.setLoginUserId(originLoginUser.getLoginUserId());
//		loginUser.setPassword((originLoginUser.getPassword()));
//		loginUser.setUpdateTime(new Date());
//
//		loginUser.setPhoneNo(partyPersonBean.getPhoneNo());//注册电话号
//		loginUser.setMail(partyPersonBean.getMail());//注册电子邮箱
//
//		update(loginUser);

//		//	4-删除原有系统用户与功能的关系；添加新的系统用户与功能的关系
//		sysLoginFunDao.deleteByLoginUser(new SysLoginUser(originLoginUser.getLoginUserId()));
//
//		SysLoginFun loginFunRelation;
//		for(Map<String,Object> fun : partyPersonBean.getFunInfo()){
//			loginFunRelation = new SysLoginFun();
//			loginFunRelation.setLoginUser(loginUser);
//			loginFunRelation.setFunctionId(new ProdFunSet(Long.valueOf(Util.toStringAndTrim(fun.get("functionId")))));
//
//			insert(loginFunRelation);
//			}

		return partyId;
		}

	/**
	* 外部员工信息 - 删除，某个外部企业管理员删除本企业下的员工信息
	*/
	@RequestMapping(value="/BG/Party/OutEmployee/{partyId}/{state}", method={RequestMethod.DELETE})
	@Transactional
	public Long deletePartyOutEmployee(@PathVariable Long partyId, @PathVariable Integer state) {

		verifyNotEmpty(partyId,"当事人标识");
		verifyNotEmpty(state,"状态");

		Party party = new Party();

		party.setPartyId(partyId);

		Party originParty = queryOne(party);
		if(Util.isNullOrEmpty(originParty)){throw new IFException("没有此当事人");}

		SysLoginUser loginUser = sysLoginUserDao.findByParty(originParty);
		if(Util.isNullOrEmpty(loginUser)){return partyId;}

		loginUser.setState(state);	//	0-启用，1-停用
		loginUser.setUpdateTime(new Date());

		update(loginUser);

		return partyId;
		}

	/**
	* 外部员工信息维护 - 列表查询，某个外部企业管理员查询本企业下的员工信息- 列表分页查询
	*/
	@RequestMapping(value="/BG/Party/OutEmployee", method={RequestMethod.POST})
	public Page<?> searchPartyPersonOutEmployee(@RequestBody PartyPersonSearchBean partyPersonSearchBean,HttpSession httpSession) {

		StringBuffer listSql = new StringBuffer();
		listSql.append("select view ");
		listSql.append("from ViewPerProvider view ");
	
		StringBuffer countSql = new StringBuffer();
		countSql.append("select count(1) ");
		countSql.append("from ViewPerProvider view ");

		Map<String,Object> sqlParamsMap = new HashMap<String,Object>();

		//从session中获取登录人信息
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");

		sqlParamsMap.put("orgPartyId",(Long)userMap.get("orgId"));
		//用于压力测试，测试完毕需要恢复
//		sqlParamsMap.put("createPartyId",Long.parseLong("316"));
		listSql.append(" where view.orgPartyId=:orgPartyId ");
		countSql.append(" where view.orgPartyId=:orgPartyId ");
		
		//当前登录外部人员不能看到自己的用户信息
		sqlParamsMap.put("partyId",(Long)userMap.get("perPartyId"));
		listSql.append(" AND view.partyId !=:partyId ");
		countSql.append(" AND  view.partyId !=:partyId ");

		String fuzzyData = partyPersonSearchBean.getFuzzyData();
		if(Util.isNotNullOrEmpty(fuzzyData)){
			listSql.append(" and (");
			listSql.append(" view.orgName like '%").append(fuzzyData).append("%' ");//企业名称
			listSql.append(" or view.name like '%").append(fuzzyData).append("%' ");//姓名
			listSql.append(" or view.phoneNo like '%").append(fuzzyData).append("%'");//注册手机号
			listSql.append(" ) ");

			countSql.append(" and (");
			countSql.append(" view.orgName like '%").append(fuzzyData).append("%' ");
			countSql.append(" or view.name like '%").append(fuzzyData).append("%' ");
			countSql.append(" or view.phoneNo like '%").append(fuzzyData).append("%'");
			countSql.append(" ) ");
			}

		listSql.append(" order by view.updateTime desc ");

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,partyPersonSearchBean.getPageRequest());

		return datas;
		}

	/**
	* 外部员工信息维护 - 详情查询，某个外部企业管理员查询本企业下的员工信息 - 详细查询
	*/
	@RequestMapping(value="/BG/Party/OutEmployee/{partyId}", method={RequestMethod.GET})
	public Map<String,Object> searchPartyDetail(@PathVariable Long partyId)
	{
		
		verifyNotEmpty(partyId,"当事人ID");
		Map<String,Object> data = new HashMap<String,Object>();
		
		Party party = new Party(partyId);
		PartyOrg baseParty = partyRelationDao.findPartyOrgByPartyId2(1,partyId);//注意，应该拿企业的信息
		
	/*	PartyOrg basePro = partyRelationDao.findPartyProByPartyId2(1,partyId);//注意，应该拿项目的信息
		if(basePro!=null)
		{
			data.put("proId",basePro.getPartyId());
			data.put("proName",basePro.getName());
		}
		else
		{
			data.put("proId","");
			data.put("proName","");
		}*/
	
	
	/*	if(baseParty!=null)
		{*/
			//获取个人信息
			PartyPerson person = queryOne(party);
			data.put("parTypeId",3);
			data.put("name",person.getName());
			data.put("code",person.getCode());
			data.put("mobile",person.getMobile());
			data.put("email",person.getEmail());
			/*data.put("orgName",person.getEmail());*/
			data.put("deptId",baseParty.getPartyId());
			data.put("deptName",baseParty.getName());
			data.put("note",person.getNote());
			data.put("qq",person.getQq());
			//获取系统用户信息
			SysLoginUser loginUser = sysLoginUserDao.findByParty(party);
			if(loginUser!=null)
			{
				data.put("loginId",loginUser.getLoginId());
				data.put("updateTime",Util.convertDateToStr(loginUser.getUpdateTime(),"yyyy-MM-dd HH:mm:ss"));
				data.put("uId",loginUser.getUId());
				data.put("openId",loginUser.getOpenId());
				data.put("state",loginUser.getState());
				
				data.put("phoneNo",loginUser.getPhoneNo());
				data.put("mail",loginUser.getMail());
				//获取用户功能信息
				data.put("funInfo",sysLoginFunDao.findSysLoginFunByLoginUser(loginUser.getLoginUserId()));
			 }
			    //获取用户文件信息
/*				data.put("uploadFileInfo",partyUploadFileDao.findUploadFileByParty(party));*/
	/*		}*/
			data.put("partyId",partyId);
	
		  return data;
		}

	}