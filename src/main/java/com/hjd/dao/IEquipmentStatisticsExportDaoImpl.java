package com.hjd.dao;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;

import com.hjd.action.bean.BusEquipmentReportBean;
import com.hjd.base.IFException;
import com.hjd.util.BusState;
import com.hjd.util.EquRentType;
import com.hjd.util.EquState;
import com.hjd.util.EquTrsType;
import com.hjd.util.EquUnit;
import com.hjd.util.PubState;
import com.hjd.util.PubType;
import com.hjd.util.RentType;
import com.hjd.util.ReportData;
import com.hjd.util.SettlementModeName;
import com.hjd.util.TechnicalStatus;
import com.hjd.util.Util;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import com.hjd.dao.base.IBaseDaoImpl;

public class IEquipmentStatisticsExportDaoImpl extends IBaseDaoImpl {

//	@Value("${exportExcelPath}")
	private String exportExcelPath = "/home/equ_2016/file/media/excelFile";

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
	public Map<String,Object> equipmentResourceReportExport(BusEquipmentReportBean busEquipmentReportBean) throws IOException, RowsExceededException, WriteException {

		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select * ");
		listSql.append("from view_equ_info vEqu ");	//	设备拥有者和设备使用者的设备信息
		listSql.append("where vEqu.delFlag!=1 and (vEqu.equState in (1,2) or vEqu.equState is null) ");

		//	拼组所属单位/项目的查询条件
		int orgFlag = busEquipmentReportBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
		Long orgPartyId = busEquipmentReportBean.getOrgPartyId();	//	所属单位/项目id
		Integer isInclude = busEquipmentReportBean.getIsInclude();	//	是否包含下级单位：1-包含
		Integer equTrsType = busEquipmentReportBean.getEquTrsType();	//	来源：1-自有，2-内租，3-外租，4-外协
		if(Util.isNullOrEmpty(orgFlag)){
			throw new IFException("所属单位信息不能为空！");
		}

		//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
		if(orgFlag==9){//	总公司
			if(Util.isNotNullOrEmpty(equTrsType)){//	拼组来源的查询条件
				if(1==equTrsType){//	自有
					listSql.append("and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgParTypeId=4 ");
				}
				else if(2==equTrsType){//	内租
					throw new IFException("当前单位为总公司时，无内租！");
				}
				else if(3==equTrsType){//	外租
					listSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.bureauOrgParTypeId=4) or (vEqu.busState=5 and vEqu.equAtOrgParTypeId=4)) ");
				}
				else{//	外协
					listSql.append("and vEqu.equipmentSourceNo=3 and vEqu.bureauOrgParTypeId=4 ");
				}
			}
			else{
				listSql.append("and (vEqu.bureauOrgParTypeId=4 or vEqu.equAtOrgParTypeId=4) ");
			}
		}
		else if(orgFlag==8){//	外部单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			listSql.append("and ((vEqu.bureauOrgParTypeId=8 and vEqu.bureauOrgPartyId=:orgPartyId) or (vEqu.equAtOrgParTypeId=8 and vEqu.equAtOrgId=:orgPartyId)) ");
		}
		else if(orgFlag==1){//	局级单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			if(Util.isNotNullOrEmpty(equTrsType)){//	拼组来源的查询条件
				if(isInclude!=null && isInclude==1){
					if(1==equTrsType){//	自有
						listSql.append("and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.equipmentSourceNo=1 ");
					}
					else if(2==equTrsType){//	内租
						listSql.append("and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.busState=4 ");
					}
					else if(3==equTrsType){//	外租
						listSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.bureauOrgPartyId=:orgPartyId) or (vEqu.busState=5 and vEqu.equAtOrgId=:orgPartyId)) ");
					}
					else{//	外协
						listSql.append("and vEqu.equipmentSourceNo=3 and vEqu.bureauOrgPartyId=:orgPartyId ");
					}
				}
				else{
					if(1==equTrsType){//	自有
						listSql.append("and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.equipmentSourceNo=1 and vEqu.sonOrgPartyId is null ");
					}
					else if(2==equTrsType){//	内租
						listSql.append("and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.busState=4 and vEqu.sonOrgPartyId is null ");
					}
					else if(3==equTrsType){//	外租
						listSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null) or (vEqu.busState=5 and vEqu.equAtOrgId=:orgPartyId and vEqu.equAtSubOrgId is null)) ");
					}
					else{//	外协
						listSql.append("and vEqu.equipmentSourceNo=3 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null ");
					}
				}
			}
			else{
				if(isInclude!=null && isInclude==1){
					listSql.append("and (vEqu.bureauOrgPartyId=:orgPartyId or vEqu.equAtOrgId=:orgPartyId) ");
				}
				else{
					listSql.append("and ((vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null) or (vEqu.equAtOrgId=:orgPartyId and vEqu.equAtSubOrgId is null)) ");
				}
			}
		}
		else if(orgFlag==2){//	处级单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			if(Util.isNotNullOrEmpty(equTrsType)){//	拼组来源的查询条件
				if(1==equTrsType){//	自有
					listSql.append("and vEqu.sonOrgPartyId=:orgPartyId and vEqu.equipmentSourceNo=1 ");
				}
				else if(2==equTrsType){//	内租
					listSql.append("and vEqu.sonOrgPartyId=:orgPartyId and vEqu.busState in (3,4) ");
				}
				else if(3==equTrsType){//	外租
					listSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.sonOrgPartyId=:orgPartyId) or (vEqu.busState=5 and vEqu.equAtSubOrgId=:orgPartyId)) ");
				}
				else{//	外协
					listSql.append("and vEqu.equipmentSourceNo=3 and vEqu.sonOrgPartyId=:orgPartyId ");
				}
			}
			else{
				listSql.append("and (vEqu.sonOrgPartyId=:orgPartyId or vEqu.equAtSubOrgId=:orgPartyId) ");
			}
		}
		else if(orgFlag==3){//	项目
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			if(Util.isNotNullOrEmpty(equTrsType)){//	拼组来源的查询条件
				if(1==equTrsType){//	自有
					listSql.append("and vEqu.proOrgPartyId=:orgPartyId and vEqu.equipmentSourceNo=1 ");
				}
				else if(2==equTrsType){//	内租
					listSql.append("and vEqu.proOrgPartyId=:orgPartyId and vEqu.busState in (3,4) ");
				}
				else if(3==equTrsType){//	外租
					listSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.proOrgPartyId=:orgPartyId) or (vEqu.busState=5 and vEqu.equAtProjectId=:orgPartyId)) ");
				}
				else{//	外协
					listSql.append("and vEqu.equipmentSourceNo=3 and vEqu.proOrgPartyId=:orgPartyId ");
				}
			}
			else{
				listSql.append("and (vEqu.proOrgPartyId=:orgPartyId or vEqu.equAtProjectId=:orgPartyId) ");
			}
		}
		else{
			throw new IFException("所属单位信息错误！");
		}

		//	拼组设备分类的查询条件
		Long equCategoryId = busEquipmentReportBean.getEquCategoryId();	//	设备分类
		if(Util.isNotNullOrEmpty(equCategoryId)){
			sqlParamsMap.put("equCategoryId", equCategoryId);
			listSql.append("and vEqu.equCategoryId=:equCategoryId ");
		}

		//	拼组设备名称的查询条件
		String equName = busEquipmentReportBean.getEquName();	//	设备名称
		if(Util.isNotNullOrEmpty(equName)){
			sqlParamsMap.put("equName", "%" + equName + "%");
			listSql.append("and vEqu.equName like :equName ");
		}

		//	按照设备编号升序
		listSql.append("order by vEqu.equNo ");

		listSql.append("limit ").append(busEquipmentReportBean.getStart()).append(",").append(busEquipmentReportBean.getItemCount());

		//	创建原生SQL查询QUERY实例
		List<Map<String,Object>> list = query(listSql.toString(), sqlParamsMap);

		//	结果集为空时，直接返回
		if(list==null){
			throw new IFException("没有符合条件的记录！");
		}

		if(list.size()<=0){
			throw new IFException("没有符合条件的记录！");
		}

		//	标题行
		String title[] = {"设备编号","来源","资产编号","设备名称","规格","型号","品牌","生产厂家","技术状况","功率（KW）","原值（万元）","累计折旧（万元）","净值（万元）","出厂日期","出厂编号","购置日期","牌照号码","设备状态","业务状态","进场日期","使用单位","联系人","联系电话","设备所在地"};
		String fileName = "equDetail_" + System.currentTimeMillis() + ".xls";
		//	t.xls为要新建的文件名
		WritableWorkbook book = Workbook.createWorkbook(new File(exportExcelPath + "/" + fileName));
		//	生成名为“第一页”的工作表，参数0表示这是第一页
		WritableSheet sheet=book.createSheet("第一页",0); 

		//	写入标题
		for(int i=0;i<24;i++){
			sheet.addCell(new Label(i,0,title[i])); //写标题
		}

		int line = 1;	//	起始行

		//	对返回的资源进行处理，根据orgFlag、equipmentSourceNo和busState，来显示来源；根据局级名称、项目名称，来显示单位名称
		for(Map<String,Object> map : list){
			//	根据orgFlag、equipmentSourceNo和busState，来显示来源
			Integer equipmentSourceNo = Integer.parseInt(Util.toStringAndTrim(map.get("EquipmentSourceNo")));
			Integer bureauOrgParTypeId = Integer.parseInt(Util.toStringAndTrim(map.get("BureauOrgParTypeId")));
			Integer result_equTrsType = null;
			Integer busState = Util.isNotNullOrEmpty(map.get("BusState")) ? Integer.parseInt(Util.toStringAndTrim(map.get("BusState"))) : null;
			if(orgFlag==9){//	总公司
				if(1==equipmentSourceNo){
					if(4==bureauOrgParTypeId){//	自有
						result_equTrsType = 1;
					}
					else{//	外租
						result_equTrsType = 3;
					}
				}
				else if(2==equipmentSourceNo){//	外租
					result_equTrsType = 3;
				}
				else if(3==equipmentSourceNo){//	外协
					result_equTrsType = 4;
				}
			}
			else if(orgFlag==8){//	外部单位
				result_equTrsType = 1;
			}
			else if(orgFlag==1){//	局级单位
				if(1==equipmentSourceNo){
					if(Util.isNullOrEmpty(busState)){//	自有
						result_equTrsType = 1;
					}
					else if(4==busState){//	内租
						result_equTrsType = 2;
					}
					else{//	自有
						result_equTrsType = 1;
					}
				}
				else if(2==equipmentSourceNo){//	外租
					result_equTrsType = 3;
				}
				else if(3==equipmentSourceNo){//	外协
					result_equTrsType = 4;
				}

				if(1==result_equTrsType){
					if(4==bureauOrgParTypeId){//	自有
						result_equTrsType = 1;
					}
					else{//	外租
						result_equTrsType = 3;
					}
				}
			}
			else if(orgFlag==2){//	处级单位
				if(1==equipmentSourceNo){
					if(Util.isNullOrEmpty(busState)){//	自有
						result_equTrsType = 1;
					}
					else if(4==busState || 3==busState){//	内租
						result_equTrsType = 2;
					}
					else{//	自有
						result_equTrsType = 1;
					}
				}
				else if(2==equipmentSourceNo){//	外租
					result_equTrsType = 3;
				}
				else if(3==equipmentSourceNo){//	外协
					result_equTrsType = 4;
				}

				if(1==result_equTrsType){
					if(4==bureauOrgParTypeId){//	自有
						result_equTrsType = 1;
					}
					else{//	外租
						result_equTrsType = 3;
					}
				}
			}
			else if(orgFlag==3){//	项目
				if(1==equipmentSourceNo){
					if(Util.isNullOrEmpty(busState)){//	自有
						result_equTrsType = 1;
					}
					else if(4==busState || 3==busState){//	内租
						result_equTrsType = 2;
					}
					else{//	自有
						result_equTrsType = 1;
					}
				}
				else if(2==equipmentSourceNo){//	外租
					result_equTrsType = 3;
				}
				else if(3==equipmentSourceNo){//	外协
					result_equTrsType = 4;
				}

				if(1==result_equTrsType){
					if(4==bureauOrgParTypeId){//	自有
						result_equTrsType = 1;
					}
					else{//	外租
						result_equTrsType = 3;
					}
				}
			}

			//	根据局级名称、项目名称，来显示单位名称
			String equAtProjectName = Util.toStringAndTrim(map.get("EquAtProjectName"));
			String disEquAtName = "";
			if(Util.isNullOrEmpty(equAtProjectName)){
				disEquAtName = Util.toStringAndTrim(map.get("EquAtOrgName"));
			}
			else{
				disEquAtName = equAtProjectName;
			}

			//	写内容
			sheet.addCell(new Label(0, line, Util.toStringAndTrim(map.get("EquNo"))));	//	设备编号

			sheet.addCell(new Label(1, line, EquTrsType.getInstance(result_equTrsType).getTypeName()));	//	来源（翻译）

			sheet.addCell(new Label(2, line, Util.toStringAndTrim(map.get("Asset")))); //	资产编号
			sheet.addCell(new Label(3, line, Util.toStringAndTrim(map.get("EquName"))));	//	设备名称
			sheet.addCell(new Label(4, line, Util.toStringAndTrim(map.get("Specifications"))));	//	规格
			sheet.addCell(new Label(5, line, Util.toStringAndTrim(map.get("Models"))));	//	型号
			sheet.addCell(new Label(6, line, Util.toStringAndTrim(map.get("BrandName"))));	//	品牌
			sheet.addCell(new Label(7, line, Util.toStringAndTrim(map.get("ManufacturerName"))));	//	生产厂家

			sheet.addCell(new Label(8, line, Util.isNotNullOrEmpty(map.get("TechnicalStatus")) ? TechnicalStatus.getInstance(Integer.parseInt(Util.toStringAndTrim(map.get("TechnicalStatus")))).getTypeName() : ""));	//	技术状况（翻译）

			sheet.addCell(new Label(9, line, Util.isNotNullOrEmpty(map.get("Power")) ? Util.toStringAndTrim(map.get("Power")) : ""));	//	功率

			BigDecimal equipmentCost = Util.isNotNullOrEmpty(map.get("EquipmentCost")) ? new BigDecimal(Util.toStringAndTrim(map.get("EquipmentCost"))) : BigDecimal.ZERO; //	原值（万元）
			sheet.addCell(new Label(10, line, Util.toStringAndTrim(equipmentCost)));
			BigDecimal totalDepreciation = Util.isNotNullOrEmpty(map.get("TotalDepreciation")) ? new BigDecimal(Util.toStringAndTrim(map.get("TotalDepreciation"))) : BigDecimal.ZERO;	//	累计折旧（万元）
			sheet.addCell(new Label(11, line, Util.toStringAndTrim(totalDepreciation)));
			sheet.addCell(new Label(12, line, Util.toStringAndTrim(equipmentCost.subtract(totalDepreciation))));	//	净值（万元）

			sheet.addCell(new Label(13, line, Util.isNotNullOrEmpty(map.get("ProductionDate")) ? Util.convertDateToStr((Date)map.get("ProductionDate"), "yyyy-MM-dd") : ""));	//	出厂日期
			sheet.addCell(new Label(14, line, Util.toStringAndTrim(map.get("FacortyNo"))));	//	出厂编号
			sheet.addCell(new Label(15, line, Util.isNotNullOrEmpty(map.get("PurchaseDate")) ? Util.convertDateToStr((Date)map.get("PurchaseDate"), "yyyy-MM-dd") : ""));	//	购置日期
			sheet.addCell(new Label(16, line, Util.toStringAndTrim(map.get("LicenseNo"))));	//	牌照号码
			sheet.addCell(new Label(17, line, Util.isNotNullOrEmpty(map.get("EquState")) ? EquState.getInstance(Integer.parseInt(Util.toStringAndTrim(map.get("EquState")))).getTypeName() : ""));	//	设备状态（翻译）
			sheet.addCell(new Label(18, line, Util.isNotNullOrEmpty(busState) ? BusState.getInstance(busState).getTypeName() : ""));	//	业务状态（翻译）
			sheet.addCell(new Label(19, line, Util.isNotNullOrEmpty(map.get("ApproachDate")) ? Util.convertDateToStr((Date)map.get("ApproachDate"), "yyyy-MM-dd") : ""));	//	进场日期
			sheet.addCell(new Label(20, line, disEquAtName));	//	使用单位
			sheet.addCell(new Label(21, line, Util.toStringAndTrim(map.get("Custodian"))));	//	联系人
			sheet.addCell(new Label(22, line, Util.toStringAndTrim(map.get("ContactPersonPhone"))));	//	联系电话
			//	设备所在地
			StringBuffer sb = new StringBuffer();

			sb.append(map.get("OnProvince")).append(map.get("OnCity")).append(map.get("OnDistrict"));
			sheet.addCell(new Label(23, line, sb.toString())); //设备所在地

			line += 1;
		}

		//	写入数据
		book.write();
		//	关闭文件
		book.close();

		Map<String,Object> fileMap = new HashMap<String,Object>();

		int offset = fileName.lastIndexOf(".");
		fileName = fileName.substring(0, offset) + "/" + fileName.substring(offset + 1);
		fileMap.put("excel", fileName);

		return fileMap;
	}

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
	public Map<String,Object> equipmentRentHistReportExport(BusEquipmentReportBean busEquipmentReportBean) throws RowsExceededException, WriteException, IOException {

		Date now = new Date();

		if(Util.isNullOrEmpty(busEquipmentReportBean.getStartMonth())){
			busEquipmentReportBean.setStartMonth(Util.convertDateToStr(now, "yyyy-MM"));
		}

		if(Util.isNullOrEmpty(busEquipmentReportBean.getEndMonth())){
			busEquipmentReportBean.setEndMonth(Util.convertDateToStr(now, "yyyy-MM"));
		}

		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		sqlParamsMap.put("startMonth", busEquipmentReportBean.getStartMonth());
		sqlParamsMap.put("endMonth", busEquipmentReportBean.getEndMonth());

		//	拼组起始月份和截止月份的查询条件

		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select distinct vEqu.equipmentId AS equipmentId, vEqu.equNo as equNo, vEqu.asset as asset, vEqu.equName as equName, vEqu.specifications as specifications, vEqu.models as models, vEqu.equState as equState, ");
		listSql.append("vEqu.bureauOrgParTypeId as bureauOrgParTypeId, vEqu.bureauOrgPartyId as bureauOrgPartyId, vEqu.bureauOrgPartyName as bureauOrgPartyName, vEqu.busState as busState, ");
		listSql.append("vEqu.sonOrgPartyId as sonOrgPartyId, vEqu.proOrgPartyId as proOrgPartyId, vEqu.proOrgName as proOrgName, depreciation.depreciation as depreciation, ");
		listSql.append("vEqu.approachDate as approachDate, vEqu.exitDate as exitDate, vEqu.settlementModeName as settlementModeName, vEqu.scrapPrice as scrapPrice, vEqu.sellPrice as sellPrice, ");
		listSql.append("vRent.month as month, vRent.cost as cost, vRent.rentCount as rentCount, vRent.rentType as rentType, vRent.rent as rent, ");
		listSql.append("vRent.deductCost as deductCost, vRent.amount as amount, vRent.sonOrgPartyId as equAtSonOrgPartyId, vRent.proOrgPartyId as equAtProOrgPartyId, vRent.proOrgName as equAtProOrgName, ");
		listSql.append("vRent.bureauParTypeId as equAtBureauParTypeId, vRent.bureauOrgPartyId as equAtBureauOrgPartyId, vRent.bureauOrgName as equAtBureauOrgName ");
		listSql.append("from view_equ_info vEqu ");	//	设备拥有者和设备使用者的设备信息
		listSql.append("left join view_rent_info vRent on vEqu.equipmentId=vRent.equipmentId and vRent.month>=:startMonth and vRent.month<=:endMonth ");
		listSql.append("left join bus_depreciation_hist depreciation on vEqu.equipmentId=depreciation.equipmentId and depreciation.month>=:startMonth and depreciation.month<=:endMonth ");
		listSql.append("where date_format(vEqu.createTime, '%Y-%m')>=:startMonth and date_format(vEqu.createTime, '%Y-%m')<=:endMonth ");

		//	拼组所属单位/项目的查询条件
		int orgFlag = busEquipmentReportBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
		Long orgPartyId = busEquipmentReportBean.getOrgPartyId();	//	所属单位/项目id
		Integer isInclude = busEquipmentReportBean.getIsInclude();	//	是否包含下级单位：1-包含
		Integer equRentType = busEquipmentReportBean.getEquRentType();	//	业务类型：1-自有，2-局内租，3-外局租，4-外租，5-作废，6-出售
		if(Util.isNullOrEmpty(orgFlag)){
			throw new IFException("所属单位信息不能为空！");
		}

		//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
		if(orgFlag==9){//	总公司
			if(Util.isNotNullOrEmpty(equRentType)){//	拼组来源的查询条件
				if(1==equRentType){//	自有
					listSql.append("and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgParTypeId=4 and (vEqu.equState in (1,2) or vEqu.equState is null) ");
				}
				else if(2==equRentType){//	局内租
					throw new IFException("当前单位为总公司时，无局内租！");
				}
				else if(3==equRentType){//	外局租
					throw new IFException("当前单位为总公司时，无外局租！");
				}
				else if(4==equRentType){//	外租
					listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=5 ");
				}
				else if(5==equRentType){//	报废
					listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=4 ");
				}
				else{//	出售
					listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=3 ");
				}
			}
			else{
				listSql.append("and ((vEqu.bureauOrgParTypeId=4 and vEqu.equipmentSourceNo=1) or (vRent.bureauParTypeId=4 and vEqu.busState in (3,4,5))) ");
			}
		}
		else if(orgFlag==8){//	外部单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			if(Util.isNotNullOrEmpty(equRentType)){//	拼组来源的查询条件
				if(1==equRentType){//	自有
					listSql.append("and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgParTypeId=8 and vEqu.bureauOrgPartyId=:orgPartyId and (vEqu.equState in (1,2) or vEqu.equState is null) ");
				}
				else if(4==equRentType){//	外租
					listSql.append("and vRent.bureauParTypeId=8 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId ");
				}
				else if(5==equRentType){//	报废
					listSql.append("and vEqu.bureauOrgParTypeId=8 and vEqu.equState=4 and vEqu.bureauOrgPartyId=:orgPartyId ");
				}
				else{//	出售
					listSql.append("and vEqu.bureauOrgParTypeId=8 and vEqu.equState=3 and vEqu.bureauOrgPartyId=:orgPartyId ");
				}
			}
			else{
				listSql.append("and ((vEqu.bureauOrgParTypeId=8 and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgPartyId=:orgPartyId) or (vRent.bureauParTypeId=8 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId)) ");
			}
		}
		else if(orgFlag==1){//	局级单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			if(Util.isNotNullOrEmpty(equRentType)){//	拼组来源的查询条件
				if(isInclude!=null && isInclude==1){
					if(1==equRentType){//	自有
						listSql.append("and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgParTypeId=4 and vEqu.bureauOrgPartyId=:orgPartyId and (vEqu.equState in (1,2) or vEqu.equState is null) ");
					}
					else if(2==equRentType){//	局内租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=3 and vRent.bureauOrgPartyId=:orgPartyId ");
					}
					else if(3==equRentType){//	外局租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=4 and vRent.bureauOrgPartyId=:orgPartyId ");
					}
					else if(4==equRentType){//	外租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId ");
					}
					else if(5==equRentType){//	报废
						listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=4 and vEqu.bureauOrgPartyId=:orgPartyId ");
					}
					else{//	出售
						listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=3 and vEqu.bureauOrgPartyId=:orgPartyId ");
					}
				}
				else{
					if(1==equRentType){//	自有
						listSql.append("and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgParTypeId=4 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null and (vEqu.equState in (1,2) or vEqu.equState is null) ");
					}
					else if(2==equRentType){//	局内租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=3 and vRent.bureauOrgPartyId=:orgPartyId and vRent.sonOrgPartyId is null ");
					}
					else if(3==equRentType){//	外局租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=4 and vRent.bureauOrgPartyId=:orgPartyId and vRent.sonOrgPartyId is null ");
					}
					else if(4==equRentType){//	外租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId and vRent.sonOrgPartyId is null ");
					}
					else if(5==equRentType){//	报废
						listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=4 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null ");
					}
					else{//	出售
						listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=3 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null ");
					}
				}
			}
			else{
				if(isInclude!=null && isInclude==1){
					listSql.append("and ((vEqu.bureauOrgParTypeId=4 and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgPartyId=:orgPartyId) or (vRent.bureauParTypeId=4 and vEqu.busState in (3,4,5) and vRent.bureauOrgPartyId=:orgPartyId)) ");
				}
				else{
					listSql.append("and ((vEqu.bureauOrgParTypeId=4 and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgPartyId=:orgPartyId) or (vRent.bureauParTypeId=4 and vEqu.busState in (3,4,5) and vRent.bureauOrgPartyId=:orgPartyId)) ");
				}
			}
		}
		else if(orgFlag==2){//	处级单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			if(Util.isNotNullOrEmpty(equRentType)){//	拼组来源的查询条件
				if(1==equRentType){//	自有
					listSql.append("and vEqu.equipmentSourceNo=1 and vEqu.sonOrgPartyId=:orgPartyId and (vEqu.equState in (1,2) or vEqu.equState is null) ");
				}
				else if(2==equRentType){//	局内租
					listSql.append("and vEqu.busState=3 and vRent.sonOrgPartyId=:orgPartyId ");
				}
				else if(3==equRentType){//	外局租
					listSql.append("and vEqu.busState=4 and vRent.sonOrgPartyId=:orgPartyId ");
				}
				else if(4==equRentType){//	外租
					listSql.append("and vEqu.busState=5 and vRent.sonOrgPartyId=:orgPartyId ");
				}
				else if(5==equRentType){//	报废
					listSql.append("and vEqu.equState=4 and vEqu.sonOrgPartyId=:orgPartyId ");
				}
				else{//	出售
					listSql.append("and vEqu.equState=3 and vEqu.sonOrgPartyId=:orgPartyId ");
				}
			}
			else{
				listSql.append("and ((vEqu.equipmentSourceNo=1 and vEqu.sonOrgPartyId=:orgPartyId) or (vEqu.busState in (3,4,5) and vRent.sonOrgPartyId=:orgPartyId)) ");
			}
		}
		else if(orgFlag==3){//	项目
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			if(Util.isNotNullOrEmpty(equRentType)){//	拼组来源的查询条件
				if(1==equRentType){//	自有
					listSql.append("and vEqu.equipmentSourceNo=1 and vEqu.proOrgPartyId=:orgPartyId and (vEqu.equState in (1,2) or vEqu.equState is null) ");
				}
				else if(2==equRentType){//	局内租
					listSql.append("and vEqu.busState=3 and vRent.proOrgPartyId=:orgPartyId ");
				}
				else if(3==equRentType){//	外局租
					listSql.append("and vEqu.busState=4 and vRent.proOrgPartyId=:orgPartyId ");
				}
				else if(4==equRentType){//	外租
					listSql.append("and vEqu.busState=5 and vRent.proOrgPartyId=:orgPartyId ");
				}
				else if(5==equRentType){//	报废
					listSql.append("and vEqu.equState=4 and vEqu.proOrgPartyId=:orgPartyId ");
				}
				else{//	出售
					listSql.append("and vEqu.equState=3 and vEqu.proOrgPartyId=:orgPartyId ");
				}
			}
			else{
				listSql.append("and ((vEqu.equipmentSourceNo=1 and vEqu.proOrgPartyId=:orgPartyId) or (vEqu.busState in (3,4,5) and vRent.proOrgPartyId=:orgPartyId)) ");
			}
		}
		else{
			throw new IFException("所属单位信息错误！");
		}

		//	拼组设备分类的查询条件
		Long equCategoryId = busEquipmentReportBean.getEquCategoryId();	//	设备分类
		if(Util.isNotNullOrEmpty(equCategoryId)){
			sqlParamsMap.put("equCategoryId", equCategoryId);
			listSql.append("and vEqu.equCategoryId=:equCategoryId ");
		}

		//	拼组设备名称的查询条件
		String equName = busEquipmentReportBean.getEquName();	//	设备名称
		if(Util.isNotNullOrEmpty(equName)){
			sqlParamsMap.put("equName", "%" + equName + "%");
			listSql.append("and vEqu.equName like :equName ");
		}

		//	按照设备编号升序
		listSql.append("order by vEqu.equNo ");

		listSql.append("limit ").append(busEquipmentReportBean.getStart()).append(",").append(busEquipmentReportBean.getItemCount());

		//	创建原生SQL查询QUERY实例
		List<Map<String,Object>> list = query(listSql.toString(), sqlParamsMap);

		//	结果集为空时，直接返回
		if(list==null){
			throw new IFException("没有符合条件的记录！");
		}

		if(list.size()<=0){
			throw new IFException("没有符合条件的记录！");
		}

		//	标题行
		String title[] = {"设备编号","资产编号","设备名称","规格","型号","拥有单位","使用单位","租赁所属年月","业务类型","本期折旧金额（万元）","进场日期","出场日期","进出场费用（万元）","结算方式","租期数","租期单位","租赁单价（万元）","租赁金额（万元）","报废残值（万元）","出售售价（万元）"};
		String fileName = "rentDetail_" + System.currentTimeMillis() + ".xls";
		//	t.xls为要新建的文件名
		WritableWorkbook book = Workbook.createWorkbook(new File(exportExcelPath + "/" + fileName));
		//	生成名为“第一页”的工作表，参数0表示这是第一页
		WritableSheet sheet=book.createSheet("第一页",0); 

		//	写入标题
		for(int i=0;i<20;i++){
			sheet.addCell(new Label(i,0,title[i])); //写标题
		}

		int line = 1;	//	起始行

		//	对返回的租赁进行处理，根据equState和busState，来显示业务类型；根据拥有局级单位名称和拥有项目名称，来显示拥有单位名称；根据使用局级单位名称和使用项目名称，来显示使用单位名称
		BigDecimal conversion =new BigDecimal("10000");

		for(Map<String,Object> equInfo : list){
			Integer equState = Integer.parseInt(Util.toStringAndTrim(equInfo.get("equState")));
			Integer busState = Util.isNotNullOrEmpty(equInfo.get("busState")) ? Integer.parseInt(Util.toStringAndTrim(equInfo.get("busState"))) : null;
			Integer bureauOrgParTypeId = Util.isNotNullOrEmpty(equInfo.get("bureauOrgParTypeId")) ? Integer.parseInt(Util.toStringAndTrim(equInfo.get("bureauOrgParTypeId"))) : null;
			Long bureauOrgPartyId = Util.isNotNullOrEmpty(equInfo.get("bureauOrgPartyId")) ? Long.parseLong(Util.toStringAndTrim(equInfo.get("bureauOrgPartyId"))) : null;
			Long sonOrgPartyId = Util.isNotNullOrEmpty(equInfo.get("sonOrgPartyId")) ? Long.parseLong(Util.toStringAndTrim(equInfo.get("sonOrgPartyId"))) : null;
			Long proOrgPartyId = Util.isNotNullOrEmpty(equInfo.get("proOrgPartyId")) ? Long.parseLong(Util.toStringAndTrim(equInfo.get("proOrgPartyId"))) : null;
			//	对返回的租赁进行处理，根据orgFlag、equState和busState，来显示业务类型
			if(4==equState){//	报废
				equInfo.put("equRentType", 5);
			}
			else if(3==equState){//	出售
				equInfo.put("equRentType", 6);
			}
			else{
				if(orgFlag==9){//	总公司
					if(bureauOrgParTypeId==4){//	自有
						equInfo.put("equRentType", 1);
					}
					else{
						if(Util.isNullOrEmpty(busState)){//	自有
							equInfo.put("equRentType", 1);
						}
						else if(5==busState){//	外租
							equInfo.put("equRentType", 4);
						}
						else{//	自有
							equInfo.put("equRentType", 1);
						}
					}
				}
				else if(orgFlag==8){//	外部单位
					if(bureauOrgParTypeId==8){//	自有
						equInfo.put("equRentType", 1);
					}
					else{
						if(Util.isNullOrEmpty(busState)){//	自有
							equInfo.put("equRentType", 1);
						}
						else if(5==busState){//	外租
							equInfo.put("equRentType", 4);
						}
						else{//	自有
							equInfo.put("equRentType", 1);
						}
					}
				}
				else if(orgFlag==1){//	局级单位
					if(orgPartyId.equals(bureauOrgPartyId)){//	自有
						equInfo.put("equRentType", 1);
					}
					else{
						if(Util.isNullOrEmpty(busState)){//	自有
							equInfo.put("equRentType", 1);
						}
						else if(3==busState){//	局内租
							equInfo.put("equRentType", 2);
						}
						else if(4==busState){//	外局租
							equInfo.put("equRentType", 3);
						}
						else if(5==busState){//	外租
							equInfo.put("equRentType", 4);
						}
						else{//	自有
							equInfo.put("equRentType", 1);
						}
					}
				}
				else if(orgFlag==2){//	处级单位
					if(orgPartyId.equals(sonOrgPartyId)){//	自有
						equInfo.put("equRentType", 1);
					}
					else{
						if(Util.isNullOrEmpty(busState)){//	自有
							equInfo.put("equRentType", 1);
						}
						else if(3==busState){//	局内租
							equInfo.put("equRentType", 2);
						}
						else if(4==busState){//	外局租
							equInfo.put("equRentType", 3);
						}
						else if(5==busState){//	外租
							equInfo.put("equRentType", 4);
						}
						else{//	自有
							equInfo.put("equRentType", 1);
						}
					}
				}
				else if(orgFlag==3){//	项目
					if(orgPartyId.equals(proOrgPartyId)){//	自有
						equInfo.put("equRentType", 1);
					}
					else{
						if(Util.isNullOrEmpty(busState)){//	自有
							equInfo.put("equRentType", 1);
						}
						else if(3==busState){//	局内租
							equInfo.put("equRentType", 2);
						}
						else if(4==busState){//	外局租
							equInfo.put("equRentType", 3);
						}
						else if(5==busState){//	外租
							equInfo.put("equRentType", 4);
						}
						else{//	自有
							equInfo.put("equRentType", 1);
						}
					}
				}
			}

			//	根据拥有局级单位名称和拥有项目名称，来显示拥有单位名称
			if(Util.isNullOrEmpty(equInfo.get("proOrgName"))){
				equInfo.put("disOrgName", equInfo.get("bureauOrgPartyName"));
			}
			else{
				equInfo.put("disOrgName", equInfo.get("proOrgName"));
			}

			//	根据使用局级单位名称和使用项目名称，来显示使用单位名称
			if(Util.isNullOrEmpty(equInfo.get("equAtProOrgName"))){
				equInfo.put("disEquAtOrgName", equInfo.get("equAtBureauOrgName"));
			}
			else{
				equInfo.put("disEquAtOrgName", equInfo.get("equAtProOrgName"));
			}

			//	本期折旧金额（万元）
			BigDecimal depreciation = Util.isNotNullOrEmpty(equInfo.get("depreciation")) ? new BigDecimal(Util.toStringAndTrim(equInfo.get("depreciation"))) : BigDecimal.ZERO;
			equInfo.put("depreciation", depreciation.divide(conversion));

			//	进出场费用（万元）
			BigDecimal cost = Util.isNotNullOrEmpty(equInfo.get("cost")) ? new BigDecimal(Util.toStringAndTrim(equInfo.get("cost"))) : BigDecimal.ZERO;
			equInfo.put("cost", cost.divide(conversion));

			//	租赁单价（万元）
			BigDecimal rent = Util.isNotNullOrEmpty(equInfo.get("rent")) ? new BigDecimal(Util.toStringAndTrim(equInfo.get("rent"))) : BigDecimal.ZERO;
			equInfo.put("rent", rent.divide(conversion));

			//	租赁金额（万元）
			BigDecimal deductCost = Util.isNotNullOrEmpty(equInfo.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(equInfo.get("deductCost"))) : BigDecimal.ZERO;
			deductCost = deductCost.divide(conversion);
			BigDecimal amount = Util.isNotNullOrEmpty(equInfo.get("amount")) ? new BigDecimal(Util.toStringAndTrim(equInfo.get("amount"))) : BigDecimal.ZERO;
			amount = amount.divide(conversion);

			equInfo.put("rentTotalAmt", deductCost.add(cost).subtract(amount));

			//	报废残值
			BigDecimal scrapPrice = Util.isNotNullOrEmpty(equInfo.get("scrapPrice")) ? new BigDecimal(Util.toStringAndTrim(equInfo.get("scrapPrice"))) : BigDecimal.ZERO;
			equInfo.put("scrapPrice", scrapPrice);

			//	出售售价
			BigDecimal sellPrice = Util.isNotNullOrEmpty(equInfo.get("sellPrice")) ? new BigDecimal(Util.toStringAndTrim(equInfo.get("sellPrice"))) : BigDecimal.ZERO;
			equInfo.put("sellPrice", sellPrice);

			//	写内容
			sheet.addCell(new Label(0, line, Util.toStringAndTrim(equInfo.get("equNo"))));	//	设备编号
			sheet.addCell(new Label(1, line, Util.toStringAndTrim(equInfo.get("asset"))));	//	资产编号
			sheet.addCell(new Label(2, line, Util.toStringAndTrim(equInfo.get("equName"))));	//	设备名称
			sheet.addCell(new Label(3, line, Util.toStringAndTrim(equInfo.get("specifications"))));	//	规格
			sheet.addCell(new Label(4, line, Util.toStringAndTrim(equInfo.get("models"))));	//	型号
			sheet.addCell(new Label(5, line, Util.toStringAndTrim(equInfo.get("disOrgName"))));	//	拥有单位
			sheet.addCell(new Label(6, line, Util.toStringAndTrim(equInfo.get("disEquAtOrgName"))));	//	使用单位
			sheet.addCell(new Label(7, line, Util.toStringAndTrim(equInfo.get("month"))));	//	租赁年月
			sheet.addCell(new Label(8, line, EquRentType.getInstance(Integer.parseInt(Util.toStringAndTrim(equInfo.get("equRentType")))).getTypeName()));	//	业务类型（翻译）
			sheet.addCell(new Label(9, line, Util.toStringAndTrim(equInfo.get("depreciation"))));	//	本期折旧金额（万元）
			sheet.addCell(new Label(10, line, Util.isNotNullOrEmpty(equInfo.get("approachDate")) ? Util.convertDateToStr((Date)equInfo.get("approachDate"), "yyyy-MM-dd") : ""));	//	进场日期
			sheet.addCell(new Label(11, line, Util.isNotNullOrEmpty(equInfo.get("exitDate")) ? Util.convertDateToStr((Date)equInfo.get("exitDate"), "yyyy-MM-dd") : ""));	//	出场日期
			sheet.addCell(new Label(12, line, Util.toStringAndTrim(equInfo.get("cost"))));	//	进出场费用
			sheet.addCell(new Label(13, line, Util.isNotNullOrEmpty(equInfo.get("settlementModeName")) ? SettlementModeName.getInstance(Integer.parseInt(Util.toStringAndTrim(equInfo.get("settlementModeName")))).getTypeName() : ""));	//	结算方式（翻译）
			sheet.addCell(new Label(14, line, Util.toStringAndTrim(equInfo.get("rentCount"))));	//	租期数
			sheet.addCell(new Label(15, line, Util.isNotNullOrEmpty(equInfo.get("rentType")) ? RentType.getInstance(Integer.parseInt(Util.toStringAndTrim(equInfo.get("rentType")))).getTypeName() : ""));	//	租期单位（翻译）
			sheet.addCell(new Label(16, line, Util.toStringAndTrim(equInfo.get("rent"))));	//	租赁单价
			sheet.addCell(new Label(17, line, Util.toStringAndTrim(equInfo.get("rentTotalAmt"))));	//	租赁金额
			sheet.addCell(new Label(18, line, Util.toStringAndTrim(equInfo.get("scrapPrice"))));	//	报废残值
			sheet.addCell(new Label(19, line, Util.toStringAndTrim(equInfo.get("sellPrice"))));	//	出售售价

			line += 1;
		}

		//	写入数据
		book.write();
		//	关闭文件
		book.close();

		Map<String,Object> fileMap = new HashMap<String,Object>();

		int offset = fileName.lastIndexOf(".");
		fileName = fileName.substring(0, offset) + "/" + fileName.substring(offset + 1);
		fileMap.put("excel", fileName);

		return fileMap;
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
	public Map<String,Object> infoPublishReportExport(BusEquipmentReportBean busEquipmentReportBean) throws IOException, RowsExceededException, WriteException {

		Date now = new Date();

		if(Util.isNullOrEmpty(busEquipmentReportBean.getStartMonth())){
			busEquipmentReportBean.setStartMonth(Util.convertDateToStr(now, "yyyy-MM"));
		}

		if(Util.isNullOrEmpty(busEquipmentReportBean.getEndMonth())){
			busEquipmentReportBean.setEndMonth(Util.convertDateToStr(now, "yyyy-MM"));
		}

		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		sqlParamsMap.put("startMonth", busEquipmentReportBean.getStartMonth());
		sqlParamsMap.put("endMonth", busEquipmentReportBean.getEndMonth());

		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select * ");
		listSql.append("from view_pub_info vPub ");	//	设备拥有者和设备使用者的设备信息
		listSql.append("where date_format(vPub.ReleaseDate, '%Y-%m')>=:startMonth and date_format(vPub.ReleaseDate, '%Y-%m')<=:endMonth ");

		//	拼组所属单位/项目的查询条件
		int orgFlag = busEquipmentReportBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
		String orgCode = busEquipmentReportBean.getOrgCode();	//	所属单位编码
		Long orgPartyId = busEquipmentReportBean.getOrgPartyId();	//	所属单位/项目id
		Integer isInclude = busEquipmentReportBean.getIsInclude();	//	是否包含下级单位：1-包含
		if(Util.isNullOrEmpty(orgFlag)){
			throw new IFException("所属单位信息不能为空！");
		}

		//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
		if(orgFlag==9){//	总公司
			listSql.append("and vPub.OrgParTypeId=4 ");
		}
		else if(orgFlag==8){//	外部单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			listSql.append("and vPub.OrgId=:orgPartyId and vPub.OrgParTypeId=8 ");
		}
		else if(orgFlag==1){//	局级单位
			if(isInclude!=null && isInclude==1){
				if(Util.isNullOrEmpty(orgCode)){
					throw new IFException("所属单位信息不能为空！");
				}
				sqlParamsMap.put("orgCode", orgCode + "%");

				listSql.append("and vPub.OrgCode like :orgCode and vPub.OrgParTypeId=4 ");
			}
			else{
				if(Util.isNullOrEmpty(orgPartyId)){
					throw new IFException("所属单位信息不能为空！");
				}
				sqlParamsMap.put("orgPartyId", orgPartyId);

				listSql.append("and vPub.OrgId=:orgPartyId and vPub.OrgParTypeId=4 ");
			}
		}
		else if(orgFlag==2){//	处级单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			listSql.append("and vPub.OrgId=:orgPartyId and vPub.OrgParTypeId=4 ");
		}
		else if(orgFlag==3){//	项目
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			listSql.append("and vPub.ProId=:orgPartyId and vPub.ProParTypeId=4 ");
		}
		else{
			throw new IFException("所属单位信息错误！");
		}

		//	拼组设备分类的查询条件
		Integer equPubType = busEquipmentReportBean.getEquPubType();	//	业务类型：1-出租，2-出售，3-求租，4-求购
		if(Util.isNotNullOrEmpty(equPubType)){
			sqlParamsMap.put("equPubType", equPubType);
			listSql.append("and vPub.PubType=:equPubType ");
		}

		//	拼组设备分类的查询条件
		Long equCategoryId = busEquipmentReportBean.getEquCategoryId();	//	设备分类
		if(Util.isNotNullOrEmpty(equCategoryId)){
			sqlParamsMap.put("equCategoryId", equCategoryId);
			listSql.append("and vPub.EquCategoryId=:equCategoryId ");
		}

		//	拼组设备名称的查询条件
		String equName = busEquipmentReportBean.getEquName();	//	设备名称
		if(Util.isNotNullOrEmpty(equName)){
			sqlParamsMap.put("equName", "%" + equName + "%");
			listSql.append("and vPub.EquName like :equName ");
		}

		//	按照设备编号升序
		listSql.append("order by vPub.EquNo ");

		listSql.append("limit ").append(busEquipmentReportBean.getStart()).append(",").append(busEquipmentReportBean.getItemCount());

		//	创建原生SQL查询QUERY实例
		List<Map<String,Object>> list = query(listSql.toString(), sqlParamsMap);

		//	结果集为空时，直接返回
		if(list==null){
			throw new IFException("没有符合条件的记录！");
		}

		if(list.size()<=0){
			throw new IFException("没有符合条件的记录！");
		}

		//	标题行
		String title[] = {"设备编号","资产编号","设备名称","规格","型号","业务类型","信息标题","发布单位","发布日期","所属省市","响应单位数","当前状态","成交日期","成交单位","预估金额（万元）"};
		String fileName = "pubDetail_" + System.currentTimeMillis() + ".xls";
		//	t.xls为要新建的文件名
		WritableWorkbook book = Workbook.createWorkbook(new File(exportExcelPath + "/" + fileName));
		//	生成名为“第一页”的工作表，参数0表示这是第一页
		WritableSheet sheet=book.createSheet("第一页",0); 

		//	写入标题
		for(int i=0;i<15;i++){
			sheet.addCell(new Label(i,0,title[i])); //写标题
		}

		int line = 1;	//	起始行

		//	对返回的资源进行处理，根据orgFlag、equipmentSourceNo和busState，来显示来源；根据局级名称、项目名称，来显示单位名称
		StringBuffer sb = new StringBuffer();

		for(Map<String,Object> equPubInfo : list){
			//	根据局级名称、项目名称，来显示单位名称
			if(Util.isNullOrEmpty(equPubInfo.get("ProName"))){
				equPubInfo.put("disOrgName", equPubInfo.get("OrgName"));
			}
			else{
				equPubInfo.put("disOrgName", equPubInfo.get("ProName"));
			}

			//	写内容
			sheet.addCell(new Label(0, line, Util.toStringAndTrim(equPubInfo.get("EquNo"))));	//	设备编号
			sheet.addCell(new Label(1, line, Util.toStringAndTrim(equPubInfo.get("Asset"))));	//	资产编号
			sheet.addCell(new Label(2, line, Util.toStringAndTrim(equPubInfo.get("EquName"))));	//	设备名称
			sheet.addCell(new Label(3, line, Util.toStringAndTrim(equPubInfo.get("StandardNameEx"))));	//	规格
			sheet.addCell(new Label(4, line, Util.toStringAndTrim(equPubInfo.get("ModelNameEx"))));	//	型号
			sheet.addCell(new Label(5, line, Util.isNotNullOrEmpty(equPubInfo.get("PubType")) ? PubType.getInstance(Integer.parseInt(Util.toStringAndTrim(equPubInfo.get("PubType")))).getTypeName() : ""));	//	业务类型（翻译）
			sheet.addCell(new Label(6, line, Util.toStringAndTrim(equPubInfo.get("InfoTitle"))));	//	信息标题
			sheet.addCell(new Label(7, line, Util.toStringAndTrim(equPubInfo.get("disOrgName"))));	//	发布单位
			sheet.addCell(new Label(8, line, Util.isNotNullOrEmpty(equPubInfo.get("ReleaseDate")) ? Util.convertDateToStr((Date)equPubInfo.get("ReleaseDate"), "yyyy-MM-dd HH:mm:ss") : ""));	//	发布日期

			sb.append(Util.toStringAndTrim(equPubInfo.get("OnProvinceEx"))).append(Util.toStringAndTrim(equPubInfo.get("OnCityEx"))).append(Util.toStringAndTrim(equPubInfo.get("OnDistrictEx")));
			sheet.addCell(new Label(9, line, sb.toString()));	//	所属省市
			sb.setLength(0);

			sheet.addCell(new Label(10, line, Util.toStringAndTrim(equPubInfo.get("DepResponseCount"))));	//	响应单位数
			sheet.addCell(new Label(11, line, Util.isNotNullOrEmpty(equPubInfo.get("State")) ? PubState.getInstance(Integer.parseInt(Util.toStringAndTrim(equPubInfo.get("State")))).getTypeName() : ""));	//	当前状态
			sheet.addCell(new Label(12, line, Util.isNotNullOrEmpty(equPubInfo.get("DealDate")) ? Util.convertDateToStr((Date)equPubInfo.get("DealDate"), "yyyy-MM-dd HH:mm:ss") : ""));	//	成交日期
			sheet.addCell(new Label(13, line, Util.toStringAndTrim(equPubInfo.get("DepName"))));	//	成交单位
			sheet.addCell(new Label(14, line, Util.toStringAndTrim(equPubInfo.get("ForecastSum"))));	//	预估金额

			line += 1;
		}

		//	写入数据
		book.write();
		//	关闭文件
		book.close();

		Map<String,Object> fileMap = new HashMap<String,Object>();

		int offset = fileName.lastIndexOf(".");
		fileName = fileName.substring(0, offset) + "/" + fileName.substring(offset + 1);
		fileMap.put("excel", fileName);

		return fileMap;
	}

	/**
	 * 设备分类信息查询
	 * @author haopeng
     * @since 2016-08-26
     * @return List<Map<String,Object>>
	 */
	public List<Map<String,Object>> createCategoryIdListExport() {

		StringBuffer listSql = new StringBuffer();

		listSql.append("select EquCategoryId as equCategoryId, EquipmentCategoryName as equCategoryName from bus_equ_category_manage");

		return query(listSql.toString(), null);
	}

    /**
     * 拼组设备分类及设备名称信息
     * @author haopeng
     * @since 2016-08-26
     * @param resultData 结果集
     * @param categoryList 设备分类及设备名称信息
     * @param keyName categoryList中的字段键值/页面显示字段值
     */
    private void packageEquTypeInfo(ReportData resultData, List<Map<String,Object>> categoryList, String keyName) {

    	ArrayList<String> path = new ArrayList<String>();
		for(Map<String,Object> rec : categoryList){
			path.clear();

			path.add(Util.toStringAndTrim(rec.get("equCategoryId")));

			resultData.put(path, keyName, Util.toStringAndTrim(rec.get(keyName)));
		}
    }

    /**
     * 将ReportData转换成List
     * @author haopeng
     * @since 2016-08-26
     * @param reportData 结果集
     * @reutrn List<Map<String,Object>>
     */
	private List<Map<String,Object>> convertReportDataToList(ReportData reportData) {

		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		Map<String,Object> map = new HashMap<String,Object>();

		Iterator<?> it = reportData.keySet().iterator();
		while(it.hasNext()){
			String key = it.next().toString();

			map.put("equCategoryId", key);
			map.put("result", reportData.get(key));

			list.add(map);

			map = new HashMap<String,Object>();
	       }  

		return list;
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
	public Map<String,Object> resourceStatisticsCollectExport(BusEquipmentReportBean busEquipmentReportBean,List<Map<String,Object>> categoryList) throws IOException, RowsExceededException, WriteException {

		int orgFlag = busEquipmentReportBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
		if(Util.isNullOrEmpty(orgFlag)){
			throw new IFException("所属单位信息不能为空！");
		}

		Long orgPartyId = busEquipmentReportBean.getOrgPartyId();	//	所属单位/项目id
		Integer isInclude = busEquipmentReportBean.getIsInclude();	//	是否包含下级单位：1-包含

		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();	//	条件查询参数载体

		StringBuffer ownSql = new StringBuffer();	//	拼组自有的查询语句

		ownSql.append("select EquCategoryId as equCategoryId, EquNameId as equNameId, EquName as equName, Second as second, sum(EquipmentCost) as equipmentCost, sum(TotalDepreciation) as totalDepreciation, count(1) as totalNum ");
		ownSql.append("from view_equ_info ");
		ownSql.append("where DelFlag!=1 and (EquState in (1,2) or EquState is null) ");

		StringBuffer innerLeaseSql = new StringBuffer();	//	拼组内租的查询语句

		innerLeaseSql.append("select EquCategoryId as equCategoryId, EquNameId as equNameId, EquName as equName, Second as second, sum(EquipmentCost) as equipmentCost, count(1) as totalNum ");
		innerLeaseSql.append("from view_equ_info ");
		innerLeaseSql.append("where DelFlag!=1 and (EquState in (1,2) or EquState is null) ");

		StringBuffer outerLeaseSql = new StringBuffer();	//	拼组外租的查询语句

		outerLeaseSql.append("select EquCategoryId as equCategoryId, EquNameId as equNameId, EquName as equName, Second as second, sum(EquipmentCost) as equipmentCost, count(1) as totalNum ");
		outerLeaseSql.append("from view_equ_info ");
		outerLeaseSql.append("where DelFlag!=1 and (EquState in (1,2) or EquState is null) ");

		StringBuffer outerAssistSql = new StringBuffer();	//	拼组外协的查询语句

		outerAssistSql.append("select EquCategoryId as equCategoryId, EquNameId as equNameId, EquName as equName, Second as second, sum(EquipmentCost) as equipmentCost, count(1) as totalNum ");
		outerAssistSql.append("from view_equ_info ");
		outerAssistSql.append("where DelFlag!=1 and (EquState in (1,2) or EquState is null) ");

		/** 根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的条件查询参数 */
		if(orgFlag==9){//	总公司（只有自有、外租、外协）
			ownSql.append("and EquipmentSourceNo=1 and BureauOrgParTypeId=4 ");
			outerLeaseSql.append("and ((EquipmentSourceNo=2 and BureauOrgParTypeId=4) or (BusState=5 and EquAtOrgParTypeId=4)) ");
			outerAssistSql.append("and EquipmentSourceNo=3 and BureauOrgParTypeId=4 ");
		}
		else if(orgFlag==8){//	外部单位（只有自有、外租）
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			ownSql.append("and BureauOrgParTypeId=8 and BureauOrgPartyId=:orgPartyId and (BusState=1 or BusState is null) ");
			outerLeaseSql.append("and ((BureauOrgParTypeId=8 and BureauOrgPartyId=:orgPartyId) or (EquAtOrgParTypeId=8 and EquAtOrgId=:orgPartyId)) and BusState=5 ");
		}
		else if(orgFlag==1){//	局级单位（自有、内租、外租、外协）
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			if(isInclude!=null && isInclude==1){
				ownSql.append("and EquipmentSourceNo=1 and BureauOrgPartyId=:orgPartyId ");
				innerLeaseSql.append("and BureauOrgPartyId=:orgPartyId and BusState=4 ");
				outerLeaseSql.append("and ((EquipmentSourceNo=2 and BureauOrgPartyId=:orgPartyId) or (BusState=5 and EquAtOrgId=:orgPartyId)) ");
				outerAssistSql.append("and EquipmentSourceNo=3 and BureauOrgPartyId=:orgPartyId ");
			}
			else{
				ownSql.append("and EquipmentSourceNo=1 and BureauOrgPartyId=:orgPartyId and SonOrgPartyId is null ");
				innerLeaseSql.append("and BureauOrgPartyId=:orgPartyId and BusState=4 and SonOrgPartyId is null ");
				outerLeaseSql.append("and ((EquipmentSourceNo=2 and BureauOrgPartyId=:orgPartyId and SonOrgPartyId is null) or (BusState=5 and EquAtOrgId=:orgPartyId and EquAtSubOrgId is null)) ");
				outerAssistSql.append("and EquipmentSourceNo=3 and BureauOrgPartyId=:orgPartyId and SonOrgPartyId is null ");
			}
		}
		else if(orgFlag==2){//	处级单位（自有、内租、外租、外协）
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			ownSql.append("and EquipmentSourceNo=1 and SonOrgPartyId=:orgPartyId ");
			innerLeaseSql.append("and SonOrgPartyId=:orgPartyId and BusState in (3,4) ");
			outerLeaseSql.append("and ((EquipmentSourceNo=2 and SonOrgPartyId=:orgPartyId) or (BusState=5 and EquAtSubOrgId=:orgPartyId)) ");
			outerAssistSql.append("and EquipmentSourceNo=3 and SonOrgPartyId=:orgPartyId ");
		}
		else if(orgFlag==3){//	项目（自有、内租、外租、外协）
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			ownSql.append("and EquipmentSourceNo=1 and ProOrgPartyId=:orgPartyId ");
			innerLeaseSql.append("and ProOrgPartyId=:orgPartyId and BusState in (3,4) ");
			outerLeaseSql.append("and ((EquipmentSourceNo=2 and ProOrgPartyId=:orgPartyId) or (BusState=5 and EquAtProjectId=:orgPartyId)) ");
			outerAssistSql.append("and EquipmentSourceNo=3 and ProOrgPartyId=:orgPartyId ");
		}
		else{
			throw new IFException("所属单位信息错误！");
		}

		/** 按大类统计，需要展示全部信息 */
		StringBuffer ownSql_cat = new StringBuffer();	//	拼组设备分类自有的查询语句
		StringBuffer innerLeaseSql_cat = new StringBuffer();	//	拼组设备分类内租的查询语句
		StringBuffer outerLeaseSql_cat = new StringBuffer();	//	拼组设备分类外租的查询语句
		StringBuffer outerAssistSql_cat = new StringBuffer();	//	拼组设备分类外协的查询语句

		ownSql_cat.append(ownSql).append("group by EquCategoryId order by EquCategoryId");
		innerLeaseSql_cat.append(innerLeaseSql).append("group by EquCategoryId order by EquCategoryId");
		outerLeaseSql_cat.append(outerLeaseSql).append("group by EquCategoryId order by EquCategoryId");
		outerAssistSql_cat.append(outerAssistSql).append("group by EquCategoryId order by EquCategoryId");

		List<Map<String, Object>> ownList_cat = query(ownSql_cat.toString(), sqlParamsMap);	//	自有查询

		List<Map<String, Object>> innerLeaseList_cat = new ArrayList<Map<String, Object>>();	//	内租查询
		if(orgFlag==1 || orgFlag==2 || orgFlag==3){
			innerLeaseList_cat = query(innerLeaseSql_cat.toString(), sqlParamsMap);
		}

		List<Map<String, Object>> outerLeaseList_cat = query(outerLeaseSql_cat.toString(), sqlParamsMap);	//	外租查询

		List<Map<String, Object>> outerAssistList_cat = new ArrayList<Map<String, Object>>();	//	外协查询
		if(orgFlag!=8){
			outerAssistList_cat = query(outerAssistSql_cat.toString(), sqlParamsMap);
		}

		ReportData reportData_cat = new ReportData();	//	返回资源汇总结果集

		ArrayList<String> path = new ArrayList<String>();

		/** 拼组设备分类信息 */
		packageEquTypeInfo(reportData_cat, categoryList, "equCategoryName");

		/** 总合计字段定义 */
		BigDecimal totalNum1 = BigDecimal.ZERO;	//	自有 - 数量
		BigDecimal equipmentCost1 = BigDecimal.ZERO;	//	自有 - 原值
		BigDecimal netValue1 = BigDecimal.ZERO;	//	自有 - 净值
		BigDecimal totalNum2 = BigDecimal.ZERO;	//	内租 - 数量
		BigDecimal equipmentCost2 = BigDecimal.ZERO;	//	内租 - 原值
		BigDecimal totalNum3 = BigDecimal.ZERO;	//	外租 - 数量
		BigDecimal equipmentCost3 = BigDecimal.ZERO;	//	外租 - 原值
		BigDecimal totalNum4 = BigDecimal.ZERO;	//	外协 - 数量
		BigDecimal equipmentCost4 = BigDecimal.ZERO;	//	外协 - 原值

		BigDecimal equipmentCost = BigDecimal.ZERO;
		BigDecimal totalDepreciation = BigDecimal.ZERO;
		BigDecimal totalNum = BigDecimal.ZERO;

		/**  拼组设备分类自有信息 */
		if(ownList_cat!=null && ownList_cat.size()>0){
			for(Map<String,Object> rec : ownList_cat){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "totalNum1", totalNum);	//	数量
				totalNum1 = totalNum1.add(totalNum);

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				equipmentCost = Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("equipmentCost"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "equipmentCost1", equipmentCost);	//	原值
				equipmentCost1 = equipmentCost1.add(equipmentCost);

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				totalDepreciation = Util.isNotNullOrEmpty(rec.get("totalDepreciation")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalDepreciation"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "netValue1",  equipmentCost.subtract(totalDepreciation));	//	净值
				netValue1 = netValue1.add(equipmentCost).subtract(totalDepreciation);
			}
		}

		/**  拼组设备分类内租信息 */
		if(innerLeaseList_cat!=null && innerLeaseList_cat.size()>0){
			for(Map<String,Object> rec : innerLeaseList_cat){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "totalNum2", totalNum);	//	数量
				totalNum2 = totalNum2.add(totalNum);

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				equipmentCost = Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("equipmentCost"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "equipmentCost2", equipmentCost);	//	原值
				equipmentCost2 = equipmentCost2.add(equipmentCost);
			}
		}

		/**  拼组设备分类外租信息 */
		if(outerLeaseList_cat!=null && outerLeaseList_cat.size()>0){
			for(Map<String,Object> rec : outerLeaseList_cat){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "totalNum3", totalNum);	//	数量
				totalNum3 = totalNum3.add(totalNum);

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				equipmentCost = Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("equipmentCost"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "equipmentCost3", equipmentCost);	//	原值
				equipmentCost3 = equipmentCost3.add(equipmentCost);
			}
		}

		/**  拼组设备分类外协信息 */
		if(outerAssistList_cat!=null && outerAssistList_cat.size()>0){
			for(Map<String,Object> rec : outerAssistList_cat){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "totalNum4", totalNum);	//	数量
				totalNum4 = totalNum4.add(totalNum);

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id


				equipmentCost = Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("equipmentCost"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "equipmentCost4", equipmentCost);	//	原值
				equipmentCost4 = equipmentCost4.add(equipmentCost);
			}
		}

		/** 添加总合计 */
		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "equCategoryName", "总合计");

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "totalNum1", totalNum1);	//	总合计 - 自有 - 数量

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "equipmentCost1", equipmentCost1);	//	总合计 - 自有 - 原值

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "netValue1", netValue1);	//	总合计 - 自有 - 净值

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "totalNum2", totalNum2);	//	总合计 - 内租 - 数量

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "equipmentCost2", equipmentCost2);	//	总合计 - 内租 - 原值

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "totalNum3", totalNum3);	//	总合计 - 外租 - 数量

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "equipmentCost3", equipmentCost3);	//	总合计 - 外租 - 原值

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "totalNum4", totalNum4);	//	总合计 - 外协 - 数量

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "equipmentCost4", equipmentCost4);	//	总合计 - 外协 - 原值

		List<Map<String,Object>> reportDataList_cat = convertReportDataToList(reportData_cat);

		/** 按小类统计，展示有数据的信息 */
		StringBuffer ownSql_name = new StringBuffer();	//	拼组设备名称自有的查询语句
		StringBuffer innerLeaseSql_name = new StringBuffer();	//	拼组设备名称内租的查询语句
		StringBuffer outerLeaseSql_name = new StringBuffer();	//	拼组设备名称外租的查询语句
		StringBuffer outerAssistSql_name = new StringBuffer();	//	拼组设备名称外协的查询语句

		ownSql_name.append(ownSql).append("group by EquNameId order by EquCategoryId, EquNameId");
		innerLeaseSql_name.append(innerLeaseSql).append("group by EquNameId order by EquCategoryId, EquNameId");
		outerLeaseSql_name.append(outerLeaseSql).append("group by EquNameId order by EquCategoryId, EquNameId");
		outerAssistSql_name.append(outerAssistSql).append("group by EquNameId order by EquCategoryId, EquNameId");

		List<Map<String, Object>> ownList_name = query(ownSql_name.toString(), sqlParamsMap);	//	自有查询

		List<Map<String, Object>> innerLeaseList_name = new ArrayList<Map<String, Object>>();	//	内租查询
		if(orgFlag==1 || orgFlag==2 || orgFlag==3){
			innerLeaseList_name = query(innerLeaseSql_name.toString(), sqlParamsMap);
		}

		List<Map<String, Object>> outerLeaseList_name = query(outerLeaseSql_name.toString(), sqlParamsMap);	//	外租查询

		List<Map<String, Object>> outerAssistList_name = new ArrayList<Map<String, Object>>();	//	外协查询
		if(orgFlag!=8){
			outerAssistList_name = query(outerAssistSql_name.toString(), sqlParamsMap);
		}

		ReportData reportData_name = new ReportData();	//	返回资源汇总结果集

		/**  拼组设备名称自有信息 */
		if(ownList_name!=null && ownList_name.size()>0){
			equipmentCost = BigDecimal.ZERO;
			totalDepreciation = BigDecimal.ZERO;
			for(Map<String,Object> rec : ownList_name){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));

				reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "totalNum1", Util.isNotNullOrEmpty(rec.get("totalNum")) ? rec.get("totalNum") : 0);	//	数量

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				equipmentCost = Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("equipmentCost"))) : BigDecimal.ZERO;
				reportData_name.put(path, "equipmentCost1", equipmentCost);	//	原值

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				totalDepreciation = Util.isNotNullOrEmpty(rec.get("totalDepreciation")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalDepreciation"))) : BigDecimal.ZERO;
				reportData_name.put(path, "netValue1",  equipmentCost.subtract(totalDepreciation));	//	净值
			}
		}

		/**  拼组内租信息 */
		if(innerLeaseList_name!=null && innerLeaseList_name.size()>0){
			for(Map<String,Object> rec : innerLeaseList_name){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));

				reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "totalNum2", Util.isNotNullOrEmpty(rec.get("totalNum")) ? rec.get("totalNum") : 0);	//	数量

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equipmentCost2", Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? rec.get("equipmentCost") : 0);	//	原值
			}
		}

		/**  拼组设备名称外租信息 */
		if(outerLeaseList_name!=null && outerLeaseList_name.size()>0){
			for(Map<String,Object> rec : outerLeaseList_name){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));

				reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "totalNum3", Util.isNotNullOrEmpty(rec.get("totalNum")) ? rec.get("totalNum") : 0);	//	数量

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equipmentCost3", Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? rec.get("equipmentCost") : 0);	//	原值
			}
		}

		/**  拼组设备名称外协信息 */
		if(outerAssistList_name!=null && outerAssistList_name.size()>0){
			for(Map<String,Object> rec : outerAssistList_name){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));

				reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "totalNum4", Util.isNotNullOrEmpty(rec.get("totalNum")) ? rec.get("totalNum") : 0);	//	数量

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equipmentCost4", Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? rec.get("equipmentCost") : 0);	//	原值
			}
		}

		List<Map<String,Object>> reportDataList_name = convertReportDataToList(reportData_name);

		//	标题行
		String title[] = {"数量","数量","原值（万元）","净值（万元）","数量","原值（万元）","数量","原值（万元）","数量","原值（万元）"};
		//	t.xls为要新建的文件名
		String fileName = "equReport_" + System.currentTimeMillis() + ".xls";
	    WritableWorkbook book = Workbook.createWorkbook(new File(exportExcelPath + "/" + fileName));
		//	生成名为“第一页”的工作表，参数0表示这是第一页 
		WritableSheet sheet = book.createSheet("第一页", 0);

		//	合并行
		sheet.mergeCells(3, 0, 5, 0);
		sheet.mergeCells(6, 0, 7, 0);
		sheet.mergeCells(8, 0, 9, 0);
		sheet.mergeCells(10, 0, 11, 0);

		//	合并列
		sheet.mergeCells(0, 0, 0, 1);
		sheet.mergeCells(1, 0, 1, 1);

		//	给合并行赋值
		sheet.addCell(new Label(2, 0, "小计"));	//	写标题
		sheet.addCell(new Label(3, 0, "自有"));	//	写标题
		sheet.addCell(new Label(6, 0, "内租"));	//	写标题
		sheet.addCell(new Label(8, 0, "外租"));	//	写标题
		sheet.addCell(new Label(10, 0, "外协"));	//	写标题

		//	给合并列赋值
		sheet.addCell(new Label(0, 0, "设备名称"));	//	写标题
		sheet.addCell(new Label(1, 0, "计量单位"));	//	写标题

		//	写入标题
		for(int a=2;a<12;a++){
			sheet.addCell(new Label(a, 1, title[a - 2]));	//	写标题
		}

		int line = 2;	//	起始行

		/** 循环设备分类，先写入设备分类信息；再根据设备分类id，写入设备名称信息 */
		Map<String,Object> equReportInfo = new HashMap<String,Object>();
		for(Map<String,Object> reportDataMap_cat : reportDataList_cat){//	写入设备分类信息
			equReportInfo = reportDataMap_cat.get("result")!=null ? (Map<String,Object>)reportDataMap_cat.get("result") : new HashMap<String,Object>();
			if(equReportInfo.isEmpty()){
				continue ;
			}

			//	写内容
			sheet.addCell(new Label(0, line, Util.toStringAndTrim(equReportInfo.get("equCategoryName"))));	//	设备名称
			sheet.addCell(new Label(1, line, ""));	//	计量单位

			BigDecimal totalNum1_rec = Util.isNotNullOrEmpty(equReportInfo.get("totalNum1")) ? new BigDecimal(Util.toStringAndTrim(equReportInfo.get("totalNum1"))) : BigDecimal.ZERO;
			BigDecimal totalNum2_rec = Util.isNotNullOrEmpty(equReportInfo.get("totalNum2")) ? new BigDecimal(Util.toStringAndTrim(equReportInfo.get("totalNum2"))) : BigDecimal.ZERO;
			BigDecimal totalNum3_rec = Util.isNotNullOrEmpty(equReportInfo.get("totalNum3")) ? new BigDecimal(Util.toStringAndTrim(equReportInfo.get("totalNum3"))) : BigDecimal.ZERO;
			BigDecimal totalNum4_rec = Util.isNotNullOrEmpty(equReportInfo.get("totalNum4")) ? new BigDecimal(Util.toStringAndTrim(equReportInfo.get("totalNum4"))) : BigDecimal.ZERO;
			sheet.addCell(new Label(2, line, Util.toStringAndTrim(totalNum1_rec.add(totalNum2_rec).add(totalNum3_rec).add(totalNum4_rec))));	//	小计 - 数量

			sheet.addCell(new Label(3, line, Util.toStringAndTrim(totalNum1_rec)));	//	自有 - 数量
			sheet.addCell(new Label(4, line, Util.isNotNullOrEmpty(equReportInfo.get("equipmentCost1")) ? Util.toStringAndTrim(equReportInfo.get("equipmentCost1")) : "0"));	//	自有 - 原值
			sheet.addCell(new Label(5, line, Util.isNotNullOrEmpty(equReportInfo.get("netValue1")) ? Util.toStringAndTrim(equReportInfo.get("netValue1")) : "0"));	//	自有 - 净值

			sheet.addCell(new Label(6, line, Util.toStringAndTrim(totalNum2_rec)));	//	内租 - 数量
			sheet.addCell(new Label(7, line, Util.isNotNullOrEmpty(equReportInfo.get("equipmentCost2")) ? Util.toStringAndTrim(equReportInfo.get("equipmentCost2")) : "0"));	//	内租 - 原值

			sheet.addCell(new Label(8, line, Util.toStringAndTrim(totalNum3_rec)));	//	外租 - 数量
			sheet.addCell(new Label(9, line, Util.isNotNullOrEmpty(equReportInfo.get("equipmentCost3")) ? Util.toStringAndTrim(equReportInfo.get("equipmentCost3")) : "0"));	//	外租 - 原值

			sheet.addCell(new Label(10, line, Util.toStringAndTrim(totalNum4_rec)));	//	外协- 数量
			sheet.addCell(new Label(11, line, Util.isNotNullOrEmpty(equReportInfo.get("equipmentCost4")) ? Util.toStringAndTrim(equReportInfo.get("equipmentCost4")) : "0"));	//	外协 - 原值

			line += 1;
			equReportInfo = new HashMap<String,Object>();

			if(reportDataList_name!=null && reportDataList_name.size()>0){//	根据设备分类id，写入设备名称信息
				Long equCategoryId = Long.parseLong(Util.toStringAndTrim(reportDataMap_cat.get("equCategoryId")));

				for(Map<String,Object> reportDataMap_name : reportDataList_name){
					equReportInfo = reportDataMap_name.get("result")!=null ? (Map<String,Object>)reportDataMap_name.get("result") : new HashMap<String,Object>();
					if(equReportInfo.isEmpty()){
						continue ;
					}

					if(equCategoryId.equals(Long.parseLong(Util.toStringAndTrim(equReportInfo.get("equCategoryId"))))){
						//	写内容
						sheet.addCell(new Label(0, line, Util.toStringAndTrim(equReportInfo.get("equCategoryName"))));	//	设备名称
						sheet.addCell(new Label(1, line, Util.isNotNullOrEmpty(equReportInfo.get("second")) ? EquUnit.getInstance(Integer.parseInt(Util.toStringAndTrim(equReportInfo.get("second")))).getTypeName() : ""));	//	计量单位

						totalNum1_rec = Util.isNotNullOrEmpty(equReportInfo.get("totalNum1")) ? new BigDecimal(Util.toStringAndTrim(equReportInfo.get("totalNum1"))) : BigDecimal.ZERO;
						totalNum2_rec = Util.isNotNullOrEmpty(equReportInfo.get("totalNum2")) ? new BigDecimal(Util.toStringAndTrim(equReportInfo.get("totalNum2"))) : BigDecimal.ZERO;
						totalNum3_rec = Util.isNotNullOrEmpty(equReportInfo.get("totalNum3")) ? new BigDecimal(Util.toStringAndTrim(equReportInfo.get("totalNum3"))) : BigDecimal.ZERO;
						totalNum4_rec = Util.isNotNullOrEmpty(equReportInfo.get("totalNum4")) ? new BigDecimal(Util.toStringAndTrim(equReportInfo.get("totalNum4"))) : BigDecimal.ZERO;
						sheet.addCell(new Label(2, line, Util.toStringAndTrim(totalNum1_rec.add(totalNum2_rec).add(totalNum3_rec).add(totalNum4_rec))));	//	小计 - 数量

						sheet.addCell(new Label(3, line, Util.toStringAndTrim(totalNum1_rec)));	//	自有 - 数量
						sheet.addCell(new Label(4, line, Util.isNotNullOrEmpty(equReportInfo.get("equipmentCost1")) ? Util.toStringAndTrim(equReportInfo.get("equipmentCost1")) : "0"));	//	自有 - 原值
						sheet.addCell(new Label(5, line, Util.isNotNullOrEmpty(equReportInfo.get("netValue1")) ? Util.toStringAndTrim(equReportInfo.get("netValue1")) : "0"));	//	自有 - 净值

						sheet.addCell(new Label(6, line, Util.toStringAndTrim(totalNum2_rec)));	//	内租 - 数量
						sheet.addCell(new Label(7, line, Util.isNotNullOrEmpty(equReportInfo.get("equipmentCost2")) ? Util.toStringAndTrim(equReportInfo.get("equipmentCost2")) : "0"));	//	内租 - 原值

						sheet.addCell(new Label(8, line, Util.toStringAndTrim(totalNum3_rec)));	//	外租 - 数量
						sheet.addCell(new Label(9, line, Util.isNotNullOrEmpty(equReportInfo.get("equipmentCost3")) ? Util.toStringAndTrim(equReportInfo.get("equipmentCost3")) : "0"));	//	外租 - 原值

						sheet.addCell(new Label(10, line, Util.toStringAndTrim(totalNum4_rec)));	//	外协- 数量
						sheet.addCell(new Label(11, line, Util.isNotNullOrEmpty(equReportInfo.get("equipmentCost4")) ? Util.toStringAndTrim(equReportInfo.get("equipmentCost4")) : "0"));	//	外协 - 原值

						line += 1;
						equReportInfo = new HashMap<String,Object>();
					}
				}
			}
		}

		//	写入数据
		book.write();
		//	关闭文件
		book.close();

		Map<String,Object> fileMap = new HashMap<String,Object>();

		int offset = fileName.lastIndexOf(".");
		fileName = fileName.substring(0, offset) + "/" + fileName.substring(offset + 1);
		fileMap.put("excel", fileName);

		return fileMap;
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
	public Map<String,Object> rentStatisticsCollectExport(BusEquipmentReportBean busEquipmentReportBean, List<Map<String,Object>> categoryList) throws RowsExceededException, WriteException, IOException {

		int orgFlag = busEquipmentReportBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
		if(Util.isNullOrEmpty(orgFlag)){
			throw new IFException("所属单位信息不能为空！");
		}

		Date now = new Date();

		if(Util.isNullOrEmpty(busEquipmentReportBean.getStartMonth())){
			busEquipmentReportBean.setStartMonth(Util.convertDateToStr(now, "yyyy-MM"));
		}

		if(Util.isNullOrEmpty(busEquipmentReportBean.getEndMonth())){
			busEquipmentReportBean.setEndMonth(Util.convertDateToStr(now, "yyyy-MM"));
		}

		Long orgPartyId = busEquipmentReportBean.getOrgPartyId();	//	所属单位/项目id
		Integer isInclude = busEquipmentReportBean.getIsInclude();	//	是否包含下级单位：1-包含

		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		sqlParamsMap.put("startMonth", busEquipmentReportBean.getStartMonth());
		sqlParamsMap.put("endMonth", busEquipmentReportBean.getEndMonth());

		StringBuffer ownSql = new StringBuffer();	//	拼组自有的查询语句

		ownSql.append("select vEqu.EquCategoryId as equCategoryId, vEqu.EquNameId as equNameId, vEqu.EquName as equName, vEqu.Second as second, count(1) as ownNum, sum(depr.depreciation) as depreciation ");
		ownSql.append("from view_equ_info vEqu ");
		ownSql.append("left join bus_depreciation_hist depr on vEqu.EquipmentId=depr.equipmentId and depr.month>=:startMonth and depr.month<=:endMonth ");
		ownSql.append("where date_format(vEqu.CreateTime, '%Y-%m')>=:startMonth and date_format(vEqu.CreateTime, '%Y-%m')<=:endMonth and (vEqu.EquState in (1,2) or vEqu.EquState is null) and vEqu.EquipmentSourceNo=1 ");

		StringBuffer rentSql = new StringBuffer();	//	拼组局内租、外局租、外租的查询语句

		rentSql.append("select vEqu.EquCategoryId as equCategoryId, vEqu.EquNameId as equNameId, vEqu.EquName as equName, vEqu.Second as second, vEqu.BusState as busState, ");
		rentSql.append("count(1) as rentNum, sum(vRent.DeductCost) as deductCost, sum(vRent.Cost) as cost, sum(vRent.Amount) as amount ");
		rentSql.append("from view_rent_info vRent ");
		rentSql.append("join view_equ_info vEqu on vRent.EquipmentId=vEqu.EquipmentId and date_format(vEqu.CreateTime, '%Y-%m')>=:startMonth and date_format(vEqu.CreateTime, '%Y-%m')<=:endMonth ");
		rentSql.append("where vRent.EquipmentId=vEqu.EquipmentId and vRent.Month>=:startMonth and vRent.Month<=:endMonth ");

		StringBuffer scrapSql = new StringBuffer();	//	拼组报废的查询语句

		scrapSql.append("select vEqu.EquCategoryId as equCategoryId, vEqu.EquNameId as equNameId, vEqu.EquName as equName, vEqu.Second as second, count(1) as scrapNum, sum(vEqu.scrapPrice) as scrapPrice ");
		scrapSql.append("from view_equ_info vEqu ");
		scrapSql.append("where date_format(vEqu.CreateTime, '%Y-%m')>=:startMonth and date_format(vEqu.CreateTime, '%Y-%m')<=:endMonth and vEqu.EquState=4 ");

		StringBuffer sellSql = new StringBuffer();	//	拼组出售的查询语句

		sellSql.append("select vEqu.EquCategoryId as equCategoryId, vEqu.EquNameId as equNameId, vEqu.EquName as equName, vEqu.Second as second, count(1) as sellNum, sum(vEqu.sellPrice) as sellPrice ");
		sellSql.append("from view_equ_info vEqu ");
		sellSql.append("where date_format(vEqu.CreateTime, '%Y-%m')>=:startMonth and date_format(vEqu.CreateTime, '%Y-%m')<=:endMonth and vEqu.EquState=3 ");

		//	拼组所属单位/项目的查询条件
		//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
		if(orgFlag==9){//	总公司
			ownSql.append("and vEqu.BureauOrgParTypeId=4 ");
			rentSql.append("and vRent.BureauParTypeId=4 and vEqu.BusState=5 ");
			scrapSql.append("and vEqu.BureauOrgParTypeId=4 ");
			sellSql.append("and vEqu.BureauOrgParTypeId=4 ");
		}
		else if(orgFlag==8){//	外部单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			ownSql.append("and vEqu.BureauOrgParTypeId=8 and vEqu.BureauOrgPartyId=:orgPartyId ");
			rentSql.append("and vRent.BureauParTypeId=8 and vRent.BureauOrgPartyId=:orgPartyId and vEqu.BusState=5 ");
			scrapSql.append("and vEqu.BureauOrgParTypeId=8 and vEqu.BureauOrgPartyId=:orgPartyId ");
			sellSql.append("and vEqu.BureauOrgParTypeId=8 and vEqu.BureauOrgPartyId=:orgPartyId ");
		}
		else if(orgFlag==1){//	局级单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			if(isInclude!=null && isInclude==1){
				ownSql.append("and vEqu.BureauOrgParTypeId=4 and vEqu.BureauOrgPartyId=:orgPartyId ");
				rentSql.append("and vRent.BureauParTypeId=4 and vRent.BureauOrgPartyId=:orgPartyId and vEqu.BusState in (3,4,5) ");
				scrapSql.append("and vEqu.BureauOrgParTypeId=4 and vEqu.BureauOrgPartyId=:orgPartyId ");
				sellSql.append("and vEqu.BureauOrgParTypeId=4 and vEqu.BureauOrgPartyId=:orgPartyId ");
			}
			else{
				ownSql.append("and vEqu.BureauOrgParTypeId=4 and vEqu.BureauOrgPartyId=:orgPartyId and vEqu.SonOrgPartyId is null ");
				rentSql.append("and vRent.BureauParTypeId=4 and vRent.BureauOrgPartyId=:orgPartyId and vRent.SonOrgPartyId is null and vEqu.BusState in (3,4,5) ");
				scrapSql.append("and vEqu.BureauOrgParTypeId=4 and vEqu.BureauOrgPartyId=:orgPartyId and vEqu.SonOrgPartyId is null ");
				sellSql.append("and vEqu.BureauOrgParTypeId=4 and vEqu.BureauOrgPartyId=:orgPartyId and vEqu.SonOrgPartyId is null ");
			}
		}
		else if(orgFlag==2){//	处级单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			ownSql.append("and vEqu.SonOrgPartyId=:orgPartyId ");
			rentSql.append("and vRent.SonOrgPartyId=:orgPartyId and vEqu.BusState in (3,4,5) ");
			scrapSql.append("and vEqu.SonOrgPartyId=:orgPartyId ");
			sellSql.append("and vEqu.SonOrgPartyId=:orgPartyId ");
		}
		else if(orgFlag==3){//	项目
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			ownSql.append("and vEqu.ProOrgPartyId=:orgPartyId ");
			rentSql.append("and vRent.ProOrgPartyId=:orgPartyId and vEqu.BusState in (3,4,5) ");
			scrapSql.append("and vEqu.ProOrgPartyId=:orgPartyId ");
			sellSql.append("and vEqu.ProOrgPartyId=:orgPartyId ");
		}
		else{
			throw new IFException("所属单位信息错误！");
		}

		/** 按大类统计，需要展示全部信息 */
		StringBuffer ownSql_cat = new StringBuffer();	//	拼组设备分类自有的查询语句
		StringBuffer rentSql_cat = new StringBuffer();	//	拼组设备分类局内租、外局租、外租的查询语句
		StringBuffer scrapSql_cat = new StringBuffer();	//	拼组设备分类报废的查询语句
		StringBuffer sellSql_cat = new StringBuffer();	//	拼组设备分类出售的查询语句

		ownSql_cat.append(ownSql).append("group by vEqu.EquCategoryId order by vEqu.EquCategoryId");
		rentSql_cat.append(rentSql).append("group by vEqu.EquCategoryId, vEqu.BusState order by vEqu.EquCategoryId");
		scrapSql_cat.append(scrapSql).append("group by vEqu.EquCategoryId order by vEqu.EquCategoryId");
		sellSql_cat.append(sellSql).append("group by vEqu.EquCategoryId order by vEqu.EquCategoryId");

		List<Map<String, Object>> ownList_cat = query(ownSql_cat.toString(), sqlParamsMap);	//	自有查询
		List<Map<String, Object>> rentList_cat = query(rentSql_cat.toString(), sqlParamsMap);	//	局内租、外局租、外租查询
		List<Map<String, Object>> scrapList_cat = query(scrapSql_cat.toString(), sqlParamsMap);	//	报废查询
		List<Map<String, Object>> sellList_cat = query(sellSql_cat.toString(), sqlParamsMap);	//	出售查询

		ReportData reportData_cat = new ReportData();	//	返回资源汇总结果集

		ArrayList<String> path = new ArrayList<String>();

		BigDecimal conversion = new BigDecimal("10000");
		Integer busState = null;
		BigDecimal deductCost = BigDecimal.ZERO;
		BigDecimal cost = BigDecimal.ZERO;
		BigDecimal amount = BigDecimal.ZERO;

		/** 拼组设备分类信息 */
		packageEquTypeInfo(reportData_cat, categoryList, "equCategoryName");

		/** 总合计字段定义 */
		BigDecimal ownNum = BigDecimal.ZERO;	//	自有 - 数量
		BigDecimal depreciation = BigDecimal.ZERO;	//	自有 - 本期折旧（万元）
		BigDecimal rentNum1 = BigDecimal.ZERO;	//	局内租 - 数量
		BigDecimal rentAmt1 = BigDecimal.ZERO;	//	局内租 - 租金（万元）
		BigDecimal rentNum2 = BigDecimal.ZERO;	//	外局租 - 数量
		BigDecimal rentAmt2 = BigDecimal.ZERO;	//	外局租 - 租金（万元）
		BigDecimal rentNum3 = BigDecimal.ZERO;	//	外租 - 数量
		BigDecimal rentAmt3 = BigDecimal.ZERO;	//	外租 - 租金（万元）
		BigDecimal scrapNum = BigDecimal.ZERO;	//	报废 - 数量
		BigDecimal scrapPrice = BigDecimal.ZERO;	//	报废 - 残值（万元）
		BigDecimal sellNum = BigDecimal.ZERO;	//	出售 - 数量
		BigDecimal sellPrice = BigDecimal.ZERO;	//	出售 - 售价（万元）

		BigDecimal num = BigDecimal.ZERO;
		BigDecimal amt = BigDecimal.ZERO;

		/**  拼组自有信息 */
		if(ownList_cat!=null && ownList_cat.size()>0){
			for(Map<String,Object> rec : ownList_cat){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				num = Util.isNotNullOrEmpty(rec.get("ownNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("ownNum"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "ownNum", num);	//	数量
				ownNum = ownNum.add(num);

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				amt = Util.isNotNullOrEmpty(rec.get("depreciation")) ? new BigDecimal(Util.toStringAndTrim(rec.get("depreciation"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "depreciation", amt);	//	本期折旧（万元）
				depreciation = depreciation.add(amt);
			}
		}

		/**  拼组局内租、外局租、外租信息 */
		if(rentList_cat!=null && rentList_cat.size()>0){
			for(Map<String,Object> rec : rentList_cat){
				busState = Integer.parseInt(Util.toStringAndTrim(rec.get("busState")));	//	业务类型

				switch(busState){
					case 3://	局内租
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						num = Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO;
						reportData_cat.put(path, "rentNum1", num);	//	数量
						rentNum1 = rentNum1.add(num);

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
						cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
						amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

						amt = BigDecimal.ZERO;
						amt = deductCost.add(cost).subtract(amount).divide(conversion);

						reportData_cat.put(path, "rentAmt1", amt);	//	租金（万元）
						rentAmt1 = rentAmt1.add(amt);
						break;
					case 4://	外局租
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						num = Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO;
						reportData_cat.put(path, "rentNum2", num);	//	数量
						rentNum2 = rentNum2.add(num);

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
						cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
						amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

						amt = BigDecimal.ZERO;
						amt = deductCost.add(cost).subtract(amount).divide(conversion);

						reportData_cat.put(path, "rentAmt2", amt);	//	租金（万元）
						rentAmt2 = rentAmt2.add(amt);
						break;
					case 5://	外租
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						num = Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO;
						reportData_cat.put(path, "rentNum3", num);	//	数量
						rentNum3 = rentNum3.add(num);

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
						cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
						amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

						amt = BigDecimal.ZERO;
						amt = deductCost.add(cost).subtract(amount).divide(conversion);

						reportData_cat.put(path, "rentAmt3", amt);	//	租金（万元）
						rentAmt3 = rentAmt3.add(amt);
						break;
					default:
						break;
				}
			}
		}

		/**  拼组报废信息 */
		if(scrapList_cat!=null && scrapList_cat.size()>0){
			for(Map<String,Object> rec : scrapList_cat){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				num = Util.isNotNullOrEmpty(rec.get("scrapNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("scrapNum"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "scrapNum", num);	//	数量
				scrapNum = scrapNum.add(num);

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				amt = Util.isNotNullOrEmpty(rec.get("scrapPrice")) ? new BigDecimal(Util.toStringAndTrim(rec.get("scrapPrice"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "scrapPrice", amt);	//	残值（万元）
				scrapPrice = scrapPrice.add(amt);
			}
		}

		/**  拼组出售信息 */
		if(sellList_cat!=null && sellList_cat.size()>0){
			for(Map<String,Object> rec : sellList_cat){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				num = Util.isNotNullOrEmpty(rec.get("sellNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("sellNum"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "sellNum", num);	//	数量
				sellNum = sellNum.add(num);

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

				amt = Util.isNotNullOrEmpty(rec.get("sellPrice")) ? new BigDecimal(Util.toStringAndTrim(rec.get("sellPrice"))) : BigDecimal.ZERO;
				reportData_cat.put(path, "sellPrice", amt);	//	残值（万元）
				sellPrice = sellPrice.add(amt);
			}
		}

		/** 添加总合计 */
		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "equCategoryName", "总合计");

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "ownNum", ownNum);	//	总合计 - 自有 - 数量

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "depreciation", depreciation);	//	总合计 - 自有 - 本期折旧（万元）

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "rentNum1", rentNum1);	//	总合计 - 局内租 - 数量

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "rentAmt1", rentAmt1);	//	总合计 - 局内租 - 租金（万元）

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "rentNum2", rentNum2);	//	总合计 - 外局租 - 数量

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "rentAmt2", rentAmt2);	//	总合计 - 外局租 - 租金（万元）

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "rentNum3", rentNum3);	//	总合计 - 外租 - 数量

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "rentAmt3", rentAmt3);	//	总合计 - 外租 - 租金（万元）

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "scrapNum", scrapNum);	//	总合计 - 报废 - 数量

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "scrapPrice", scrapPrice);	//	总合计 - 报废 - 残值（万元）

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "sellNum", sellNum);	//	总合计 - 出售 - 数量

		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "sellPrice", sellPrice);	//	总合计 - 出售 - 售价（万元）

		List<Map<String,Object>> reportDataList_cat = convertReportDataToList(reportData_cat);

		/** 按小类统计，展示有数据的信息 */
		StringBuffer ownSql_name = new StringBuffer();	//	拼组设备分类自有的查询语句
		StringBuffer rentSql_name = new StringBuffer();	//	拼组设备分类局内租、外局租、外租的查询语句
		StringBuffer scrapSql_name = new StringBuffer();	//	拼组设备分类报废的查询语句
		StringBuffer sellSql_name = new StringBuffer();	//	拼组设备分类出售的查询语句

		ownSql_name.append(ownSql).append("group by vEqu.EquNameId order by vEqu.EquNameId");
		rentSql_name.append(rentSql).append("group by vEqu.EquNameId, vEqu.BusState order by vEqu.EquNameId");
		scrapSql_name.append(scrapSql).append("group by vEqu.EquNameId order by vEqu.EquNameId");
		sellSql_name.append(sellSql).append("group by vEqu.EquNameId order by vEqu.EquNameId");

		List<Map<String, Object>> ownList_name = query(ownSql_name.toString(), sqlParamsMap);	//	自有查询
		List<Map<String, Object>> rentList_name = query(rentSql_name.toString(), sqlParamsMap);	//	局内租、外局租、外租查询
		List<Map<String, Object>> scrapList_name = query(scrapSql_name.toString(), sqlParamsMap);	//	报废查询
		List<Map<String, Object>> sellList_name = query(sellSql_name.toString(), sqlParamsMap);	//	出售查询

		ReportData reportData_name = new ReportData();	//	返回资源汇总结果集

		/**  拼组自有信息 */
		if(ownList_name!=null && ownList_name.size()>0){
			for(Map<String,Object> rec : ownList_name){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));

				reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

				reportData_name.put(path, "ownNum", Util.isNotNullOrEmpty(rec.get("ownNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("ownNum"))) : BigDecimal.ZERO);	//	数量

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

				reportData_name.put(path, "depreciation", Util.isNotNullOrEmpty(rec.get("depreciation")) ? new BigDecimal(Util.toStringAndTrim(rec.get("depreciation"))) : BigDecimal.ZERO);	//	本期折旧（万元）
			}
		}

		/**  拼组局内租、外局租、外租信息 */
		if(rentList_name!=null && rentList_name.size()>0){
			for(Map<String,Object> rec : rentList_name){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));

				reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

				busState = Integer.parseInt(Util.toStringAndTrim(rec.get("busState")));	//	业务类型

				switch(busState){
					case 3://	局内租
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						reportData_name.put(path, "rentNum1", Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO);	//	数量

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
						cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
						amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

						reportData_name.put(path, "rentAmt1", deductCost.add(cost).subtract(amount).divide(conversion));	//	租金（万元）
						break;
					case 4://	外局租
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						reportData_name.put(path, "rentNum2", Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO);	//	数量

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
						cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
						amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

						reportData_name.put(path, "rentAmt2", deductCost.add(cost).subtract(amount).divide(conversion));	//	租金（万元）
						break;
					case 5://	外租
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						reportData_name.put(path, "rentNum3", Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO);	//	数量

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
						cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
						amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

						reportData_name.put(path, "rentAmt3", deductCost.add(cost).subtract(amount).divide(conversion));	//	租金（万元）
						break;
					default:
						break;
				}
			}
		}

		/**  拼组报废信息 */
		if(scrapList_name!=null && scrapList_name.size()>0){
			for(Map<String,Object> rec : scrapList_name){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));

				reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

				reportData_name.put(path, "scrapNum", Util.isNotNullOrEmpty(rec.get("scrapNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("scrapNum"))) : BigDecimal.ZERO);	//	数量

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

				reportData_name.put(path, "scrapPrice", Util.isNotNullOrEmpty(rec.get("scrapPrice")) ? new BigDecimal(Util.toStringAndTrim(rec.get("scrapPrice"))) : BigDecimal.ZERO);	//	残值（万元）
			}
		}

		/**  拼组出售信息 */
		if(sellList_name!=null && sellList_name.size()>0){
			for(Map<String,Object> rec : sellList_name){
				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));

				reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

				reportData_name.put(path, "sellNum", Util.isNotNullOrEmpty(rec.get("sellNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("sellNum"))) : BigDecimal.ZERO);	//	数量

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

				reportData_name.put(path, "sellPrice", Util.isNotNullOrEmpty(rec.get("sellPrice")) ? new BigDecimal(Util.toStringAndTrim(rec.get("sellPrice"))) : BigDecimal.ZERO);	//	残值（万元）
			}
		}

		List<Map<String,Object>> reportDataList_name = convertReportDataToList(reportData_name);

		//	标题行
		String title[] = {"数量","本期折旧（万元）","数量","租金（万元）","数量","租金（万元）","数量","租金（万元）","数量","残值（万元）","数量","售价（万元）"};
		//	t.xls为要新建的文件名
		String fileName = "rentReport_" + System.currentTimeMillis() + ".xls";
	    WritableWorkbook book = Workbook.createWorkbook(new File(exportExcelPath + "/" + fileName));
		//	生成名为“第一页”的工作表，参数0表示这是第一页 
		WritableSheet sheet = book.createSheet("第一页", 0);

		//	合并行
		sheet.mergeCells(2, 0, 3, 0);
		sheet.mergeCells(4, 0, 5, 0);
		sheet.mergeCells(6, 0, 7, 0);
		sheet.mergeCells(8, 0, 9, 0);
		sheet.mergeCells(10, 0, 11, 0);
		sheet.mergeCells(12, 0, 13, 0);

		//	合并列
		sheet.mergeCells(0, 0, 0, 1);
		sheet.mergeCells(1, 0, 1, 1);

		//	给合并行赋值
		sheet.addCell(new Label(2, 0, "自有"));	//	写标题
		sheet.addCell(new Label(4, 0, "局内租"));	//	写标题
		sheet.addCell(new Label(6, 0, "外局租"));	//	写标题
		sheet.addCell(new Label(8, 0, "外租"));	//	写标题
		sheet.addCell(new Label(10, 0, "报废"));	//	写标题
		sheet.addCell(new Label(12, 0, "出售"));	//	写标题

		//	给合并列赋值
		sheet.addCell(new Label(0, 0, "设备名称"));	//	写标题
		sheet.addCell(new Label(1, 0, "计量单位"));	//	写标题

		//	写入标题
		for(int a=2;a<14;a++){
			sheet.addCell(new Label(a, 1, title[a - 2]));	//	写标题
		}

		int line = 2;	//	起始行

		/** 循环设备分类，先写入设备分类信息；再根据设备分类id，写入设备名称信息 */
		Map<String,Object> equReportInfo = new HashMap<String,Object>();
		for(Map<String,Object> reportDataMap_cat : reportDataList_cat){//	写入设备分类信息
			equReportInfo = reportDataMap_cat.get("result")!=null ? (Map<String,Object>)reportDataMap_cat.get("result") : new HashMap<String,Object>();
			if(equReportInfo.isEmpty()){
				continue ;
			}

			//	写内容
			sheet.addCell(new Label(0, line, Util.toStringAndTrim(equReportInfo.get("equCategoryName"))));	//	设备名称
			sheet.addCell(new Label(1, line, ""));	//	计量单位

			sheet.addCell(new Label(2, line, Util.isNotNullOrEmpty(equReportInfo.get("ownNum")) ? Util.toStringAndTrim(equReportInfo.get("ownNum")) : "0"));	//	自有 - 数量
			sheet.addCell(new Label(3, line, Util.isNotNullOrEmpty(equReportInfo.get("depreciation")) ? Util.toStringAndTrim(equReportInfo.get("depreciation")) : "0"));	//	自有 - 本期折旧（万元）

			sheet.addCell(new Label(4, line, Util.isNotNullOrEmpty(equReportInfo.get("rentNum1")) ? Util.toStringAndTrim(equReportInfo.get("rentNum1")) : "0"));	//	局内租 - 数量
			sheet.addCell(new Label(5, line, Util.isNotNullOrEmpty(equReportInfo.get("rentAmt1")) ? Util.toStringAndTrim(equReportInfo.get("rentAmt1")) : "0"));	//	局内租 - 租金（万元）

			sheet.addCell(new Label(6, line, Util.isNotNullOrEmpty(equReportInfo.get("rentNum2")) ? Util.toStringAndTrim(equReportInfo.get("rentNum2")) : "0"));	//	外局租 - 数量
			sheet.addCell(new Label(7, line, Util.isNotNullOrEmpty(equReportInfo.get("rentAmt2")) ? Util.toStringAndTrim(equReportInfo.get("rentAmt2")) : "0"));	//	外局租 - 租金（万元）

			sheet.addCell(new Label(8, line, Util.isNotNullOrEmpty(equReportInfo.get("rentNum3")) ? Util.toStringAndTrim(equReportInfo.get("rentNum3")) : "0"));	//	外租 - 数量
			sheet.addCell(new Label(9, line, Util.isNotNullOrEmpty(equReportInfo.get("rentAmt3")) ? Util.toStringAndTrim(equReportInfo.get("rentAmt3")) : "0"));	//	外租 - 租金（万元）

			sheet.addCell(new Label(10, line, Util.isNotNullOrEmpty(equReportInfo.get("scrapNum")) ? Util.toStringAndTrim(equReportInfo.get("scrapNum")) : "0"));	//	报废 - 数量
			sheet.addCell(new Label(11, line, Util.isNotNullOrEmpty(equReportInfo.get("scrapPrice")) ? Util.toStringAndTrim(equReportInfo.get("scrapPrice")) : "0"));	//	报废 - 残值（万元）

			sheet.addCell(new Label(12, line, Util.isNotNullOrEmpty(equReportInfo.get("sellNum")) ? Util.toStringAndTrim(equReportInfo.get("sellNum")) : "0"));	//	出售 - 数量
			sheet.addCell(new Label(13, line, Util.isNotNullOrEmpty(equReportInfo.get("sellPrice")) ? Util.toStringAndTrim(equReportInfo.get("sellPrice")) : "0"));	//	出售 - 售价（万元）

			line += 1;
			equReportInfo = new HashMap<String,Object>();

			if(reportDataList_name!=null && reportDataList_name.size()>0){//	根据设备分类id，写入设备名称信息
				Long equCategoryId = Long.parseLong(Util.toStringAndTrim(reportDataMap_cat.get("equCategoryId")));

				for(Map<String,Object> reportDataMap_name : reportDataList_name){
					equReportInfo = reportDataMap_name.get("result")!=null ? (Map<String,Object>)reportDataMap_name.get("result") : new HashMap<String,Object>();
					if(equReportInfo.isEmpty()){
						continue ;
					}

					if(equCategoryId.equals(Long.parseLong(Util.toStringAndTrim(equReportInfo.get("equCategoryId"))))){
						//	写内容
						sheet.addCell(new Label(0, line, Util.toStringAndTrim(equReportInfo.get("equCategoryName"))));	//	设备名称
						sheet.addCell(new Label(1, line, Util.isNotNullOrEmpty(equReportInfo.get("second")) ? EquUnit.getInstance(Integer.parseInt(Util.toStringAndTrim(equReportInfo.get("second")))).getTypeName() : ""));	//	计量单位

						sheet.addCell(new Label(2, line, Util.isNotNullOrEmpty(equReportInfo.get("ownNum")) ? Util.toStringAndTrim(equReportInfo.get("ownNum")) : "0"));	//	自有 - 数量
						sheet.addCell(new Label(3, line, Util.isNotNullOrEmpty(equReportInfo.get("depreciation")) ? Util.toStringAndTrim(equReportInfo.get("depreciation")) : "0"));	//	自有 - 本期折旧（万元）

						sheet.addCell(new Label(4, line, Util.isNotNullOrEmpty(equReportInfo.get("rentNum1")) ? Util.toStringAndTrim(equReportInfo.get("rentNum1")) : "0"));	//	局内租 - 数量
						sheet.addCell(new Label(5, line, Util.isNotNullOrEmpty(equReportInfo.get("rentAmt1")) ? Util.toStringAndTrim(equReportInfo.get("rentAmt1")) : "0"));	//	局内租 - 租金（万元）

						sheet.addCell(new Label(6, line, Util.isNotNullOrEmpty(equReportInfo.get("rentNum2")) ? Util.toStringAndTrim(equReportInfo.get("rentNum2")) : "0"));	//	外局租 - 数量
						sheet.addCell(new Label(7, line, Util.isNotNullOrEmpty(equReportInfo.get("rentAmt2")) ? Util.toStringAndTrim(equReportInfo.get("rentAmt2")) : "0"));	//	外局租 - 租金（万元）

						sheet.addCell(new Label(8, line, Util.isNotNullOrEmpty(equReportInfo.get("rentNum3")) ? Util.toStringAndTrim(equReportInfo.get("rentNum3")) : "0"));	//	外租 - 数量
						sheet.addCell(new Label(9, line, Util.isNotNullOrEmpty(equReportInfo.get("rentAmt3")) ? Util.toStringAndTrim(equReportInfo.get("rentAmt3")) : "0"));	//	外租 - 租金（万元）

						sheet.addCell(new Label(10, line, Util.isNotNullOrEmpty(equReportInfo.get("scrapNum")) ? Util.toStringAndTrim(equReportInfo.get("scrapNum")) : "0"));	//	报废 - 数量
						sheet.addCell(new Label(11, line, Util.isNotNullOrEmpty(equReportInfo.get("scrapPrice")) ? Util.toStringAndTrim(equReportInfo.get("scrapPrice")) : "0"));	//	报废 - 残值（万元）

						sheet.addCell(new Label(12, line, Util.isNotNullOrEmpty(equReportInfo.get("sellNum")) ? Util.toStringAndTrim(equReportInfo.get("sellNum")) : "0"));	//	出售 - 数量
						sheet.addCell(new Label(13, line, Util.isNotNullOrEmpty(equReportInfo.get("sellPrice")) ? Util.toStringAndTrim(equReportInfo.get("sellPrice")) : "0"));	//	出售 - 售价（万元）

						line += 1;
						equReportInfo = new HashMap<String,Object>();
					}
				}
			}
		}

		//	写入数据
		book.write();
		//	关闭文件
		book.close();

		Map<String,Object> fileMap = new HashMap<String,Object>();

		int offset = fileName.lastIndexOf(".");
		fileName = fileName.substring(0, offset) + "/" + fileName.substring(offset + 1);
		fileMap.put("excel", fileName);

		return fileMap;
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
	public Map<String,Object> infoPublishCollectionExport(BusEquipmentReportBean busEquipmentReportBean, List<Map<String,Object>> categoryList) throws RowsExceededException, WriteException, IOException {

		Date now = new Date();

		if(Util.isNullOrEmpty(busEquipmentReportBean.getStartMonth())){
			busEquipmentReportBean.setStartMonth(Util.convertDateToStr(now, "yyyy-MM"));
		}

		if(Util.isNullOrEmpty(busEquipmentReportBean.getEndMonth())){
			busEquipmentReportBean.setEndMonth(Util.convertDateToStr(now, "yyyy-MM"));
		}

		int orgFlag = busEquipmentReportBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
		if(Util.isNullOrEmpty(orgFlag)){
			throw new IFException("所属单位信息不能为空！");
		}

		String orgCode = busEquipmentReportBean.getOrgCode();	//	所属单位编码
		Long orgPartyId = busEquipmentReportBean.getOrgPartyId();	//	所属单位/项目id
		Integer isInclude = busEquipmentReportBean.getIsInclude();	//	是否包含下级单位：1-包含

		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		sqlParamsMap.put("startMonth", busEquipmentReportBean.getStartMonth());
		sqlParamsMap.put("endMonth", busEquipmentReportBean.getEndMonth());

		StringBuffer totalListSql = new StringBuffer();	//	拼组按业务类型归类，总发布笔数、预估总金额的查询语句

		totalListSql.append("select EquCategoryId as equCategoryId, EquNameId as equNameId, EquName as equName, PubType as pubType, sum(ForecastSum) as forecastSum, count(1) as totalNum ");
		totalListSql.append("from view_pub_info vPub ");
		totalListSql.append("where date_format(vPub.releaseDate, '%Y-%m')>=:startMonth and date_format(vPub.releaseDate, '%Y-%m')<=:endMonth ");

		StringBuffer stateListSql = new StringBuffer();	//	拼组按业务类型、成交状态归类，总作废笔数、总成交笔数、总待成交笔数的查询语句

		stateListSql.append("select EquCategoryId as equCategoryId, EquNameId as equNameId, EquName as equName, PubType as pubType, State as state, count(1) as totalNum ");
		stateListSql.append("from view_pub_info vPub ");
		stateListSql.append("where date_format(vPub.releaseDate, '%Y-%m')>=:startMonth and date_format(vPub.releaseDate, '%Y-%m')<=:endMonth ");

		//	拼组所属单位/项目的查询条件
		if(Util.isNullOrEmpty(orgFlag)){
			throw new IFException("所属单位信息不能为空！");
		}

		//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
		if(orgFlag==9){//	总公司
			totalListSql.append("and vPub.orgParTypeId=4 ");
			stateListSql.append("and vPub.orgParTypeId=4 ");
		}
		else if(orgFlag==8){//	外部单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			totalListSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=8 ");
			stateListSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=8 ");
		}
		else if(orgFlag==1){//	局级单位
			if(isInclude!=null && isInclude==1){
				if(Util.isNullOrEmpty(orgCode)){
					throw new IFException("所属单位信息不能为空！");
				}
				sqlParamsMap.put("orgCode", orgCode + "%");

				totalListSql.append("and vPub.orgCode like :orgCode and vPub.orgParTypeId=4 ");
				stateListSql.append("and vPub.orgCode like :orgCode and vPub.orgParTypeId=4 ");
			}
			else{
				if(Util.isNullOrEmpty(orgPartyId)){
					throw new IFException("所属单位信息不能为空！");
				}
				sqlParamsMap.put("orgPartyId", orgPartyId);

				totalListSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=4 ");
				stateListSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=4 ");
			}
		}
		else if(orgFlag==2){//	处级单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			totalListSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=4 ");
			stateListSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=4 ");
		}
		else if(orgFlag==3){//	项目
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			totalListSql.append("and vPub.proId=:orgPartyId and vPub.proParTypeId=4 ");
			stateListSql.append("and vPub.proId=:orgPartyId and vPub.proParTypeId=4 ");
		}
		else{
			throw new IFException("所属单位信息错误！");
		}

		StringBuffer totalListSql_cat = new StringBuffer();
		StringBuffer stateListSql_cat = new StringBuffer();

		/** 按大类统计，需要展示全部信息 */
		totalListSql_cat.append(totalListSql).append("group by EquCategoryId, PubType order by EquCategoryId, PubType ");
		stateListSql_cat.append(stateListSql).append("group by EquCategoryId, PubType, State order by EquCategoryId, PubType, State ");

		List<Map<String, Object>> totalList_cat = query(totalListSql_cat.toString(), sqlParamsMap);	//	拼组按业务类型归类，总发布笔数、预估总金额的设备分类查询语句
		List<Map<String, Object>> stateList_cat = query(stateListSql_cat.toString(), sqlParamsMap);	//	拼组按业务类型、成交状态归类，总作废笔数、总成交笔数、总待成交笔数的设备分类查询语句

		ReportData reportData_cat = new ReportData();	//	返回资源汇总结果集

		ArrayList<String> path = new ArrayList<String>();

		/** 拼组设备分类信息 */
		packageEquTypeInfo(reportData_cat, categoryList, "equCategoryName");

		/** 总合计字段定义 */
		BigDecimal totalNum1 = BigDecimal.ZERO;	//	出租信息 - 发布数
		BigDecimal cancelNum1 = BigDecimal.ZERO;	//	出租信息 - 作废数
		BigDecimal turnoveredNum1 = BigDecimal.ZERO;	//	出租信息 - 成交数
		BigDecimal forecastSum1 = BigDecimal.ZERO;	//	出租信息 - 预估金额
		BigDecimal turnoveringNum1 = BigDecimal.ZERO;	//	出租信息 - 待成交数

		BigDecimal totalNum2 = BigDecimal.ZERO;	//	出售信息 - 发布数
		BigDecimal cancelNum2 = BigDecimal.ZERO;	//	出售信息 - 作废数
		BigDecimal turnoveredNum2 = BigDecimal.ZERO;	//	出售信息 - 成交数
		BigDecimal forecastSum2 = BigDecimal.ZERO;	//	出售信息 - 预估金额
		BigDecimal turnoveringNum2 = BigDecimal.ZERO;	//	出售信息 - 待成交数

		BigDecimal totalNum3 = BigDecimal.ZERO;	//	求租信息 - 发布数
//		BigDecimal cancelNum3 = BigDecimal.ZERO;	//	求租信息 - 作废数
//		BigDecimal turnoveredNum3 = BigDecimal.ZERO;	//	求租信息 - 成交数
//		BigDecimal forecastSum3 = BigDecimal.ZERO;	//	求租信息 - 预估金额
//		BigDecimal turnoveringNum3 = BigDecimal.ZERO;	//	求租信息 - 待成交数

		BigDecimal totalNum4 = BigDecimal.ZERO;	//	求购信息 - 发布数
//		BigDecimal cancelNum4 = BigDecimal.ZERO;	//	求购信息 - 作废数
//		BigDecimal turnoveredNum4 = BigDecimal.ZERO;	//	求购信息 - 成交数
//		BigDecimal forecastSum4 = BigDecimal.ZERO;	//	求购信息 - 预估金额
//		BigDecimal turnoveringNum4 = BigDecimal.ZERO;	//	求购信息 - 待成交数

		BigDecimal totalNum = BigDecimal.ZERO;
		BigDecimal forecastSum = BigDecimal.ZERO;
		Integer pubType = null;
		Integer state = null;

		/**  拼组发布数、预估金额 */
		if(totalList_cat!=null && totalList_cat.size()>0){
			for(Map<String,Object> rec : totalList_cat){
				pubType = Integer.parseInt(Util.toStringAndTrim(rec.get("pubType")));	//	业务类型：1-出租，2-出售，3-求租，4-求购

				totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
				forecastSum = Util.isNotNullOrEmpty(rec.get("forecastSum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("forecastSum"))) : BigDecimal.ZERO;
				switch(pubType){
					case 1://	出租信息
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						reportData_cat.put(path, "totalNum1", totalNum);	//	发布数
						totalNum1 = totalNum1.add(totalNum);

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						reportData_cat.put(path, "forecastSum1", forecastSum);	//	预估金额
						forecastSum1 = forecastSum1.add(forecastSum);
						break;
					case 2://	出售信息
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						reportData_cat.put(path, "totalNum2", totalNum);	//	发布数
						totalNum2 = totalNum2.add(totalNum);

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						reportData_cat.put(path, "forecastSum2", forecastSum);	//	预估金额
						forecastSum2 = forecastSum2.add(forecastSum);
						break;
					case 3://	求租信息
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						reportData_cat.put(path, "totalNum3", totalNum);	//	发布数
						totalNum3 = totalNum3.add(totalNum);

//						path.clear();
//
//						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//						reportData_cat.put(path, "forecastSum3", forecastSum);	//	预估金额
//						forecastSum3 = forecastSum3.add(forecastSum);
						break;
					case 4://	求购信息
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

						reportData_cat.put(path, "totalNum4", totalNum);	//	发布数
						totalNum4 = totalNum4.add(totalNum);

//						path.clear();
//
//						path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//						reportData_cat.put(path, "forecastSum4", forecastSum);	//	预估金额
//						forecastSum4 = forecastSum4.add(forecastSum);
						break;
					default:
						break;
				}
			}
		}

		/**  拼组作废数、成交数、待成交数 */
		if(stateList_cat!=null && stateList_cat.size()>0){
			for(Map<String,Object> rec : stateList_cat){
				pubType = Integer.parseInt(Util.toStringAndTrim(rec.get("pubType")));	//	业务类型：1-出租，2-出售，3-求租，4-求购
				state = Util.isNotNullOrEmpty(rec.get("state")) ? Integer.parseInt(Util.toStringAndTrim(rec.get("state"))) : 99;	//	成交状态：1-已成交，2-未成交，3-作废

				totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
				switch(pubType){
					case 1://	出租信息
						switch(state){
							case 3:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

								reportData_cat.put(path, "cancelNum1", totalNum);	//	作废数
								cancelNum1 = cancelNum1.add(totalNum);
								break;
							case 1:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

								reportData_cat.put(path, "turnoveredNum1", totalNum);	//	成交数
								turnoveredNum1 = turnoveredNum1.add(totalNum);
								break;
							case 2:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

								reportData_cat.put(path, "turnoveringNum1", totalNum);	//	待成交数
								turnoveringNum1 = turnoveringNum1.add(totalNum);
								break;
							default:
								break;
						}
						break;
					case 2://	出售信息
						switch(state){
							case 3:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

								reportData_cat.put(path, "cancelNum2", totalNum);	//	作废数
								cancelNum2 = cancelNum2.add(totalNum);
								break;
							case 1:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

								reportData_cat.put(path, "turnoveredNum2", totalNum);	//	成交数
								turnoveredNum2 = turnoveredNum2.add(totalNum);
								break;
							case 2:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

								reportData_cat.put(path, "turnoveringNum2", totalNum);	//	待成交数
								turnoveringNum2 = turnoveringNum2.add(totalNum);
								break;
							default:
								break;
						}
						break;
//					case 3://	求租信息
//						switch(state){
//							case 3:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//								reportData_cat.put(path, "cancelNum3", totalNum);	//	作废数
//								cancelNum3 = cancelNum3.add(totalNum);
//								break;
//							case 1:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//								reportData_cat.put(path, "turnoveredNum3", totalNum);	//	成交数
//								turnoveredNum3 = turnoveredNum3.add(totalNum);
//								break;
//							case 2:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//								reportData_cat.put(path, "turnoveringNum3", totalNum);	//	待成交数
//								turnoveringNum3 = turnoveringNum3.add(totalNum);
//								break;
//							default:
//								break;
//						}
//						break;
//					case 4://	求购信息
//						switch(state){
//							case 3:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//								reportData_cat.put(path, "cancelNum4", totalNum);	//	作废数
//								cancelNum4 = cancelNum4.add(totalNum);
//								break;
//							case 1:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//								reportData_cat.put(path, "turnoveredNum4", totalNum);	//	成交数
//								turnoveredNum4 = turnoveredNum4.add(totalNum);
//								break;
//							case 2:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//								reportData_cat.put(path, "turnoveringNum4", totalNum);	//	待成交数
//								turnoveringNum4 = turnoveringNum4.add(totalNum);
//								break;
//							default:
//								break;
//						}
//						break;
					default:
						break;
				}
			}
		}

		/** 添加总合计 */
		path.clear();

		path.add("999999999999");

		reportData_cat.put(path, "equCategoryName", "总合计");

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "totalNum1", totalNum1);	//	总合计 - 出租信息 - 发布数

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "totalNum2", totalNum2);	//	总合计 - 出售信息 - 发布数

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "totalNum3", totalNum3);	//	总合计 - 求租信息 - 发布数

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "totalNum4", totalNum4);	//	总合计 - 求购信息 - 发布数

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "cancelNum1", cancelNum1);	//	总合计 - 出租信息 - 作废数

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "cancelNum2", cancelNum2);	//	总合计 - 出售信息 - 作废数

