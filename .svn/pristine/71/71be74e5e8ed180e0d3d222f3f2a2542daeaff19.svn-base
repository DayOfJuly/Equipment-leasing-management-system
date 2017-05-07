package com.hjd.action;

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
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.BusAuditInfoBean;
import com.hjd.action.bean.BusAuditInfoSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IBizExDataDao;
import com.hjd.dao.IBusRefuseReasonDao;
import com.hjd.dao.IDemandRentDao;
import com.hjd.dao.IDemandSaleDao;
import com.hjd.dao.IEquipmentDao;
import com.hjd.dao.IRentDao;
import com.hjd.dao.ISaleDao;
import com.hjd.domain.BizDataState;
import com.hjd.domain.BizExData;
import com.hjd.domain.BusRefuseReasonTable;
import com.hjd.domain.DemandRentTable;
import com.hjd.domain.DemandSaleTable;
import com.hjd.domain.EquipmentTable;
import com.hjd.domain.RentTable;
import com.hjd.domain.SaleTable;
import com.hjd.util.Util;

@RestController
public class BusAuditInfoAction extends BaseAction{
	@Autowired
	IRentDao iRentDao;
	@Autowired
	ISaleDao iSaleDao;
	@Autowired
	IDemandRentDao iDemandRentDao;
	@Autowired
	IDemandSaleDao iDemandSaleDao;
	@Autowired
	IEquipmentDao iEquipmentDao;
	@Autowired
	IBusRefuseReasonDao iBusRefuseReasonDao;
	@Autowired
	IBizExDataDao iBizExDataDao;
/*发布审核的信息++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/	
	//1：查询发布审核信息的方法
	/**
	 * 查询发布审核的信息
	 * @param busAuditInfoSearchBean
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value="/AUDIT/BusAuditInfo",method={RequestMethod.POST})
	public Page<?> queryAll(@RequestBody BusAuditInfoSearchBean busAuditInfoSearchBean)
	{
		//传递分页参数的载体
/*		Integer pageNo = busAuditInfoSearchBean.getPageNo();
		Integer pageSize = busAuditInfoSearchBean.getPageSize();
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize);*/
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT obj ");
		listSql.append("FROM BizExData  obj ");
		listSql.append("WHERE 1=1 ");
		
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM BizExData obj ");		
		countSql.append("WHERE 1=1 ");
		
		listSql.append(" AND obj.operateFlag != 1");
		countSql.append(" AND obj.operateFlag != 1");
		
		
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//信息类型
		if(Util.isNotNullOrEmpty(busAuditInfoSearchBean.getDataType()))
		{
			sqlParamsMap.put("dataType", busAuditInfoSearchBean.getDataType());
			listSql.append(" AND obj.dataType = :dataType");
			countSql.append(" AND obj.dataType = :dataType");
		}
		//发布状态
		if(Util.isNotNullOrEmpty(busAuditInfoSearchBean.getDataState()))
		{
			sqlParamsMap.put("dataState", busAuditInfoSearchBean.getDataState());
			listSql.append(" AND obj.dataState.dataState = :dataState");
			countSql.append(" AND obj.dataState.dataState = :dataState");
		}
		//最小发布时间
		if(Util.isNotNullOrEmpty(busAuditInfoSearchBean.getStartReleaseDate()))
		{
			sqlParamsMap.put("startReleaseDate", busAuditInfoSearchBean.getStartReleaseDate());
			listSql.append(" AND obj.releaseDate >= :startReleaseDate");
			countSql.append(" AND obj.releaseDate >= :startReleaseDate");
		}
		//最大发布时间
		if(Util.isNotNullOrEmpty(busAuditInfoSearchBean.getEndReleaseDate()))
		{
			Date endReleaseDate =busAuditInfoSearchBean.getEndReleaseDate();
			endReleaseDate.setHours(23);
			endReleaseDate.setMinutes(59);
			endReleaseDate.setSeconds(59);
			sqlParamsMap.put("endReleaseDate", busAuditInfoSearchBean.getEndReleaseDate());
			listSql.append(" AND obj.releaseDate <= :endReleaseDate");
			countSql.append(" AND obj.releaseDate <= :endReleaseDate");
		}

