package com.hjd.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;

import com.hjd.action.bean.BusPublishInfoSearchBean;
import com.hjd.dao.base.IBaseDaoImpl;
import com.hjd.util.Util;

public class IBusPublishInfoDaoImpl extends IBaseDaoImpl{
	
	@SuppressWarnings("deprecation")
	public Page<?> queryAll(BusPublishInfoSearchBean busPublishInfoSearchBean,HttpSession httpSession)
	{
		
        //定义SQL,请不要删除最后一行的空格，建议拼写SQL语句的时候，每个语句前后都空出一个空格来  
		StringBuffer listSql = new StringBuffer();
			  listSql.append("  SELECT bpi.id AS id,bpi.PartyId AS partyId,bpi.ProId AS proId,bpi.LoginUserId AS loginUserId,bpi.operateFlag AS operateFlag,be.DataType AS dataType,be.DataState AS dataState ");
				  listSql.append(" ,(SELECT  bd.Note FROM biz_datastate bd WHERE bd.DataState = be.DataState) AS dataStateDesc ");
				  listSql.append(" ,be.dataId AS dataId,be.infoTitle AS infoTitle, be.contactPerson AS contactPerson,be.contactPhone AS contactPhone,DATE_FORMAT(be.releaseDate,'%Y-%m-%d %H:%i:%S') AS releaseDate ");
				  listSql.append(" ,be.state AS equState ");
			  listSql.append(" FROM biz_exdata be JOIN bus_publish_info bpi ON bpi.DataId = be.DataId ");

		StringBuffer countSql = new StringBuffer();
			  countSql.append(" SELECT COUNT(1) ");
			  countSql.append(" FROM biz_exdata be JOIN bus_publish_info bpi ON bpi.DataId = be.DataId ");

				listSql.append("  WHERE bpi.operateFlag != 1 ");
				countSql.append(" WHERE  bpi.operateFlag != 1 ");
				
				//传递条件查询参数的载体
				Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
				Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
//				sqlParamsMap.put("loginUserId", (Long)userMap.get("loginUserId"));
////				sqlParamsMap.put("loginUserId", Long.parseLong("3")); //压力测试，测试完毕需要恢复
//				
//				listSql.append(" AND bpi.loginUserId = :loginUserId ");
//				countSql.append(" AND bpi.loginUserId = :loginUserId ");
				
				//如果当前当前登录者的项目ID存在，则查询同一个项目下的已发布的信息，否则查询同一个单位下的已发布的信息
				if(Util.isNotNullOrEmpty(userMap.get("proId")))
				{
					sqlParamsMap.put("proId", (Long)userMap.get("proId"));
					listSql.append(" AND bpi.proId = :proId");
					countSql.append(" AND bpi.proId = :proId");
				}
				else
				{
					sqlParamsMap.put("partyId", (Long)userMap.get("orgId"));
					listSql.append(" AND bpi.partyId = :partyId");
					countSql.append(" AND bpi.partyId = :partyId");
				}
				
				//信息类型
				if(Util.isNotNullOrEmpty(busPublishInfoSearchBean.getDataType()))
				{
					sqlParamsMap.put("dataType", busPublishInfoSearchBean.getDataType());
					listSql.append(" AND be.dataType = :dataType ");
					countSql.append(" AND be.dataType = :dataType ");
				}
				//发布状态
				if(Util.isNotNullOrEmpty(busPublishInfoSearchBean.getDataState()))
				{
					sqlParamsMap.put("dataState", busPublishInfoSearchBean.getDataState());
					listSql.append(" AND be.dataState = :dataState ");
					countSql.append(" AND be.dataState = :dataState ");
				}
				//最小发布时间
				if(Util.isNotNullOrEmpty(busPublishInfoSearchBean.getStartReleaseDate()))
				{
					sqlParamsMap.put("minReleaseDate", busPublishInfoSearchBean.getStartReleaseDate());
					listSql.append(" AND be.releaseDate >= :minReleaseDate ");
					countSql.append(" AND be.releaseDate >= :minReleaseDate ");
				}
				//最大发布时间
				if(Util.isNotNullOrEmpty(busPublishInfoSearchBean.getEndReleaseDate()))
				{
					Date erd=busPublishInfoSearchBean.getEndReleaseDate();
					erd.setHours(23);
					erd.setMinutes(59);
					erd.setSeconds(59);
					sqlParamsMap.put("maxReleaseDate", erd);
					listSql.append(" AND be.releaseDate <= :maxReleaseDate ");
					countSql.append(" AND be.releaseDate <= :maxReleaseDate ");
				}
				
				listSql.append(" ORDER BY be.releaseDate DESC ");
		
		//创建原生SQL查询QUERY实例
		Page<?> page = this.queryAllByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,busPublishInfoSearchBean.getPageRequest());
		
		return page;
	}

}
