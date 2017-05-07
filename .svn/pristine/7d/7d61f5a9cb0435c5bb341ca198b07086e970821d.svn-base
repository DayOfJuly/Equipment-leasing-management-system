package com.hjd.dao;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;

import com.hjd.action.bean.BusRentHistSearchBean;
import com.hjd.base.IFException;
import com.hjd.dao.base.IBaseDaoImpl;
import com.hjd.util.Util;

public class IBusRentHistDaoImpl extends IBaseDaoImpl{
	
	/**
	 * 这里的列表比较特殊，需要先查出设备的信息，然后在查出设备租赁的信息，然后在拼成一个结果集
	 * @param busRentHistSearchBean
	 * @return
	 */
	public Page<?> queryOwnerAll(BusRentHistSearchBean busRentHistSearchBean,HttpSession httpSession)
	{
		String month=busRentHistSearchBean.getMonth();
		 if(Util.isNullOrEmpty(month)){throw new IFException("登记月份不能为空");}
		 
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append(" SELECT vrhs.equId AS equId,vrhs.month AS MONTH,vrhs.amount AS amount,vrhs.cost AS cost,vrhs.deductCost AS deductCost,vrhs.equAtOrgId AS equAtOrgId "); 
			listSql.append(" ,vrhs.equAtOrgCode AS equAtOrgCode,be.equNo AS equNo,be.asset AS asset,benm.EquipmentName AS EquipmentName,beb.name AS BrandName ");
		listSql.append(" FROM  view_rent_hist_sum vrhs ");
			listSql.append(" JOIN equipment.bus_equipment be ON be.EquipmentId = vrhs.equId ");
			listSql.append(" JOIN equipment.bus_category bc ON be.CategoryId = bc.CategoryId ");
			listSql.append(" JOIN equipment.bus_equ_name_manage benm ON bc.EquNameId = benm.EquNameId ");
			listSql.append(" JOIN equipment.bus_equ_brand beb ON be.BrandNo = beb.id ");
		listSql.append("WHERE 1=1 ");
		
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append(" SELECT count(1) "); 
		countSql.append(" FROM  view_rent_hist_sum vrhs ");
			countSql.append(" JOIN equipment.bus_equipment be ON be.EquipmentId = vrhs.equId ");
			countSql.append(" JOIN equipment.bus_category bc ON be.CategoryId = bc.CategoryId ");
			countSql.append(" JOIN equipment.bus_equ_name_manage benm ON bc.EquNameId = benm.EquNameId ");
			countSql.append(" JOIN equipment.bus_equ_brand beb ON be.BrandNo = beb.id ");
		countSql.append("WHERE 1=1 ");
		
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		
		//外部供应商对应的代码
		Integer isProvider=busRentHistSearchBean.getIsProvider();
	
		if(isProvider!=null && isProvider==1)
		{
			Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
			Long partyId=(Long)userMap.get("orgId"); //用于压力测试，测试完毕需要恢复
	//		Long partyId=Long.parseLong("316");
			
			sqlParamsMap.put("equAtOrgId",partyId);
			listSql.append(" AND vrhs.equAtOrgId=:equAtOrgId");
			countSql.append(" AND vrhs.equAtOrgId=:equAtOrgId");	
		}
		else
		{
			String orgCode = busRentHistSearchBean.getOrgCode();
			if("".equals(Util.toStringAndTrim(orgCode)))throw new IFException("当前登录人员的单位编码不能为空");
			Integer isInclude = busRentHistSearchBean.getIsInclude();
			
			if(isInclude!=null && isInclude==1)
			{
				sqlParamsMap.put("equAtOrgCode",orgCode+"%");
				listSql.append(" AND vrhs.equAtOrgCode LIKE :equAtOrgCode");
				countSql.append(" AND vrhs.equAtOrgCode LIKE :equAtOrgCode");
			}
			else
			{
				sqlParamsMap.put("equAtOrgCode",orgCode);
				listSql.append(" AND vrhs.equAtOrgCode=:equAtOrgCode");
				countSql.append(" AND vrhs.equAtOrgCode=:equAtOrgCode");	
			}
		}
	
		if(Util.isNotNullOrEmpty(month))
		{
			sqlParamsMap.put("month",month);
			listSql.append(" AND vrhs.month=:month");
			countSql.append(" AND vrhs.month=:month");	
		}

		//创建原生SQL查询QUERY实例
		Page<?> page = this.queryAllByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,busRentHistSearchBean.getPageRequest());
		return page;
	}

	
	public Page<?> queryUserAll(BusRentHistSearchBean busRentHistSearchBean){
		
		String orgCode = busRentHistSearchBean.getOrgCode();
		if("".equals(Util.toStringAndTrim(orgCode)))throw new IFException("当前登录人员的单位编码不能为空");
		Integer isInclude = busRentHistSearchBean.getIsInclude();

        //定义SQL,请不要删除最后一行的空格   
		StringBuffer listSql = new StringBuffer();
        listSql.append("SELECT vei.EquipmentId AS equipmentId,vei.equNo AS equNo,vei.asset AS asset,vei.productionDate AS productionDate,vei.categoryId AS categoryId, ");
	        listSql.append("vei.equNameId AS equNameId,vei.equipmentName AS equipmentName,vei.brandNo AS brandNo,vei.brandName AS brandName,vei.partyId AS partyId, ");
			listSql.append("brht.id AS id,brht.equipmentId AS equId,brht.month AS month,brht.amount AS amount, ");
			listSql.append("brht.cost AS cost,brht.deductCost AS deductCost ");
		listSql.append("FROM view_equ_info vei ");
			listSql.append("LEFT JOIN BusRentHistTable brht ON vei.EquipmentId=brht.equipmentId AND brht.regFlag=1  ");
		
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) ");
		countSql.append("FROM view_equ_info vei ");
		listSql.append("LEFT JOIN BusRentHistTable brht ON vei.EquipmentId=brht.equipmentId AND brht.regFlag=1  ");
		
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		
		//如果包含下级单位，就是采用模糊查询的方式，如果不包含下级单位就采用等于查询的方式
		if(isInclude==1)
		{
			listSql.append("WHERE vei.orgCode LIKE '").append(orgCode).append("%'");
			countSql.append("WHERE vei.orgCode LIKE '").append(orgCode).append("%'");
		}
		else
		{
			listSql.append("WHERE vei.orgCode=").append(orgCode);
			countSql.append("WHERE vei.orgCode=").append(orgCode);	
		}
		
		//单位名称
		if(Util.isNotNullOrEmpty(busRentHistSearchBean.getOrgName()))
		{
			sqlParamsMap.put("orgName", "%"+busRentHistSearchBean.getOrgName()+"%");
			listSql.append(" AND vei.orgName LIKE :orgName");
			countSql.append(" AND vei.orgName LIKE :orgName");
		}
		//登记月份
		if(Util.isNotNullOrEmpty(busRentHistSearchBean.getMonth()))
		{
			sqlParamsMap.put("month", busRentHistSearchBean.getMonth());
			listSql.append(" AND brht.month = :month");
			countSql.append(" AND brht.month = :month");
		}
		
		//创建原生SQL查询QUERY实例
		Page<?> page = this.queryAllByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,busRentHistSearchBean.getPageRequest());
		return page;
	}
}