//		path.clear();
//
//		path.add("999999999999");	//	设备分类id
//
//		reportData_cat.put(path, "cancelNum3", cancelNum3);	//	总合计 - 求租信息 - 作废数
//
//		path.clear();
//
//		path.add("999999999999");	//	设备分类id
//
//		reportData_cat.put(path, "cancelNum4", cancelNum4);	//	总合计 - 求购信息 - 作废数

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "turnoveredNum1", turnoveredNum1);	//	总合计 - 出租信息 - 成交数

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "turnoveredNum2", turnoveredNum2);	//	总合计 - 出售信息 - 成交数

//		path.clear();
//
//		path.add("999999999999");	//	设备分类id
//
//		reportData_cat.put(path, "turnoveredNum3", turnoveredNum3);	//	总合计 - 求租信息 - 成交数
//
//		path.clear();
//
//		path.add("999999999999");	//	设备分类id
//
//		reportData_cat.put(path, "turnoveredNum4", turnoveredNum4);	//	总合计 - 求购信息 - 成交数

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "forecastSum1", forecastSum1);	//	总合计 - 出租信息 - 预估金额

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "forecastSum2", forecastSum2);	//	总合计 - 出售信息 - 预估金额

//		path.clear();
//
//		path.add("999999999999");	//	设备分类id
//
//		reportData_cat.put(path, "forecastSum3", forecastSum3);	//	总合计 - 求租信息 - 预估金额
//
//		path.clear();
//
//		path.add("999999999999");	//	设备分类id
//
//		reportData_cat.put(path, "forecastSum4", forecastSum4);	//	总合计 - 求购信息 - 预估金额

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "turnoveringNum1", turnoveringNum1);	//	总合计 - 出租信息 - 待成交数

		path.clear();

		path.add("999999999999");	//	设备分类id

		reportData_cat.put(path, "turnoveringNum2", turnoveringNum2);	//	总合计 - 出售信息 - 待成交数

