package com.hjd.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.BusRentHistBean;
import com.hjd.action.bean.BusRentHistBeanTemp;
import com.hjd.action.bean.BusRentHistSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IBusRentHistDao;
import com.hjd.dao.IBusUseInfoDao;
import com.hjd.domain.BusRentHistTable;
import com.hjd.domain.ViewEquInfo;
import com.hjd.util.Util;

@RestController
public class BusRentHistAction extends BaseAction{
	
/*设备"拥有者"的登记功能如下++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/	
	@Autowired
	IBusRentHistDao iBusRentHistDao;
	@Autowired
	IBusUseInfoDao iBusUseInfoDao;
    //1：查询当前登录人所在单位的设备统计信息
	/**
	 * 根据企业的名称、设备租赁费的登记的年月来查询设备拥有者租赁登记统计信息集合
	 * @param busRentHistSearchBean
	 * @return
	 */
	@RequestMapping(value="/BG/RentHistOwner",method={RequestMethod.POST})
//	public Page<?> queryOwnerAll(@RequestBody BusRentHistSearchBean busRentHistSearchBean,HttpSession httpSession)
//	{
//		return iBusRentHistDao.queryOwnerAll(busRentHistSearchBean,httpSession);//这里使用的是原生的SQL语句，原因是提高他的查询效率，但是实验发现，不能提高很多的时间
//	}
	public Page<?> queryOwnerAll(@RequestBody BusRentHistSearchBean busRentHistSearchBean,HttpSession httpSession)
	{	
		String month=busRentHistSearchBean.getMonth();
		 if(Util.isNullOrEmpty(month)){throw new IFException("登记月份不能为空");}
		 
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append(" SELECT obj ");
		listSql.append(" FROM ViewRentHistOwner  obj ");
		listSql.append("WHERE 1=1 ");
		
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append(" SELECT count(1) "); 
		countSql.append(" FROM ViewRentHistOwner obj ");		
		countSql.append("WHERE 1=1 ");
		
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		
		Integer isProvider = busRentHistSearchBean.getIsProvider();	//	费中铁单位：1-费中铁单位、0或者空位中铁单位
		if(Util.isNotNullOrEmpty(isProvider) && 1==isProvider)//如果是非中铁单位时的处理方式
		{
			Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
			Long orgPartyId=(Long)userMap.get("orgId"); //用于压力测试，测试完毕需要恢复
			sqlParamsMap.put("orgPartyId", orgPartyId);
			listSql.append(" AND obj.bureauOrgPartyId =:orgPartyId ");
			countSql.append(" AND obj.bureauOrgPartyId =:orgPartyId ");	
		}
		else//如果是中单位的处理方式
		{
			//	拼组所属单位/项目的查询条件
			Integer orgFlag = busRentHistSearchBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
			Long orgPartyId = busRentHistSearchBean.getOrgPartyId();	//	所属单位/项目id
			Integer isInclude = busRentHistSearchBean.getIsInclude();	//	是否包含下级单位：1-包含
			if(Util.isNotNullOrEmpty(orgPartyId) && Util.isNotNullOrEmpty(orgFlag))
			{

				//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
				if(orgFlag==9){//	总公司
					listSql.append(" AND obj.bureauOrgParTypeId=4");
					countSql.append(" AND obj.bureauOrgParTypeId=4");
				}
				else if(orgFlag==1){//	局级单位
					sqlParamsMap.put("orgPartyId", orgPartyId);
					if(isInclude!=null && isInclude==1){
						listSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");
						countSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");
					}
					else{
						listSql.append(" AND (obj.bureauOrgPartyId=:orgPartyId AND obj.sonOrgPartyId=null)");
						countSql.append(" AND (obj.bureauOrgPartyId=:orgPartyId AND obj.sonOrgPartyId=null)");
					}
				}
				else if(orgFlag==2){//	处级单位
					sqlParamsMap.put("orgPartyId", orgPartyId);
					listSql.append(" AND obj.sonOrgPartyId=:orgPartyId");
					countSql.append(" AND obj.sonOrgPartyId=:orgPartyId");
				}
				else if(orgFlag==3){//	项目
					sqlParamsMap.put("orgPartyId", orgPartyId);
					listSql.append(" AND obj.proOrgPartyId=:orgPartyId");
					countSql.append(" AND obj.proOrgPartyId=:orgPartyId");
				}
				else{
					throw new IFException("所属单位信息错误！");
				}	    	
			}
		}
		
		
//		//外部供应商对应的代码
//		Integer isProvider=busRentHistSearchBean.getIsProvider();
//	
//		if(isProvider!=null && isProvider==1)
//		{
//			Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
//			Long partyId=(Long)userMap.get("orgId"); //用于压力测试，测试完毕需要恢复
//	//		Long partyId=Long.parseLong("316");
//			
//			sqlParamsMap.put("equAtOrgId",partyId);
//			listSql.append(" AND obj.equAtOrgId=:equAtOrgId");
//			countSql.append(" AND obj.equAtOrgId=:equAtOrgId");	
//		}
//		else
//		{
//			String orgCode = busRentHistSearchBean.getOrgCode();
//			if("".equals(Util.toStringAndTrim(orgCode)))throw new IFException("当前登录人员的单位编码不能为空");
//			Integer isInclude = busRentHistSearchBean.getIsInclude();
//			
//			if(isInclude!=null && isInclude==1)
//			{
//				sqlParamsMap.put("equAtOrgCode",orgCode+"%");
//				listSql.append(" AND obj.equAtOrgCode LIKE :equAtOrgCode");
//				countSql.append(" AND obj.equAtOrgCode LIKE :equAtOrgCode");
//			}
//			else
//			{
//				sqlParamsMap.put("equAtOrgCode",orgCode);
//				listSql.append(" AND obj.equAtOrgCode=:equAtOrgCode");
//				countSql.append(" AND obj.equAtOrgCode=:equAtOrgCode");	
//			}
//		}
	
		if(Util.isNotNullOrEmpty(month))
		{
			sqlParamsMap.put("month",month);
			listSql.append(" AND obj.month=:month");
			countSql.append(" AND obj.month=:month");	
		}
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,busRentHistSearchBean.getPageRequest());
	
