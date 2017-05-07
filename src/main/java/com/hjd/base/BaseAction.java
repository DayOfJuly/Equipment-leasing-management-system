package com.hjd.base;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;

import com.hjd.dao.IPartyOrgDao;
import com.hjd.dao.IPartyRegionDao;
import com.hjd.dao.IPartyRegionRelationDao;
import com.hjd.domain.PartyOrg;
import com.hjd.domain.PartyRegion;
import com.hjd.domain.PartyRegionRelation;
import com.hjd.domain.PartyRegionRelationType;
import com.hjd.service.CommonSvc;
import com.hjd.util.Util;

public class BaseAction {
	@Autowired
	private CommonSvc commonSvc;
	@Autowired
	private IPartyRegionRelationDao partyRegionRelationDao;
	@Autowired
	private IPartyRegionDao partyRegionDao;
	@Autowired
	IPartyOrgDao partyOrgDao;

	protected List queryListByNative(String nativeSql, Map<String, ?> paramsMap) {

		return commonSvc.queryAllByNative(nativeSql, paramsMap);
	}

	protected Integer queryCountByNative(String nativeSql, Map<String, ?> paramsMap) {

		return commonSvc.queryCountByNative(nativeSql, paramsMap);
	}

	protected <T> T insert(T bean) {

		return commonSvc.commonSave(bean);
		}

	protected <T> T update(IDomainBase bean) {

		return commonSvc.commonUpdate(bean);
		}

	protected void delete(IDomainBase bean) {

		commonSvc.commonDel(bean);
		}

	protected <T> T queryOne(IDomainBase bean) {

		return commonSvc.commonFind(bean);
		}

	protected Object queryList(String jsql, String countJsql,Map<String, ?> paramsMap, PageRequest pageRequest) {

		return commonSvc.findAllByConditions(jsql, countJsql, paramsMap, pageRequest);
		}

	protected int exeNativeUpdateSql(String sql, Map<String,?> params) {

		return commonSvc.commonNativeUpdate(sql, params);
		}

	protected Object queryListByNativeSql(String listSql, String countSql, Map<String, ?> paramsMap, PageRequest pageRequest) {

		return commonSvc.commonQueryAllByNativeSql(listSql, countSql, paramsMap, pageRequest);
		}

	/**
	 * 根据子区域节点逐级向上遍历区域树上的节点
	 * @param regionId2
	 * @return
	 */
/*	public List<Map<String,Object>> searchRegionByRegionId2(Long regionId2) {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		
		if(regionId2!=null)
		{
			PartyRegion region2 =partyRegionDao.findOne(regionId2);
			if(region2!=null)
			{
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("regionId",region2.getRegionId());
				map.put("code",region2.getCode());
				map.put("name",region2.getName());
				map.put("note",region2.getNote());
				list.add(map);
			}

			PartyRegionRelation prr =null;
			if(regionId2>1)
			{
				prr = partyRegionRelationDao.findByRelationTypeAndRegion2(new PartyRegionRelationType(1),region2);	
			}
			if(prr!=null)
			{
				getAllRegions(list,prr.getRegion2(),new PartyRegionRelationType(1));
			}

		}
		return list;
	}*/
	public String getRegionNameByRegionId2(Long regionId2) {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		
		if(regionId2!=null){
			PartyRegion region2 =partyRegionDao.findOne(regionId2);
			if(region2!=null)
			{
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("regionId",region2.getRegionId());
				map.put("code",region2.getCode());
				map.put("name",region2.getName());
				map.put("note",region2.getNote());
				list.add(map);
			}

			PartyRegionRelation prr =null;
			if(regionId2>1)
			{
				prr = partyRegionRelationDao.findByRelationTypeAndRegion2(new PartyRegionRelationType(1),region2);	
			}
			if(prr!=null)
			{
				getAllRegions(list,prr.getRegion2(),new PartyRegionRelationType(1));
			}

		}
		
		String regionName="";
		int i=0;
		for(;i<list.size();i++)
		{
			regionName+=list.get(i).get("name").toString()+" ";
		}
		return regionName;
	}
	/**
	 * 采用回调的方式，从叶子节点遍历树
	 * @param list
	 * @param region
	 * @param relationType
	 */
	private void getAllRegions(List<Map<String,Object>> list, PartyRegion region, PartyRegionRelationType relationType)
	{
		if(region==null){return;}
		PartyRegionRelation partyRegion = partyRegionRelationDao.findByRelationTypeAndRegion2(relationType,region);
		if(partyRegion==null)
		{
			return;
		}
		else
		{
			PartyRegion newRegion = partyRegion.getRegion1();
			Long regionId = newRegion.getRegionId();
			if(regionId==1){return;}
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("regionId",regionId);
			map.put("code",newRegion.getCode());
			map.put("name",newRegion.getName());
			map.put("note",newRegion.getNote());
			list.add(0, map);
			//list.add(map);
			getAllRegions(list,newRegion,relationType);
		}
	}
	
	public void verifyNotEmpty(Object obj,String errorInfo)
	{
		if("".equals(Util.toStringAndTrim(obj))){throw new IFException("请输入"+errorInfo);}
	}
	
	/**
	 * 根据设备所在单位的名称获取设备在单位的信息，为了复用，所以在这里写一个公共的方法
	 * @param name
	 * @return
	 */
	public PartyOrg getOrgByName(String name)
	{
		PartyOrg partyOrg=null;//注意，当企业的ID是从0开始的时候是不对的
		if(Util.isNotNullOrEmpty(name))
		{
		 partyOrg=partyOrgDao.findByNameAndState(name,0);
		}	
		return partyOrg; 
	}
}