//		path.clear();
//
//		path.add("999999999999");	//	设备分类id
//
//		reportData_cat.put(path, "turnoveringNum3", turnoveringNum3);	//	总合计 - 求租信息 - 待成交数
//
//		path.clear();
//
//		path.add("999999999999");	//	设备分类id
//
//		reportData_cat.put(path, "turnoveringNum4", turnoveringNum4);	//	总合计 - 求购信息 - 待成交数

		List<Map<String,Object>> reportDataList_cat = convertReportDataToList(reportData_cat);

		StringBuffer totalListSql_name = new StringBuffer();
		StringBuffer stateListSql_name = new StringBuffer();

		/** 按小类统计，展示有数据的信息 */
		totalListSql_name.append(totalListSql).append("group by EquNameId, PubType order by EquCategoryId, EquNameId, PubType ");
		stateListSql_name.append(stateListSql).append("group by EquNameId, PubType, State order by EquCategoryId, EquNameId, PubType, State ");

		List<Map<String, Object>> totalList_name = query(totalListSql_name.toString(), sqlParamsMap);	//	拼组按业务类型归类，总发布笔数、预估总金额的设备分类查询语句
		List<Map<String, Object>> stateList_name = query(stateListSql_name.toString(), sqlParamsMap);	//	拼组按业务类型、成交状态归类，总作废笔数、总成交笔数、总待成交笔数的设备分类查询语句

		ReportData reportData_name = new ReportData();	//	返回资源汇总结果集

		/**  拼组发布数、预估金额 */
		if(totalList_name!=null && totalList_name.size()>0){
			for(Map<String,Object> rec : totalList_name){
				pubType = Integer.parseInt(Util.toStringAndTrim(rec.get("pubType")));	//	业务类型：1-出租，2-出售，3-求租，4-求购

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

				reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

				path.clear();

				path.add(Util.toStringAndTrim(rec.get("equNameId")));

				reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));

				totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
				forecastSum = Util.isNotNullOrEmpty(rec.get("forecastSum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("forecastSum"))) : BigDecimal.ZERO;
				switch(pubType){
					case 1://	出租信息
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						reportData_name.put(path, "totalNum1", totalNum);	//	发布数

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						reportData_name.put(path, "forecastSum1", forecastSum);	//	预估金额
						break;
					case 2://	出售信息
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						reportData_name.put(path, "totalNum2", totalNum);	//	发布数

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						reportData_name.put(path, "forecastSum2", forecastSum);	//	预估金额
						break;
					case 3://	求租信息
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						reportData_name.put(path, "totalNum3", totalNum);	//	发布数

//						path.clear();
//
//						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//						reportData_name.put(path, "forecastSum3", forecastSum);	//	预估金额
						break;
					case 4://	求购信息
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

						reportData_name.put(path, "totalNum4", totalNum);	//	发布数

//						path.clear();
//
//						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//						reportData_name.put(path, "forecastSum4", forecastSum);	//	预估金额
						break;
					default:
						break;
				}
			}
		}

		/**  拼组作废数、成交数、待成交数 */
		if(stateList_name!=null && stateList_name.size()>0){
			for(Map<String,Object> rec : stateList_name){
				pubType = Integer.parseInt(Util.toStringAndTrim(rec.get("pubType")));	//	业务类型：1-出租，2-出售，3-求租，4-求购
				state = Util.isNotNullOrEmpty(rec.get("state")) ? Integer.parseInt(Util.toStringAndTrim(rec.get("state"))) : 99;	//	成交状态：1-已成交，2-未成交，3-作废

				totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
				switch(pubType){
					case 1://	出租信息
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

						reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));

						reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));

						switch(state){
							case 3:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

								reportData_name.put(path, "cancelNum1", totalNum);	//	作废数
								break;
							case 1:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

								reportData_name.put(path, "turnoveredNum1", totalNum);	//	成交数
								break;
							case 2:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

								reportData_name.put(path, "turnoveringNum1", totalNum);	//	待成交数
								break;
							default:
								break;
						}
						break;
					case 2://	出售信息
						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

						reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

						path.clear();

						path.add(Util.toStringAndTrim(rec.get("equNameId")));

						reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));

						switch(state){
							case 3:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

								reportData_name.put(path, "cancelNum2", totalNum);	//	作废数
								break;
							case 1:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

								reportData_name.put(path, "turnoveredNum2", totalNum);	//	成交数
								break;
							case 2:
								path.clear();

								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

								reportData_name.put(path, "turnoveringNum2", totalNum);	//	待成交数
								break;
							default:
								break;
						}
						break;