		return datas;	
   }
	
//	public Page<?> queryOwnerAll_test(@RequestBody BusRentHistSearchBean busRentHistSearchBean,HttpSession httpSession)
//	{	
//		//拼写的列表查询语句
//		StringBuffer listSql = new StringBuffer();
//		listSql.append(" SELECT obj ");
//		listSql.append(" FROM ViewEquOwnInfo  obj ");
//		listSql.append(" WHERE 1=1 ");
//		
//		//拼写获取总的记录条数的查询语句
//		StringBuffer countSql = new StringBuffer();
//		countSql.append(" SELECT count(1) "); 
//		countSql.append(" FROM ViewEquOwnInfo obj ");		
//		countSql.append(" WHERE 1=1 ");
//		
//		//租赁费登记，只登记设备处在使用中的
//		
//		//传递条件查询参数的载体
//		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
//		
//		//设备来源分类为“自有”
///*		sqlParamsMap.put("equipmentSourceNo",1);
//		listSql.append(" AND obj.equipmentSourceNo=:equipmentSourceNo");
//		countSql.append(" AND obj.equipmentSourceNo=:equipmentSourceNo");	*/
//		//设备状态为“使用中”
///*		sqlParamsMap.put("equState",2);
//		listSql.append(" AND obj.equState=:equState");
//		countSql.append(" AND obj.equState=:equState");	*/
//		
//		List<ViewRentHistSum> vrhss=new ArrayList<ViewRentHistSum>();
//		
//
//		
//		//外部供应商对应的代码
//		Integer isProvider=busRentHistSearchBean.getIsProvider();
//		if(isProvider!=null && isProvider==1)
//		{
//			Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
//			Long partyId=(Long)userMap.get("orgId");//用于压力测试，测试完毕需要恢复
////			Long partyId=Long.parseLong("316");
//			//外部用户-租赁费登记（设备使用者）-列表显示设备来源分类”为“自有”，“设备状态”为“使用中”，“业务状态”为“外租”，设备拥有者在“资源管理”登记时所填写“设备所在单位”为“当前操作人所在单位”的设备信息
//
//			sqlParamsMap.put("partyId",partyId);
//			listSql.append(" AND obj.partyId=:partyId");
//			countSql.append(" AND obj.partyId=:partyId");	
//			
//			//业务状态为“外租”
///*			sqlParamsMap.put("busState",5);
//			listSql.append(" AND obj.busState=:busState");
//			countSql.append(" AND obj.busState=:busState");	*/
//			
//			//获取外部单位的租赁费拥有者登记信息
//			vrhss=iBusRentHistDao.queryByEquOwnOrgIdAndMonth(partyId, busRentHistSearchBean.getMonth());
//		}
//		else
//		{
//			//设备来源分类”为“自有”，“设备状态”为“使用中”，“业务状态”为“调拨、局内租、外局租、外租”，设备拥有者在“资源管理”登记时所填写“设备所在单位”为“当前操作人所在单位”的设备信息
//
//			String orgCode = busRentHistSearchBean.getOrgCode();
//			if("".equals(Util.toStringAndTrim(orgCode)))throw new IFException("当前登录人员的单位编码不能为空");
//			Integer isInclude = busRentHistSearchBean.getIsInclude();
//			
//			if(isInclude!=null && isInclude==1)
//			{
//				sqlParamsMap.put("orgCode",orgCode+"%");
//				listSql.append(" AND obj.orgCode LIKE :orgCode");
//				countSql.append(" AND obj.orgCode LIKE :orgCode");
//				
//				//获取内部单位的租赁费拥有者登记信息
//				vrhss=iBusRentHistDao.queryByEquOwnOrgCodeAndMonth((String)sqlParamsMap.get("orgCode"), busRentHistSearchBean.getMonth());
//			}
//			else
//			{
//				sqlParamsMap.put("orgCode",orgCode);
//				listSql.append(" AND obj.orgCode=:orgCode");
//				countSql.append(" AND obj.orgCode=:orgCode");	
//				
//				//获取内部单位的租赁费拥有者登记信息
//				vrhss=iBusRentHistDao.getByEquOwnOrgCodeAndMonth((String)sqlParamsMap.get("orgCode"), busRentHistSearchBean.getMonth());
//			}
//			//业务状态为“调拨、局内租、外局租、外租”
///*			sqlParamsMap.put("busState",1);//1是自用，其他是上面的
//			listSql.append(" AND obj.busState!=:busState");
//			countSql.append(" AND obj.busState!=:busState");	*/
//		}
//		
//	
///*		if(Util.isNotNullOrEmpty(busRentHistSearchBean.getOrgName()))
//		{
//			sqlParamsMap.put("orgName", busRentHistSearchBean.getOrgName());
//			listSql.append(" AND obj.orgName = :orgName");
//			countSql.append(" AND obj.orgName = :orgName");
//		}*/
//		
//		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,busRentHistSearchBean.getPageRequest());
//		
//		List<ViewEquOwnInfo> veis = (List<ViewEquOwnInfo>)datas.getContent();
//		
//		//同一个拥有单位、同一台设备、同一个年月，最多只能有一条设备使用的租赁费登记信息
//
//		List<Map<String, Object>> mapList= new ArrayList<Map<String, Object>>();
//		Map<String, Object> map=null;
//		for(int i=0; i<veis.size();i++)
//		{
//			map= new HashMap<String, Object>();
//			
//			map.put("equInfo", veis.get(i));
//			if(vrhss.size()>0)
//			{   
//				int j=0;
//				for(j=0;j<vrhss.size();j++)
//				{
//					if(veis.get(i).getEquipmentId().equals(vrhss.get(j).getEquId()) && veis.get(i).getPartyId().equals(vrhss.get(j).getEquAtOrgId()))
//					{
//						map.put("rentInfo", vrhss.get(j));
//						break;
//					}
//				}	
//				if(j==vrhss.size() && map.get("rentInfo")==null)
//				{
//					map.put("rentInfo", new ViewRentHistSum ());
//				}	
//			}
//			else
//			{
//				map.put("rentInfo", new ViewRentHistSum ());
//			}
//
//			mapList.add(map);
//		}
//		
//		Page<?> page = new PageImpl(mapList,busRentHistSearchBean.getPageRequest(),datas.getTotalElements());
//
//		return page;	
//	}
	
	//2：查看单个设备的登记信息
	/**
	 * 根据设备ID获取设备的信息，以及根据设备ID和登记月份获取登记信息
	 * @param id
	 * @param reqParamsMap
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value="/BG/RentHistOwner",method={RequestMethod.GET})
	public Map<String,Object> getRentInfo(@RequestParam Map<?, ?> reqParamsMap) throws ParseException
	{
		    //设备的ID
		    Long equipmentId=Long.valueOf((String)reqParamsMap.get("equipmentId"));
		    /*Long equAtOrgId=Long.valueOf((String)reqParamsMap.get("equAtOrgId"));*/
		    //设备登记的月份，知道年月，不是正确的日期格式所以使用字符串
		    String month=(String)reqParamsMap.get("month");
		    //获取某个设备的信息
		    Map<String, Object> map = new HashMap<String, Object>();
		    ViewEquInfo viewEquInfo =iBusRentHistDao.queryViewEquInfo(equipmentId);
		    map.put("viewEquInfo", viewEquInfo);
			//获取某个设备某个年月的租赁登记信息，设备拥有者登记的
			List<BusRentHistTable> brhts=iBusRentHistDao.queryByEquIdAndMonth(equipmentId,month,0);
			map.put("ownerRentInfos", brhts);
			//获取某个设备某个年月的租赁登记信息，设备使用者登记的
			List<BusRentHistTable> brhts_=iBusRentHistDao.queryByEquIdAndMonth(equipmentId,month,1);
			map.put("userRentInfos", brhts_);
		   return map;
	}
	//3：登记设备的租赁信息（这个方法对应两个方法添加设备租赁费的登记信息和修改设备租赁费的登记信息）
	/**
	 * 添加或者修改设备拥有者的租赁费登记信息
	 * @param busRentHistBean
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value="/BG/RentHistOwner",method={RequestMethod.POST},params={"Action=AddOrUpd"})
	@Transactional
	public Map<String, String> addOrUpdRentHistOwner(@RequestBody BusRentHistBean busRentHistBean,HttpSession httpSession)
	{
	       Long equipmentId=busRentHistBean.getEquipmentId();//资源设备的ID
	       String month_=busRentHistBean.getMonth_();//租赁费登记的月份
		   List<BusRentHistBeanTemp>brhtList=busRentHistBean.getBrhtList();//租赁费登记的信息集合
		   
		   //前端页面是同一个页面又能添加、又能修改、又能删除，这三种情况需要在程序中分别处理
		   //首先删除从前台页面中删除的记录，然后对于已有的记录进行修改，对于新加的记录进行添加
		   List<BusRentHistTable> brhts=iBusRentHistDao.queryByEquIdAndMonth(equipmentId,month_,0);
		   
		   BusRentHistBeanTemp b=new BusRentHistBeanTemp();
		   BusRentHistTable b_=new BusRentHistTable();
		   for(int i=0;i<brhts.size();i++)
		   {
			   b_=brhts.get(i);
			   int j=0;
			   for(;j<brhtList.size();j++)
			   {
				   b=brhtList.get(j);
				   if(Util.isNotNullOrEmpty(b.getId()) && b_.getId().equals(b.getId())){break;}
			   }
			   if(j==brhtList.size() && !b_.getId().equals(b.getId()))
			   {
				   iBusRentHistDao.deleteById(b_.getId());
			   }
		   }
		   
		  /* iBusRentHistDao.deleteByEquIdAndMonth(equipmentId, month_);*/
		   
		   for(int i=0;i<brhtList.size();i++)
		   {
			   
			   BusRentHistBeanTemp busRentHistBeanTemp=brhtList.get(i);
			   Long  id=busRentHistBeanTemp.getId();
			   //id：存在就修改，否者就添加新的设备的租赁费，当然，添加的时候需要判断一下同一个设备同一个月份是否已经登记过了，如果登记过了就不再登记了
			   if(Util.isNotNullOrEmpty(id))
			   {
					BusRentHistTable bdht = iBusRentHistDao.queryDesc(id);
					
					bdht.setAmount(busRentHistBeanTemp.getAmount());
					bdht.setCost(busRentHistBeanTemp.getCost());
					bdht.setDeductCost(busRentHistBeanTemp.getDeductCost());
					bdht.setDepName(busRentHistBeanTemp.getDepName());
					bdht.setNote(busRentHistBeanTemp.getNote());
					bdht.setRent(busRentHistBeanTemp.getRent());
					bdht.setRentCount(busRentHistBeanTemp.getRentCount());
					bdht.setRentType(busRentHistBeanTemp.getRentType());
					bdht.setStartEndDate(busRentHistBeanTemp.getStartEndDate());
					bdht.setBureauOrgPartyId(busRentHistBeanTemp.getBureauOrgPartyId());
					bdht.setSonOrgPartyId(busRentHistBeanTemp.getSonOrgPartyId());
					bdht.setProOrgPartyId(busRentHistBeanTemp.getProOrgPartyId());
					
					bdht.setOperateDate(new Date());
					Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo"); //用于压力测试，测试完毕需要恢复
					bdht.setOperator((Long)userMap.get("loginUserId"));
//					bdht.setOperator(Long.parseLong("3"));
					
					bdht.setRegFlag(0);
					
					iBusRentHistDao.save(bdht);
			   }
			   else
			   {
				   BusRentHistTable bdht_ = new BusRentHistTable();
				   busRentHistBeanTemp.copyPropertyToDestBean(bdht_);
				   
				   bdht_.setEquipmentId(equipmentId);
				   bdht_.setMonth(month_);
				   
				   bdht_.setOperateDate(new Date());
				   Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
				   bdht_.setOperator((Long)userMap.get("loginUserId"));
//				   bdht_.setOperator(Long.parseLong("3")); //用于压力测试，测试完毕需要恢复
				   
				   bdht_.setRegFlag(0);
				   
				   iBusRentHistDao.save(bdht_);
			   }
			   
/*			   BusRentHistBeanTemp busRentHistBeanTemp=brhtList.get(i);
			   BusRentHistTable bdht_ = new BusRentHistTable();
			   busRentHistBeanTemp.copyPropertyToDestBean(bdht_);
			   
			   bdht_.setEquipmentId(equipmentId);
			   bdht_.setMonth(month_);
			   
			   bdht_.setOperateDate(new Date());
			   Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
			   bdht_.setOperator((Long)userMap.get("loginUserId"));
			   bdht_.setRegFlag(0);
			   
			   iBusRentHistDao.save(bdht_);*/
		   }
			Map<String, String> map = new HashMap<String, String>();
			map.put("msg", "保存成功");
			return map;
	}