		listSql.append(" ORDER BY obj.releaseDate DESC ");
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,busAuditInfoSearchBean.getPageRequest());
		
		return datas;	
	}
	
	//2：查看各个类型的发布信息的方法，可以使用原来的查看发布的方法
	/**
	 * 获取各个类型的发布信息，为我想交易的页面使用
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/BG/BusPublishInfo/{id}",method={RequestMethod.GET},params={"Action=GetAduitInfo"})
	public Map<String,Object> getAuditInfoForBusPublishInfo(@PathVariable Long id)
	{
 		    //id：我已发布信息的记录ID
		    Map<String, Object> map = new HashMap<String, Object>();
		    
			BizExData bed=iBizExDataDao.getOne(id);
			Integer dataType=bed.getDataType();
			Long dataId=bed.getDataId();//发布信息的ID
			if(1==dataType)//获得出租信息
			{
				RentTable rt = iRentDao.queryDesc(dataId);
				map.put("auditInfo", rt);
			}
			else if(2==dataType)//获得出售信息
			{
				SaleTable rt = iSaleDao.queryDesc(dataId);
				map.put("auditInfo", rt);
			}
			else if(3==dataType)//获得求租信息
			{
				DemandRentTable rt = iDemandRentDao.queryDesc(dataId);
				map.put("auditInfo", rt);
			}
			else if(4==dataType)//获得求购信息
			{
				DemandSaleTable rt = iDemandSaleDao.queryDesc(dataId);
				map.put("auditInfo", rt);
			}
			//获取拒绝原因
			List<BusRefuseReasonTable> brrts=iBusRefuseReasonDao.queryDescs(dataId);
			map.put("refuseReasons", brrts);

		   return map;
	}
	
	
	
	//2：查看各个类型的发布信息的方法，可以使用原来的查看发布的方法
	/**
	 * 获取各个类型的发布信息
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/AUDIT/BusAuditInfo/{id}",method={RequestMethod.GET})
	public Map<String,Object> getAuditInfo(@PathVariable Long id)
	{
 		    //id：我已发布信息的记录ID
		    Map<String, Object> map = new HashMap<String, Object>();
			BizExData bed=iBizExDataDao.getOne(id);
			Integer dataType=bed.getDataType();
			Long dataId=bed.getDataId();//发布信息的ID
			if(1==dataType)//获得出租信息
			{
				RentTable rt = iRentDao.queryDesc(dataId);
				map.put("auditInfo", rt);
			}
			else if(2==dataType)//获得出售信息
			{
				SaleTable rt = iSaleDao.queryDesc(dataId);
				map.put("auditInfo", rt);
			}
			else if(3==dataType)//获得求租信息
			{
				DemandRentTable rt = iDemandRentDao.queryDesc(dataId);
				map.put("auditInfo", rt);
			}
			else if(4==dataType)//获得求购信息
			{
				DemandSaleTable rt = iDemandSaleDao.queryDesc(dataId);
				map.put("auditInfo", rt);
			}
			//获取拒绝原因
			List<BusRefuseReasonTable> brrts=iBusRefuseReasonDao.queryDescs(dataId);
			map.put("refuseReasons", brrts);

		   return map;
	}
	//3：审批各个类型的发布信息的方法，和查看的方法类似，主要使显示对应的信息
	
	//4：批量审批各个类型的发布信息的方法，此方法单个审批通过的同样适用
	/**
	 * 批量审核/单个审核通过，是将所有的待审核的发布信息，全部审核通过
	 * @param busAuditInfoSearchBean
	 * @return
	 */
	@RequestMapping(value="/AUDIT/BusAuditInfo",method={RequestMethod.POST},params={"Action=Audits"})
	@Transactional
	public Map<String,String> audits(@RequestBody BusAuditInfoBean busAuditInfoBean)
	{
 		    //id：我已发布信息的记录ID
			Long dataIds[]=busAuditInfoBean.getDataIds();

			if(Util.isNotNullOrEmpty(dataIds))
			{
				BizDataState bds = new BizDataState();
				bds.setDataState(3);//3：审核通过
				for(int i=0;i<dataIds.length;i++)
				{
					Long id=dataIds[i];
					BizExData bed=iBizExDataDao.getOne(id);
					Integer dataType=bed.getDataType();
					Long dataId=bed.getDataId();//发布信息的ID
					if(1==dataType)//获得出租信息
					{
						RentTable rt = iRentDao.queryDesc(dataId);
						rt.setUpdateTime(new Date());
						rt.setDataState(bds);
						iRentDao.save(rt);
						
						EquipmentTable et = new EquipmentTable();
						//将设备的发布状态修改为出售发布中
						et = iEquipmentDao.queryDesc(rt.getEquipmentTable().getEquipmentId());
						Integer pubState = et.getPubState();
						if(Util.isNotNullOrEmpty(pubState) && 3==pubState)//如果已出售，则将状态修改为租售发布中 ，1：未发布、2：出租发布中、3：出售发布中、4：租售发布中
						{
							et.setPubState(4);
						}
						else
						{
							et.setPubState(2);
						}
						iEquipmentDao.save(et);
						
					}
					else if(2==dataType)//获得出售信息
					{
						SaleTable rt = iSaleDao.queryDesc(dataId);
						rt.setUpdateTime(new Date());
						rt.setDataState(bds);
						iSaleDao.save(rt);
						
						EquipmentTable et = new EquipmentTable();
						//将设备的发布状态修改为出售发布中
						et = iEquipmentDao.queryDesc(rt.getEquipmentTable().getEquipmentId());
						Integer pubState = et.getPubState();
						if(Util.isNotNullOrEmpty(pubState) && 2==pubState)//如果已出租，则将状态修改为租售发布中 ，1：未发布、2：出租发布中、3：出售发布中、4：租售发布中
						{
							et.setPubState(4);
						}
						else
						{
							et.setPubState(3);
						}
						iEquipmentDao.save(et);
					}
					else if(3==dataType)//获得求租信息
					{
						DemandRentTable rt = iDemandRentDao.queryDesc(dataId);
						rt.setUpdateTime(new Date());
						rt.setDataState(bds);
						iDemandRentDao.save(rt);
					}
					else if(4==dataType)//获得求购信息
					{
						DemandSaleTable rt = iDemandSaleDao.queryDesc(dataId);
						rt.setUpdateTime(new Date());
						rt.setDataState(bds);
						iDemandSaleDao.save(rt);
					}
				}
				
			}
			else
			{
				throw new IFException("我已发布信息不能为空！");
			}
			Map<String, String> map = new HashMap<String, String>();
			map.put("msg", "通过审核");
			return map;
	}
	
	//5：审批拒绝的方法
	@RequestMapping(value="/AUDIT/BusAuditInfo",method={RequestMethod.POST},params={"Action=AuditRefuse"})
	@Transactional
	public Map<String,String> auditRefuse(@RequestBody BusAuditInfoBean busAuditInfoBean)
	{/*拒绝表的结构待定*/
 		    //id：我已发布信息的记录ID
			Long dataIds[]=busAuditInfoBean.getDataIds();

			if(Util.isNotNullOrEmpty(dataIds))
			{
				BizDataState bds = new BizDataState();
				bds.setDataState(4);//4：审核拒绝
				for(int i=0;i<dataIds.length;i++)
				{
					Long id=dataIds[i];
					BizExData bed=iBizExDataDao.getOne(id);
					Integer dataType=bed.getDataType();
					Long dataId=bed.getDataId();//发布信息的ID
					if(1==dataType)//获得出租信息
					{
						RentTable rt = iRentDao.queryDesc(dataId);
						rt.setUpdateTime(new Date());
						rt.setDataState(bds);
						iRentDao.save(rt);
						
						EquipmentTable et = new EquipmentTable();
						//将设备的发布状态修改为未发布
						et = iEquipmentDao.queryDesc(rt.getEquipmentTable().getEquipmentId());
						et.setPubState(1);//审核不通过后将设备的发布状态自动修改为未发布
						iEquipmentDao.save(et);
					}
					else if(2==dataType)//获得出售信息
					{
						SaleTable rt = iSaleDao.queryDesc(dataId);
						rt.setUpdateTime(new Date());
						rt.setDataState(bds);
						iSaleDao.save(rt);
						
						EquipmentTable et = new EquipmentTable();
						//将设备的发布状态修改为未发布
						et = iEquipmentDao.queryDesc(rt.getEquipmentTable().getEquipmentId());
						et.setPubState(1);//审核不通过后将设备的发布状态自动修改为未发布
						iEquipmentDao.save(et);
					}
					else if(3==dataType)//获得求租信息
					{
						DemandRentTable rt = iDemandRentDao.queryDesc(dataId);
						rt.setUpdateTime(new Date());
						rt.setDataState(bds);
						iDemandRentDao.save(rt);
					}
					else if(4==dataType)//获得求购信息
					{
						DemandSaleTable rt = iDemandSaleDao.queryDesc(dataId);
						rt.setUpdateTime(new Date());
						rt.setDataState(bds);
						iDemandSaleDao.save(rt);
					}
					Integer[] reasonIds=busAuditInfoBean.getReasonIds();
					String[] reasonNotes=busAuditInfoBean.getReasonNotes();
					BusRefuseReasonTable brrt=null;
					for(int j=0;j<reasonIds.length;j++)
					{
						brrt= new BusRefuseReasonTable();
						brrt.setDataId(dataId);
						brrt.setReasonId(reasonIds[j]);
						brrt.setReasonNote(reasonNotes[j]);
						iBusRefuseReasonDao.save(brrt);
					}
				}
				
			}
			else
			{
				throw new IFException("我已发布信息不能为空！");
			}
			Map<String, String> map = new HashMap<String, String>();
			map.put("msg", "审批拒绝成功！");
			return map;
	}
	//6：审批删除的方法
	/**
	 *将对应审核状态修改为删除，然后将出租、出售的设备信息修改为未发布
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/AUDIT/BusAuditInfo/{id}",method={RequestMethod.DELETE})
	@Transactional
	public Map<String, String> busAuditInfoDel(@PathVariable Long id)
	{
		// id：我已发布信息的记录ID
		BizExData bed=iBizExDataDao.getOne(id);
		Integer dataType=bed.getDataType();
		Long dataId=bed.getDataId();//发布信息的ID

		BizDataState bds = new BizDataState();
		bds.setDataState(5);//5：审核删除
		
		if(1==dataType)//修改出租信息
		{
			RentTable rt = iRentDao.queryDesc(dataId);
			rt.setUpdateTime(new Date());
			rt.setDataState(bds);
			iRentDao.save(rt);
			
			EquipmentTable et = iEquipmentDao.queryDesc(rt.getEquipmentTable().getEquipmentId());
			et.setPubState(1);//设置资源的发布状态为未发布
			iEquipmentDao.save(et);
		}
		else if(2==dataType)//修改出售信息
		{
			SaleTable st = iSaleDao.queryDesc(dataId);
			st.setUpdateTime(new Date());
			st.setDataState(bds);
			iSaleDao.save(st);
			
			EquipmentTable et = iEquipmentDao.queryDesc(st.getEquipmentTable().getEquipmentId());
			et.setPubState(1);//设置资源的发布状态为未发布
			iEquipmentDao.save(et);
		}
		else if(3==dataType)//修改求租信息
		{
			DemandRentTable drt = iDemandRentDao.queryDesc(dataId);
			drt.setUpdateTime(new Date());
			drt.setDataState(bds);
			iDemandRentDao.save(drt);
		}
		else if(4==dataType)//修改求购信息
		{
			DemandSaleTable srt = iDemandSaleDao.queryDesc(dataId);
			srt.setUpdateTime(new Date());
			srt.setDataState(bds);
			iDemandSaleDao.save(srt);
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "删除成功");
		return map;
	}	
	/**
	 *将对应的已发布的信息逻辑删除，然后将出租、出售的设备信息修改为未发布
	 * @param id
	 * @return
	 */