//					case 3://	求租信息
//						path.clear();
//
//						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id
//
//						reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));
//
//						path.clear();
//
//						path.add(Util.toStringAndTrim(rec.get("equNameId")));
//
//						reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));
//
//						switch(state){
//							case 3:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//								reportData_name.put(path, "cancelNum3", totalNum);	//	作废数
//								break;
//							case 1:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//								reportData_name.put(path, "turnoveredNum3", totalNum);	//	成交数
//								break;
//							case 2:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//								reportData_name.put(path, "turnoveringNum3", totalNum);	//	待成交数
//								break;
//							default:
//								break;
//						}
//						break;
//					case 4://	求购信息
//						path.clear();
//
//						path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id
//
//						reportData_name.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));
//
//						path.clear();
//
//						path.add(Util.toStringAndTrim(rec.get("equNameId")));
//
//						reportData_name.put(path, "equCategoryId", Util.toStringAndTrim(rec.get("equCategoryId")));
//
//						switch(state){
//							case 3:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//								reportData_name.put(path, "cancelNum4", totalNum);	//	作废数
//								break;
//							case 1:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//								reportData_name.put(path, "turnoveredNum4", totalNum);	//	成交数
//								break;
//							case 2:
//								path.clear();
//
//								path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//								reportData_name.put(path, "turnoveringNum4", totalNum);	//	待成交数
//								break;
//							default:
//								break;
//						}
//						break;
					default:
						break;
				}
			}
		}

		List<Map<String,Object>> reportDataList_name = convertReportDataToList(reportData_name);

		//	标题行
		String title[] = {"发布数","作废数","成交数","预估金额（万元）","待成交数","发布数","作废数","成交数","预估金额（万元）","待成交数","发布数","发布数"};/** 求租、求购只有发布数，没有发布结果登记功能 */
