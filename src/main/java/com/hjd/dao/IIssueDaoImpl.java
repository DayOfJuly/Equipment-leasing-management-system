package com.hjd.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import com.hjd.base.IFException;
import com.hjd.dao.base.IBaseDaoImpl;
import com.hjd.util.Util;

public class IIssueDaoImpl extends IBaseDaoImpl{
	
	/**
	 *  获取发布信息，一样的发布信息题目的记录条数
	 * @param reqParamsMap
	 * @return
	 */
	public Page<?> queryCount(Map<?, ?> reqParamsMap){
		//定义SQL,请不要删除最后一行的空格   
		//传递分页参数的载体
		Integer pageNo = 0;
		Integer pageSize = 10;
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
	    
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		
		//信息类型
		String infoType="";
		if(Util.isNotNullOrEmpty(reqParamsMap.get("infoType")))
		{
			infoType=(String)reqParamsMap.get("infoType");
			
			listSql.append(" SELECT be.infoTitle AS infoTitle, be.dataType AS dataType,be.infoTitlePy AS fpy,COUNT(be.infoTitle) AS itCount ");
			listSql.append(" FROM biz_exdata be ");
			
//			countSql.append(" SELECT COUNT(1) ");
//			countSql.append(" FROM biz_exdata be ");
			
			if("1".equals(infoType) || "2".equals(infoType) || "3".equals(infoType) || "4".equals(infoType))//查询求租信息
			{
				Integer it=Integer.valueOf(infoType);
				sqlParamsMap.put("infoType",it);
				listSql.append(" WHERE be.dataState=3 AND be.operateFlag!=1 AND be.dataType = :infoType ");
//				countSql.append(" WHERE be.dataState=3 AND be.operateFlag!=1 AND be.dataType = :infoType ");
			}
			else
			{
				throw new IFException("信息类型有误！");
			}
		}else{
			throw new IFException("信息类型不能为空！");
		}

	//信息标题
		if(Util.isNotNullOrEmpty(reqParamsMap.get("infoTitle")))
		{
			sqlParamsMap.put("infoTitle", "%"+reqParamsMap.get("infoTitle")+"%");
			listSql.append(" AND ( be.infoTitle LIKE :infoTitle ");
			listSql.append(" OR be.infoTitlePy LIKE :infoTitle ) ");
			
//			countSql.append(" AND ( be.infoTitle LIKE :infoTitle ");
//			countSql.append(" OR be.infoTitlePy LIKE :infoTitle ) ");
		}
		listSql.append(" GROUP BY be.infoTitle,be.infoTitlePy ");
//		countSql.append(" GROUP BY be.infoTitle,be.infoTitlePy ");
//		listSql.append(" ORDER BY COUNT(be.infoTitle) DESC "); //为了提高查询效率，暂时关闭排序的功能
		//创建原生SQL查询QUERY实例
		Page<?> page = this.queryAllByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		return page;
	}
	
//	public Page<?> queryCount_copy(Map<?, ?> reqParamsMap){//为了提高查询的速度，分别查询四张表中的记录，如果数据比较多，可以使用这个方式来查询，相当于纵向分表
//		//定义SQL,请不要删除最后一行的空格   
//		//传递分页参数的载体
//		Integer pageNo = 0;
//		Integer pageSize = 10;
//		//传递条件查询参数的载体
//		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
//		//获取并初步处理页面传递的请求参数
//		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
//		{
//			pageNo=Integer.valueOf((String)reqParamsMap.get("pageNo"));
//		}
//		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
//		{
//			pageSize=Integer.valueOf((String)reqParamsMap.get("pageSize"));
//		}
//		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize);
//
//		//拼写的列表查询语句
//		StringBuffer listSql = new StringBuffer();
//	    
//		//拼写获取总的记录条数的查询语句
//		StringBuffer countSql = new StringBuffer();
//		
//		//信息类型
//		String infoType="";
//		if(Util.isNotNullOrEmpty(reqParamsMap.get("infoType")))
//		{
//			infoType=(String)reqParamsMap.get("infoType");
//			
//			listSql.append(" SELECT be.infoTitle AS infoTitle,infoTitlePy AS fpy,COUNT(be.infoTitle) AS itCount ");
//			
//			if("1".equals(infoType))//查询求租信息
//			{
//				listSql.append(" FROM bus_rent be ");	
//			}else if("2".equals(infoType))//查询求购信息
//			{
//				listSql.append(" FROM bus_sale  be ");
//			}else if("3".equals(infoType))//查询求购信息
//			{
//				listSql.append(" FROM bus_demandrent  be ");
//			}else if("4".equals(infoType))//查询求购信息
//			{
//				listSql.append(" FROM bus_demandsale  be ");
//			}else{
//				throw new IFException("信息类型有误！");
//			}
//		}else{
//			throw new IFException("信息类型不能为空！");
//		}
//
//	//信息标题
//		if(Util.isNotNullOrEmpty(reqParamsMap.get("infoTitle")))
//		{
//			sqlParamsMap.put("infoTitle", "%"+reqParamsMap.get("infoTitle")+"%");
//			listSql.append("  WHERE ( be.infoTitle LIKE :infoTitle ");
//			listSql.append(" OR infoTitlePy LIKE :infoTitle ) ");
//		}
//		listSql.append(" GROUP BY be.infoTitle ");
////		listSql.append(" ORDER BY COUNT(be.infoTitle) DESC "); //为了提高查询效率，暂时关闭排序的功能
//		//创建原生SQL查询QUERY实例
//		Page<?> page = this.queryAllByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
//		return page;
//	}
}
