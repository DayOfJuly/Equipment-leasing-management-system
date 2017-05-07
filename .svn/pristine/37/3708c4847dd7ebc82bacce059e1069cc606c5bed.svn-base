package com.hjd.action;

import java.math.BigDecimal;
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
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.BusDepreciationHistBean;
import com.hjd.action.bean.BusDepreciationHistBeanTemp;
import com.hjd.action.bean.BusDepreciationHistSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IBusDepreciationHistDao;
import com.hjd.dao.IEquipmentDao;
import com.hjd.domain.BusDepreciationHistTable;
import com.hjd.domain.EquipmentTable;

@RestController
public class BusDepreciationHistAction extends BaseAction{
	
	@Autowired
	IBusDepreciationHistDao iBusDepreciationHistDao;
	@Autowired
	IEquipmentDao iEquipmentDao;
	/*设备折旧费登记相关++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
	//1：查询设备信息，注意是根据设备所在的单位查询的，默认是当前登录人所在的单位，也可以选择当前登录人的下级单位的设备（关键是：所有下级的，企业、员工、项目等等都有此要求）
	/**
	 * 查询资源设备折旧费登记的结果集，一个设备可以多次登记，不过每个月只能登记一次
	 * @param busDepreciationHistSearchBean
	 * @return
	 */
	@RequestMapping(value="/BG/DepreciationHist",method={RequestMethod.POST})
	public Page<?> queryAll(@RequestBody BusDepreciationHistSearchBean busDepreciationHistSearchBean)
	{
		return iBusDepreciationHistDao.queryAll(busDepreciationHistSearchBean);//这里使用的是原生的SQL语句，原因在于拼视图的时候，对应的主键没有值，使用联合主键有比较麻烦
	}
	
	//2：保存折旧费信息
	/**
	 * 如果某个资源设备对应的某个月份没有登记就登记，如果登记过了就修改，这个方法，就是添加的方法有时修改的方法
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/BG/DepreciationHist",method={RequestMethod.POST},params={"Action=AddOrUpd"})
	@Transactional
	public Map<String, String> busDealInfoDel(@RequestBody BusDepreciationHistBean busDepreciationHistBean)
	{
		   String month_=busDepreciationHistBean.getMonth_();//折旧费登记的月份
		   List<BusDepreciationHistBeanTemp> bdhbtList=busDepreciationHistBean.getBdhbtList();//租赁登记信息的集合
		   for(int i=0;i<bdhbtList.size();i++)
		   {
			   BusDepreciationHistBeanTemp bdhbt=bdhbtList.get(i);
			   BusDepreciationHistTable bdhtTemp_ = new BusDepreciationHistTable();
			   bdhbt.copyPropertyToDestBean(bdhtTemp_);
			   Long id_=bdhtTemp_.getId();
			   //id：存在就修改，否者就添加新的设备的折旧费，当然，添加的时候需要判断一下同一个设备同一个月份是否已经登记过了，如果登记过了就不再登记了
			   BigDecimal depreciation = bdhtTemp_.getDepreciation()==null?BigDecimal.ZERO:bdhtTemp_.getDepreciation();
			   if(id_!=null)
			   {
					BusDepreciationHistTable bdht = iBusDepreciationHistDao.queryDesc(id_);
					
					BigDecimal oldDepreciation = bdht.getDepreciation()==null?BigDecimal.ZERO:bdht.getDepreciation();
					
				   //当前登记月份内第n(n>1)次登记折旧费，则首先从累计折旧费中减去n-1次的折旧费，然后再加上第n次的折旧费
				   EquipmentTable et= iEquipmentDao.queryDesc(bdhtTemp_.getEquipmentId());
				   BigDecimal totalDepreciation = et.getTotalDepreciation();
				   totalDepreciation = totalDepreciation==null?BigDecimal.ZERO:totalDepreciation;

				   totalDepreciation=totalDepreciation.subtract(oldDepreciation);//两个BigDecimal类型的数相减
				   
				   BigDecimal totalDepreciationTemp = totalDepreciation.add(depreciation);//两个BigDecimal类型的数相加
				   
				   totalDepreciationTemp = totalDepreciationTemp.divide(new BigDecimal(10000),6,BigDecimal.ROUND_HALF_UP);//将“元”变成“万元”，保留六位小数点
				   et.setTotalDepreciation(totalDepreciationTemp);
				
				   iEquipmentDao.save(et);
				   
					bdht.setDepreciation(depreciation);
					iBusDepreciationHistDao.save(bdht);
			   }
			   else
			   {
				   BusDepreciationHistTable bdht = iBusDepreciationHistDao.queryByEquIdAndMonth(bdhtTemp_.getEquipmentId(), month_);
				   if(bdht!=null){throw new IFException("此设备"+month_+"月的折旧费已经登记过了！");}
				   
				   BusDepreciationHistTable bdht_ = new BusDepreciationHistTable();
				   bdht_.setDepreciation(bdhtTemp_.getDepreciation());
				   bdht_.setMonth(month_);
				   bdht_.setEquipmentId(bdhtTemp_.getEquipmentId());
				   
				   //当前登记月份内第一次登记折旧费，则将折旧费直接累计到设备的累计折旧费中
				   EquipmentTable et= iEquipmentDao.queryDesc(bdhtTemp_.getEquipmentId());
				   BigDecimal depreciation_ = et.getTotalDepreciation()==null ? BigDecimal.ZERO : et.getTotalDepreciation();
				   BigDecimal totalDepreciationTemp = depreciation_ .add(depreciation);//两个BigDecimal类型的数相加
				   
				   totalDepreciationTemp = totalDepreciationTemp.divide(new BigDecimal(10000),6,BigDecimal.ROUND_HALF_UP);//将“元”变成“万元”，保留六位小数点
				   et.setTotalDepreciation(totalDepreciationTemp);
				   iEquipmentDao.save(et);
				   
				   iBusDepreciationHistDao.save(bdht_);
			   }
		   }
			Map<String, String> map = new HashMap<String, String>();
			map.put("msg", "保存成功");
			return map;
	}
	
	/**外部供应商，设备折旧费登记相关++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
	//1：查询设备信息，注意是根据设备所在的单位查询的，默认是当前登录人所在的单位
	/**
	 * 查询资源设备折旧费登记的结果集，一个设备可以多次登记，不过每个月只能登记一次
	 * @param busDepreciationHistSearchBean
	 * @return
	 */
	@RequestMapping(value="/BG/DepreciationHist",method={RequestMethod.POST},params={"Action=Provider"})
	public Page<?> queryAllProvider(@RequestBody BusDepreciationHistSearchBean busDepreciationHistSearchBean,HttpSession httpSession)
	{
		//从Session中获取对应的用户信息
	    Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
		busDepreciationHistSearchBean.setOrgId((Long)userMap.get("orgId"));
//		busDepreciationHistSearchBean.setOrgId(Long.parseLong("316")); //用于压力测试，测试完毕需要恢复
		return iBusDepreciationHistDao.queryAllProvider(busDepreciationHistSearchBean);//这里使用的是原生的SQL语句，原因在于拼视图的时候，对应的主键没有值，使用联合主键有比较麻烦
	}
}
