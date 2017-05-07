package com.hjd.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.hjd.action.bean.BusEquParameterBean;
import com.hjd.action.bean.BusEquParameterSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IBusEquNameParameterDao;
import com.hjd.dao.IBusEquParameterDao;
import com.hjd.domain.BusEquNameParameterTable;
import com.hjd.domain.BusEquParameterTable;
import com.hjd.domain.EquNameManageTable;
import com.hjd.util.Util;
import com.hjd.util.pinyin.PinyinUtil;

@RestController
public class BusEquParameterAction extends BaseAction{
	
	/**
	 * 设备参数的DAO
	 */
	@Autowired
	IBusEquParameterDao iBusEquParameterDao;
	/**
	 * 设备小类名称和设备参数关系的DAO
	 */
	@Autowired
	IBusEquNameParameterDao iBusEquNameParameterDao;
	
	@Value("${tmpInfoFilePath}")
	String tmpInfoFilePath="";
	
	@Value("${realInfofilePath}")
	String realInfofilePath="";
	/**
	 * 查询设备参数列表，根据设备参数的类型
	 * @author Qian
	 * @return Page 
	 * @param reqParamsMap
	 * @since 2016-08-03
	 */
	@RequestMapping(value="/BG/BusEquParameter",method={RequestMethod.GET})
	public Page<?> queryBusEquParameter(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		BusEquParameterSearchBean pageParams = new BusEquParameterSearchBean();
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageParams.setPageNo(Integer.valueOf((String)reqParamsMap.get("pageNo")));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageParams.setPageSize(Integer.valueOf((String)reqParamsMap.get("pageSize")));
		}
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT obj ");
		listSql.append("FROM BusEquParameterTable  obj ");
		listSql.append("WHERE 1=1 ");
	    
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM BusEquParameterTable obj ");		
		countSql.append("WHERE 1=1 ");
		
