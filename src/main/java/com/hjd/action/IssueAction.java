package com.hjd.action;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.IssueSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IBizExDataDao;
import com.hjd.dao.IBusDealInfoDao;
import com.hjd.dao.IDemandRentDao;
import com.hjd.dao.IDemandSaleDao;
import com.hjd.dao.IIssueDao;
import com.hjd.dao.IPartyOrgDao;
import com.hjd.dao.IRentDao;
import com.hjd.dao.ISaleDao;
import com.hjd.domain.BizExData;
import com.hjd.domain.BusDealInfoTable;
import com.hjd.domain.DemandRentTable;
import com.hjd.domain.DemandSaleTable;
import com.hjd.domain.RentTable;
import com.hjd.domain.SaleTable;
import com.hjd.domain.ViewEquCount;
import com.hjd.util.Util;


@RestController
public class IssueAction extends BaseAction{
	
	@Autowired
	IIssueDao iIssueDao;
	@Autowired
	IRentDao iRentDao;
	@Autowired
	ISaleDao iSaleDao;
	@Autowired
	IDemandRentDao iDemandRentDao;
	@Autowired
	IDemandSaleDao iDemandSaleDao;
	@Autowired
	IBizExDataDao iBizExDataDao;
	@Autowired
	IBusDealInfoDao iBusDealInfoDao;
	@Autowired
	IPartyOrgDao partyOrgDao;
	
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=All"})
	public Page<?> queryAll(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		Integer pageNo = 0;
		Integer pageSize = 1;
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageNo=Integer.valueOf((String)reqParamsMap.get("pageNo"));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageSize=Integer.valueOf((String)reqParamsMap.get("pageSize"));
		}
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize);
		
		
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT obj ");
		listSql.append("FROM RentSalePublishedView  obj ");
		listSql.append("WHERE 1=1 ");
		
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM RentSalePublishedView obj ");		
		countSql.append("WHERE 1=1 ");
		
		//信息类型
		if(Util.isNotNullOrEmpty(reqParamsMap.get("infoType")))
		{
			sqlParamsMap.put("infoType", Integer.valueOf((String)reqParamsMap.get("infoType")));
			listSql.append(" AND obj.bizType = :infoType");
			countSql.append(" AND obj.bizType = :infoType");
		}
		//信息标题
		if(Util.isNotNullOrEmpty(reqParamsMap.get("infoTitle")))
		{
			sqlParamsMap.put("infoTitle", "%"+reqParamsMap.get("infoTitle")+"%");
			listSql.append(" AND obj.infoTitle LIKE :infoTitle");
			countSql.append(" AND obj.infoTitle LIKE :infoTitle");
		}
		//状态
		if(Util.isNotNullOrEmpty(reqParamsMap.get("dataState")))
		{
			sqlParamsMap.put("dataState", Integer.valueOf((String)reqParamsMap.get("dataState")));
			listSql.append(" AND obj.dataState = :dataState");
			countSql.append(" AND obj.dataState = :dataState");
		}
		listSql.append(" ORDER BY obj.releaseDate DESC ");
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas;	
	}
	
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=RentSale"})
	public Page<?> queryRentSale(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		Integer pageNo = 0;
		Integer pageSize = 1;
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageNo=Integer.valueOf((String)reqParamsMap.get("pageNo"));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageSize=Integer.valueOf((String)reqParamsMap.get("pageSize"));
		}
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize, null);
		
		
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
	    
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		
		//信息类型
		String infoType="";
		if(Util.isNotNullOrEmpty(reqParamsMap.get("infoType")))
		{
			infoType=(String)reqParamsMap.get("infoType");
			if("1".equals(infoType))//查询求租信息
			{
				listSql.append("SELECT obj ");
				listSql.append("FROM RentTable  obj ");
				listSql.append("WHERE 1=1 ");
				
				countSql.append("SELECT count(1) "); 
				countSql.append("FROM RentTable obj ");		
				countSql.append("WHERE 1=1 ");
			}else if("2".equals(infoType))//查询求购信息
			{
				listSql.append("SELECT obj ");
				listSql.append("FROM SaleTable  obj ");
				listSql.append("WHERE 1=1 ");
				
				countSql.append("SELECT count(1) "); 
				countSql.append("FROM SaleTable obj ");		
				countSql.append("WHERE 1=1 ");
			}else{
				throw new IFException("信息类型有误！");
			}
			
		}else{
			throw new IFException("信息类型不能为空！");
		}
		//状态
		if(Util.isNotNullOrEmpty(reqParamsMap.get("dataState")))
		{
			sqlParamsMap.put("dataState", Integer.valueOf((String)reqParamsMap.get("dataState")));
			listSql.append(" AND obj.dataState.dataState = :dataState");
			countSql.append(" AND obj.dataState.dataState = :dataState");
		}
		//开始时间
		if(Util.isNotNullOrEmpty(reqParamsMap.get("beginDate")))
		{
			sqlParamsMap.put("beginDate", reqParamsMap.get("beginDate"));
			listSql.append(" AND DATE_FORMAT(obj.releaseDate,'%Y-%m-%d') >= :beginDate");
			countSql.append(" AND DATE_FORMAT(obj.releaseDate,'%Y-%m-%d') >= :beginDate");
		}
		//结束时间
		if(Util.isNotNullOrEmpty(reqParamsMap.get("endDate")))
		{
			sqlParamsMap.put("endDate", reqParamsMap.get("endDate"));
			listSql.append(" AND DATE_FORMAT(obj.releaseDate,'%Y-%m-%d') <= :endDate");
			countSql.append(" AND DATE_FORMAT(obj.releaseDate,'%Y-%m-%d') <= :endDate");
		}
		//信息标题，企业名称，联系人，联系电话
		if(Util.isNotNullOrEmpty(reqParamsMap.get("searhParam")))
		{
			sqlParamsMap.put("searhParam", "%"+reqParamsMap.get("searhParam")+"%");
			listSql.append(" AND ( obj.infoTitle LIKE :searhParam");
			countSql.append(" AND ( obj.infoTitle LIKE :searhParam");

			listSql.append(" OR obj.enterpriseName LIKE :searhParam");
			countSql.append(" OR obj.enterpriseName LIKE :searhParam");

			listSql.append(" OR obj.contactPerson LIKE :searhParam");
			countSql.append(" OR obj.contactPerson LIKE :searhParam");

			listSql.append(" OR obj.contactPhone LIKE :searhParam )");
			countSql.append(" OR obj.contactPhone LIKE :searhParam )");
		}
		