//		String title[] = {"发布数","作废数","成交数","预估金额（万元）","待成交数","发布数","作废数","成交数","预估金额（万元）","待成交数","发布数","作废数","成交数","预估金额（万元）","待成交数","发布数","作废数","成交数","预估金额（万元）","待成交数"};
		//	t.xls为要新建的文件名
		String fileName = "pubReport_" + System.currentTimeMillis() + ".xls";
	    WritableWorkbook book = Workbook.createWorkbook(new File(exportExcelPath + "/" + fileName));
		//	生成名为“第一页”的工作表，参数0表示这是第一页 
		WritableSheet sheet = book.createSheet("第一页", 0);

		//	合并行
		sheet.mergeCells(1, 0, 5, 0);
		sheet.mergeCells(6, 0, 10, 0);
//		sheet.mergeCells(11, 0, 15, 0);
//		sheet.mergeCells(16, 0, 20, 0);

		//	合并列
		sheet.mergeCells(0, 0, 0, 1);

		//	给合并行赋值
		sheet.addCell(new Label(1, 0, "出租信息"));	//	写标题
		sheet.addCell(new Label(6, 0, "出售信息"));	//	写标题
		/** 求租、求购只有发布数，没有发布结果登记功能 */
		sheet.addCell(new Label(11, 0, "求租信息"));	//	写标题
		sheet.addCell(new Label(12, 0, "求购信息"));	//	写标题
		/** 求租、求购只有发布数，没有发布结果登记功能 */
