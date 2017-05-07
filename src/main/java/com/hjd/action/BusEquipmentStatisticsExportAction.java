package com.hjd.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.BusEquipmentReportBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IEquipmentStatisticsExportDao;
import com.hjd.util.Util;

/**
 * 设备资源 
 * 统计控制器
 * @author Administrator
 *
 */
@RestController
@RequestMapping(value="/BusEquipmentStatisticsExport")
public class BusEquipmentStatisticsExportAction extends BaseAction{

//	@Value("${exportExcelPath}")
//	private String exportExcelPath = "/home/equ_2016/file/media/excelFile";
	@Autowired
	IEquipmentStatisticsExportDao iEquipmentStatisticsExportDao;

	Logger log = Logger.getLogger(BusEquipmentStatisticsExportAction.class);

	/**
	 * 租赁明细 - 导出Excel
	 * @author haopeng
	 * @since 2016-08-25
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equRentType 业务类型
	 * @param equCategoryId 设备分类
	 * @param equName 设备名称（模糊查询）
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/Detail", method={RequestMethod.POST}, params={"Action=RentHistExport"})
	public Map<String,Object> equipmentReportExport(@RequestBody BusEquipmentReportBean busEquipmentReportBean){

		log.info("租赁明细统计 导出Excel...........");

		Integer startNum = busEquipmentReportBean.getStart();	//	起始条数
		if(Util.isNotNullOrEmpty(startNum) && startNum>0){
			busEquipmentReportBean.setStart(startNum - 1);
		}
		else{
			throw new IFException("请输入起始条数！");
		}

		Integer countNum = busEquipmentReportBean.getItemCount();	//	取多少条
		if(Util.isNullOrEmpty(countNum)){
			throw new IFException("请输入导出条数！");
		}

		if(countNum>5000){
			throw new IFException("最多可下载5000条数据，请重新选择下载区间");
		}

		return iEquipmentStatisticsExportDao.equipmentRentHistReportExport(busEquipmentReportBean);
	}

	/**
	 * 资源明细 - 导出Excel
	 * @author haopeng
	 * @since 2016-08-24
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equTrsType 来源
	 * @param equCategoryId 设备分类
	 * @param equName 设备名称（模糊查询）
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/Detail", method={RequestMethod.POST}, params={"Action=Resource"})
	public Map<String,Object> equipmentResourceReport(@RequestBody BusEquipmentReportBean busEquipmentReportBean){

		log.info("资源明细统计 导出Excel...........");

		Integer startNum = busEquipmentReportBean.getStart();	//	起始条数
		if(Util.isNotNullOrEmpty(startNum) && startNum>0){
			busEquipmentReportBean.setStart(startNum - 1);
		}
		else{
			throw new IFException("请输入起始条数！");
		}

		Integer countNum = busEquipmentReportBean.getItemCount();	//	取多少条
		if(Util.isNullOrEmpty(countNum)){
			throw new IFException("请输入导出条数！");
		}

		if(countNum>5000){
			throw new IFException("最多可下载5000条数据，请重新选择下载区间");
		}

		return iEquipmentStatisticsExportDao.equipmentResourceReportExport(busEquipmentReportBean);
	}

	/**
	 * 信息发布明细 - 导出Excel
	 * @author haopeng
	 * @since 2016-08-25
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgCode 单位编码
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equPubType 业务类型
	 * @param equCategoryId 设备分类
	 * @param equName 设备名称（模糊查询）
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/Detail", method={RequestMethod.POST}, params={"Action=Info"})
	public Map<String,Object> infoPublishReport(@RequestBody BusEquipmentReportBean busEquipmentReportBean){

		log.info("信息发布明细统计 导出Excel...........");

		Integer startNum = busEquipmentReportBean.getStart();	//	起始条数
		if(Util.isNotNullOrEmpty(startNum) && startNum>0){
			busEquipmentReportBean.setStart(startNum - 1);
		}
		else{
			throw new IFException("请输入起始条数！");
		}

		Integer countNum = busEquipmentReportBean.getItemCount();	//	取多少条
		if(Util.isNullOrEmpty(countNum)){
			throw new IFException("请输入导出条数！");
		}

		if(countNum>5000){
			throw new IFException("最多可下载5000条数据，请重新选择下载区间");
		}

		return iEquipmentStatisticsExportDao.infoPublishReportExport(busEquipmentReportBean);
	}

	/**
	 * 资源汇总 - 导出Excel
	 * 按大类或小类统计资源汇总数据，大类需要全部显示，小类有数据的才显示
	 * @author haopeng
	 * @since 2016-08-26
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param categoryList 设备分类信息
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/Detail", method={RequestMethod.POST}, params={"Action=recourcesCollect"})
	public Map<String,Object> recourcesCollect(@RequestBody BusEquipmentReportBean busEquipmentReportBean){

		log.info("资源汇总统计 导出Excel...........");

		List<Map<String,Object>> categoryList = iEquipmentStatisticsExportDao.createCategoryIdListExport();

		return iEquipmentStatisticsExportDao.resourceStatisticsCollectExport(busEquipmentReportBean, categoryList);
	}

	/**
	 * 租赁汇总 - 导出Excel
	 * 按大类或小类统计资源汇总数据，大类需要全部显示，小类有数据的才显示
	 * @author haopeng
	 * @since 2016-08-28
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param categoryList 设备分类信息
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/Collection", method={RequestMethod.POST}, params={"Action=rentCollect"})
	public Map<String,Object> rentCollect(@RequestBody BusEquipmentReportBean busEquipmentReportBean){

		log.info("租赁汇总统计 导出Excel...........");

		List<Map<String,Object>> categoryList = iEquipmentStatisticsExportDao.createCategoryIdListExport();

		return iEquipmentStatisticsExportDao.rentStatisticsCollectExport(busEquipmentReportBean, categoryList);
	}

	/**
	 * 信息发布汇总 - 导出Excel
	 * 按大类或小类统计资源汇总数据，大类需要全部显示，小类有数据的才显示
	 * @author haopeng
	 * @since 2016-08-27
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param categoryList 设备分类信息
	 * @return Map<String,Object>
	 */
	@RequestMapping(value="/Collection", method={RequestMethod.POST}, params={"Action=InfoPublishCollection"})
	public Map<String,Object> infoPublishCollectionReportExport(@RequestBody BusEquipmentReportBean busEquipmentReportBean){

		log.info("信息汇总统计 导出Excel...........");

		List<Map<String,Object>> categoryList = iEquipmentStatisticsExportDao.createCategoryIdListExport();

		return iEquipmentStatisticsExportDao.infoPublishCollectionExport(busEquipmentReportBean, categoryList);
	}

