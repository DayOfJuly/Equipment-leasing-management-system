package com.hjd.dao;

import java.util.HashMap;
import java.util.Map;





import org.springframework.data.domain.Page;

import com.hjd.action.bean.BusDepreciationHistSearchBean;
import com.hjd.base.IFException;
import com.hjd.dao.base.IBaseDaoImpl;
import com.hjd.util.Util;

public class IBusDepreciationHistDaoImpl extends IBaseDaoImpl{
	
	public Page<?> queryAll(BusDepreciationHistSearchBean busDepreciationHistSearchBean)
	{
		String month = busDepreciationHistSearchBean.getMonth();
		if("".equals(Util.toStringAndTrim(month)))throw new IFException("折旧费登记月份不能为空");
		
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

        //定义SQL,请不要删除最后一行的空格   
		StringBuffer listSql = new StringBuffer();
		listSql.append(" SELECT  vei.equipmentId AS equipmentId,vei.equNo AS equNo,vei.asset AS asset,vei.productionDate AS productionDate,vei.equName AS equipmentName,vei.brandName AS brandName ");
		    listSql.append(" ,vei.orgPartyId AS partyId,vei.specifications AS specifications,vei.models AS models,vei.equipmentCost AS equipmentCost,vei.equState AS equState ");
		    listSql.append(" ,bdh.id AS id,bdh.equipmentId AS equId,bdh.month AS MONTH,bdh.depreciation AS depreciation ");
	    listSql.append(" FROM view_equ_info vei ");
	    	listSql.append(" LEFT JOIN bus_depreciation_hist bdh ON vei.EquipmentId = bdh.EquipmentId  AND bdh.month ='").append(month).append("' ");
			
		StringBuffer countSql = new StringBuffer();
		countSql.append(" SELECT count(1) ");
	    countSql.append(" FROM view_equ_info vei ");
	    	countSql.append(" LEFT JOIN bus_depreciation_hist bdh ON vei.EquipmentId = bdh.EquipmentId  AND bdh.month ='").append(month).append("' ");

			listSql.append(" WHERE  1=1");
			countSql.append(" WHERE  1=1");
		//	拼组所属单位/项目的查询条件
		Integer orgFlag = busDepreciationHistSearchBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
		Long orgPartyId = busDepreciationHistSearchBean.getOrgPartyId();	//	所属单位/项目id
		Integer isInclude = busDepreciationHistSearchBean.getIsInclude();	//	是否包含下级单位：1-包含
		if(Util.isNullOrEmpty(orgFlag)){throw new IFException("所属单位信息不能为空！");}
		if(Util.isNullOrEmpty(orgPartyId)){throw new IFException("所属单位信息不能为空！");}
		//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
		if(orgFlag==9){//	总公司
			listSql.append(" AND vei.bureauOrgParTypeId=4");
			countSql.append(" AND vei.bureauOrgParTypeId=4");
		}
		else if(orgFlag==1){//	局级单位
			sqlParamsMap.put("orgPartyId", orgPartyId);
			if(isInclude!=null && isInclude==1){
				listSql.append(" AND vei.bureauOrgPartyId=:orgPartyId");
				countSql.append(" AND vei.bureauOrgPartyId=:orgPartyId");
			}
			else{
				listSql.append(" AND (vei.bureauOrgPartyId=:orgPartyId AND vei.sonOrgPartyId IS NULL)");
				countSql.append(" AND (vei.bureauOrgPartyId=:orgPartyId AND vei.sonOrgPartyId  IS NULL)");
			}
		}
		else if(orgFlag==2){//	处级单位
			sqlParamsMap.put("orgPartyId", orgPartyId);
			listSql.append(" AND vei.sonOrgPartyId=:orgPartyId");
			countSql.append(" AND vei.sonOrgPartyId=:orgPartyId");
		}
		else if(orgFlag==3){//	项目
			sqlParamsMap.put("orgPartyId", orgPartyId);
			listSql.append(" AND vei.proOrgPartyId=:orgPartyId");
			countSql.append(" AND vei.proOrgPartyId=:orgPartyId");
		}
		else{
			throw new IFException("所属单位信息错误！");
		}	    	

		sqlParamsMap.put("month", month);
		//登记月份大于等于设备的创建月份，才能登记此设备
		listSql.append(" AND DATE_FORMAT(vei.createTime,'%Y-%m')<=:month");//当月添加的设备当月就能登记折旧费
		countSql.append(" AND DATE_FORMAT(vei.createTime,'%Y-%m')<=:month");
		//登记月份小于设备的删除月份，才能登记此设备，当删除时间为空时表示没有删除此设备
		listSql.append(" AND (LAST_DAY(vei.delDate)>:month OR vei.delDate IS NULL)");
		countSql.append(" AND (LAST_DAY(vei.delDate)>:month OR vei.delDate IS NULL)");
		
		//创建原生SQL查询QUERY实例
		Page<?> page = this.queryAllByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,busDepreciationHistSearchBean.getPageRequest());
		return page;
	}
	