//		sheet.addCell(new Label(11, 0, "求租信息"));	//	写标题
//		sheet.addCell(new Label(16, 0, "求购信息"));	//	写标题

		//	给合并列赋值
		sheet.addCell(new Label(0, 0, "设备名称"));	//	写标题

		//	写入标题
		/** 求租、求购只有发布数，没有发布结果登记功能 */
		for(int a=1;a<13;a++){
			sheet.addCell(new Label(a, 1, title[a - 1]));	//	写标题
		}
		/** 求租、求购只有发布数，没有发布结果登记功能 */
//		for(int a=1;a<21;a++){
//			sheet.addCell(new Label(a, 1, title[a - 1]));	//	写标题
//		}

		int line = 2;	//	起始行

		/** 循环设备分类，先写入设备分类信息；再根据设备分类id，写入设备名称信息 */
		Map<String,Object> equReportInfo = new HashMap<String,Object>();
		for(Map<String,Object> reportDataMap_cat : reportDataList_cat){//	写入设备分类信息
			equReportInfo = reportDataMap_cat.get("result")!=null ? (Map<String,Object>)reportDataMap_cat.get("result") : new HashMap<String,Object>();
			if(equReportInfo.isEmpty()){
				continue ;
			}

			//	写内容
			sheet.addCell(new Label(0, line, Util.toStringAndTrim(equReportInfo.get("equCategoryName"))));	//	设备名称

			sheet.addCell(new Label(1, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum1")) ? Util.toStringAndTrim(equReportInfo.get("totalNum1")) : "0"));	//	出租信息 - 发布数
			sheet.addCell(new Label(2, line, Util.isNotNullOrEmpty(equReportInfo.get("cancelNum1")) ? Util.toStringAndTrim(equReportInfo.get("cancelNum1")) : "0"));	//	出租信息 - 作废数
			sheet.addCell(new Label(3, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveredNum1")) ? Util.toStringAndTrim(equReportInfo.get("turnoveredNum1")) : "0"));	//	出租信息 - 成交数
			sheet.addCell(new Label(4, line, Util.isNotNullOrEmpty(equReportInfo.get("forecastSum1")) ? Util.toStringAndTrim(equReportInfo.get("forecastSum1")) : "0"));	//	出租信息 - 预估金额
			sheet.addCell(new Label(5, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveringNum1")) ? Util.toStringAndTrim(equReportInfo.get("turnoveringNum1")) : "0"));	//	出租信息 - 待成交数

			sheet.addCell(new Label(6, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum2")) ? Util.toStringAndTrim(equReportInfo.get("totalNum2")) : "0"));	//	出售信息 - 发布数
			sheet.addCell(new Label(7, line, Util.isNotNullOrEmpty(equReportInfo.get("cancelNum2")) ? Util.toStringAndTrim(equReportInfo.get("cancelNum2")) : "0"));	//	出售信息 - 作废数
			sheet.addCell(new Label(8, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveredNum2")) ? Util.toStringAndTrim(equReportInfo.get("turnoveredNum2")) : "0"));	//	出售信息 - 成交数
			sheet.addCell(new Label(9, line, Util.isNotNullOrEmpty(equReportInfo.get("forecastSum2")) ? Util.toStringAndTrim(equReportInfo.get("forecastSum2")) : "0"));	//	出售信息 - 预估金额
			sheet.addCell(new Label(10, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveringNum2")) ? Util.toStringAndTrim(equReportInfo.get("turnoveringNum2")) : "0"));	//	出售信息 - 待成交数

			/** 求租、求购只有发布数，没有发布结果登记功能 */
			sheet.addCell(new Label(11, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum3")) ? Util.toStringAndTrim(equReportInfo.get("totalNum3")) : "0"));	//	求租信息 - 发布数
			sheet.addCell(new Label(12, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum4")) ? Util.toStringAndTrim(equReportInfo.get("totalNum4")) : "0"));	//	求购信息 - 发布数
			/** 求租、求购只有发布数，没有发布结果登记功能 */

//			sheet.addCell(new Label(11, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum3")) ? Util.toStringAndTrim(equReportInfo.get("totalNum3")) : "0"));	//	求租信息 - 发布数
//			sheet.addCell(new Label(12, line, Util.isNotNullOrEmpty(equReportInfo.get("cancelNum3")) ? Util.toStringAndTrim(equReportInfo.get("cancelNum3")) : "0"));	//	求租信息 - 作废数
//			sheet.addCell(new Label(13, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveredNum3")) ? Util.toStringAndTrim(equReportInfo.get("turnoveredNum3")) : "0"));	//	求租信息 - 成交数
//			sheet.addCell(new Label(14, line, Util.isNotNullOrEmpty(equReportInfo.get("forecastSum3")) ? Util.toStringAndTrim(equReportInfo.get("forecastSum3")) : "0"));	//	求租信息 - 预估金额
//			sheet.addCell(new Label(15, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveringNum3")) ? Util.toStringAndTrim(equReportInfo.get("turnoveringNum3")) : "0"));	//	求租信息 - 待成交数
//
//			sheet.addCell(new Label(16, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum4")) ? Util.toStringAndTrim(equReportInfo.get("totalNum4")) : "0"));	//	求购信息 - 发布数
//			sheet.addCell(new Label(17, line, Util.isNotNullOrEmpty(equReportInfo.get("cancelNum4")) ? Util.toStringAndTrim(equReportInfo.get("cancelNum4")) : "0"));	//	求购信息 - 作废数
//			sheet.addCell(new Label(18, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveredNum4")) ? Util.toStringAndTrim(equReportInfo.get("turnoveredNum4")) : "0"));	//	求购信息 - 成交数
//			sheet.addCell(new Label(19, line, Util.isNotNullOrEmpty(equReportInfo.get("forecastSum4")) ? Util.toStringAndTrim(equReportInfo.get("forecastSum4")) : "0"));	//	求购信息 - 预估金额
//			sheet.addCell(new Label(20, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveringNum4")) ? Util.toStringAndTrim(equReportInfo.get("turnoveringNum4")) : "0"));	//	求购信息 - 待成交数

			line += 1;
			equReportInfo = new HashMap<String,Object>();

			if(reportDataList_name!=null && reportDataList_name.size()>0){//	根据设备分类id，写入设备名称信息
				Long equCategoryId = Long.parseLong(Util.toStringAndTrim(reportDataMap_cat.get("equCategoryId")));

				for(Map<String,Object> reportDataMap_name : reportDataList_name){
					equReportInfo = reportDataMap_name.get("result")!=null ? (Map<String,Object>)reportDataMap_name.get("result") : new HashMap<String,Object>();
					if(equReportInfo.isEmpty()){
						continue ;
					}

					if(equCategoryId.equals(Long.parseLong(Util.toStringAndTrim(equReportInfo.get("equCategoryId"))))){
						//	写内容
						sheet.addCell(new Label(0, line, Util.toStringAndTrim(equReportInfo.get("equCategoryName"))));	//	设备名称

						sheet.addCell(new Label(1, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum1")) ? Util.toStringAndTrim(equReportInfo.get("totalNum1")) : "0"));	//	出租信息 - 发布数
						sheet.addCell(new Label(2, line, Util.isNotNullOrEmpty(equReportInfo.get("cancelNum1")) ? Util.toStringAndTrim(equReportInfo.get("cancelNum1")) : "0"));	//	出租信息 - 作废数
						sheet.addCell(new Label(3, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveredNum1")) ? Util.toStringAndTrim(equReportInfo.get("turnoveredNum1")) : "0"));	//	出租信息 - 成交数
						sheet.addCell(new Label(4, line, Util.isNotNullOrEmpty(equReportInfo.get("forecastSum1")) ? Util.toStringAndTrim(equReportInfo.get("forecastSum1")) : "0"));	//	出租信息 - 预估金额
						sheet.addCell(new Label(5, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveringNum1")) ? Util.toStringAndTrim(equReportInfo.get("turnoveringNum1")) : "0"));	//	出租信息 - 待成交数

						sheet.addCell(new Label(6, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum2")) ? Util.toStringAndTrim(equReportInfo.get("totalNum2")) : "0"));	//	出售信息 - 发布数
						sheet.addCell(new Label(7, line, Util.isNotNullOrEmpty(equReportInfo.get("cancelNum2")) ? Util.toStringAndTrim(equReportInfo.get("cancelNum2")) : "0"));	//	出售信息 - 作废数
						sheet.addCell(new Label(8, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveredNum2")) ? Util.toStringAndTrim(equReportInfo.get("turnoveredNum2")) : "0"));	//	出售信息 - 成交数
						sheet.addCell(new Label(9, line, Util.isNotNullOrEmpty(equReportInfo.get("forecastSum2")) ? Util.toStringAndTrim(equReportInfo.get("forecastSum2")) : "0"));	//	出售信息 - 预估金额
						sheet.addCell(new Label(10, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveringNum2")) ? Util.toStringAndTrim(equReportInfo.get("turnoveringNum2")) : "0"));	//	出售信息 - 待成交数

						/** 求租、求购只有发布数，没有发布结果登记功能 */
						sheet.addCell(new Label(11, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum3")) ? Util.toStringAndTrim(equReportInfo.get("totalNum3")) : "0"));	//	求租信息 - 发布数
						sheet.addCell(new Label(12, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum4")) ? Util.toStringAndTrim(equReportInfo.get("totalNum4")) : "0"));	//	求购信息 - 发布数
						/** 求租、求购只有发布数，没有发布结果登记功能 */

//						sheet.addCell(new Label(11, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum3")) ? Util.toStringAndTrim(equReportInfo.get("totalNum3")) : "0"));	//	求租信息 - 发布数
//						sheet.addCell(new Label(12, line, Util.isNotNullOrEmpty(equReportInfo.get("cancelNum3")) ? Util.toStringAndTrim(equReportInfo.get("cancelNum3")) : "0"));	//	求租信息 - 作废数
//						sheet.addCell(new Label(13, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveredNum3")) ? Util.toStringAndTrim(equReportInfo.get("turnoveredNum3")) : "0"));	//	求租信息 - 成交数
//						sheet.addCell(new Label(14, line, Util.isNotNullOrEmpty(equReportInfo.get("forecastSum3")) ? Util.toStringAndTrim(equReportInfo.get("forecastSum3")) : "0"));	//	求租信息 - 预估金额
//						sheet.addCell(new Label(15, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveringNum3")) ? Util.toStringAndTrim(equReportInfo.get("turnoveringNum3")) : "0"));	//	求租信息 - 待成交数
//
//						sheet.addCell(new Label(16, line, Util.isNotNullOrEmpty(equReportInfo.get("totalNum4")) ? Util.toStringAndTrim(equReportInfo.get("totalNum4")) : "0"));	//	求购信息 - 发布数
//						sheet.addCell(new Label(17, line, Util.isNotNullOrEmpty(equReportInfo.get("cancelNum4")) ? Util.toStringAndTrim(equReportInfo.get("cancelNum4")) : "0"));	//	求购信息 - 作废数
//						sheet.addCell(new Label(18, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveredNum4")) ? Util.toStringAndTrim(equReportInfo.get("turnoveredNum4")) : "0"));	//	求购信息 - 成交数
//						sheet.addCell(new Label(19, line, Util.isNotNullOrEmpty(equReportInfo.get("forecastSum4")) ? Util.toStringAndTrim(equReportInfo.get("forecastSum4")) : "0"));	//	求购信息 - 预估金额
//						sheet.addCell(new Label(20, line, Util.isNotNullOrEmpty(equReportInfo.get("turnoveringNum4")) ? Util.toStringAndTrim(equReportInfo.get("turnoveringNum4")) : "0"));	//	求购信息 - 待成交数

						line += 1;
						equReportInfo = new HashMap<String,Object>();
					}
				}
			}
		}

		//	写入数据
		book.write();
		//	关闭文件
		book.close();

		Map<String,Object> fileMap = new HashMap<String,Object>();

		int offset = fileName.lastIndexOf(".");
		fileName = fileName.substring(0, offset) + "/" + fileName.substring(offset + 1);
		fileMap.put("excel", fileName);

		return fileMap;
	}

}