		//根据设备参数的状态查询，0：删除，1：正常
		String status=(String)reqParamsMap.get("status"); 
		if(Util.isNotNullOrEmpty(status))
		{
			Integer status_=Integer.valueOf(status);
			sqlParamsMap.put("status",status_);
			listSql.append(" AND ( obj.status = :status)");
			countSql.append(" AND ( obj.status = :status)");
		}		
		//根据设备参数的类型查询，1：品牌，2：生产厂家，3：型号，4：规格
		String type=(String)reqParamsMap.get("type");
		if(Util.isNotNullOrEmpty(type))
		{
			Integer type_=Integer.valueOf(type);
			sqlParamsMap.put("type",type_);
			listSql.append(" AND ( obj.type = :type)");
			countSql.append(" AND ( obj.type = :type)");
		}
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageParams.getPageRequest());
		
		return datas;	
	}
	/**
	 * 添加设备的参数，根据类型添加不同的设备参数，比如：生产厂家、品牌
	 * @author Qian
	 * @return Map 
	 * @param busEquParameterBean
	 * @since 2016-08-03
	 */
	@RequestMapping(value="/BG/BusEquParameter",method={RequestMethod.PUT})
	@Transactional
	public BusEquParameterTable add(@RequestBody BusEquParameterBean busEquParameterBean)
	{
		BusEquParameterTable busEquParameterTable = new BusEquParameterTable();
		busEquParameterBean.copyPropertyToDestBean(busEquParameterTable);
		
		//将设备参数的名称转换为汉语拼音，全部大写，取每个汉字的第一个首字母的拼音
		busEquParameterTable.setNamePy(PinyinUtil.getUpperCaseShortPinyin(busEquParameterTable.getName()));
		busEquParameterTable.setStatus(1);
		busEquParameterTable=(BusEquParameterTable)iBusEquParameterDao.save(busEquParameterTable);
		return busEquParameterTable;
	}
	/**
	 * 删除设备参数，根据设备参数的ID来删除，是逻辑删除
	 * @author Qian
	 * @return Map 
	 * @param parameterId
	 * @since 2016-08-03
	 */
	@RequestMapping(value="/BG/BusEquParameter/{parameterId}",method={RequestMethod.DELETE})
	@Transactional
	public Map<String, String> del(@PathVariable Long parameterId)
	{
		//逻辑删除，修改记录的标识，要先查询对应的记录，然后再修改状态
		BusEquParameterTable busEquParameterTable=iBusEquParameterDao.queryByParameterId(parameterId);
		busEquParameterTable.setStatus(0);
		iBusEquParameterDao.save(busEquParameterTable);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "删除成功.");
		return map;
	}
	/**
	 * 添加设备参数和设备小类的关系，注意：这一功能的逻辑有点复杂，添加的时候需要先判断是否有，如果没有才添加，另外就是型号、规格是可以手输的，当手输
	 * @author Qian
	 * @return Map 
	 * @param busEquParameterBean
	 * @since 2016-08-03
	 */
	@RequestMapping(value="/BG/BusEquParameter",method={RequestMethod.PUT},params={"action=ADD_BUS_EQU_PARAMETER"})
	@Transactional
	public Map<String, String> addBusEquParameter(@RequestBody BusEquParameterBean busEquParameterBean)
	{
		//如果设备小类的ID不为空，则先将小类放入关系对象之中
		Integer equNameId=busEquParameterBean.getEquNameId();
		if(Util.isNullOrEmpty(equNameId)){throw new IFException("设备小类的ID不能为空");}
		//生产厂家
		if(Util.isNotNullOrEmpty(busEquParameterBean.getManufactruerId()))
		{
			addBusEquParameter(equNameId,busEquParameterBean.getManufactruerId());
		}
		//品牌
		if(Util.isNotNullOrEmpty(busEquParameterBean.getBrandId()))
		{
			addBusEquParameter(equNameId,busEquParameterBean.getBrandId());
			//将图片从临时目录移动到真实目录
			if(Util.isNotNullOrEmpty(busEquParameterBean.getLogoPic())){
				String[] fileNames = busEquParameterBean.getLogoPic().split(",");
				Util.copyFileToRealPath(tmpInfoFilePath, realInfofilePath, fileNames);
			}
		}
		//规格
		if(Util.isNotNullOrEmpty(busEquParameterBean.getStandardId()))
		{
			addBusEquParameter(equNameId,busEquParameterBean.getStandardId());
		}
		else if(Util.isNotNullOrEmpty(busEquParameterBean.getStandardName()))
		{
			BusEquParameterBean busEquParameterBean_ = new BusEquParameterBean();
			busEquParameterBean_.setType(4);
			busEquParameterBean_.setName(busEquParameterBean.getStandardName());
			//如果手工填写的规格名称已经存在了，则不插入一条新的规格数据，否则插入一条新的规格数据
			List<BusEquParameterTable> bepList= iBusEquParameterDao.queryByEquName(1, busEquParameterBean_.getType(), busEquParameterBean_.getName());
			if(bepList!=null && bepList.size()>0)
			{
				addBusEquParameter(equNameId,bepList.get(0).getParameterId());
			}
			else
			{
				BusEquParameterTable busEquParameterTable_ = add(busEquParameterBean_);
				addBusEquParameter(equNameId,busEquParameterTable_.getParameterId());
			}
		}
		//型号
		if(Util.isNotNullOrEmpty(busEquParameterBean.getModelId()))
		{
			addBusEquParameter(equNameId,busEquParameterBean.getModelId());
		}
		else if(Util.isNotNullOrEmpty(busEquParameterBean.getModelName()))
		{
			BusEquParameterBean busEquParameterBean_ = new BusEquParameterBean();
			busEquParameterBean_.setType(3);
			busEquParameterBean_.setName(busEquParameterBean.getModelName());
			
			//如果手工填写的型号名称已经存在了，则不插入一条新的型号数据，否则插入一条新的型号数据
			List<BusEquParameterTable> bepList= iBusEquParameterDao.queryByEquName(1, busEquParameterBean_.getType(), busEquParameterBean_.getName());
			if(bepList!=null && bepList.size()>0)
			{
				addBusEquParameter(equNameId,bepList.get(0).getParameterId());
			}
			else
			{
				BusEquParameterTable busEquParameterTable_ = add(busEquParameterBean_);
				addBusEquParameter(equNameId,busEquParameterTable_.getParameterId());
			}

		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "添加成功.");
		return map;
	}
	
	/**
	 * 根据设备小类的来查询设备参数的集合
	 * @author Qian
	 * @return Page 
	 * @param reqParamsMap
	 * @since 2016-08-08
	 */
	@RequestMapping(value="/BG/BusEquParameter",method={RequestMethod.GET},params={"action=GET_BUS_EQU_NAME_PARAMETER"})
	public Page<?> queryBusEquNameParameter(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		BusEquParameterSearchBean pageParams = new BusEquParameterSearchBean();
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageParams.setPageNo(Integer.valueOf((String)reqParamsMap.get("pageNo")));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageParams.setPageSize(Integer.valueOf((String)reqParamsMap.get("pageSize")));
		}
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append(" SELECT obj ");
		listSql.append(" FROM ViewEquNameParameter obj ");
		listSql.append(" WHERE 1=1 ");
	    
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append(" SELECT count(1) "); 
		countSql.append(" FROM ViewEquNameParameter obj ");
		countSql.append(" WHERE 1=1 ");
		
		//根据设备参数的状态查询，0：删除，1：正常
		String status=(String)reqParamsMap.get("status"); 
		if(Util.isNotNullOrEmpty(status))
		{
			Integer status_=Integer.valueOf(status);
			sqlParamsMap.put("status",status_);
			listSql.append(" AND (obj.status = :status)");
			countSql.append(" AND ( obj.status = :status)");
		}		
		//根据设备参数的类型查询，1：品牌，2：生产厂家，3：型号，4：规格
		String type=(String)reqParamsMap.get("type");
		if(Util.isNotNullOrEmpty(type))
		{
			Integer type_=Integer.valueOf(type);
			sqlParamsMap.put("type",type_);
			listSql.append(" AND ( obj.type = :type)");
			countSql.append(" AND ( obj.type = :type)");
		}
		//根据设备小类的名称关联查询出品牌、生产厂家、型号、规则的集合信息
		String equNameId=(String)reqParamsMap.get("equNameId");
		if(Util.isNotNullOrEmpty(equNameId))
		{
			Integer equNameId_=Integer.valueOf(equNameId);
			sqlParamsMap.put("equNameId",equNameId_);
			listSql.append(" AND ( obj.equNameId = :equNameId)");
			countSql.append(" AND ( obj.equNameId = :equNameId)");
		}
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageParams.getPageRequest());
		
		return datas;	
	}
	
	
	/**
	 * 根据设备参数名称的英文字母来查询对应的设备参数的集合
	 * @author Qian
	 * @return Page 
	 * @param reqParamsMap
	 * @since 2016-08-15
	 */
	@RequestMapping(value="/BG/BusEquParameter",method={RequestMethod.GET},params={"action=GET_BUS_EQU_PARAMETERS"})
	public List<BusEquParameterTable> queryBusEquParameterByNamePy(@RequestParam Map<?, ?> reqParamsMap)
	{
		//根据设备参数的状态查询，0：删除，1：正常
		String status=(String)reqParamsMap.get("status"); 
		verifyNotEmpty(status,"单位编码");
		//根据设备参数的类型查询，1：品牌，2：生产厂家，3：型号，4：规格
		String type=(String)reqParamsMap.get("type");
		verifyNotEmpty(status,"单位编码");
		//根据设备小类的名称关联查询出品牌、生产厂家、型号、规则的集合信息
		String namePy=(String)reqParamsMap.get("namePy");
		verifyNotEmpty(status,"单位编码");
		
		Integer status_=Integer.valueOf(status);
		Integer type_=Integer.valueOf(type);

		return  iBusEquParameterDao.queryByEquNamePy(status_, type_, namePy+"%");
	}
	
	
	/**
	 * 添加设备小类和设备参数的关系，工具方法
	 * @author Qian
	 * @return Map 
	 * @param equNameId
	 * @param parameterId
	 * @since 2016-08-03
	 */
	private void addBusEquParameter(Integer equNameId,Long parameterId)
	{
		List<BusEquNameParameterTable> busEquNameParameterList = null;
		busEquNameParameterList = iBusEquParameterDao.queryByEquNameIdAndParameterId(equNameId, parameterId,1);
		if(null==busEquNameParameterList || busEquNameParameterList.size()<=0)
		{
			EquNameManageTable equNameManageTable = new EquNameManageTable();
			equNameManageTable.setEquNameId(equNameId);
			
			BusEquParameterTable busEquParameterTable = new BusEquParameterTable();
			busEquParameterTable.setParameterId(parameterId);
			
			BusEquNameParameterTable busEquNameParameterTable = new BusEquNameParameterTable();
			busEquNameParameterTable.setEquName(equNameManageTable);
			busEquNameParameterTable.setEquParameter(busEquParameterTable);
			
			iBusEquNameParameterDao.save(busEquNameParameterTable);
		}
	}
	
	/**
	 * 根据类型和名称添加，工具方法
	 * @author Qian
	 * @return Map 
	 * @param type
	 * @param name
	 * @since 2016-08-03
	 */
//	private void addBusEquParameter(Integer type,String name)
//	{
//
//	}
}