//	public Page<?> queryAll(BusDepreciationHistSearchBean busDepreciationHistSearchBean)
//	{
//		String orgCode = busDepreciationHistSearchBean.getOrgCode();
//		if("".equals(Util.toStringAndTrim(orgCode)))throw new IFException("当前登录人员的单位编码不能为空");
//		
//		String month = busDepreciationHistSearchBean.getMonth();
//		if("".equals(Util.toStringAndTrim(month)))throw new IFException("折旧费登记月份不能为空");
//		
//		//传递条件查询参数的载体
//		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
//		
//		/*sqlParamsMap.put("month", busDepreciationHistSearchBean.getMonth());*/
//		
//		Integer isInclude = busDepreciationHistSearchBean.getIsInclude();
//		
//        //定义SQL,请不要删除最后一行的空格   
//		StringBuffer listSql = new StringBuffer();
//		listSql.append(" SELECT  be.equipmentId AS equipmentId,be.equNo AS equNo,be.asset AS asset,be.productionDate AS productionDate,benm.EquipmentName AS equipmentName,beb.name AS brandName ");
//		    listSql.append(" ,be.AssetOwnersId AS partyId,bdh.id AS id,bdh.equipmentId AS equId,bdh.month AS MONTH,bdh.depreciation AS depreciation ");
//	    listSql.append(" FROM bus_equipment be ");
//	        listSql.append("JOIN bus_category bc ON be.CategoryId = bc.CategoryId ");
//	        listSql.append("JOIN bus_equ_name_manage benm ON bc.EquNameId = benm.EquNameId ");
//	    	listSql.append("JOIN bus_equ_brand beb ON be.BrandNo = beb.id ");
//	    	listSql.append("JOIN par_party pp ON (pp.ParTypeId = 4 OR pp.ParTypeId = 8) AND be.AssetOwnersId = pp.PartyId  ");
//	    	listSql.append("JOIN par_org po ON pp.PartyId = po.PartyId ");
//	    	listSql.append(" LEFT JOIN bus_depreciation_hist bdh ON be.EquipmentId = bdh.EquipmentId  AND bdh.month ='").append(month).append("' ");
//			
//		StringBuffer countSql = new StringBuffer();
//		countSql.append(" SELECT count(1) ");
//	    countSql.append(" FROM bus_equipment be ");
//	        countSql.append("JOIN bus_category bc ON be.CategoryId = bc.CategoryId ");
//	        countSql.append("JOIN bus_equ_name_manage benm ON bc.EquNameId = benm.EquNameId ");
//	    	countSql.append("JOIN bus_equ_brand beb ON be.BrandNo = beb.id ");
//	    	countSql.append("JOIN par_party pp ON (pp.ParTypeId = 4 OR pp.ParTypeId = 8) AND be.AssetOwnersId = pp.PartyId  ");
//	    	countSql.append("JOIN par_org po ON pp.PartyId = po.PartyId ");
//	    	countSql.append(" LEFT JOIN bus_depreciation_hist bdh ON be.EquipmentId = bdh.EquipmentId  AND bdh.month ='").append(month).append("' ");
//
//		//如果包含下级单位，就是采用模糊查询的方式，如果不包含下级单位就采用等于查询的方式
//		if(isInclude!=null && isInclude==1)
//		{
//			listSql.append(" WHERE po.code LIKE '").append(orgCode).append("%'");
//			countSql.append(" WHERE po.code LIKE '").append(orgCode).append("%'");
//		}
//		else
//		{
//			listSql.append(" WHERE po.code='").append(orgCode).append("' ");
//			countSql.append(" WHERE po.code='").append(orgCode).append("' ");
//		}
//		
//		
//		//控制设备删除之前和删除当月能够看到，不过删除之后就看不到了
//		sqlParamsMap.put("month", month);
//		listSql.append(" AND (LAST_DAY(be.delDate)>:month OR be.delDate IS NULL)");
//		countSql.append(" AND (LAST_DAY(be.delDate)>:month OR be.delDate IS NULL)");
//		
///*		//单位名称
//		if(Util.isNotNullOrEmpty(busDepreciationHistSearchBean.getOrgName()))
//		{
//			sqlParamsMap.put("orgName", "%"+busDepreciationHistSearchBean.getOrgName()+"%");
//			listSql.append(" AND vei.orgName LIKE :orgName");
//			countSql.append(" AND vei.orgName LIKE :orgName");
//		}*/
//		
//		
//		//登记月份
///*		if(Util.isNotNullOrEmpty(busDepreciationHistSearchBean.getMonth()))
//		{
//			sqlParamsMap.put("month", busDepreciationHistSearchBean.getMonth());
//			listSql.append(" AND bdh.month = :month");
//			countSql.append(" AND bdh.month = :month");
//		}*/
//		
//		//创建原生SQL查询QUERY实例
//		Page<?> page = this.queryAllByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,busDepreciationHistSearchBean.getPageRequest());
//		return page;
//	}
	
	public Page<?> queryAllProvider(BusDepreciationHistSearchBean busDepreciationHistSearchBean)
	{
		Long orgId = busDepreciationHistSearchBean.getOrgId();
		
		String month = busDepreciationHistSearchBean.getMonth();
		if("".equals(Util.toStringAndTrim(month)))throw new IFException("折旧费登记月份不能为空");
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		
		/*sqlParamsMap.put("month", busDepreciationHistSearchBean.getMonth());*/
		
        //定义SQL,请不要删除最后一行的空格   
		StringBuffer listSql = new StringBuffer();
		listSql.append(" SELECT  vei.equipmentId AS equipmentId,vei.equNo AS equNo,vei.asset AS asset,vei.productionDate AS productionDate,vei.equName AS equipmentName,vei.brandName AS brandName ");
		    listSql.append(" ,vei.orgPartyId AS partyId,vei.specifications AS specifications,vei.models AS models,vei.equipmentCost AS equipmentCost,vei.equState AS equState ");
		    listSql.append(" ,bdh.id AS id,bdh.equipmentId AS equId,bdh.month AS MONTH,bdh.depreciation AS depreciation ");
	    listSql.append(" FROM view_equ_info vei ");
	    	listSql.append(" LEFT JOIN bus_depreciation_hist bdh ON vei.EquipmentId = bdh.EquipmentId  AND bdh.month ='").append(month).append("' ");
			
		StringBuffer countSql = new StringBuffer();
		countSql.append(" SELECT count(1) ");
	    countSql.append(" FROM view_equ_info vei ");
	    	countSql.append(" LEFT JOIN bus_depreciation_hist bdh ON vei.EquipmentId = bdh.EquipmentId  AND bdh.month ='").append(month).append("' ");

		//单位ID 注意，连接的时候过滤条件放在ON之后和WHERE之后效果相差是非常之大的
		
		sqlParamsMap.put("orgPartyId", orgId);
		listSql.append(" WHERE  vei.orgPartyId = :orgPartyId");
		countSql.append(" WHERE  vei.orgPartyId = :orgPartyId");

		sqlParamsMap.put("month", month);
		//登记月份大于等于设备的创建月份，才能登记此设备
		listSql.append(" AND DATE_FORMAT(vei.createTime,'%Y-%m')<=:month");//当月添加的设备当月就能登记折旧费
		countSql.append(" AND DATE_FORMAT(vei.createTime,'%Y-%m')<=:month");
		//登记月份小于设备的删除月份，才能登记此设备，当删除时间为空时表示没有删除此设备
		listSql.append(" AND (LAST_DAY(vei.delDate)>:month OR vei.delDate IS NULL)");
		countSql.append(" AND (LAST_DAY(vei.delDate)>:month OR vei.delDate IS NULL)");
		//登记月份
/*		if(Util.isNotNullOrEmpty(busDepreciationHistSearchBean.getMonth()))
		{
			sqlParamsMap.put("month", busDepreciationHistSearchBean.getMonth());
			listSql.append(" AND bdh.month = :month");
			countSql.append(" AND bdh.month = :month");
		}*/
		
		//创建原生SQL查询QUERY实例
		Page<?> page = this.queryAllByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,busDepreciationHistSearchBean.getPageRequest());
		return page;
	}

	
