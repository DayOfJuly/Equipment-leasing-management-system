package com.hjd.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.base.BaseAction;
import com.hjd.domain.DemandRentTable;
import com.hjd.domain.DemandSaleTable;
import com.hjd.domain.RentTable;
import com.hjd.domain.SaleTable;
import com.hjd.util.Util;

@RestController
public class OutputDataAction extends BaseAction{

	@Value("${server.url}")
	private String baseUrl;

/*为网站系统提供数据的接口（注意：需要是POST方法来）+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/	
	/**
	 * 1：提供设备大类分类的名称以及设备租赁网站登录的首页地址
	 */
	@RequestMapping(value="/EquSys/OutputData/EquCategoryName",method={RequestMethod.POST})
	public List<?> queryEquCategoryNames(HttpServletRequest request)
	{
		//传递分页参数的载体
		Integer pageNo = request.getParameter("pageNo")==null ? 0 : Integer.parseInt(request.getParameter("pageNo"));
		Integer pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize);
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT new Map(obj.equipmentCategoryName as equCategoryName ,'");
		listSql.append(baseUrl);
		listSql.append("/WebSite/Front/Main/HomePage.jsp' as equHomeUrl) ");
		listSql.append("FROM EquCategoryManageTable  obj ");
		
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM EquCategoryManageTable obj ");		
		
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas.getContent();	
	}

	/**
	 * 2：提供审核通过的发布信息标题，按照发布日期降序排序
	 */
	@RequestMapping(value="/EquSys/OutputData/EquPublishTitle",method={RequestMethod.POST})
	public List<?> queryEquPublishTitles(HttpServletRequest request)
	{
		//传递分页参数的载体
		Integer pageNo = request.getParameter("pageNo")==null ? 0 : Integer.parseInt(request.getParameter("pageNo"));
		Integer pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		PageRequest pageRequest=new PageRequest(pageNo<0?0:pageNo, pageSize);
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT new Map(obj.infoTitle as equPublishTitle) ");
		listSql.append("FROM BizExData  obj ");
		listSql.append("WHERE obj.dataState.dataState=3 ");
		
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM BizExData obj ");		
		countSql.append("WHERE obj.dataState.dataState=3 ");
		
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		
		listSql.append(" ORDER BY obj.releaseDate DESC ");
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		
		return datas.getContent();	
	}

	/**
	 * 3：提供出售、求购、出租、求租的信息列表，按照发布日期降序排序
	 */
	@RequestMapping(value="/EquSys/OutputData/EquInfo",method={RequestMethod.POST})
	public Map<String,Object> queryEquInfo(HttpServletRequest request) {

		//传递分页参数的载体
		Integer pageNo = request.getParameter("pageNo")==null ? 0 : Integer.parseInt(request.getParameter("pageNo"));
		Integer pageSize = request.getParameter("pageSize")==null ? 10 : Integer.parseInt(request.getParameter("pageSize"));
		PageRequest pageRequest = new PageRequest(pageNo<0?0:pageNo, pageSize);

		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		//参数list
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		//参数map
		Map<String,Object> map = new HashMap<String,Object>();
		//参数picStr
		String[] picStr1;
		String[] picStr2;

		//	返回结果
		Map<String,Object> result = new HashMap<String,Object>();

		//查询出售信息
		listSql.append("from SaleTable sale order by sale.releaseDate desc");

		countSql.append("select count(1) from SaleTable sale");

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);

		List<?> sale = datas.getContent();
		if(sale!=null && sale.size()>0){
			for(int i=0;i<sale.size();i++){
				SaleTable saleRec = (SaleTable)sale.get(i);

				picStr1 = saleRec.getEquipmentPic().split(",");
				if(picStr1!=null && picStr1.length>0){
					picStr2 = picStr1[0].split("\\.");
					map.put("imgUrl", baseUrl + "/Picture/" + picStr2[0] + "/" + picStr2[1]);
					}

				map.put("url", baseUrl + "/WebSite/Front/Publish/ViewInfo.jsp?infoType=2&id=" + saleRec.getDataId());
				map.put("name", saleRec.getInfoTitle());

				list.add(map);

				map = new HashMap<String,Object>();
				}
			}

		result.put("sale", list);

		listSql.setLength(0);
		countSql.setLength(0);
		list = new ArrayList<Map<String,Object>>();

		//查询求购信息
		listSql.append("from DemandSaleTable demandSale order by demandSale.releaseDate desc");

		countSql.append("select count(1) from DemandSaleTable demandSale");

		datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);

		List<?> demandSale = datas.getContent();
		if(demandSale!=null && demandSale.size()>0){
			for(int i=0;i<demandSale.size();i++){
				DemandSaleTable demandSaleRec = (DemandSaleTable)demandSale.get(i);

				map.put("url", baseUrl + "/WebSite/Front/Publish/ViewInfo.jsp?infoType=4&id=" + demandSaleRec.getDataId());
				map.put("name", demandSaleRec.getInfoTitle());
				map.put("releaseDate", Util.convertDateToStr(demandSaleRec.getReleaseDate(),"yyyy-MM-dd"));

				list.add(map);

				map = new HashMap<String,Object>();
				}
			}

		result.put("demandSale", list);

		listSql.setLength(0);
		countSql.setLength(0);
		list = new ArrayList<Map<String,Object>>();

		//查询出租信息
		listSql.append("from RentTable rent order by rent.releaseDate desc");

		countSql.append("select count(1) from RentTable rent");

		datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);

		List<?> rent = datas.getContent();
		if(rent!=null && rent.size()>0){
			for(int i=0;i<rent.size();i++){
				RentTable rentRec = (RentTable)rent.get(i);

				picStr1 = rentRec.getEquipmentPic().split(",");
				if(picStr1!=null && picStr1.length>0){
					picStr2 = picStr1[0].split("\\.");
					map.put("imgUrl", baseUrl + "/Picture/" + picStr2[0] + "/" + picStr2[1]);
					}

				map.put("url", baseUrl + "/WebSite/Front/Publish/ViewInfo.jsp?infoType=1&id=" + rentRec.getDataId());
				map.put("name", rentRec.getInfoTitle());

				list.add(map);

				map = new HashMap<String,Object>();
				}
			}

		result.put("rent", list);

		listSql.setLength(0);
		countSql.setLength(0);
		list = new ArrayList<Map<String,Object>>();

		//查询求租信息
		listSql.append("from DemandRentTable demandRent order by demandRent.releaseDate desc");

		countSql.append("select count(1) from DemandRentTable demandRent");

		datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);

		List<?> demandRent = datas.getContent();
		if(demandRent!=null && demandRent.size()>0){
			for(int i=0;i<demandRent.size();i++){
				DemandRentTable demandRentRec = (DemandRentTable)demandRent.get(i);

				map.put("url", baseUrl + "/WebSite/Front/Publish/ViewInfo.jsp?infoType=3&id=" + demandRentRec.getDataId());
				map.put("name", demandRentRec.getInfoTitle());
				map.put("releaseDate", Util.convertDateToStr(demandRentRec.getReleaseDate(),"yyyy-MM-dd"));

				list.add(map);

				map = new HashMap<String,Object>();
				}
			}

		result.put("demandRent", list);

		return result;
		}

	}