	/**
	 * 下载生成的Excel
	 * @param response
	 * @param fileName
	 * @param fileSuffix
	 * @param infofilePath
	 */
	@RequestMapping(value="/Download/{fileName}/{fileSuffix}", method={RequestMethod.GET})
	private void download(@PathVariable String fileName, @PathVariable String fileSuffix, HttpServletResponse response) {

		response.setHeader("Content-type","application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment; filename=" + fileName + "." + fileSuffix);

		String downLoadFileName = "/home/equ_2016/file/media/excelFile/" + fileName + "." + fileSuffix;
		//the release down load excel path
//		String downLoadFileName = exportExcelPath + "/" + fileName + "." + fileSuffix;

		FileInputStream imageIn = null;
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try{
			imageIn = new FileInputStream(downLoadFileName);
			bis = new BufferedInputStream(imageIn);
			bos = new BufferedOutputStream(response.getOutputStream());

			byte data[] = new byte[1024];
			int size = bis.read(data);
			while(size!=-1){
				bos.write(data, 0, size);           
				size = bis.read(data);   
			}
		}
		catch(IOException e){
			e.printStackTrace();
			throw new IFException("下载文件出错！");
		}
		finally{
			try{
				if(imageIn!=null){
					imageIn.close();
				}
				if(bos!=null){
					bos.flush();
				}
				if(bos!=null){
					bos.close();
				}
			}
			catch(IOException e){
				e.printStackTrace();
			}
		}

		if(imageIn!=null){
			imageIn = null;
		}
		if(bos!=null){
			bos = null;
		}
	}

}