//	public Page<?> queryAllProvider(BusDepreciationHistSearchBean busDepreciationHistSearchBean)
//	{
//		Long orgId = busDepreciationHistSearchBean.getOrgId();
//		
//		String month = busDepreciationHistSearchBean.getMonth();
//		if("".equals(Util.toStringAndTrim(month)))throw new IFException("折旧费登记月份不能为空");
//		//传递条件查询参数的载体
//		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
//		
//		/*sqlParamsMap.put("month", busDepreciationHistSearchBean.getMonth());*/
//		
//        //定义SQL,请不要删除最后一行的空格   
//		StringBuffer listSql = new StringBuffer();
//		listSql.append(" SELECT  be.equipmentId AS equipmentId,be.equNo AS equNo,be.asset AS asset,be.productionDate AS productionDate,benm.EquipmentName AS equipmentName,beb.name AS brandName ");
//		    listSql.append(" ,be.AssetOwnersId AS partyId,bdh.id AS id,bdh.equipmentId AS equId,bdh.month AS MONTH,bdh.depreciation AS depreciation ");
//	    listSql.append(" FROM bus_equipment be ");
//	        listSql.append("JOIN bus_category bc ON be.CategoryId = bc.CategoryId ");
//	        listSql.append("JOIN bus_equ_name_manage benm ON bc.EquNameId = benm.EquNameId ");
//	    	listSql.append("JOIN bus_equ_brand beb ON be.BrandNo = beb.id ");
//	    	listSql.append("JOIN par_party pp ON (pp.ParTypeId = 4 OR pp.ParTypeId = 8) AND be.AssetOwnersId = pp.PartyId  ");
//	    	listSql.append("JOIN par_org po ON pp.PartyId = po.PartyId ");
//	    	listSql.append(" LEFT JOIN bus_depreciation_hist bdh ON be.EquipmentId = bdh.EquipmentId  AND bdh.month ='").append(month).append("' ");		
//
//		StringBuffer countSql = new StringBuffer();
//		countSql.append(" SELECT count(1) ");
//	    countSql.append(" FROM bus_equipment be ");
//	        countSql.append("JOIN bus_category bc ON be.CategoryId = bc.CategoryId ");
//	        countSql.append("JOIN bus_equ_name_manage benm ON bc.EquNameId = benm.EquNameId ");
//	    	countSql.append("JOIN bus_equ_brand beb ON be.BrandNo = beb.id ");
//	    	countSql.append("JOIN par_party pp ON (pp.ParTypeId = 4 OR pp.ParTypeId = 8) AND be.AssetOwnersId = pp.PartyId  ");
//	    	countSql.append("JOIN par_org po ON pp.PartyId = po.PartyId ");
//	    	countSql.append(" LEFT JOIN bus_depreciation_hist bdh ON be.EquipmentId = bdh.EquipmentId  AND bdh.month ='").append(month).append("' ");
//
//		//单位ID 注意，连接的时候过滤条件放在ON之后和WHERE之后效果相差是非常之大的
//		
//		sqlParamsMap.put("orgPartyId", orgId);
//		listSql.append(" WHERE  po.partyId = :orgPartyId");
//		countSql.append(" WHERE  po.partyId = :orgPartyId");
//
//		//控制设备删除之前和删除当月能够看到，不过删除之后就看不到了
//		sqlParamsMap.put("month", month);
//		listSql.append(" AND (LAST_DAY(be.delDate)>:month OR be.delDate IS NULL)");
//		countSql.append(" AND (LAST_DAY(be.delDate)>:month OR be.delDate IS NULL)");
//		//登记月份
///*		if(Util.isNotNullOrEmpty(busDepreciationHistSearchBean.getMonth()))
//		{
//			sqlParamsMap.put("month", busDepreciationHistSearchBean.getMonth());
//			listSql.append(" AND bdh.month = :month");
//			countSql.append(" AND bdh.month = :month");
//		}*/
//		
//		//创建原生SQL查询QUERY实例
//		Page<?> page = this.queryAllByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,busDepreciationHistSearchBean.getPageRequest());
//		return page;
//	}

}