/*设备"使用者"的登记功能如下++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/	
	/**
	 * 使用者的租赁费登记，稍微有点复杂，解决的思路如下：
	 * 1：“租赁费——设备使用者”的数据，主要来自租赁费表，通过跑批往里面插入的数据
	 * @param busRentHistSearchBean
	 * @return
	 */
	@RequestMapping(value="/BG/RentHistUser",method={RequestMethod.POST})
	public Page<?> queryUserAll(@RequestBody BusRentHistSearchBean busRentHistSearchBean,HttpSession httpSession)
	{	
	String month=busRentHistSearchBean.getMonth();
	 if(Util.isNullOrEmpty(month)){throw new IFException("登记月份不能为空");}
	 
	//拼写的列表查询语句
	StringBuffer listSql = new StringBuffer();
	listSql.append(" SELECT obj ");
	listSql.append(" FROM ViewRentHistUser  obj ");
	listSql.append("WHERE 1=1 ");
	
	//拼写获取总的记录条数的查询语句
	StringBuffer countSql = new StringBuffer();
	countSql.append(" SELECT count(1) "); 
	countSql.append(" FROM ViewRentHistUser obj ");		
	countSql.append("WHERE 1=1 ");
	
	//传递条件查询参数的载体
	Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
	
	sqlParamsMap.put("regFlag",1);
	listSql.append(" AND obj.regFlag=:regFlag");
	countSql.append(" AND obj.regFlag=:regFlag");	
	
	Integer isProvider = busRentHistSearchBean.getIsProvider();	//	费中铁单位：1-费中铁单位、0或者空位中铁单位
	if(Util.isNotNullOrEmpty(isProvider) && 1==isProvider)//如果是非中铁单位时的处理方式
	{
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
		Long orgPartyId=(Long)userMap.get("orgId"); //用于压力测试，测试完毕需要恢复
		sqlParamsMap.put("orgPartyId", orgPartyId);
		listSql.append(" AND obj.bureauOrgPartyId =:orgPartyId ");
		countSql.append(" AND obj.bureauOrgPartyId =:orgPartyId ");	
	}
	else//如果是中单位的处理方式
	{
		//	拼组所属单位/项目的查询条件
		Integer orgFlag = busRentHistSearchBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
		Long orgPartyId = busRentHistSearchBean.getOrgPartyId();	//	所属单位/项目id
		Integer isInclude = busRentHistSearchBean.getIsInclude();	//	是否包含下级单位：1-包含
		if(Util.isNotNullOrEmpty(orgPartyId) && Util.isNotNullOrEmpty(orgFlag))
		{

			//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
			if(orgFlag==9){//	总公司
				listSql.append(" AND obj.bureauOrgParTypeId=4");
				countSql.append(" AND obj.bureauOrgParTypeId=4");
			}
			else if(orgFlag==1){//	局级单位
				sqlParamsMap.put("orgPartyId", orgPartyId);
				if(isInclude!=null && isInclude==1){
					listSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");
					countSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");
				}
				else{
					listSql.append(" AND (obj.bureauOrgPartyId=:orgPartyId AND obj.sonOrgPartyId=null)");
					countSql.append(" AND (obj.bureauOrgPartyId=:orgPartyId AND obj.sonOrgPartyId=null)");
				}
			}
			else if(orgFlag==2){//	处级单位
				sqlParamsMap.put("orgPartyId", orgPartyId);
				listSql.append(" AND obj.sonOrgPartyId=:orgPartyId");
				countSql.append(" AND obj.sonOrgPartyId=:orgPartyId");
			}
			else if(orgFlag==3){//	项目
				sqlParamsMap.put("orgPartyId", orgPartyId);
				listSql.append(" AND obj.proOrgPartyId=:orgPartyId");
				countSql.append(" AND obj.proOrgPartyId=:orgPartyId");
			}
			else{
				throw new IFException("所属单位信息错误！");
			}	    	
		}
	}
	
	
//	//外部供应商对应的代码
//	Integer isProvider=busRentHistSearchBean.getIsProvider();
//
//	if(isProvider!=null && isProvider==1)
//	{
//		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
//		Long partyId=(Long)userMap.get("orgId"); //用于压力测试，测试完毕需要恢复
////		Long partyId=Long.parseLong("316");
//		
//		sqlParamsMap.put("equAtOrgId",partyId);
//		listSql.append(" AND obj.equAtOrgId=:equAtOrgId");
//		countSql.append(" AND obj.equAtOrgId=:equAtOrgId");	
//	}
//	else
//	{
//		String orgCode = busRentHistSearchBean.getOrgCode();
//		if("".equals(Util.toStringAndTrim(orgCode)))throw new IFException("当前登录人员的单位编码不能为空");
//		Integer isInclude = busRentHistSearchBean.getIsInclude();
//		
//		if(isInclude!=null && isInclude==1)
//		{
//			sqlParamsMap.put("equAtOrgCode",orgCode+"%");
//			listSql.append(" AND obj.equAtOrgCode LIKE :equAtOrgCode");
//			countSql.append(" AND obj.equAtOrgCode LIKE :equAtOrgCode");
//		}
//		else
//		{
//			sqlParamsMap.put("equAtOrgCode",orgCode);
//			listSql.append(" AND obj.equAtOrgCode=:equAtOrgCode");
//			countSql.append(" AND obj.equAtOrgCode=:equAtOrgCode");	
//		}
//	}

	if(Util.isNotNullOrEmpty(busRentHistSearchBean.getMonth()))
	{
		sqlParamsMap.put("month",busRentHistSearchBean.getMonth());
		listSql.append(" AND obj.month=:month");
		countSql.append(" AND obj.month=:month");	
	}
	Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,busRentHistSearchBean.getPageRequest());

	return datas;	
 }
	
	
	/**
	 * 使用者的租赁费登记，稍微有点复杂，解决的思路如下：
	 * 1：根据登录人和月份先查看一下设备使用历史表里有没有对应的设备信息，如果有就使用设备表左联接租赁费表，
	 * 2：如果没有再到设备表中查询，如果有数据，也是左联租赁表，如果没有就没有使用数据了
	 * @param busRentHistSearchBean
	 * @return
	 */	
