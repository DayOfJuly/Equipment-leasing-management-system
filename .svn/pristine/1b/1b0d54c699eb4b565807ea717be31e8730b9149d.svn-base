package com.hjd.dao;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;

import com.hjd.action.bean.BusEquipmentReportBean;
import com.hjd.domain.ViewEquInfo;

public interface IEquipmentStatisticsExportDao extends JpaRepository<ViewEquInfo, Long> {

	/**
	 * 设备资源明细统计
	 * @param busEquipmentReportBean
	 * @return
	 */
	public Map<String,Object> equipmentResourceReportExport(BusEquipmentReportBean busEquipmentReportBean);

	/**
	 * 设备租赁明细统计
	 * @param busEquipmentReportBean
	 * @return
	 */
	public Map<String,Object> equipmentRentHistReportExport(BusEquipmentReportBean busEquipmentReportBean);

	/**
	 * 信息发布明细表统计
	 * @param busEquipmentReportBean
	 * @return
	 */
	public Map<String,Object> infoPublishReportExport(BusEquipmentReportBean busEquipmentReportBean);

	/**
	 * 设备分类信息查询
	 * @author haopeng
	 */
	public List<Map<String,Object>> createCategoryIdListExport();

	/***
	 * 资源汇总统计
	 * 使用坐标式
	 * @param busEquipmentReportBean
	 * @param categoryList
	 */
	public Map<String,Object> resourceStatisticsCollectExport(BusEquipmentReportBean busEquipmentReportBean, List<Map<String,Object>> categoryList);

	/***
	 * 租赁汇总统计
	 * 使用坐标式
	 * @param busEquipmentReportBean
	 * @param categoryList
	 */
	public Map<String,Object> rentStatisticsCollectExport(BusEquipmentReportBean busEquipmentReportBean, List<Map<String,Object>> categoryList);

	/**
	 * 信息发布汇总统计
	 * 使用坐标式
	 * @param busEquipmentReportBean
	 * @param categoryList
	 */
	public Map<String,Object> infoPublishCollectionExport(BusEquipmentReportBean busEquipmentReportBean, List<Map<String,Object>> categoryIdList);

}
