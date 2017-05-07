package com.hjd.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.BusEquipmentReportBean;
import com.hjd.base.BaseAction;
import com.hjd.dao.IEquipmentStatisticsDao;
import com.hjd.util.Util;

/**
 * 设备资源 
 * 统计控制器
 * @author Administrator
 *
 */
@RestController
@RequestMapping(value="/BusEquipmentStatistics")
public class BusEquipmentStatisticsAction extends BaseAction{

	@Autowired
	IEquipmentStatisticsDao iEquipmentStatisticsDao;

	Logger log = Logger.getLogger(BusEquipmentStatisticsAction.class);

	/**
	 * 资源明细 - 列表查询
	 * @author haopeng
	 * @since 2016-08-24
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equTrsType 来源
	 * @param equCategoryId 设备分类
	 * @param equName 设备名称（模糊查询）
	 * @return Page<?>
	 */
	@RequestMapping(value="/Detail",method={RequestMethod.POST},params={"Action=Resource"})
	public Page<?> equipmentResourceReport(@RequestBody BusEquipmentReportBean busEquipmentReportBean){

		log.info("资源明细统计...........");

		Page<?> page = iEquipmentStatisticsDao.equipmentResourceReport(busEquipmentReportBean);

		return page;
	}

	/**
	 * 租赁明细 - 列表查询
	 * @author haopeng
	 * @since 2016-08-24
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equRentType 业务类型
	 * @param equCategoryId 设备分类
	 * @param equName 设备名称（模糊查询）
	 * @return Map<String, Object>
	 */
	@RequestMapping(value="/Detail", method={RequestMethod.POST}, params={"Action=RentHist"})
	public Map<String,Object> equipmentReport(@RequestBody BusEquipmentReportBean busEquipmentReportBean) {

		log.info("租赁明细统计...........");

		Page<?> page = iEquipmentStatisticsDao.equipmentRentHistReport(busEquipmentReportBean);

		Map<String,Object> resultMap = new HashMap<String,Object>();

		resultMap.put("page", page);
		resultMap.put("busEquipmentReportBean", busEquipmentReportBean);

		return resultMap;
	}

	/**
	 * 信息发布明细 - 列表查询
	 * @author haopeng
	 * @since 2016-08-25
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgCode 单位编码
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equPubType 业务类型
	 * @param equCategoryId 设备分类
	 * @param equName 设备名称（模糊查询）
	 * @return Map<String, Object>
	 */
	@RequestMapping(value="/Detail", method={RequestMethod.POST}, params={"Action=Info"})
	public Map<String,Object> infoPublishReport(@RequestBody BusEquipmentReportBean busEquipmentReportBean){

		log.info("信息发布明细统计...........");

		Page<?> page = iEquipmentStatisticsDao.infoPublishReport(busEquipmentReportBean);

		Map<String,Object> resultMap = new HashMap<String,Object>();

		resultMap.put("page", page);
		resultMap.put("busEquipmentReportBean", busEquipmentReportBean);

		return resultMap;
	}

	/**
	 * 资源汇总 - 列表查询
	 * 按大类或小类统计资源汇总数据，大类需要全部显示，小类有数据的才显示
	 * @author haopeng
	 * @since 2016-08-26
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equCategoryId 设备分类id
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/Detail", method={RequestMethod.POST}, params={"Action=recourcesCollect"})
	public Map<String,Object> recourcesCollect(@RequestBody BusEquipmentReportBean busEquipmentReportBean){

		log.info("资源汇总统计...........");

		List<Map<String,Object>> categoryList = new ArrayList<Map<String,Object>>();

		Long equCategoryId = busEquipmentReportBean.getEquCategoryId();	//	设备分类id
		if(Util.isNullOrEmpty(equCategoryId)){//	按大类统计
			categoryList = iEquipmentStatisticsDao.createCategoryIdList();
		}

		Map<String,Object> resultMap = new HashMap<String,Object>();

		resultMap.put("list", iEquipmentStatisticsDao.resourceStatisticsCollect(busEquipmentReportBean, categoryList));

		return resultMap;
	}

	/**
	 * 租赁汇总 - 列表查询
	 * 按大类或小类统计资源汇总数据，大类需要全部显示，小类有数据的才显示
	 * @author haopeng
	 * @since 2016-08-27
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equCategoryId 设备分类id
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/Collection", method={RequestMethod.POST}, params={"Action=rentCollect"})
	public Map<String,Object> rentCollectInner(@RequestBody BusEquipmentReportBean busEquipmentReportBean) {

		log.info("租赁汇总统计...........");

		List<Map<String,Object>> categoryList = new ArrayList<Map<String,Object>>();

		Long equCategoryId = busEquipmentReportBean.getEquCategoryId();	//	设备分类id
		if(Util.isNullOrEmpty(equCategoryId)){//	按大类统计
			categoryList = iEquipmentStatisticsDao.createCategoryIdList();
		}

		Map<String,Object> resultMap = new HashMap<String,Object>();

		resultMap.put("list", iEquipmentStatisticsDao.rentStatisticsCollect(busEquipmentReportBean, categoryList));
		resultMap.put("busEquipmentReportBean", busEquipmentReportBean);

		return resultMap;
	}

	/**
	 * 信息发布汇总 - 列表查询
	 * 按大类或小类统计资源汇总数据，大类需要全部显示，小类有数据的才显示
	 * @author haopeng
	 * @since 2016-08-27
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equCategoryId 设备分类id
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/Collection", method={RequestMethod.POST}, params={"Action=InfoPublishCollection"})
	public Map<String,Object> infoPublishCollectionReport(@RequestBody BusEquipmentReportBean busEquipmentReportBean){

		log.info("信息汇总统计...........");

		List<Map<String,Object>> categoryList = new ArrayList<Map<String,Object>>();

		Long equCategoryId = busEquipmentReportBean.getEquCategoryId();	//	设备分类id
		if(Util.isNullOrEmpty(equCategoryId)){//	按大类统计
			categoryList = iEquipmentStatisticsDao.createCategoryIdList();
		}

		Map<String,Object> resultMap = new HashMap<String,Object>();

		resultMap.put("list", iEquipmentStatisticsDao.infoPublishCollection(busEquipmentReportBean, categoryList));
		resultMap.put("busEquipmentReportBean", busEquipmentReportBean);

		return resultMap;
	}

}