//	@SuppressWarnings({ "unchecked", "rawtypes" })
//	public Page<?> queryUserAll_test(@RequestBody BusRentHistSearchBean busRentHistSearchBean,HttpSession httpSession)
//	{	
//		String month=busRentHistSearchBean.getMonth();
//		 if(Util.isNullOrEmpty(month)){throw new IFException("登记月份不能为空");}
//		 
//		//拼写的列表查询语句
//		StringBuffer listSql = new StringBuffer();
//		listSql.append(" SELECT obj ");
//		listSql.append(" FROM ViewEquUseInfo  obj ");
//		listSql.append(" WHERE exitFlag=0  AND obj.month='").append(month).append("' ");
//		
//		//拼写获取总的记录条数的查询语句
//		StringBuffer countSql = new StringBuffer();
//		countSql.append(" SELECT count(1) "); 
//		countSql.append(" FROM ViewEquUseInfo obj ");		
//		countSql.append(" WHERE exitFlag=0  AND obj.month='").append(month).append("' ");
//		
//		//传递条件查询参数的载体
//		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
//		
//		//设备来源分类为“自有”
///*		sqlParamsMap.put("equipmentSourceNo",1);
//		listSql.append(" AND obj.equipmentSourceNo=:equipmentSourceNo");
//		countSql.append(" AND obj.equipmentSourceNo=:equipmentSourceNo");	*/
//		//设备状态为“使用中”
///*		sqlParamsMap.put("equState",2);
//		listSql.append(" AND obj.equState=:equState");
//		countSql.append(" AND obj.equState=:equState");	*/
//		
//		//外部供应商对应的代码
//		Integer isProvider=busRentHistSearchBean.getIsProvider();
//		
//		List<BusRentHistTable> brhts=new ArrayList<BusRentHistTable>();
//		
//
//		
//		if(isProvider!=null && isProvider==1)
//		{
//			Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
//			Long partyId=(Long)userMap.get("orgId");
//			
//			//外部用户-租赁费登记（设备使用者）-列表显示设备来源分类”为“自有”，“设备状态”为“使用中”，“业务状态”为“外租”，设备拥有者在“资源管理”登记时所填写“设备所在单位”为“当前操作人所在单位”的设备信息
//			
//			sqlParamsMap.put("equAtOrgId",partyId);
//			listSql.append(" AND obj.equAtOrgId=:equAtOrgId");
//			countSql.append(" AND obj.equAtOrgId=:equAtOrgId");	
//			
//			//业务状态为“外租”
///*			sqlParamsMap.put("busState",5);
//			listSql.append(" AND obj.busState=:busState");
//			countSql.append(" AND obj.busState=:busState");	*/
//			
//			//获取外部单位的租赁费使用者登记信息
//			brhts=iBusRentHistDao.queryByEquAtOrgIdAndMonth(partyId, busRentHistSearchBean.getMonth());
//		}
//		else
//		{
//			//设备来源分类”为“自有”，“设备状态”为“使用中”，“业务状态”为“调拨、局内租、外局租、外租”，设备拥有者在“资源管理”登记时所填写“设备所在单位”为“当前操作人所在单位”的设备信息
//			String orgCode = busRentHistSearchBean.getOrgCode();
//			if("".equals(Util.toStringAndTrim(orgCode)))throw new IFException("当前登录人员的单位编码不能为空");
//			Integer isInclude = busRentHistSearchBean.getIsInclude();
//			
//			if(isInclude!=null && isInclude==1)
//			{
//				sqlParamsMap.put("orgCode",orgCode+"%");
//				listSql.append(" AND obj.orgCode LIKE :orgCode");
//				countSql.append(" AND obj.orgCode LIKE :orgCode");
//				
//				//获取外部单位的租赁费使用者登记信息
//				brhts=iBusRentHistDao.queryByEquAtOrgCodeAndMonth((String)sqlParamsMap.get("orgCode"), busRentHistSearchBean.getMonth());
//			}
//			else
//			{
//				
//				sqlParamsMap.put("orgCode",orgCode);
//				listSql.append(" AND obj.orgCode=:orgCode");
//				countSql.append(" AND obj.orgCode=:orgCode");	
//				
//				//获取外部单位的租赁费使用者登记信息
//				brhts=iBusRentHistDao.getByEquAtOrgCodeAndMonth((String)sqlParamsMap.get("orgCode"), busRentHistSearchBean.getMonth());
//			}
//			//业务状态为“调拨、局内租、外局租、外租”
///*			sqlParamsMap.put("busState",1);//1是自用，其他是上面的
//			listSql.append(" AND obj.busState!=:busState");
//			countSql.append(" AND obj.busState!=:busState");	*/
//		}
//		
//
//		
///*		if(Util.isNotNullOrEmpty(busRentHistSearchBean.getOrgName()))
//		{
//			sqlParamsMap.put("orgName", busRentHistSearchBean.getOrgName());
//			listSql.append(" AND obj.orgName = :orgName");
//			countSql.append(" AND obj.orgName = :orgName");
//		}*/
//		
//		
//		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,busRentHistSearchBean.getPageRequest());
//		
//		List<ViewEquUseInfo> veuis = (List<ViewEquUseInfo>)datas.getContent();
//		
//		
//		//同一个使用单位、同一台设备、同一个年月，最多只能有一条设备使用的租赁费登记信息
//
//		List<Map<String, Object>> mapList= new ArrayList<Map<String, Object>>();
//		Map<String, Object> map=null;
//		for(int i=0; i<veuis.size();i++)
//		{
//			map= new HashMap<String, Object>();
//			map.put("equInfo", veuis.get(i));
//			if(brhts.size()>0)
//			{
//				int j=0;
//				for(;j<brhts.size();j++)
//				{
//					//同一个年月，设备名称相同、设备所在单位相同才是此单位使用的租赁费登记的记录
//					if(veuis.get(i).getEquipmentId().equals(brhts.get(j).getEquipmentId()) && veuis.get(i).getEquAtOrgId().equals(brhts.get(j).getEquAtOrgId()))
//					{
//						map.put("rentInfo", brhts.get(j));
//						break;
//					}
//				}
//				if(j==brhts.size() && null==map.get("rentInfo")){map.put("rentInfo", new BusRentHistTable ());}
//			}
//			else
//			{
//				map.put("rentInfo", new BusRentHistTable ());
//			}
//
//			mapList.add(map);
//		}
//		
//		Page<?> page = new PageImpl(mapList,busRentHistSearchBean.getPageRequest(),datas.getTotalElements());
//
//		return page;	
//	}
/*	{
		return iBusRentHistDao.queryUserAll(busRentHistSearchBean);//这里使用的是原生的SQL语句，原因在于拼视图的时候，对应的主键没有值，使用联合主键有比较麻烦
	}*/
	
	/**
	 * 添加或者修改设备使用者的租赁费登记信息
	 * @param busRentHistBean
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value="/BG/RentHistUser",method={RequestMethod.POST},params={"Action=AddOrUpd"})
	@Transactional
	public Map<String, String> addOrUpdRentHistUser(@RequestBody BusRentHistBean busRentHistBean,HttpSession httpSession)
	{
	       String month_=busRentHistBean.getMonth_();//租赁费登记的月份
		   List<BusRentHistBeanTemp>brhtList=busRentHistBean.getBrhtList();//租赁费登记的信息
		   
		   for(int i=0;i<brhtList.size();i++)
		   {
			   BusRentHistBeanTemp busRentHistBeanTemp=brhtList.get(i);
			   Long  id=busRentHistBeanTemp.getId();
			   //id：存在就修改，否者就添加新的设备的租赁费，当然，添加的时候需要判断一下同一个设备同一个月份是否已经登记过了，如果登记过了就不再登记了
			   if(id!=null)
			   {
					BusRentHistTable bdht = iBusRentHistDao.queryDesc(id);
					
					bdht.setAmount(busRentHistBeanTemp.getAmount());
					bdht.setCost(busRentHistBeanTemp.getCost());
					bdht.setDeductCost(busRentHistBeanTemp.getDeductCost());
					bdht.setDepName(busRentHistBeanTemp.getDepName());
					bdht.setNote(busRentHistBeanTemp.getNote());
					bdht.setRent(busRentHistBeanTemp.getRent());
					bdht.setRentCount(busRentHistBeanTemp.getRentCount());
					bdht.setRentType(busRentHistBeanTemp.getRentType());
					bdht.setStartEndDate(busRentHistBeanTemp.getStartEndDate());
					
					bdht.setOperateDate(new Date());
					Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
					bdht.setOperator((Long)userMap.get("loginUserId"));
					bdht.setRegFlag(1);
					bdht.setManualFlag(0);
					
					iBusRentHistDao.save(bdht);
			   }
			   else
			   {
				   BusRentHistTable bdht_ = new BusRentHistTable();
				   
				   busRentHistBeanTemp.copyPropertyToDestBean(bdht_);
				   
				   bdht_.setMonth(month_);
				   
				   bdht_.setOperateDate(new Date());
				   Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
				   bdht_.setOperator((Long)userMap.get("loginUserId"));
				   bdht_.setRegFlag(1);
				   
				   iBusRentHistDao.save(bdht_);
			   }
		   }
			Map<String, String> map = new HashMap<String, String>();
			map.put("msg", "保存成功");
			return map;
	}
	/**
	 * 退场操作的规则，将设备使用时间小于等于当前时间，并且没有退过场的设备使用信息做退场的处理，当然，另外的条件是，列表中中选中的某个单位的某个设备
	 * @param busRentHistBean
	 * @param httpSession
	 * @return
	 */
	@RequestMapping(value="/BG/RentHistUser",method={RequestMethod.POST},params={"Action=Exit"})
	@Transactional
	public Map<String, String> exitRentHistUser(@RequestBody BusRentHistBean busRentHistBean,HttpSession httpSession)
	{
	       Long equipmentId=busRentHistBean.getEquipmentId();//资源设备的ID
	       /*String month_=busRentHistBean.getMonth_();//租赁费登记的月份
*/		   Long equAtOrgId=busRentHistBean.getEquAtOrgId();//设备所在的单位，就是指这个设备被那个单位使用了
		   verifyNotEmpty(equipmentId,"资源设备的ID");
		   /*verifyNotEmpty(month_,"租赁费登记的月份");*/
		   verifyNotEmpty(equAtOrgId,"设备所在单位");
		   
		   //退场已当前单位为准
			Date now=new Date();
		    SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM");
		    String month=simpleDateFormat.format(now);
		   // month = "2016-04";
		   iBusUseInfoDao.updByEquAtOrgIdAndMonth(equipmentId,equAtOrgId,month,now);
		   
		   Map<String, String> map = new HashMap<String, String>();
		   map.put("msg", "退场成功");
		   return map;
	}
	
}