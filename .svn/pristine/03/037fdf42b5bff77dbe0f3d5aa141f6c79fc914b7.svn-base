package com.hjd.action;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.base.BaseAction;
import com.hjd.dao.IPartyRegionDao;
import com.hjd.dao.IPartyRegionRelationDao;
import com.hjd.domain.PartyRegion;
import com.hjd.domain.PartyRegionRelation;
import com.hjd.domain.PartyRegionRelationType;

@RestController
public class RegionAction extends BaseAction {
	@Autowired
	private IPartyRegionRelationDao partyRegionRelationDao;
	@Autowired
	private IPartyRegionDao partyRegionDao;

	/**
	 * 根据regionId，查询对应的地区信息
	 * @author haopeng
	 * @since 2016-08-13
	 * @param regionId
	 * @return PartyRegion
	 */
	@RequestMapping(value="/Party/Region/{regionId}", method={RequestMethod.GET}, params={"action=RegionDetail"})
	public PartyRegion searchPartyRegionByRegionId(@PathVariable Long regionId) {

		PartyRegion partyRegion = new PartyRegion();

		partyRegion.setRegionId(regionId);

		return queryOne(partyRegion);
		}

	/**
	 * 根据子级区域ID来查找父级区域
	 */
	@RequestMapping(value="/Party/Region/{regionId2}", method={RequestMethod.GET})
	public Map<String,Object> searchPartyRegionByRegionId2(@PathVariable Long regionId2) {

		Long regionId = regionId2;
		if(regionId==null)
			regionId = 1L;
		return partyRegionRelationDao.findRegionByRegionId2(1,regionId);
		}
	
	
	/**
	 * 行政地区信息 - 获取所有的行政区域信息
	 */
	@RequestMapping(value="/Party/Region", method={RequestMethod.GET},params={"Action=All"})
	public List<PartyRegion> searchRegions() {
		return partyRegionDao.findAll();
		}
	
	/**
	 * 根据子区域节点逐级向上遍历区域树上的节点
	 * @param regionId2
	 * @return
	 */
	@RequestMapping(value="/Party/Region/{regionId2}", method={RequestMethod.GET},params={"Action=RegionName"})
	public List<Map<String,Object>> searchRegionByRegionId2(@PathVariable Long regionId2) {
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
	}
	/*public Map<String,Object> searchRegionByRegionId2(@PathVariable Long regionId2,@PathVariable Long decollator) {
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
		
		Map<String,Object> regionMap = new HashMap<String,Object>();
		String regionName="";
		int i=0;
		for(;i<list.size()-1;i++)
		{
			regionName+=list.get(i).get("name").toString()+decollator;
		}
		regionName+=list.get(i).get("name").toString();
		regionMap.put("regionName", regionName);
		return regionMap;
	}*/
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
}