//	@RequestMapping(value="/AUDIT/BusAuditInfo/{id}",method={RequestMethod.DELETE})
//	@Transactional
//	public Map<String, String> busAuditInfoDel(@PathVariable Long id)
//	{
//		// id：我已发布信息的记录ID
//		BizExData bed=iBizExDataDao.getOne(id);
//		Integer dataType=bed.getDataType();
//		Long dataId=bed.getDataId();//发布信息的ID
//
//		if(1==dataType)//修改出租信息
//		{
//			RentTable rt = iRentDao.queryDesc(dataId);
//			rt.setUpdateTime(new Date());
//			rt.setOperateFlag(1);
//			iRentDao.save(rt);
//			
//			EquipmentTable et = iEquipmentDao.queryDesc(rt.getEquipmentTable().getEquipmentId());
//			et.setPubState(1);//设置资源的发布状态为未发布
//			iEquipmentDao.save(et);
//		}
//		else if(2==dataType)//修改出售信息
//		{
//			SaleTable st = iSaleDao.queryDesc(dataId);
//			st.setUpdateTime(new Date());
//			st.setOperateFlag(1);
//			iSaleDao.save(st);
//			
//			EquipmentTable et = iEquipmentDao.queryDesc(st.getEquipmentTable().getEquipmentId());
//			et.setPubState(1);//设置资源的发布状态为未发布
//			iEquipmentDao.save(et);
//		}
//		else if(3==dataType)//修改求租信息
//		{
//			DemandRentTable drt = iDemandRentDao.queryDesc(dataId);
//			drt.setUpdateTime(new Date());
//			drt.setOperateFlag(1);
//			iDemandRentDao.save(drt);
//		}
//		else if(4==dataType)//修改求购信息
//		{
//			DemandSaleTable srt = iDemandSaleDao.queryDesc(dataId);
//			srt.setUpdateTime(new Date());
//			srt.setOperateFlag(1);
//			iDemandSaleDao.save(srt);
//		}
//		Map<String, String> map = new HashMap<String, String>();
//		map.put("msg", "删除成功");
//		return map;
//	}
	
}
