package com.hjd.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.CategorySearchBean;
import com.hjd.action.bean.EquipmentBean;
import com.hjd.base.BaseAction;
import com.hjd.dao.IBusEquNameManageDao;
import com.hjd.domain.EquNameManageTable;
import com.hjd.domain.ViewEquName;
import com.hjd.util.Util;


@RestController
public class BusEquNameManageAction extends BaseAction{
	
	@Autowired
	IBusEquNameManageDao iBusEquNameManageDao;
	
	/**
	 * 获取热词搜索频率最高的记录集
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=SearchHotWords"})
	public Page<?> searhHotEquName(@RequestParam Map<?, ?> reqParamsMap){
		//传递分页参数的载体
		Integer pageNo = 0;
		Integer pageSize = 5;
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
		listSql.append("FROM EquNameManageTable  obj ");
		listSql.append("WHERE 1=1 ");
		
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM EquNameManageTable obj ");		
		countSql.append("WHERE 1=1 ");
		
		listSql.append(" ORDER BY obj.searchCount DESC ");
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas;	
	}
	/**
	 * 判断搜索的热词是否在三百三十三个设备小类中，如果是更新热词搜索的次数
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=UpdHotWordCount"})
	@Transactional
	public Map<String, String> updEquName(@RequestParam Map<?, ?> reqParamsMap){
		String hw=(String)reqParamsMap.get("hotWord");
		Map<String, String> map = new HashMap<String, String>();
		String updResult="update_fail";
		if(Util.isNotNullOrEmpty(hw))
		{
			String[] properties ={"searchCount"};
			Sort sort=new Sort(Direction.DESC,properties);
			List<EquNameManageTable> list=iBusEquNameManageDao.findAll(sort);
			EquNameManageTable enmt=new EquNameManageTable();
			for(int i=0;i<list.size();i++)
			{
				enmt=list.get(i);
				if(Util.isNotNullOrEmpty(enmt.getEquipmentName()) && hw.indexOf(enmt.getEquipmentName())>-1)
				{
					enmt.setSearchCount((enmt.getSearchCount()+1));
					update(enmt);
					updResult="update_success";
					break;
				}
			}
		}
		map.put("msg", updResult);
		return map;
	}

	/**
	 * 判断搜索的热词是否在三百三十三个设备小类中，如果是将其加入最近搜索之中
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=RecentSearch"})
	@Transactional
	public Map<String, String> searchEquName(@RequestParam Map<?, ?> reqParamsMap){
		String hw=(String)reqParamsMap.get("hotWord");
		Map<String, String> map = new HashMap<String, String>();
		String searchResult="FALSE";
		if(Util.isNotNullOrEmpty(hw))
		{
			String[] properties ={"searchCount"};
			Sort sort=new Sort(Direction.DESC,properties);
			List<EquNameManageTable> list=iBusEquNameManageDao.findAll(sort);
			EquNameManageTable enmt=new EquNameManageTable();
			for(int i=0;i<list.size();i++)
			{
				enmt=list.get(i);
				if(Util.isNotNullOrEmpty(enmt.getEquipmentName()) && hw.indexOf(enmt.getEquipmentName())>-1)
				{
					searchResult="TRUE";
					break;
				}
			}
		}
		map.put("msg", searchResult);
		return map;
	}
	
	/**
	 * 根据英文字母查询设备名称首字母相匹配的结果集
	 * @param equipmentBean
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.POST},params={"Action=EquNameFpy"})
	public Map<String, Object> searchEquNameFpy(@RequestBody EquipmentBean equipmentBean){
		String [] fpy=equipmentBean.getFpy();
		Map<String,Object> map = new HashMap<String, Object>();
		if(fpy!=null && fpy.length>0)
		{
			for(int i=0;i<fpy.length;i++)
			{
				List<ViewEquName> list=iBusEquNameManageDao.queryEquNameByFpy(fpy[i]);
				map.put(fpy[i], list);
			}
		}
		return map;
	}

	/**
	 * 根据设备名称模糊查询相匹配的结果
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.POST},params={"Action=EquNameLike"})
	public Map<String, Object> searchEquNameLike(@RequestBody CategorySearchBean categorySearchBean){

		String equipmentName = categorySearchBean.getEquipmentName();

		Map<String,Object> map = new HashMap<String, Object>();

		map.put("list", iBusEquNameManageDao.queryEquNameByLike("%" + equipmentName + "%"));

		return map;
		}

	}
