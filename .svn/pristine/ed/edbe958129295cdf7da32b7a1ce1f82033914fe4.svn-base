package com.hjd.action;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.BusPublishInfoSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IBizExDataDao;
import com.hjd.dao.IBusPublishInfoDao;
import com.hjd.dao.IDemandRentDao;
import com.hjd.dao.IDemandSaleDao;
import com.hjd.dao.IEquipmentDao;
import com.hjd.dao.IRentDao;
import com.hjd.dao.ISaleDao;
import com.hjd.domain.BizExData;
import com.hjd.domain.BusPublishInfoTable;
import com.hjd.domain.DemandRentTable;
import com.hjd.domain.DemandSaleTable;
import com.hjd.domain.EquipmentTable;
import com.hjd.domain.RentTable;
import com.hjd.domain.SaleTable;
import com.hjd.util.Util;

@RestController
public class BusPublishInfoAction extends BaseAction{
	@Autowired
	IRentDao iRentDao;
	@Autowired
	ISaleDao iSaleDao;
	@Autowired
	IDemandRentDao iDemandRentDao;
	@Autowired
	IDemandSaleDao iDemandSaleDao;
	@Autowired
	IBusPublishInfoDao iBusPublishInfoDao;
	@Autowired
	IEquipmentDao iEquipmentDao;
	@Autowired
	IBizExDataDao iBizExDataDao;
/*我已发布的信息++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/	
	
	/*0：添加我已发布的信息，是在发布信息的时候来做的，分别在添加出租、出售、求租、求购信息时来产生的*/
	
	/*1：查看我已发布的信息*/
	/**
	 * 查询对应的视图，获取当前登录人我已发布的信息
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/BG/BusPublishInfo",method={RequestMethod.POST})
	public Page<?> queryAll(@RequestBody BusPublishInfoSearchBean busPublishInfoSearchBean,HttpSession httpSession)
	{
		return iBusPublishInfoDao.queryAll(busPublishInfoSearchBean, httpSession);	
	}
	
	/*2：刷新我已发布的信息*/
	/**
	 * 主要是为了修改发布时间，以便将对应的记录信息往上提高位置，可能存在修改四种发布信息的情况，另外也需要更新我已发布信息表的操作时间
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/BG/BusPublishInfo",method={RequestMethod.GET})
	@Transactional
	public Map<String, String> rusPublishInfoRefresh(@RequestParam Map<?, ?> reqParamsMap)
	{
 		    //id：我已发布信息的记录ID
			Long id=Long.valueOf((String)reqParamsMap.get("id"));
			if(Util.isNotNullOrEmpty(id))
			{
				BusPublishInfoTable bpit = iBusPublishInfoDao.queryDesc(id);
				bpit.setOperateDate(new Date());
				iBusPublishInfoDao.save(bpit);
				
				BizExData bed=iBizExDataDao.getOne(bpit.getDataId());
				Integer dataType=bed.getDataType();
				Long dateId=bed.getDataId();//发布信息的ID
				
				if(1==dataType)//修改出租信息
				{
					RentTable rt = iRentDao.queryDesc(dateId);
					rt.setReleaseDate(new Date());
					rt.setUpdateTime(new Date());
					iRentDao.save(rt);
				}
				else if(2==dataType)//修改出售信息
				{
					SaleTable rt = iSaleDao.queryDesc(dateId);
					rt.setReleaseDate(new Date());
					rt.setUpdateTime(new Date());
					iSaleDao.save(rt);
				}
				else if(3==dataType)//修改求租信息
				{
					DemandRentTable rt = iDemandRentDao.queryDesc(dateId);
					rt.setReleaseDate(new Date());
					rt.setUpdateTime(new Date());
					iDemandRentDao.save(rt);
				}
				else if(4==dataType)//修改求购信息
				{
					DemandSaleTable rt = iDemandSaleDao.queryDesc(dateId);
					rt.setReleaseDate(new Date());
					rt.setUpdateTime(new Date());
					iDemandSaleDao.save(rt);
				}
			}
			else
			{
				throw new IFException("我已发布信息不能为空！");
			}
			Map<String, String> map = new HashMap<String, String>();
			map.put("msg", "刷新成功.");
			return map;
	}
	/*3：修改我已发布的信息，直接进入对应的发布修改的页面，调用原有的修改的方法*/
	
	/*4：删除我已发布的信息*/
	/**
	 * 将对应的已发布的信息逻辑删除，然后将出租、出售的设备信息修改为未发布，最后将我已发布的信息也逻辑
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/BG/BusPublishInfo/{id}",method={RequestMethod.DELETE})
	@Transactional
	public Map<String, String> busPublishInfoDel(@PathVariable Long id)
	{
		// id：我已发布信息的记录ID

		BusPublishInfoTable bpit = iBusPublishInfoDao.queryDesc(id);
		bpit.setOperateDate(new Date());
		bpit.setOperateFlag(1);//删除我已发布的信息，0：正常（添加我已发布的信息时默认添加），1：删除
		iBusPublishInfoDao.save(bpit);
		
		BizExData bed=iBizExDataDao.getOne(bpit.getDataId());
		//信息类型
		Integer dataType=bed.getDataType();
		Long dateId=bed.getDataId();//发布信息的ID

		if(1==dataType)//修改出租信息
		{
			RentTable rt = iRentDao.queryDesc(dateId);
			rt.setUpdateTime(new Date());
			rt.setOperateFlag(1);
			iRentDao.save(rt);
			Long equipmentId=rt.getEquipmentTable().getEquipmentId();
			EquipmentTable et = iEquipmentDao.queryDesc(equipmentId);
			et.setPubState(1);//设置资源的发布状态为未发布
			iEquipmentDao.save(et);
		}
		else if(2==dataType)//修改出售信息
		{
			SaleTable st = iSaleDao.queryDesc(dateId);
			st.setUpdateTime(new Date());
			st.setOperateFlag(1);
			iSaleDao.save(st);
			Long equipmentId=st.getEquipmentTable().getEquipmentId();
			EquipmentTable et = iEquipmentDao.queryDesc(equipmentId);
			et.setPubState(1);//设置资源的发布状态为未发布
			iEquipmentDao.save(et);
		}
		else if(3==dataType)//修改求租信息
		{
			DemandRentTable drt = iDemandRentDao.queryDesc(dateId);
			drt.setUpdateTime(new Date());
			drt.setOperateFlag(1);
			iDemandRentDao.save(drt);
		}
		else if(4==dataType)//修改求购信息
		{
			DemandSaleTable srt = iDemandSaleDao.queryDesc(dateId);
			srt.setUpdateTime(new Date());
			srt.setOperateFlag(1);
			iDemandSaleDao.save(srt);
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "删除成功.");
		return map;
	}
}
