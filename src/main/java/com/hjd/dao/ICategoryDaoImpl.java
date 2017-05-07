package com.hjd.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.hjd.dao.base.IBaseDaoImpl;
import com.hjd.domain.EquNameManageTable;

public class ICategoryDaoImpl extends IBaseDaoImpl {
	
	public Page<?> queryEquNamesByEquCategoryId(Pageable pageable,int equCategoryId){
		
		
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		sqlParamsMap.put("equCategoryId", equCategoryId);
        //定义SQL,请不要删除最后一行的空格   
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT benm.equNameId AS equNameId ,benm.equipmentNo AS equipmentNo ,benm.equipmentName AS equipmentName, ");
		sql.append("benm.second AS second  ,benm.searchCount AS  searchCount , bc.equCategoryId AS equCategoryId ");
		sql.append("FROM bus_category bc ");
		sql.append("INNER JOIN  bus_equ_name_manage benm ON bc.relationType=1 AND bc.equNameId=benm.equNameId ");
		sql.append("WHERE bc.equCategoryId=:equCategoryId ");
		sql.append("ORDER BY  benm.equipmentNo ,CONVERT(benm.equipmentName USING gbk) ASC ");

		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT COUNT(1) ");
		countSql.append("FROM bus_category bc ");
		countSql.append("INNER JOIN  bus_equ_name_manage benm ON bc.relationType=1 AND bc.equNameId=benm.equNameId ");
		countSql.append("WHERE bc.equCategoryId=:equCategoryId ");
		countSql.append("ORDER BY  benm.equipmentNo ,CONVERT(benm.equipmentName USING gbk) ASC ");
		//创建原生SQL查询QUERY实例
		@SuppressWarnings("unchecked")
		Page<?> page = (Page<EquNameManageTable>) this.queryAllByNativeSql(sql.toString(),countSql.toString(),sqlParamsMap,pageable);
		return page;
	}

}
