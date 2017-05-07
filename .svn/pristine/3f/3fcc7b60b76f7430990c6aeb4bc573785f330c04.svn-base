package com.hjd.action;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.BusDealInfoBean;
import com.hjd.action.bean.BusDealInfoSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IBizExDataDao;
import com.hjd.dao.IBusDealInfoDao;
import com.hjd.dao.IDemandRentDao;
import com.hjd.dao.IDemandSaleDao;
import com.hjd.dao.IRentDao;
import com.hjd.dao.ISaleDao;
import com.hjd.domain.BizExData;
import com.hjd.domain.BusDealInfoTable;
import com.hjd.domain.DemandRentTable;
import com.hjd.domain.DemandSaleTable;
import com.hjd.domain.RentTable;
import com.hjd.domain.SaleTable;
import com.hjd.domain.ViewDealInfo;
import com.hjd.util.Util;

@RestController
public class BusDealInfoAction extends BaseAction{
	@Autowired
	IRentDao iRentDao;
	@Autowired
	ISaleDao iSaleDao;
	@Autowired
	IDemandRentDao iDemandRentDao;
	@Autowired
	IDemandSaleDao iDemandSaleDao;
	@Autowired
	IBusDealInfoDao iBusDealInfoDao;
	@Autowired
	IBizExDataDao iBizExDataDao;
	
/*	我想交易的信息++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/	
	
	/*0：添加我想发布的信息，在查看出租、出售、求租、求购的信息时点击我想交易的按钮时触发的*/
	/**
	 * 添加求租信息
	 * @param demandRentBean 添加的求租信息表单内容
	 * @return
	 */
	@RequestMapping(value="/BG/BusDealInfo",method={RequestMethod.PUT})
	@Transactional
	public Map<String, String> add(@RequestBody BusDealInfoBean busDealInfoBean ,HttpSession httpSession){
		
		Long dateId=busDealInfoBean.getDataId();//发布信息的ID
		if(Util.isNotNullOrEmpty(dateId))
		{
			//统计发布信息的单位响应次数
			BizExData bizExData = iBizExDataDao.getOne(dateId);
		 	Long depResponseCount=bizExData.getDepResponseCount()==null?0L:bizExData.getDepResponseCount();
			bizExData.setDepResponseCount(depResponseCount+1);
			iBizExDataDao.save(bizExData);
	        //添加我已发布的信息
			Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
			BusDealInfoTable busDealInfoTable=new BusDealInfoTable();
			//将我想交易的人的信息传递进来
			busDealInfoBean.copyPropertyToDestBean(busDealInfoTable);
			
			busDealInfoTable.setOperateFlag(0);
			busDealInfoTable.setOperateDate(new Date());
			busDealInfoTable.setLoginUserId((Long)userMap.get("loginUserId"));
			busDealInfoTable.setPartyId((Long)userMap.get("orgId"));
			busDealInfoTable.setProId((Long)userMap.get("proId"));
			iBusDealInfoDao.save(busDealInfoTable);
		}
		else
		{
			throw new IFException("我想交易的信息不能为空");
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "添加成功.");
		return map;
	}
	/*1：查看我想交易的信息*/
	/**
	 * 查询对应的视图，获取当前登录人我想交易的信息
	 * @param reqParamsMap
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value="/BG/BusDealInfo",method={RequestMethod.POST})
	public Page<?> queryAll(@RequestBody BusDealInfoSearchBean busDealInfoSearchBean,HttpSession httpSession)
	{
		//传递分页参数的载体
		Integer pageNo = busDealInfoSearchBean.getPageNo();
		Integer pageSize = busDealInfoSearchBean.getPageSize();
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize);
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT obj ");
		listSql.append("FROM ViewDealInfo  obj ");
		listSql.append("WHERE 1=1 ");
		
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM ViewDealInfo obj ");		
		countSql.append("WHERE 1=1 ");
		
		listSql.append(" AND obj.operateFlag != 1");
		countSql.append(" AND obj.operateFlag != 1");
		
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
//		sqlParamsMap.put("loginUserId", (Long)userMap.get("loginUserId"));
////		sqlParamsMap.put("loginUserId", Long.parseLong("3"));
//		listSql.append(" AND obj.loginUserId = :loginUserId");
//		countSql.append(" AND obj.loginUserId = :loginUserId");
		//如果当前当前登录者的项目ID存在，则查询同一个项目下的想交易的信息，否则查询同一个单位下的想交易的信息
		if(Util.isNotNullOrEmpty(userMap.get("proId")))
		{
			sqlParamsMap.put("proId", (Long)userMap.get("proId"));
			listSql.append(" AND obj.proId = :proId");
			countSql.append(" AND obj.proId = :proId");
		}
		else
		{
			sqlParamsMap.put("partyId", (Long)userMap.get("orgId"));
			listSql.append(" AND obj.partyId = :partyId");
			countSql.append(" AND obj.partyId = :partyId");
		}

		
		//传递条件查询参数的载体

		//信息类型
		if(Util.isNotNullOrEmpty(busDealInfoSearchBean.getDataType()))
		{
			sqlParamsMap.put("dataType", busDealInfoSearchBean.getDataType());
			listSql.append(" AND obj.dataType = :dataType");
			countSql.append(" AND obj.dataType = :dataType");
		}
		//发布状态
		if(Util.isNotNullOrEmpty(busDealInfoSearchBean.getDataState()))
		{
			sqlParamsMap.put("dataState", busDealInfoSearchBean.getDataState());
			listSql.append(" AND obj.dataState = :dataState");
			countSql.append(" AND obj.dataState = :dataState");
		}
		
		//设备状态
		if(Util.isNotNullOrEmpty(busDealInfoSearchBean.getEquState()))
		{
			sqlParamsMap.put("equState", busDealInfoSearchBean.getEquState());
			listSql.append(" AND obj.equState = :equState");
			countSql.append(" AND obj.equState = :equState");
		}
		
		//最小发布时间
		if(Util.isNotNullOrEmpty(busDealInfoSearchBean.getStartReleaseDate()))
		{
			sqlParamsMap.put("startReleaseDate", busDealInfoSearchBean.getStartReleaseDate());
			listSql.append(" AND obj.releaseDate > :startReleaseDate");
			countSql.append(" AND obj.releaseDate > :startReleaseDate");
		}
		//最大发布时间
		if(Util.isNotNullOrEmpty(busDealInfoSearchBean.getEndReleaseDate()))
		{
			Date endReleaseDate =busDealInfoSearchBean.getEndReleaseDate();
			endReleaseDate.setHours(23);
			endReleaseDate.setMinutes(59);
			endReleaseDate.setSeconds(59);
			sqlParamsMap.put("maxReleaseDate", busDealInfoSearchBean.getEndReleaseDate());
			listSql.append(" AND obj.releaseDate < :maxReleaseDate");
			countSql.append(" AND obj.releaseDate < :maxReleaseDate");
		}

		listSql.append(" ORDER BY obj.releaseDate DESC ");
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas;	
	}
	
	/*3：删除我想交易的信息*/
	/**
	 * 将对应的我想交易的信息逻辑删除，将对应的已发布的信息也打上对应的操作标识
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/BG/BusDealInfo/{id}",method={RequestMethod.DELETE})
	@Transactional
	public Map<String, String> busDealInfoDel(@PathVariable Long id)
	{
			//id：我想交易信息的记录ID
			ViewDealInfo viewDealInfo =iBusDealInfoDao.queryDescs(id);
			
			BusDealInfoTable bdit = iBusDealInfoDao.queryDesc(id);
			bdit.setOperateDate(new Date());
			bdit.setOperateFlag(1);//删除我想交易的信息，0：正常（添加我想交易的信息时默认添加），1：删除
			iBusDealInfoDao.save(bdit);
			//信息类型
			Integer dataType=viewDealInfo.getDataType();
			//发布信息的ID
			Long dateId=viewDealInfo.getDataId();
			
			if(1==dataType)//修改出租信息
			{
				RentTable rt = iRentDao.queryDesc(dateId);
				rt.setUpdateTime(new Date());
				rt.setOperateFlag(2);
				iRentDao.save(rt);
			}
			else if(2==dataType)//修改出售信息
			{
				SaleTable st = iSaleDao.queryDesc(dateId);
				st.setUpdateTime(new Date());
				st.setOperateFlag(2);
				iSaleDao.save(st);
			}
			else if(3==dataType)//修改求租信息
			{
				DemandRentTable drt = iDemandRentDao.queryDesc(dateId);
				drt.setUpdateTime(new Date());
				drt.setOperateFlag(2);
				iDemandRentDao.save(drt);
			}
			else if(4==dataType)//修改求购信息
			{
				DemandSaleTable drs = iDemandSaleDao.queryDesc(dateId);
				drs.setUpdateTime(new Date());
				drs.setOperateFlag(2);
				iDemandSaleDao.save(drs);
			}
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("msg", "删除成功.");
			return map;
	}
	
	/**
	 * 根据发布信息的ID来查询我想交易的信息集合
	 * @author Qian
	 * @since 2016-08-04
	 * @return Page
	 * @param BusDealInfoSearchBean
	 */
	@RequestMapping(value="/BG/BusDealInfo",method={RequestMethod.POST},params={"action=GET_BUS_DEAL_INFOS"})
	public Page<?> queryBusDealInfo(@RequestBody BusDealInfoSearchBean busDealInfoSearchBean)
	{
		//传递分页参数的载体
		Integer pageNo = busDealInfoSearchBean.getPageNo();
		Integer pageSize = busDealInfoSearchBean.getPageSize();
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize);
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT view ");
		listSql.append("FROM ViewDealInfoUser  view ");
		listSql.append("WHERE 1=1 ");
		
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM ViewDealInfoUser view ");		
		countSql.append("WHERE 1=1 ");
		
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		
		//传递条件查询参数的载体

		//信息类型
		if(Util.isNotNullOrEmpty(busDealInfoSearchBean.getDataId()))
		{
			sqlParamsMap.put("dataId", busDealInfoSearchBean.getDataId());
			listSql.append(" AND view.dataId = :dataId");
			countSql.append(" AND view.dataId = :dataId");
		}

		listSql.append(" ORDER BY view.id DESC ");
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas;	
	}
	
}