/*		//信息标题
		if(Util.isNotNullOrEmpty(reqParamsMap.get("infoTitle")))
		{
			sqlParamsMap.put("infoTitle", "%"+reqParamsMap.get("infoTitle")+"%");
			listSql.append(" AND obj.infoTitle LIKE :infoTitle");
			countSql.append(" AND obj.infoTitle LIKE :infoTitle");
		}
		//企业名称
		if(Util.isNotNullOrEmpty(reqParamsMap.get("enterpriseName")))
		{
			sqlParamsMap.put("enterpriseName", "%"+reqParamsMap.get("enterpriseName")+"%");
			listSql.append(" AND obj.enterpriseName LIKE :enterpriseName");
			countSql.append(" AND obj.enterpriseName LIKE :enterpriseName");
		}
		//联系人
		if(Util.isNotNullOrEmpty(reqParamsMap.get("contactPerson")))
		{
			sqlParamsMap.put("contactPerson", "%"+reqParamsMap.get("contactPerson")+"%");
			listSql.append(" AND obj.contactPerson LIKE :contactPerson");
			countSql.append(" AND obj.contactPerson LIKE :contactPerson");
		}		
		//联系电话
		if(Util.isNotNullOrEmpty(reqParamsMap.get("contactPhone")))
		{
			sqlParamsMap.put("contactPhone", "%"+reqParamsMap.get("contactPhone")+"%");
			listSql.append(" AND obj.contactPhone LIKE :contactPhone");
			countSql.append(" AND obj.contactPhone LIKE :contactPhone");
		}*/

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas;	
	}
	
	/**
	 * @author Qian
	 * @param parms
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=DemandRentSale"})
	public Page<?> queryDemandRentSale(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		Integer pageNo = 0;
		Integer pageSize = 1;
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageNo=Integer.valueOf((String)reqParamsMap.get("pageNo"));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageSize=Integer.valueOf((String)reqParamsMap.get("pageSize"));
		}
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize, null);
		
		
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
	    
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		
		//信息类型
		String infoType="";
		if(Util.isNotNullOrEmpty(reqParamsMap.get("infoType")))
		{
			infoType=(String)reqParamsMap.get("infoType");
			if("3".equals(infoType))//查询求租信息
			{
				listSql.append("SELECT obj ");
				listSql.append("FROM DemandRentTable  obj ");
				listSql.append("WHERE 1=1 ");
				
				countSql.append("SELECT count(1) "); 
				countSql.append("FROM DemandRentTable obj ");		
				countSql.append("WHERE 1=1 ");
			}else if("4".equals(infoType))//查询求购信息
			{
				listSql.append("SELECT obj ");
				listSql.append("FROM DemandSaleTable  obj ");
				listSql.append("WHERE 1=1 ");
				
				countSql.append("SELECT count(1) "); 
				countSql.append("FROM DemandSaleTable obj ");		
				countSql.append("WHERE 1=1 ");
			}else{
				throw new IFException("信息类型有误！");
			}
			
		}else{
			throw new IFException("信息类型不能为空！");
		}
		//状态
		if(Util.isNotNullOrEmpty(reqParamsMap.get("dataState")))
		{
			sqlParamsMap.put("dataState", Integer.valueOf((String)reqParamsMap.get("dataState")));
			listSql.append(" AND obj.dataState.dataState = :dataState");
			countSql.append(" AND obj.dataState.dataState = :dataState");
		}
		//开始时间
		if(Util.isNotNullOrEmpty(reqParamsMap.get("beginDate")))
		{
			sqlParamsMap.put("beginDate", reqParamsMap.get("beginDate"));
			listSql.append(" AND DATE_FORMAT(obj.releaseDate,'%Y-%m-%d') >= :beginDate");
			countSql.append(" AND DATE_FORMAT(obj.releaseDate,'%Y-%m-%d') >= :beginDate");
		}
		//结束时间
		if(Util.isNotNullOrEmpty(reqParamsMap.get("endDate")))
		{
			sqlParamsMap.put("endDate", reqParamsMap.get("endDate"));
			listSql.append(" AND DATE_FORMAT(obj.releaseDate,'%Y-%m-%d') <= :endDate");
			countSql.append(" AND DATE_FORMAT(obj.releaseDate,'%Y-%m-%d') <= :endDate");
		}
		
		//信息标题，企业名称，联系人，联系电话
		if(Util.isNotNullOrEmpty(reqParamsMap.get("searhParam")))
		{
			sqlParamsMap.put("searhParam", "%"+reqParamsMap.get("searhParam")+"%");
			listSql.append(" AND ( obj.infoTitle LIKE :searhParam");
			countSql.append(" AND ( obj.infoTitle LIKE :searhParam");

			listSql.append(" OR obj.enterpriseName LIKE :searhParam");
			countSql.append(" OR obj.enterpriseName LIKE :searhParam");

			listSql.append(" OR obj.contactPerson LIKE :searhParam");
			countSql.append(" OR obj.contactPerson LIKE :searhParam");

			listSql.append(" OR obj.contactPhone LIKE :searhParam )");
			countSql.append(" OR obj.contactPhone LIKE :searhParam )");
		}
		
/*		//信息标题
		if(Util.isNotNullOrEmpty(reqParamsMap.get("infoTitle")))
		{
			sqlParamsMap.put("infoTitle", "%"+reqParamsMap.get("infoTitle")+"%");
			listSql.append(" AND obj.infoTitle LIKE :infoTitle");
			countSql.append(" AND obj.infoTitle LIKE :infoTitle");
		}
		//企业名称
		if(Util.isNotNullOrEmpty(reqParamsMap.get("enterpriseName")))
		{
			sqlParamsMap.put("enterpriseName", "%"+reqParamsMap.get("enterpriseName")+"%");
			listSql.append(" AND obj.enterpriseName LIKE :enterpriseName");
			countSql.append(" AND obj.enterpriseName LIKE :enterpriseName");
		}
		//联系人
		if(Util.isNotNullOrEmpty(reqParamsMap.get("contactPerson")))
		{
			sqlParamsMap.put("contactPerson", "%"+reqParamsMap.get("contactPerson")+"%");
			listSql.append(" AND obj.contactPerson LIKE :contactPerson");
			countSql.append(" AND obj.contactPerson LIKE :contactPerson");
		}		
		//联系电话
		if(Util.isNotNullOrEmpty(reqParamsMap.get("contactPhone")))
		{
			sqlParamsMap.put("contactPhone", "%"+reqParamsMap.get("contactPhone")+"%");
			listSql.append(" AND obj.contactPhone LIKE :contactPhone");
			countSql.append(" AND obj.contactPhone LIKE :contactPhone");
		}*/

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas;	
	}
	
	/**
	 * 
	 * @param id
	 * @param bizExData
	 * @return
	 */
	@RequestMapping(value="/Issue/{id}",method={RequestMethod.GET})
	@Transactional
	public Map<String, String> upd(@PathVariable Long id){
		BizExData bed=iBizExDataDao.getOne(id);
		if(bed!=null)
		{
			Long viewCount=bed.getViewCount();
			bed.setViewCount((viewCount==null?0L:viewCount)+1);
			iBizExDataDao.save(bed);
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "修改成功.");
		return map;
	}
	/**
	 * 
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=ITCount"})
	public Page<?> queryCount(@RequestParam Map<?, ?> reqParamsMap)
	{
		return iIssueDao.queryCount(reqParamsMap);
	}
	/**
	 * 根据设备名称获取品牌信息
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=queryEquBrand"})
	public Page<?> queryEquBrand(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		Integer pageNo = 0;
		Integer pageSize = 10;
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageNo=Integer.valueOf((String)reqParamsMap.get("pageNo"));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageSize=Integer.valueOf((String)reqParamsMap.get("pageSize"));
		}
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize);

		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();

		listSql.append("SELECT new Map(obj.id AS id,obj.equName AS equName,obj.name AS name,obj.nameOrder AS nameOrder) ");	
		listSql.append("FROM BusEquBrandTable  obj ");
		
		if(Util.isNotNullOrEmpty(reqParamsMap.get("id")))
		{
			String id=(String)reqParamsMap.get("id");
			Integer id_=Integer.valueOf(id);
			sqlParamsMap.put("equNameId",id_);
			listSql.append(" WHERE obj.equName.equNameId = :equNameId");
		}
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas;	
	}
	
	/**
	 * 根据品牌名称获取生产厂家信息
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=queryEquManufacturer"})
	public Page<?> queryEquManufacturer(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		Integer pageNo = 0;
		Integer pageSize = 10;
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageNo=Integer.valueOf((String)reqParamsMap.get("pageNo"));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageSize=Integer.valueOf((String)reqParamsMap.get("pageSize"));
		}
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize);

		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		
		listSql.append("SELECT new Map(obj.id AS id,obj.equBrand AS equBrand,obj.name AS name) ");	
		listSql.append("FROM BusEquManufacturerTable  obj ");
		
		if(Util.isNotNullOrEmpty(reqParamsMap.get("id")))
		{
			String id=(String)reqParamsMap.get("id");
			Long id_=Long.valueOf(id);
			sqlParamsMap.put("brandId",id_);
			listSql.append(" WHERE obj.equBrand.id = :brandId");
		}
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas;	
	}
	
	/**
	 * 根据品牌名称获取规格信息
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=queryEquStandard"})
	public Page<?> queryEquStandard(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		Integer pageNo = 0;
		Integer pageSize = 10;
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageNo=Integer.valueOf((String)reqParamsMap.get("pageNo"));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageSize=Integer.valueOf((String)reqParamsMap.get("pageSize"));
		}
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize);

		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		
		listSql.append("SELECT new Map(obj.id AS id,obj.equBrand AS equBrand,obj.name AS name) ");	
		listSql.append("FROM BusEquStandardTable  obj ");
		
		if(Util.isNotNullOrEmpty(reqParamsMap.get("id")))
		{
			String id=(String)reqParamsMap.get("id");
			Long id_=Long.valueOf(id);
			sqlParamsMap.put("brandId",id_);
			listSql.append(" WHERE obj.equBrand.id = :brandId");
		}
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas;	
	}
	/**
	 * 根据品牌名称获取型号信息
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=queryEquModel"})
	public Page<?> queryEquModel(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		Integer pageNo = 0;
		Integer pageSize = 10;
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageNo=Integer.valueOf((String)reqParamsMap.get("pageNo"));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageSize=Integer.valueOf((String)reqParamsMap.get("pageSize"));
		}
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize);

		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		
		listSql.append("SELECT new Map(obj.id AS id,obj.equBrand AS equBrand,obj.name AS name) ");	
		listSql.append("FROM BusEquModelTable  obj ");
		
		if(Util.isNotNullOrEmpty(reqParamsMap.get("id")))
		{
			String id=(String)reqParamsMap.get("id");
			Long id_=Long.valueOf(id);
			sqlParamsMap.put("brandId",id_);
			listSql.append(" WHERE obj.equBrand.id = :brandId");
		}
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas;	
	}
	
	
	/*实现查询首页过滤页面的功能+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
	/**
	 * 添加查询的过滤条件，目前供求租求购来使用。注意：为了提高查询效率，对于能够精确查询的就精确查询
	 * @param listSql
	 * @param countSql
	 * @param sqlParamsMap
	 * @param issueSearchBean
	 */
	private void addSelectParams(StringBuffer listSql,StringBuffer countSql,Map<String,Object> sqlParamsMap,IssueSearchBean issueSearchBean)
	{
        //发布信息的类型1：出租、2：出售、3：求租、4：求购
		Integer dataType = issueSearchBean.getDataType();
		sqlParamsMap.put("operateFlag",1);
		listSql.append(" AND obj.operateFlag != :operateFlag");
		countSql.append(" AND obj.operateFlag != :operateFlag");
		//过滤发布信息为审批通过的记录
		sqlParamsMap.put("dataState",3);
		listSql.append(" AND obj.dataState.dataState = :dataState");
		countSql.append(" AND obj.dataState.dataState = :dataState");
		
		//所属单位，分为两大类情况系统内的，系统外的
		//系统内的又分为有没有包含下级单位的情况
		//系统外的使用模糊查询
		if(dataType==1 || dataType==2){//出租、出售所属单位的处理
			
			Integer isProvider = issueSearchBean.getIsProvider();	//	费中铁单位：1-费中铁单位、0或者空位中铁单位
			if(Util.isNotNullOrEmpty(isProvider) && 1==isProvider)//如果是非中铁单位时的处理方式
			{
				String orgName = issueSearchBean.getOrgName();
				if(Util.isNotNullOrEmpty(orgName))
				{
					sqlParamsMap.put("bureauOrgPartyName", "%"+orgName+"%");
					listSql.append(" AND obj.bureauOrgPartyName LIKE:bureauOrgPartyName AND obj.bureauOrgParTypeId=8 ");
					countSql.append(" AND obj.bureauOrgPartyName LIKE:bureauOrgPartyName AND obj.bureauOrgParTypeId=8 ");	
				}
			}
			else//如果是中单位的处理方式
			{
				//	拼组所属单位/项目的查询条件
				Integer orgFlag = issueSearchBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
				Long orgPartyId = issueSearchBean.getOrgPartyId();	//	所属单位/项目id
				Integer isInclude = issueSearchBean.getIsInclude();	//	是否包含下级单位：1-包含
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
			
//			String orgCode = issueSearchBean.getOrgCode();
//			if(Util.isNotNullOrEmpty(orgCode))
//			{
//				sqlParamsMap.put("orgCode",orgCode+"%");
//				//设备的所属项目有三个局、处、项目，这里搜索页面的所属单位匹配上任意一个都行
//				listSql.append(" AND ( obj.bureauOrgCode LIKE :orgCode OR obj.sonOrgCode LIKE :orgCode  OR  obj.proOrgCode LIKE :orgCode)");
//				countSql.append(" AND ( obj.bureauOrgCode LIKE :orgCode OR obj.sonOrgCode LIKE :orgCode OR obj.proOrgCode LIKE :orgCode ) ");
//			}
			
		}else{//求租、求购所属单位的处理
			
			Integer isProvider = issueSearchBean.getIsProvider();	//	非中铁单位：1-费中铁单位、0或者空位中铁单位
			if(Util.isNotNullOrEmpty(isProvider) && 1==isProvider)//如果是非中铁单位时的处理方式
			{
				String orgName = issueSearchBean.getOrgName();
				if(Util.isNotNullOrEmpty(orgName))
				{
					sqlParamsMap.put("bureauOrgPartyName", "%"+orgName+"%");
					listSql.append(" AND obj.bureauOrgPartyName LIKE:bureauOrgPartyName ");
					countSql.append(" AND obj.bureauOrgPartyName LIKE:bureauOrgPartyName ");	
				}
			}
			else//如果是中单位的处理方式
			{
				//	拼组所属单位/项目的查询条件
				Integer orgFlag = issueSearchBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
				Long orgPartyId = issueSearchBean.getOrgPartyId();	//	所属单位/项目id
				Integer isInclude = issueSearchBean.getIsInclude();	//	是否包含下级单位：1-包含
				if(Util.isNotNullOrEmpty(orgPartyId) && Util.isNotNullOrEmpty(orgFlag))
				{

					//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
					if(orgFlag==9){//	总公司
						listSql.append(" AND obj.bureauOrgParTypeId=4");
						countSql.append(" AND obj.bureauOrgParTypeId=4");
					}
					else if(orgFlag==1){//	局级单位
						if(isInclude!=null && isInclude==1){
							String orgCode = issueSearchBean.getOrgCode();	//	所属单位/项目id
							if(Util.isNullOrEmpty(orgCode)){throw new IFException("所属单位信息传递错误！");}
							sqlParamsMap.put("orgCode", "%"+orgCode+"%");
							listSql.append(" AND obj.bureauOrgCode LIKE:orgCode ");
							countSql.append(" AND obj.bureauOrgCode LIKE:orgCode ");
						}
						else{
							sqlParamsMap.put("orgPartyId", orgPartyId);
							listSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");
							countSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");	
						}
					}
					else if(orgFlag==2){//	处级单位
						sqlParamsMap.put("orgPartyId", orgPartyId);
						listSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");
						countSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");
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

//			String orgCode = issueSearchBean.getOrgCode();
//			if(Util.isNotNullOrEmpty(orgCode))
//			{
//				Integer isInclude = issueSearchBean.getIsInclude();
//				//如果包含下级单位，就是采用模糊查询的方式，如果不包含下级单位就采用等于查询的方式
//				if(isInclude!=null && isInclude==1)
//				{
//					sqlParamsMap.put("orgCode",orgCode+"%");
//					listSql.append(" AND obj.orgCode LIKE :orgCode");
//					countSql.append(" AND obj.orgCode LIKE :orgCode");
//				}
//				else
//				{
//					sqlParamsMap.put("enterpriseName",issueSearchBean.getOrgName());
//					listSql.append(" AND obj.enterpriseName =:enterpriseName");
//					countSql.append(" AND obj.enterpriseName =:enterpriseName");	
//					
//	/*				sqlParamsMap.put("enterpriseName",issueSearchBean.getOrgName()+"%");
//					listSql.append(" AND obj.enterpriseName LIKE:enterpriseName");
//					countSql.append(" AND obj.enterpriseName LIKE:enterpriseName");	*/
//				}
//			}
//			else if(Util.isNotNullOrEmpty(issueSearchBean.getOrgName()))
//			{
//				sqlParamsMap.put("enterpriseName","%"+issueSearchBean.getOrgName()+"%");
//				listSql.append(" AND obj.enterpriseName LIKE:enterpriseName");
//				countSql.append(" AND obj.enterpriseName LIKE:enterpriseName");	
//			} 			
		}
		
	    //信息标题
		if(Util.isNotNullOrEmpty(issueSearchBean.getInfoTitle()))
		{
			sqlParamsMap.put("infoTitle", "%"+issueSearchBean.getInfoTitle()+"%");
			listSql.append(" AND obj.infoTitle LIKE :infoTitle");
			countSql.append(" AND obj.infoTitle LIKE :infoTitle");
		}
/*	    //所属单位
		if(Util.isNotNullOrEmpty(issueSearchBean.getOrgName()))
		{
			sqlParamsMap.put("orgName",issueSearchBean.getOrgName());
			listSql.append(" AND obj.enterpriseName = :orgName");
			countSql.append(" AND obj.enterpriseName = :orgName");
		}*/
	    //所在省
		if(Util.isNotNullOrEmpty(issueSearchBean.getOnProvince()))
		{
			sqlParamsMap.put("onProvince",issueSearchBean.getOnProvince());
			listSql.append(" AND obj.onProvince = :onProvince");
			countSql.append(" AND obj.onProvince = :onProvince");
		}
	    //所在城市
		if(Util.isNotNullOrEmpty(issueSearchBean.getOnCity()))
		{
			sqlParamsMap.put("onCity",issueSearchBean.getOnCity());
			listSql.append(" AND obj.onCity = :onCity");
			countSql.append(" AND obj.onCity = :onCity");
		}
	    //品牌
		if(Util.isNotNullOrEmpty(issueSearchBean.getBrandNames()))
		{
			/*sqlParamsMap.put("brandName",Util.arrayToString(issueSearchBean.getBrandNames()));*/
			listSql.append(" AND obj.brandName IN ( ").append(Util.arrayToString(issueSearchBean.getBrandNames())).append(" )");
			countSql.append(" AND obj.brandName IN ( ").append(Util.arrayToString(issueSearchBean.getBrandNames())).append(" )");
		}
	    //设备大类名称
		if(Util.isNotNullOrEmpty(issueSearchBean.getEquCategoryId()))
		{
			sqlParamsMap.put("equCategoryId",issueSearchBean.getEquCategoryId());
			listSql.append(" AND obj.equCategoryId = :equCategoryId");
			countSql.append(" AND obj.equCategoryId = :equCategoryId");
		}
	    //设备小类名称
		if(Util.isNotNullOrEmpty(issueSearchBean.getEquNameId()))
		{
			sqlParamsMap.put("equNameId",issueSearchBean.getEquNameId());
			listSql.append(" AND obj.equNameId = :equNameId");
			countSql.append(" AND obj.equNameId = :equNameId");
		}
	    //型号
		if(Util.isNotNullOrEmpty(issueSearchBean.getModelNames()))
		{
			/*sqlParamsMap.put("modelName", "("+Util.arrayToString(issueSearchBean.getModelNames())+")");*/
			listSql.append(" AND obj.modelName IN ( ").append(Util.arrayToString(issueSearchBean.getModelNames())).append(" )");
			countSql.append(" AND obj.modelName IN ( ").append(Util.arrayToString(issueSearchBean.getModelNames())).append(" )");
		}
	    //规格
		if(Util.isNotNullOrEmpty(issueSearchBean.getStandardNames()))
		{
			/*sqlParamsMap.put("standardName", "("+Util.arrayToString(issueSearchBean.getStandardNames())+")");*/
			listSql.append(" AND obj.standardName IN ( ").append(Util.arrayToString(issueSearchBean.getStandardNames())).append(" )");
			countSql.append(" AND obj.standardName IN ( ").append(Util.arrayToString(issueSearchBean.getStandardNames())).append(" )");
		}
	    //最低价格
		if(Util.isNotNullOrEmpty(issueSearchBean.getMinPrice()))
		{
			sqlParamsMap.put("minPrice",issueSearchBean.getMinPrice());
			listSql.append(" AND obj.price >= :minPrice");
			countSql.append(" AND obj.price >= :minPrice");
		}
	    //最高价格
		if(Util.isNotNullOrEmpty(issueSearchBean.getMaxPrice()))
		{
			sqlParamsMap.put("maxPrice",issueSearchBean.getMaxPrice());
			listSql.append(" AND obj.price <= :maxPrice");
			countSql.append(" AND obj.price <= :maxPrice");
		}
	    //价格类型
		if(Util.isNotNullOrEmpty(issueSearchBean.getPriceType()))
		{
			sqlParamsMap.put("priceType",issueSearchBean.getPriceType());
			listSql.append(" AND obj.priceType = :priceType");
			countSql.append(" AND obj.priceType = :priceType");
		}
	}
	
	/**
	 * 针对出租、出售、求租、求购四个前端搜索页面的查询，由于需要查询下级单位的信息，所以，需要拼视图来解决
	 * @param issueSearchBean
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.POST},params={"Action=GetAll"})
	public Page<?> queryAll(@RequestBody IssueSearchBean issueSearchBean)
	{
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();

		listSql.append(" SELECT obj ");
		countSql.append(" SELECT count(1) "); 
		
		Integer dataType=issueSearchBean.getDataType();

		if(1==dataType)//获得出租信息
		{
			listSql.append(" FROM ViewBusRent  obj ");
			countSql.append(" FROM ViewBusRent obj ");	
		}
		else if(2==dataType)//获得出售信息
		{
			listSql.append(" FROM ViewBusSale  obj ");
			countSql.append(" FROM ViewBusSale obj ");	
		}
		else if(3==dataType)//获得求租信息
		{
			listSql.append(" FROM ViewBusDemandrent  obj ");
			countSql.append(" FROM ViewBusDemandrent obj ");	
		}
		else if(4==dataType)//获得求购信息
		{
			listSql.append(" FROM ViewBusDemandsale obj ");
			countSql.append(" FROM ViewBusDemandsale obj ");	
		}
		else
		{
			throw new IFException("发布信息的类型不能为空！");
		}
		
		listSql.append(" WHERE 1=1 ");
		countSql.append(" WHERE 1=1 ");
		
		//添加查询的过滤条件
		addSelectParams(listSql,countSql,sqlParamsMap,issueSearchBean);
		
		Integer priceOrder=issueSearchBean.getPriceOrder();
		if(Util.isNotNullOrEmpty(priceOrder))
		{
			if(priceOrder==0)
			{
				listSql.append(" ORDER BY obj.price ASC");	
			}
			else
			{
				listSql.append(" ORDER BY obj.price DESC");
			}
		}
		else
		{
			listSql.append(" ORDER BY obj.releaseDate DESC");
		}
		
		
		
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,issueSearchBean.getPageRequest());
		
		return datas;	
	}
	
	
	//1：出租
	/**
	 * 前端出租搜索页面的查询方法
	 * @param issueSearchBean
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.POST},params={"Action=Rent"})
	public Page<?> queryRentAll(@RequestBody IssueSearchBean issueSearchBean)
	{
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();

		listSql.append(" SELECT obj ");
		listSql.append(" FROM RentTable  obj ");
		listSql.append(" WHERE 1=1 ");
		
		countSql.append(" SELECT count(1) "); 
		countSql.append(" FROM RentTable obj ");	
		countSql.append(" WHERE 1=1 ");
		
		//添加查询的过滤条件
		addSelectParams(listSql,countSql,sqlParamsMap,issueSearchBean);
		
		listSql.append(" ORDER BY obj.releaseDate DESC");
		
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,issueSearchBean.getPageRequest());
		
		return datas;	
	}
    //2：出售
	/**
	 * 前端出售搜索页面的查询方法
	 * @param issueSearchBean
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.POST},params={"Action=Sale"})
	public Page<?> querySaleAll(@RequestBody IssueSearchBean issueSearchBean)
	{
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();

		listSql.append("SELECT obj ");
		listSql.append("FROM SaleTable  obj ");
		listSql.append("WHERE 1=1 ");
		
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM SaleTable obj ");		
		countSql.append("WHERE 1=1 ");
		
		//添加查询的过滤条件
		addSelectParams(listSql,countSql,sqlParamsMap,issueSearchBean);
		
		listSql.append(" ORDER BY obj.releaseDate DESC");
		
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,issueSearchBean.getPageRequest());
		
		return datas;	
	}	
	//3：求租
	/**
	 * 前端求租搜索页面的查询方法
	 * @param issueSearchBean
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.POST},params={"Action=DemandRent"})
	public Page<?> queryDemandRentAll(@RequestBody IssueSearchBean issueSearchBean)
	{
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();

		listSql.append("SELECT obj ");
		listSql.append("FROM DemandRentTable  obj ");
		listSql.append("WHERE 1=1 ");
		
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM DemandRentTable obj ");		
		countSql.append("WHERE 1=1 ");
		
		//添加查询的过滤条件
		addSelectParams(listSql,countSql,sqlParamsMap,issueSearchBean);
		
		listSql.append(" ORDER BY obj.releaseDate DESC");
		
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,issueSearchBean.getPageRequest());
		
		return datas;	
	}	
	//4：求购
	/**
	 * 前端求购搜索页面的查询方法
	 * @param issueSearchBean
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.POST},params={"Action=DemandSale"})
	public Page<?> queryDemandSaleAll(@RequestBody IssueSearchBean issueSearchBean)
	{
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();

		listSql.append("SELECT obj ");
		listSql.append("FROM DemandSaleTable  obj ");
		listSql.append("WHERE 1=1 ");
		
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM DemandSaleTable obj ");		
		countSql.append("WHERE 1=1 ");
		
		//添加查询的过滤条件
		addSelectParams(listSql,countSql,sqlParamsMap,issueSearchBean);
		
		listSql.append(" ORDER BY obj.releaseDate DESC");
		
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,issueSearchBean.getPageRequest());
		
		return datas;	
	}

	/**
	 * 为出租、出售、求租、求购四种类型的发布信息添加展示信息
	 * @param map
	 * @param dataId
	 */
	private void changeMap(Map<String,Object>map,Long dataId)
	{
		//意向承租人
		Map <String,Object>dealMap=iBusDealInfoDao.queryDealCount(dataId);
		if(dealMap!=null && dealMap.get("dealCount")!=null)
		{
			map.put("dealCount", dealMap.get("dealCount"));
		}
		else
		{
			map.put("dealCount","");
		}
	}
	
	//出租
	/**
	 * 出租信息明细查询
	 * @param id 出租信息主键
	 * @return
	 */
	@RequestMapping(value="/Issue/{id}",method={RequestMethod.GET},params={"Action=Rent"})
	public Map<String,Object> queryRent(@PathVariable Long id)
	{
		Map <String,Object>map=new HashMap<String,Object>();
		RentTable issueInfo=iRentDao.queryDesc(id);
		map.put("issueInfo", issueInfo);//出租发布的信息
		map.put("equState", issueInfo.getState());//设备状态
		map.put("depName", issueInfo.getDepName());//单位名称
        changeMap(map,issueInfo.getDataId());
		return map;
	}
	
	//出售
	/**
	 * 出售信息明细查询，注意还需要一些其他的信息，比如：意向承租人、最终承租人、设备状态等，这些字段是需要通过一些判断才能展现的
	 * @param id 出售信息主键
	 * @return
	 */
	@RequestMapping(value="/Issue/{id}",method={RequestMethod.GET},params={"Action=Sale"})
	public Map<String,Object> querySale(@PathVariable Long id)
	{
		Map <String,Object>map=new HashMap<String,Object>();
		SaleTable issueInfo=iSaleDao.queryDesc(id);
		map.put("issueInfo", issueInfo);//出租发布的信息
		map.put("equState", issueInfo.getState());//设备状态
		map.put("depName", issueInfo.getDepName());//单位名称
        changeMap(map,issueInfo.getDataId());
		return map;
	}
	
	//求租
	/**
	 * 求租信息明细查询
	 * @param id 求租信息主键
	 * @return
	 */
	@RequestMapping(value="/Issue/{id}",method={RequestMethod.GET},params={"Action=DemandRent"})
	public Map<String,Object> queryDemandRent(@PathVariable Long id)
	{
		Map <String,Object>map=new HashMap<String,Object>();
		DemandRentTable issueInfo=iDemandRentDao.queryDesc(id);
		map.put("issueInfo", issueInfo);//出租发布的信息
        changeMap(map,issueInfo.getDataId());
		return map;
	}
	
	//求购
	/**
	 * 求购信息明细查询
	 * @param id 求购信息主键
	 * @return
	 */
	@RequestMapping(value="/Issue/{id}",method={RequestMethod.GET},params={"Action=DemandSale"})
	public Map<String,Object> queryDemandSale(@PathVariable Long id)
	{
		Map <String,Object>map=new HashMap<String,Object>();
		DemandSaleTable issueInfo=iDemandSaleDao.queryDesc(id);
		map.put("issueInfo", issueInfo);//出租发布的信息
        changeMap(map,issueInfo.getDataId());
		return map;
	}
	
	/**
	 * 根据当前登录人和发布信息的ID，来判断当前登录人是否点击过我想交易的按钮
	 * @param reqParamsMap
	 * @return
	 */
/*	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=ITCount"})
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=queryEquStandard"})*/
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=BusDealInfo"})
	public Map<String,String> queryDemandSale(@RequestParam Map<?, ?> reqParamsMap)
	{
		Object dataId=reqParamsMap.get("dataId");
		verifyNotEmpty(dataId,"发布信息编号");
		Object loginUserId=reqParamsMap.get("loginUserId");
		verifyNotEmpty(loginUserId,"当前登录人");
		Map<String, String> map = new HashMap<String, String>();
		String searchResult="FALSE";
		
		Long  dataId_=Long.valueOf((String)reqParamsMap.get("dataId"));
		Long  loginUserId_=Long.valueOf((String)reqParamsMap.get("loginUserId"));
		
		List<BusDealInfoTable> bdits=iBusDealInfoDao.queryByIdAndDataId(loginUserId_, dataId_);
	
		if(bdits!=null && bdits.size()>0)
		{
			searchResult="TRUE";
		}
		map.put("msg", searchResult);
		return map;
	}
	/**
	 * 资源统计，逻辑是视图之中
	    内部资源有500台设备原值：有3亿元
		外部资源有400台设备原值：有2亿元
		内部供应商共计500家
		外部供应商共计1000家
		可出租设备100台
		可出售设备50台
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=ResourceCount"})
	public ViewEquCount resourceCount(){
		ViewEquCount vec=iIssueDao.queryViewEquCount();
		if(Util.isNullOrEmpty(vec.getInnerEquCost())){vec.setInnerEquCost(BigDecimal.ZERO);}
		if(Util.isNullOrEmpty(vec.getOuterEquCost())){vec.setOuterEquCost(BigDecimal.ZERO);}
		return vec;
	}
	
	/**
	 * 
	 * @param issueSearchBean
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.POST},params={"Action=GetProviders"})
	public Page<?> getProviders(@RequestBody IssueSearchBean issueSearchBean)
	{
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT obj ");
		listSql.append("FROM PartyOrg  obj ");
		listSql.append("WHERE obj.code='provider' AND obj.state=0 ");
		
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM PartyOrg obj ");		
		countSql.append("WHERE obj.code='provider' AND obj.state=0 ");

		listSql.append(" ORDER BY obj.createTime DESC ");
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,issueSearchBean.getPageRequest());
		
		return datas;
	}
}
