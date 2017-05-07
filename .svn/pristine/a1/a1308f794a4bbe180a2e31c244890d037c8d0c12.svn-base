package com.hjd.dao;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;

import com.hjd.action.bean.BusEquipmentReportBean;
import com.hjd.domain.ViewEquInfo;

public interface IEquipmentStatisticsDao extends JpaRepository<ViewEquInfo, Long> {

	/**
	 * 设备资源明细统计
	 * @param busEquipmentReportBean
	 * @return
	 */
	public Page<?> equipmentResourceReport(BusEquipmentReportBean busEquipmentReportBean);

	/**
	 * 设备租赁明细统计
	 * @param busEquipmentReportBean
	 * @return
	 */
	public Page<?> equipmentRentHistReport(BusEquipmentReportBean busEquipmentReportBean);

	/**
	 * 信息发布明细表统计
	 * @param busEquipmentReportBean
	 * @return
	 */
	public Page<?> infoPublishReport(BusEquipmentReportBean busEquipmentReportBean);

	/**
	 * 设备分类信息查询
	 * @author haopeng
	 */
	public List<Map<String,Object>> createCategoryIdList();

	/***
	 * 资源汇总统计
	 * 使用坐标式
	 * @param busEquipmentReportBean
	 * @param categoryList
	 */
	public List<Map<String,Object>> resourceStatisticsCollect(BusEquipmentReportBean busEquipmentReportBean, List<Map<String,Object>> categoryList);

	/**
	 * 租赁汇总统计
	 * 使用坐标式
	 * @param busEquipmentReportBean
	 * @param categoryList
	 */
	public List<Map<String,Object>> rentStatisticsCollect(BusEquipmentReportBean busEquipmentReportBean, List<Map<String,Object>> categoryList);

	/**
	 * 信息发布汇总统计
	 * 使用坐标式
	 * @param busEquipmentReportBean
	 * @param categoryList
	 */
	public List<Map<String,Object>> infoPublishCollection(BusEquipmentReportBean busEquipmentReportBean, List<Map<String,Object>> categoryList);

}
