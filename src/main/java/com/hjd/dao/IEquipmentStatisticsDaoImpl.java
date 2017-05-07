package com.hjd.dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.hjd.action.bean.BusEquipmentReportBean;
import com.hjd.base.IFException;
import com.hjd.util.ReportData;
import com.hjd.util.Util;

import com.hjd.dao.base.IBaseDaoImpl;
import com.hjd.domain.ViewEquInfo;
import com.hjd.domain.ViewPubInfo;

public class IEquipmentStatisticsDaoImpl extends IBaseDaoImpl {

	/**
	 * 资源明细
	 * 列表查询 - 根据查询条件，查询未删除的资源的拥有情况和使用情况（包含内部租用和外部租用）
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
	public Page<?> equipmentResourceReport(BusEquipmentReportBean busEquipmentReportBean) {

		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select vEqu ");
		listSql.append("from ViewEquInfo vEqu ");	//	设备拥有者和设备使用者的设备信息
		listSql.append("where vEqu.delFlag!=1 and (vEqu.equState in (1,2) or vEqu.equState is null) ");

		//	拼写的总数查询语句
		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(1) ");
		countSql.append("from ViewEquInfo vEqu ");	//	设备拥有者和设备使用者的设备信息
		countSql.append("where vEqu.delFlag!=1 and (vEqu.equState in (1,2) or vEqu.equState is null) ");

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
					countSql.append("and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgParTypeId=4 ");
				}
				else if(2==equTrsType){//	内租
					throw new IFException("当前单位为总公司时，无内租！");
				}
				else if(3==equTrsType){//	外租
					listSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.bureauOrgParTypeId=4) or (vEqu.busState=5 and vEqu.equAtOrgParTypeId=4)) ");
					countSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.bureauOrgParTypeId=4) or (vEqu.busState=5 and vEqu.equAtOrgParTypeId=4)) ");
				}
				else{//	外协
					listSql.append("and vEqu.equipmentSourceNo=3 and vEqu.bureauOrgParTypeId=4 ");
					countSql.append("and vEqu.equipmentSourceNo=3 and vEqu.bureauOrgParTypeId=4 ");
				}
			}
			else{
				listSql.append("and (vEqu.bureauOrgParTypeId=4 or vEqu.equAtOrgParTypeId=4) ");
				countSql.append("and (vEqu.bureauOrgParTypeId=4 or vEqu.equAtOrgParTypeId=4) ");
			}
		}
		else if(orgFlag==8){//	外部单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			listSql.append("and ((vEqu.bureauOrgParTypeId=8 and vEqu.bureauOrgPartyId=:orgPartyId) or (vEqu.equAtOrgParTypeId=8 and vEqu.equAtOrgId=:orgPartyId)) ");
			countSql.append("and ((vEqu.bureauOrgParTypeId=8 and vEqu.bureauOrgPartyId=:orgPartyId) or (vEqu.equAtOrgParTypeId=8 and vEqu.equAtOrgId=:orgPartyId)) ");
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
						countSql.append("and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.equipmentSourceNo=1 ");
					}
					else if(2==equTrsType){//	内租
						listSql.append("and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.busState=4 ");
						countSql.append("and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.busState=4 ");
					}
					else if(3==equTrsType){//	外租
						listSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.bureauOrgPartyId=:orgPartyId) or (vEqu.busState=5 and vEqu.equAtOrgId=:orgPartyId)) ");
						countSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.bureauOrgPartyId=:orgPartyId) or (vEqu.busState=5 and vEqu.equAtOrgId=:orgPartyId)) ");
					}
					else{//	外协
						listSql.append("and vEqu.equipmentSourceNo=3 and vEqu.bureauOrgPartyId=:orgPartyId ");
						countSql.append("and vEqu.equipmentSourceNo=3 and vEqu.bureauOrgPartyId=:orgPartyId ");
					}
				}
				else{
					if(1==equTrsType){//	自有
						listSql.append("and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.equipmentSourceNo=1 and vEqu.sonOrgPartyId is null ");
						countSql.append("and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.equipmentSourceNo=1 and vEqu.sonOrgPartyId is null ");
					}
					else if(2==equTrsType){//	内租
						listSql.append("and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.busState=4 and vEqu.sonOrgPartyId is null ");
						countSql.append("and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.busState=4 and vEqu.sonOrgPartyId is null ");
					}
					else if(3==equTrsType){//	外租
						listSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null) or (vEqu.busState=5 and vEqu.equAtOrgId=:orgPartyId and vEqu.equAtSubOrgId is null)) ");
						countSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null) or (vEqu.busState=5 and vEqu.equAtOrgId=:orgPartyId and vEqu.equAtSubOrgId is null)) ");
					}
					else{//	外协
						listSql.append("and vEqu.equipmentSourceNo=3 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null ");
						countSql.append("and vEqu.equipmentSourceNo=3 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null ");
					}
				}
			}
			else{
				if(isInclude!=null && isInclude==1){
					listSql.append("and (vEqu.bureauOrgPartyId=:orgPartyId or vEqu.equAtOrgId=:orgPartyId) ");
					countSql.append("and (vEqu.bureauOrgPartyId=:orgPartyId or vEqu.equAtOrgId=:orgPartyId) ");
				}
				else{
					listSql.append("and ((vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null) or (vEqu.equAtOrgId=:orgPartyId and vEqu.equAtSubOrgId is null)) ");
					countSql.append("and ((vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null) or (vEqu.equAtOrgId=:orgPartyId and vEqu.equAtSubOrgId is null)) ");
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
					countSql.append("and vEqu.sonOrgPartyId=:orgPartyId and vEqu.equipmentSourceNo=1 ");
				}
				else if(2==equTrsType){//	内租
					listSql.append("and vEqu.sonOrgPartyId=:orgPartyId and vEqu.busState in (3,4) ");
					countSql.append("and vEqu.sonOrgPartyId=:orgPartyId and vEqu.busState in (3,4) ");
				}
				else if(3==equTrsType){//	外租
					listSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.sonOrgPartyId=:orgPartyId) or (vEqu.busState=5 and vEqu.equAtSubOrgId=:orgPartyId)) ");
					countSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.sonOrgPartyId=:orgPartyId) or (vEqu.busState=5 and vEqu.equAtSubOrgId=:orgPartyId)) ");
				}
				else{//	外协
					listSql.append("and vEqu.equipmentSourceNo=3 and vEqu.sonOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.equipmentSourceNo=3 and vEqu.sonOrgPartyId=:orgPartyId ");
				}
			}
			else{
				listSql.append("and (vEqu.sonOrgPartyId=:orgPartyId or vEqu.equAtSubOrgId=:orgPartyId) ");
				countSql.append("and (vEqu.sonOrgPartyId=:orgPartyId or vEqu.equAtSubOrgId=:orgPartyId) ");
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
					countSql.append("and vEqu.proOrgPartyId=:orgPartyId and vEqu.equipmentSourceNo=1 ");
				}
				else if(2==equTrsType){//	内租
					listSql.append("and vEqu.proOrgPartyId=:orgPartyId and vEqu.busState in (3,4) ");
					countSql.append("and vEqu.proOrgPartyId=:orgPartyId and vEqu.busState in (3,4) ");
				}
				else if(3==equTrsType){//	外租
					listSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.proOrgPartyId=:orgPartyId) or (vEqu.busState=5 and vEqu.equAtProjectId=:orgPartyId)) ");
					countSql.append("and ((vEqu.equipmentSourceNo=2 and vEqu.proOrgPartyId=:orgPartyId) or (vEqu.busState=5 and vEqu.equAtProjectId=:orgPartyId)) ");
				}
				else{//	外协
					listSql.append("and vEqu.equipmentSourceNo=3 and vEqu.proOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.equipmentSourceNo=3 and vEqu.proOrgPartyId=:orgPartyId ");
				}
			}
			else{
				listSql.append("and (vEqu.proOrgPartyId=:orgPartyId or vEqu.equAtProjectId=:orgPartyId) ");
				countSql.append("and (vEqu.proOrgPartyId=:orgPartyId or vEqu.equAtProjectId=:orgPartyId) ");
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
			countSql.append("and vEqu.equCategoryId=:equCategoryId ");
		}

		//	拼组设备名称的查询条件
		String equName = busEquipmentReportBean.getEquName();	//	设备名称
		if(Util.isNotNullOrEmpty(equName)){
			sqlParamsMap.put("equName", "%" + equName + "%");
			listSql.append("and vEqu.equName like :equName ");
			countSql.append("and vEqu.equName like :equName ");
		}

		//	按照设备编号升序
		listSql.append("order by vEqu.equNo");

		Page<?> datas = (Page<?>)findAllByConditions(listSql.toString(),countSql.toString(),sqlParamsMap,busEquipmentReportBean.getPageRequest());

		//	结果集为空时，直接返回
		if(!datas.hasContent()){
			return datas;
		}

		//	对返回的资源进行处理，根据orgFlag、equipmentSourceNo和busState，来显示来源；根据局级名称、项目名称，来显示单位名称
		List<ViewEquInfo> list = (List<ViewEquInfo>)datas.getContent();
		for(ViewEquInfo equInfo : list){
			//	根据orgFlag、equipmentSourceNo和busState，来显示来源
			if(orgFlag==9){//	总公司
				if(1==equInfo.getEquipmentSourceNo()){
					if(4==equInfo.getBureauOrgParTypeId()){//	自有
						equInfo.setEquTrsType(1);
					}
					else{//	外租
						equInfo.setEquTrsType(3);
					}
				}
				else if(2==equInfo.getEquipmentSourceNo()){//	外租
					equInfo.setEquTrsType(3);
				}
				else if(3==equInfo.getEquipmentSourceNo()){//	外协
					equInfo.setEquTrsType(4);
				}
			}
			else if(orgFlag==8){//	外部单位
				equInfo.setEquTrsType(1);
			}
			else if(orgFlag==1){//	局级单位
				if(1==equInfo.getEquipmentSourceNo()){
					if(Util.isNullOrEmpty(equInfo.getBusState())){//	自有
						equInfo.setEquTrsType(1);
					}
					else if(4==equInfo.getBusState()){//	内租
						equInfo.setEquTrsType(2);
					}
					else{//	自有
						equInfo.setEquTrsType(1);
					}
				}
				else if(2==equInfo.getEquipmentSourceNo()){//	外租
					equInfo.setEquTrsType(3);
				}
				else if(3==equInfo.getEquipmentSourceNo()){//	外协
					equInfo.setEquTrsType(4);
				}

				if(1==equInfo.getEquTrsType()){
					if(4==equInfo.getBureauOrgParTypeId()){//	自有
						equInfo.setEquTrsType(1);
					}
					else{//	外租
						equInfo.setEquTrsType(3);
					}
				}
			}
			else if(orgFlag==2){//	处级单位
				if(1==equInfo.getEquipmentSourceNo()){
					if(Util.isNullOrEmpty(equInfo.getBusState())){//	自有
						equInfo.setEquTrsType(1);
					}
					else if(4==equInfo.getBusState() || 3==equInfo.getBusState()){//	内租
						equInfo.setEquTrsType(2);
					}
					else{//	自有
						equInfo.setEquTrsType(1);
					}
				}
				else if(2==equInfo.getEquipmentSourceNo()){//	外租
					equInfo.setEquTrsType(3);
				}
				else if(3==equInfo.getEquipmentSourceNo()){//	外协
					equInfo.setEquTrsType(4);
				}

				if(1==equInfo.getEquTrsType()){
					if(4==equInfo.getBureauOrgParTypeId()){//	自有
						equInfo.setEquTrsType(1);
					}
					else{//	外租
						equInfo.setEquTrsType(3);
					}
				}
			}
			else if(orgFlag==3){//	项目
				if(1==equInfo.getEquipmentSourceNo()){
					if(Util.isNullOrEmpty(equInfo.getBusState())){//	自有
						equInfo.setEquTrsType(1);
					}
					else if(4==equInfo.getBusState() || 3==equInfo.getBusState()){//	内租
						equInfo.setEquTrsType(2);
					}
					else{//	自有
						equInfo.setEquTrsType(1);
					}
				}
				else if(2==equInfo.getEquipmentSourceNo()){//	外租
					equInfo.setEquTrsType(3);
				}
				else if(3==equInfo.getEquipmentSourceNo()){//	外协
					equInfo.setEquTrsType(4);
				}

				if(1==equInfo.getEquTrsType()){
					if(4==equInfo.getBureauOrgParTypeId()){//	自有
						equInfo.setEquTrsType(1);
					}
					else{//	外租
						equInfo.setEquTrsType(3);
					}
				}
			}

			//	根据局级名称、项目名称，来显示单位名称
			if(Util.isNullOrEmpty(equInfo.getEquAtProjectName())){
				equInfo.setDisEquAtName(equInfo.getEquAtOrgName());
			}
			else{
				equInfo.setDisEquAtName(equInfo.getEquAtProjectName());
			}
		}

		return datas;
	}

	/**
	 * 租赁明细 - 列表查询
	 * @author haopeng
	 * @since 2016-08-24
	 * @param startMonth 起始年月（必输）
	 * @param endMonth 截止年月（必输）
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equRentType 业务类型
	 * @param equCategoryId 设备分类
	 * @param equName 设备名称（模糊查询）
	 * @return Page<?>
	 */
	public Page<?> equipmentRentHistReport(BusEquipmentReportBean busEquipmentReportBean) {

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

		//	拼写的总数查询语句
		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(distinct vEqu.equipmentId) ");
		countSql.append("from view_equ_info vEqu ");	//	设备拥有者和设备使用者的设备信息
		countSql.append("left join view_rent_info vRent on vEqu.equipmentId=vRent.equipmentId and vRent.month>=:startMonth and vRent.month<=:endMonth ");
		countSql.append("left join bus_depreciation_hist depreciation on vEqu.equipmentId=depreciation.equipmentId and depreciation.month>=:startMonth and depreciation.month<=:endMonth ");
		countSql.append("where date_format(vEqu.createTime, '%Y-%m')>=:startMonth and date_format(vEqu.createTime, '%Y-%m')<=:endMonth ");

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
					countSql.append("and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgParTypeId=4 and (vEqu.equState in (1,2) or vEqu.equState is null) ");
				}
				else if(2==equRentType){//	局内租
					throw new IFException("当前单位为总公司时，无局内租！");
				}
				else if(3==equRentType){//	外局租
					throw new IFException("当前单位为总公司时，无外局租！");
				}
				else if(4==equRentType){//	外租
					listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=5 ");
					countSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=5 ");
				}
				else if(5==equRentType){//	报废
					listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=4 ");
					countSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=4 ");
				}
				else{//	出售
					listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=3 ");
					countSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=3 ");
				}
			}
			else{
				listSql.append("and ((vEqu.bureauOrgParTypeId=4 and vEqu.equipmentSourceNo=1) or (vRent.bureauParTypeId=4 and vEqu.busState in (3,4,5))) ");
				countSql.append("and ((vEqu.bureauOrgParTypeId=4 and vEqu.equipmentSourceNo=1) or (vRent.bureauParTypeId=4 and vEqu.busState in (3,4,5))) ");
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
					countSql.append("and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgParTypeId=8 and vEqu.bureauOrgPartyId=:orgPartyId and (vEqu.equState in (1,2) or vEqu.equState is null) ");
				}
				else if(4==equRentType){//	外租
					listSql.append("and vRent.bureauParTypeId=8 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId ");
					countSql.append("and vRent.bureauParTypeId=8 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId ");
				}
				else if(5==equRentType){//	报废
					listSql.append("and vEqu.bureauOrgParTypeId=8 and vEqu.equState=4 and vEqu.bureauOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.bureauOrgParTypeId=8 and vEqu.equState=4 and vEqu.bureauOrgPartyId=:orgPartyId ");
				}
				else{//	出售
					listSql.append("and vEqu.bureauOrgParTypeId=8 and vEqu.equState=3 and vEqu.bureauOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.bureauOrgParTypeId=8 and vEqu.equState=3 and vEqu.bureauOrgPartyId=:orgPartyId ");
				}
			}
			else{
				listSql.append("and ((vEqu.bureauOrgParTypeId=8 and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgPartyId=:orgPartyId) or (vRent.bureauParTypeId=8 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId)) ");
				countSql.append("and ((vEqu.bureauOrgParTypeId=8 and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgPartyId=:orgPartyId) or (vRent.bureauParTypeId=8 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId)) ");
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
						countSql.append("and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgParTypeId=4 and vEqu.bureauOrgPartyId=:orgPartyId and (vEqu.equState in (1,2) or vEqu.equState is null) ");
					}
					else if(2==equRentType){//	局内租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=3 and vRent.bureauOrgPartyId=:orgPartyId ");
						countSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=3 and vRent.bureauOrgPartyId=:orgPartyId ");
					}
					else if(3==equRentType){//	外局租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=4 and vRent.bureauOrgPartyId=:orgPartyId ");
						countSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=4 and vRent.bureauOrgPartyId=:orgPartyId ");
					}
					else if(4==equRentType){//	外租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId ");
						countSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId ");
					}
					else if(5==equRentType){//	报废
						listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=4 and vEqu.bureauOrgPartyId=:orgPartyId ");
						countSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=4 and vEqu.bureauOrgPartyId=:orgPartyId ");
					}
					else{//	出售
						listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=3 and vEqu.bureauOrgPartyId=:orgPartyId ");
						countSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=3 and vEqu.bureauOrgPartyId=:orgPartyId ");
					}
				}
				else{
					if(1==equRentType){//	自有
						listSql.append("and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgParTypeId=4 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null and (vEqu.equState in (1,2) or vEqu.equState is null) ");
						countSql.append("and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgParTypeId=4 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null and (vEqu.equState in (1,2) or vEqu.equState is null) ");
					}
					else if(2==equRentType){//	局内租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=3 and vRent.bureauOrgPartyId=:orgPartyId and vRent.sonOrgPartyId is null ");
						countSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=3 and vRent.bureauOrgPartyId=:orgPartyId and vRent.sonOrgPartyId is null ");
					}
					else if(3==equRentType){//	外局租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=4 and vRent.bureauOrgPartyId=:orgPartyId and vRent.sonOrgPartyId is null ");
						countSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=4 and vRent.bureauOrgPartyId=:orgPartyId and vRent.sonOrgPartyId is null ");
					}
					else if(4==equRentType){//	外租
						listSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId and vRent.sonOrgPartyId is null ");
						countSql.append("and vRent.bureauParTypeId=4 and vEqu.busState=5 and vRent.bureauOrgPartyId=:orgPartyId and vRent.sonOrgPartyId is null ");
					}
					else if(5==equRentType){//	报废
						listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=4 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null ");
						countSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=4 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null ");
					}
					else{//	出售
						listSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=3 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null ");
						countSql.append("and vEqu.bureauOrgParTypeId=4 and vEqu.equState=3 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null ");
					}
				}
			}
			else{
				if(isInclude!=null && isInclude==1){
					listSql.append("and ((vEqu.bureauOrgParTypeId=4 and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgPartyId=:orgPartyId) or (vRent.bureauParTypeId=4 and vEqu.busState in (3,4,5) and vRent.bureauOrgPartyId=:orgPartyId)) ");
					countSql.append("and ((vEqu.bureauOrgParTypeId=4 and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgPartyId=:orgPartyId) or (vRent.bureauParTypeId=4 and vEqu.busState in (3,4,5) and vRent.bureauOrgPartyId=:orgPartyId)) ");
				}
				else{
					listSql.append("and ((vEqu.bureauOrgParTypeId=4 and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null) or (vRent.bureauParTypeId=4 and vEqu.busState in (3,4,5) and vRent.bureauOrgPartyId=:orgPartyId and vRent.sonOrgPartyId is null)) ");
					countSql.append("and ((vEqu.bureauOrgParTypeId=4 and vEqu.equipmentSourceNo=1 and vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null) or (vRent.bureauParTypeId=4 and vEqu.busState in (3,4,5) and vRent.bureauOrgPartyId=:orgPartyId and vRent.sonOrgPartyId is null)) ");
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
					countSql.append("and vEqu.equipmentSourceNo=1 and vEqu.sonOrgPartyId=:orgPartyId and (vEqu.equState in (1,2) or vEqu.equState is null) ");
				}
				else if(2==equRentType){//	局内租
					listSql.append("and vEqu.busState=3 and vRent.sonOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.busState=3 and vRent.sonOrgPartyId=:orgPartyId ");
				}
				else if(3==equRentType){//	外局租
					listSql.append("and vEqu.busState=4 and vRent.sonOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.busState=4 and vRent.sonOrgPartyId=:orgPartyId ");
				}
				else if(4==equRentType){//	外租
					listSql.append("and vEqu.busState=5 and vRent.sonOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.busState=5 and vRent.sonOrgPartyId=:orgPartyId ");
				}
				else if(5==equRentType){//	报废
					listSql.append("and vEqu.equState=4 and vEqu.sonOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.equState=4 and vEqu.sonOrgPartyId=:orgPartyId ");
				}
				else{//	出售
					listSql.append("and vEqu.equState=3 and vEqu.sonOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.equState=3 and vEqu.sonOrgPartyId=:orgPartyId ");
				}
			}
			else{
				listSql.append("and ((vEqu.equipmentSourceNo=1 and vEqu.sonOrgPartyId=:orgPartyId) or (vEqu.busState in (3,4,5) and vRent.sonOrgPartyId=:orgPartyId)) ");
				countSql.append("and ((vEqu.equipmentSourceNo=1 and vEqu.sonOrgPartyId=:orgPartyId) or (vEqu.busState in (3,4,5) and vRent.sonOrgPartyId=:orgPartyId)) ");
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
					countSql.append("and vEqu.equipmentSourceNo=1 and vEqu.proOrgPartyId=:orgPartyId and (vEqu.equState in (1,2) or vEqu.equState is null) ");
				}
				else if(2==equRentType){//	局内租
					listSql.append("and vEqu.busState=3 and vRent.proOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.busState=3 and vRent.proOrgPartyId=:orgPartyId ");
				}
				else if(3==equRentType){//	外局租
					listSql.append("and vEqu.busState=4 and vRent.proOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.busState=4 and vRent.proOrgPartyId=:orgPartyId ");
				}
				else if(4==equRentType){//	外租
					listSql.append("and vEqu.busState=5 and vRent.proOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.busState=5 and vRent.proOrgPartyId=:orgPartyId ");
				}
				else if(5==equRentType){//	报废
					listSql.append("and vEqu.equipmentSourceNo=1 and vEqu.equState=4 and vEqu.proOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.equipmentSourceNo=1 and vEqu.equState=4 and vEqu.proOrgPartyId=:orgPartyId ");
				}
				else{//	出售
					listSql.append("and vEqu.equState=3 and vEqu.proOrgPartyId=:orgPartyId ");
					countSql.append("and vEqu.equState=3 and vEqu.proOrgPartyId=:orgPartyId ");
				}
			}
			else{
				listSql.append("and ((vEqu.equipmentSourceNo=1 and vEqu.proOrgPartyId=:orgPartyId) or (vEqu.busState in (3,4,5) and vRent.proOrgPartyId=:orgPartyId)) ");
				countSql.append("and ((vEqu.equipmentSourceNo=1 and vEqu.proOrgPartyId=:orgPartyId) or (vEqu.busState in (3,4,5) and vRent.proOrgPartyId=:orgPartyId)) ");
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
			countSql.append("and vEqu.equCategoryId=:equCategoryId ");
		}

		//	拼组设备名称的查询条件
		String equName = busEquipmentReportBean.getEquName();	//	设备名称
		if(Util.isNotNullOrEmpty(equName)){
			sqlParamsMap.put("equName", "%" + equName + "%");
			listSql.append("and vEqu.equName like :equName ");
			countSql.append("and vEqu.equName like :equName ");
		}

		//	按照设备编号升序
		listSql.append("order by vEqu.equNo");

		Page<?> datas = (Page<?>)queryAllByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,busEquipmentReportBean.getPageRequest());

		//	结果集为空时，直接返回
		if(!datas.hasContent()){
			return datas;
		}

		//	对返回的租赁进行处理，根据equState和busState，来显示业务类型；根据拥有局级单位名称和拥有项目名称，来显示拥有单位名称；根据使用局级单位名称和使用项目名称，来显示使用单位名称
		BigDecimal conversion = new BigDecimal("10000");

		List<Map<String,Object>> list = (List<Map<String,Object>>)datas.getContent();
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

			//	出售残值
			BigDecimal sellPrice = Util.isNotNullOrEmpty(equInfo.get("sellPrice")) ? new BigDecimal(Util.toStringAndTrim(equInfo.get("sellPrice"))) : BigDecimal.ZERO;
			equInfo.put("sellPrice", sellPrice);
		}

		return datas;
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
	 * @return Page<?>
	 */
	public Page<?> infoPublishReport(BusEquipmentReportBean busEquipmentReportBean) {

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

		listSql.append("select vPub ");
		listSql.append("from ViewPubInfo vPub ");
		listSql.append("where date_format(vPub.releaseDate, '%Y-%m')>=:startMonth and date_format(vPub.releaseDate, '%Y-%m')<=:endMonth ");

		//	拼写的总数查询语句
		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(1) ");
		countSql.append("from ViewPubInfo vPub ");
		countSql.append("where date_format(vPub.releaseDate, '%Y-%m')>=:startMonth and date_format(vPub.releaseDate, '%Y-%m')<=:endMonth ");

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
			listSql.append("and vPub.orgParTypeId=4 ");
			countSql.append("and vPub.orgParTypeId=4 ");
		}
		else if(orgFlag==8){//	外部单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			listSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=8 ");
			countSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=8 ");
		}
		else if(orgFlag==1){//	局级单位
			if(isInclude!=null && isInclude==1){
				if(Util.isNullOrEmpty(orgCode)){
					throw new IFException("所属单位信息不能为空！");
				}
				sqlParamsMap.put("orgCode", orgCode + "%");

				listSql.append("and vPub.orgCode like :orgCode and vPub.orgParTypeId=4 ");
				countSql.append("and vPub.orgCode like :orgCode and vPub.orgParTypeId=4 ");
			}
			else{
				if(Util.isNullOrEmpty(orgPartyId)){
					throw new IFException("所属单位信息不能为空！");
				}
				sqlParamsMap.put("orgPartyId", orgPartyId);

				listSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=4 ");
				countSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=4 ");
			}
		}
		else if(orgFlag==2){//	处级单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			listSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=4 ");
			countSql.append("and vPub.orgId=:orgPartyId and vPub.orgParTypeId=4 ");
		}
		else if(orgFlag==3){//	项目
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			listSql.append("and vPub.proId=:orgPartyId and vPub.proParTypeId=4 ");
			countSql.append("and vPub.proId=:orgPartyId and vPub.proParTypeId=4 ");
		}
		else{
			throw new IFException("所属单位信息错误！");
		}

		//	拼组设备分类的查询条件
		Integer equPubType = busEquipmentReportBean.getEquPubType();	//	业务类型：1-出租，2-出售，3-求租，4-求购
		if(Util.isNotNullOrEmpty(equPubType)){
			sqlParamsMap.put("equPubType", equPubType);
			listSql.append("and vPub.pubType=:equPubType ");
			countSql.append("and vPub.pubType=:equPubType ");
		}

		//	拼组设备分类的查询条件
		Long equCategoryId = busEquipmentReportBean.getEquCategoryId();	//	设备分类
		if(Util.isNotNullOrEmpty(equCategoryId)){
			sqlParamsMap.put("equCategoryId", equCategoryId);
			listSql.append("and vPub.equCategoryId=:equCategoryId ");
			countSql.append("and vPub.equCategoryId=:equCategoryId ");
		}

		//	拼组设备名称的查询条件
		String equName = busEquipmentReportBean.getEquName();	//	设备名称
		if(Util.isNotNullOrEmpty(equName)){
			sqlParamsMap.put("equName", "%" + equName + "%");
			listSql.append("and vPub.equName like :equName ");
			countSql.append("and vPub.equName like :equName ");
		}

		//	按照设备编号升序
		listSql.append("order by vPub.equNo");

		Page<?> datas = findAllByConditions(listSql.toString(),countSql.toString(),sqlParamsMap,busEquipmentReportBean.getPageRequest());

		//	结果集为空时，直接返回
		if(!datas.hasContent()){
			return datas;
		}

		//	对返回的资源进行处理，根据orgFlag、equipmentSourceNo和busState，来显示来源；根据局级名称、项目名称，来显示单位名称
		List<ViewPubInfo> list = (List<ViewPubInfo>)datas.getContent();
		for(ViewPubInfo equPubInfo : list){
			//	根据局级名称、项目名称，来显示单位名称
			if(Util.isNullOrEmpty(equPubInfo.getProName())){
				equPubInfo.setDisOrgName(equPubInfo.getOrgName());
			}
			else{
				equPubInfo.setDisOrgName(equPubInfo.getProName());
			}
		}

		return datas;
	}

	/**
	 * 设备分类信息查询
	 * @author haopeng
     * @since 2016-08-26
     * @return List<Map<String,Object>>
	 */
	public List<Map<String,Object>> createCategoryIdList() {

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

			path.clear();

			path.add(Util.toStringAndTrim(rec.get("equCategoryId")));

			resultData.put(path, "type", "OPEN_");
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
	 * 资源汇总 - 列表查询
	 * 按大类或小类统计资源汇总数据，大类需要全部显示，小类有数据的才显示
	 * @author haopeng
	 * @since 2016-08-26
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，8-外部单位，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equCategoryId 设备分类id
	 * @param categoryList 设备分类信息
	 * @return List<Map<String,Object>>
	 */
	public List<Map<String,Object>> resourceStatisticsCollect(BusEquipmentReportBean busEquipmentReportBean, List<Map<String,Object>> categoryList) {

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

		if(categoryList!=null && categoryList.size()>0){//	按大类统计，需要展示全部信息
			ownSql.append("group by EquCategoryId order by EquCategoryId");
			innerLeaseSql.append("group by EquCategoryId order by EquCategoryId");
			outerLeaseSql.append("group by EquCategoryId order by EquCategoryId");
			outerAssistSql.append("group by EquCategoryId order by EquCategoryId");
		}
		else{//	按小类统计，展示有数据的信息
			sqlParamsMap.put("equCategoryId", busEquipmentReportBean.getEquCategoryId());

			ownSql.append("and EquCategoryId=:equCategoryId group by EquNameId order by EquNameId");

			innerLeaseSql.append("and EquCategoryId=:equCategoryId group by EquNameId order by EquNameId");

			outerLeaseSql.append("and EquCategoryId=:equCategoryId group by EquNameId order by EquNameId");

			outerAssistSql.append("and EquCategoryId=:equCategoryId group by EquNameId order by EquNameId");
		}

		List<Map<String, Object>> ownList = query(ownSql.toString(), sqlParamsMap);	//	自有查询

		List<Map<String, Object>> innerLeaseList = new ArrayList<Map<String, Object>>();	//	内租查询
		if(orgFlag==1 || orgFlag==2 || orgFlag==3){
			innerLeaseList = query(innerLeaseSql.toString(), sqlParamsMap);
		}

		List<Map<String, Object>> outerLeaseList = query(outerLeaseSql.toString(), sqlParamsMap);	//	外租查询

		List<Map<String, Object>> outerAssistList = new ArrayList<Map<String, Object>>();	//	外协查询
		if(orgFlag!=8){
			outerAssistList = query(outerAssistSql.toString(), sqlParamsMap);
		}

		ReportData reportData = new ReportData();	//	返回资源汇总结果集

		ArrayList<String> path = new ArrayList<String>();

		if(categoryList!=null && categoryList.size()>0){//	按大类统计，需要展示全部信息
			/** 拼组设备分类信息 */
			packageEquTypeInfo(reportData, categoryList, "equCategoryName");

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

			/**  拼组自有信息 */
			if(ownList!=null && ownList.size()>0){
				for(Map<String,Object> rec : ownList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
					reportData.put(path, "totalNum1", totalNum);	//	数量
					totalNum1 = totalNum1.add(totalNum);

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					equipmentCost = Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("equipmentCost"))) : BigDecimal.ZERO;
					reportData.put(path, "equipmentCost1", equipmentCost);	//	原值
					equipmentCost1 = equipmentCost1.add(equipmentCost);

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					totalDepreciation = Util.isNotNullOrEmpty(rec.get("totalDepreciation")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalDepreciation"))) : BigDecimal.ZERO;
					reportData.put(path, "netValue1",  equipmentCost.subtract(totalDepreciation));	//	净值
					netValue1 = netValue1.add(equipmentCost).subtract(totalDepreciation);
				}
			}

			/**  拼组内租信息 */
			if(innerLeaseList!=null && innerLeaseList.size()>0){
				for(Map<String,Object> rec : innerLeaseList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
					reportData.put(path, "totalNum2", totalNum);	//	数量
					totalNum2 = totalNum2.add(totalNum);

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					equipmentCost = Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("equipmentCost"))) : BigDecimal.ZERO;
					reportData.put(path, "equipmentCost2", equipmentCost);	//	原值
					equipmentCost2 = equipmentCost2.add(equipmentCost);
				}
			}

			/**  拼组外租信息 */
			if(outerLeaseList!=null && outerLeaseList.size()>0){
				for(Map<String,Object> rec : outerLeaseList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
					reportData.put(path, "totalNum3", totalNum);	//	数量
					totalNum3 = totalNum3.add(totalNum);

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					equipmentCost = Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("equipmentCost"))) : BigDecimal.ZERO;
					reportData.put(path, "equipmentCost3", equipmentCost);	//	原值
					equipmentCost3 = equipmentCost3.add(equipmentCost);
				}
			}

			/**  拼组外协信息 */
			if(outerAssistList!=null && outerAssistList.size()>0){
				for(Map<String,Object> rec : outerAssistList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
					reportData.put(path, "totalNum4", totalNum);	//	数量
					totalNum4 = totalNum4.add(totalNum);

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id


					equipmentCost = Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("equipmentCost"))) : BigDecimal.ZERO;
					reportData.put(path, "equipmentCost4", equipmentCost);	//	原值
					equipmentCost4 = equipmentCost4.add(equipmentCost);
				}
			}

			/** 添加总合计 */
			path.clear();

			path.add("999999999999");

			reportData.put(path, "equCategoryName", "总合计");

			path.clear();

			path.add("999999999999");

			reportData.put(path, "type", "TAB_");

			path.clear();

			path.add("999999999999");

			reportData.put(path, "totalNum1", totalNum1);	//	总合计 - 自有 - 数量

			path.clear();

			path.add("999999999999");

			reportData.put(path, "equipmentCost1", equipmentCost1);	//	总合计 - 自有 - 原值

			path.clear();

			path.add("999999999999");

			reportData.put(path, "netValue1", netValue1);	//	总合计 - 自有 - 净值

			path.clear();

			path.add("999999999999");

			reportData.put(path, "totalNum2", totalNum2);	//	总合计 - 内租 - 数量

			path.clear();

			path.add("999999999999");

			reportData.put(path, "equipmentCost2", equipmentCost2);	//	总合计 - 内租 - 原值

			path.clear();

			path.add("999999999999");

			reportData.put(path, "totalNum3", totalNum3);	//	总合计 - 外租 - 数量

			path.clear();

			path.add("999999999999");

			reportData.put(path, "equipmentCost3", equipmentCost3);	//	总合计 - 外租 - 原值

			path.clear();

			path.add("999999999999");

			reportData.put(path, "totalNum4", totalNum4);	//	总合计 - 外协 - 数量

			path.clear();

			path.add("999999999999");

			reportData.put(path, "equipmentCost4", equipmentCost4);	//	总合计 - 外协 - 原值
		}
		else{//	按小类统计，展示有数据的信息
			/**  拼组自有信息 */
			if(ownList!=null && ownList.size()>0){
				BigDecimal equipmentCost = BigDecimal.ZERO;
				BigDecimal totalDepreciation = BigDecimal.ZERO;
				for(Map<String,Object> rec : ownList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));

					reportData.put(path, "type", "TAB_");

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "totalNum1", Util.isNotNullOrEmpty(rec.get("totalNum")) ? rec.get("totalNum") : 0);	//	数量

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					equipmentCost = Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("equipmentCost"))) : BigDecimal.ZERO;
					reportData.put(path, "equipmentCost1", equipmentCost);	//	原值

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					totalDepreciation = Util.isNotNullOrEmpty(rec.get("totalDepreciation")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalDepreciation"))) : BigDecimal.ZERO;
					reportData.put(path, "netValue1",  equipmentCost.subtract(totalDepreciation));	//	净值
				}
			}

			/**  拼组内租信息 */
			if(innerLeaseList!=null && innerLeaseList.size()>0){
				for(Map<String,Object> rec : innerLeaseList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));

					reportData.put(path, "type", "TAB_");

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "totalNum2", Util.isNotNullOrEmpty(rec.get("totalNum")) ? rec.get("totalNum") : 0);	//	数量

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equipmentCost2", Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? rec.get("equipmentCost") : 0);	//	原值
				}
			}

			/**  拼组外租信息 */
			if(outerLeaseList!=null && outerLeaseList.size()>0){
				for(Map<String,Object> rec : outerLeaseList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));

					reportData.put(path, "type", "TAB_");

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "totalNum3", Util.isNotNullOrEmpty(rec.get("totalNum")) ? rec.get("totalNum") : 0);	//	数量

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equipmentCost3", Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? rec.get("equipmentCost") : 0);	//	原值
				}
			}

			/**  拼组外协信息 */
			if(outerAssistList!=null && outerAssistList.size()>0){
				for(Map<String,Object> rec : outerAssistList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));

					reportData.put(path, "type", "TAB_");

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "totalNum4", Util.isNotNullOrEmpty(rec.get("totalNum")) ? rec.get("totalNum") : 0);	//	数量

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equipmentCost4", Util.isNotNullOrEmpty(rec.get("equipmentCost")) ? rec.get("equipmentCost") : 0);	//	原值
				}
			}
		}

		return convertReportDataToList(reportData);
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
	 * @param categoryList 设备分类信息
	 * @return List<Map<String,Object>>
	 */
	public List<Map<String,Object>> rentStatisticsCollect(BusEquipmentReportBean busEquipmentReportBean, List<Map<String,Object>> categoryList) {

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

		if(categoryList!=null && categoryList.size()>0){//	按大类统计，需要展示全部信息
			ownSql.append("group by vEqu.EquCategoryId order by vEqu.EquCategoryId");
			rentSql.append("group by vEqu.EquCategoryId, vEqu.BusState order by vEqu.EquCategoryId");
			scrapSql.append("group by vEqu.EquCategoryId order by vEqu.EquCategoryId");
			sellSql.append("group by vEqu.EquCategoryId order by vEqu.EquCategoryId");
		}
		else{//	按小类统计，展示有数据的信息
			sqlParamsMap.put("equCategoryId", busEquipmentReportBean.getEquCategoryId());

			ownSql.append("and vEqu.EquCategoryId=:equCategoryId group by vEqu.EquNameId order by vEqu.EquNameId");
			rentSql.append("and vEqu.EquCategoryId=:equCategoryId group by vEqu.EquNameId, vEqu.BusState order by vEqu.EquNameId");
			scrapSql.append("and vEqu.EquCategoryId=:equCategoryId group by vEqu.EquNameId order by vEqu.EquNameId");
			sellSql.append("and vEqu.EquCategoryId=:equCategoryId group by vEqu.EquNameId order by vEqu.EquNameId");
		}

		List<Map<String, Object>> ownList = query(ownSql.toString(), sqlParamsMap);	//	自有查询
		List<Map<String, Object>> rentList = query(rentSql.toString(), sqlParamsMap);	//	局内租、外局租、外租查询
		List<Map<String, Object>> scrapList = query(scrapSql.toString(), sqlParamsMap);	//	报废查询
		List<Map<String, Object>> sellList = query(sellSql.toString(), sqlParamsMap);	//	出售查询

		ReportData reportData = new ReportData();	//	返回资源汇总结果集

		ArrayList<String> path = new ArrayList<String>();

		BigDecimal conversion = new BigDecimal("10000");
		Integer busState = null;
		BigDecimal deductCost = BigDecimal.ZERO;
		BigDecimal cost = BigDecimal.ZERO;
		BigDecimal amount = BigDecimal.ZERO;

		if(categoryList!=null && categoryList.size()>0){//	按大类统计，需要展示全部信息
			/** 拼组设备分类信息 */
			packageEquTypeInfo(reportData, categoryList, "equCategoryName");

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
			if(ownList!=null && ownList.size()>0){
				for(Map<String,Object> rec : ownList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					num = Util.isNotNullOrEmpty(rec.get("ownNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("ownNum"))) : BigDecimal.ZERO;
					reportData.put(path, "ownNum", num);	//	数量
					ownNum = ownNum.add(num);

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					amt = Util.isNotNullOrEmpty(rec.get("depreciation")) ? new BigDecimal(Util.toStringAndTrim(rec.get("depreciation"))) : BigDecimal.ZERO;
					reportData.put(path, "depreciation", amt);	//	本期折旧（万元）
					depreciation = depreciation.add(amt);
				}
			}

			/**  拼组局内租、外局租、外租信息 */
			if(rentList!=null && rentList.size()>0){
				for(Map<String,Object> rec : rentList){
					busState = Integer.parseInt(Util.toStringAndTrim(rec.get("busState")));	//	业务类型

					switch(busState){
						case 3://	局内租
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							num = Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO;
							reportData.put(path, "rentNum1", num);	//	数量
							rentNum1 = rentNum1.add(num);

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
							cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
							amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

							amt = BigDecimal.ZERO;
							amt = deductCost.add(cost).subtract(amount).divide(conversion);

							reportData.put(path, "rentAmt1", amt);	//	租金（万元）
							rentAmt1 = rentAmt1.add(amt);
							break;
						case 4://	外局租
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							num = Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO;
							reportData.put(path, "rentNum2", num);	//	数量
							rentNum2 = rentNum2.add(num);

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
							cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
							amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

							amt = BigDecimal.ZERO;
							amt = deductCost.add(cost).subtract(amount).divide(conversion);

							reportData.put(path, "rentAmt2", amt);	//	租金（万元）
							rentAmt2 = rentAmt2.add(amt);
							break;
						case 5://	外租
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							num = Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO;
							reportData.put(path, "rentNum3", num);	//	数量
							rentNum3 = rentNum3.add(num);

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
							cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
							amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

							amt = BigDecimal.ZERO;
							amt = deductCost.add(cost).subtract(amount).divide(conversion);

							reportData.put(path, "rentAmt3", amt);	//	租金（万元）
							rentAmt3 = rentAmt3.add(amt);
							break;
						default:
							break;
					}
				}
			}

			/**  拼组报废信息 */
			if(scrapList!=null && scrapList.size()>0){
				for(Map<String,Object> rec : scrapList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					num = Util.isNotNullOrEmpty(rec.get("scrapNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("scrapNum"))) : BigDecimal.ZERO;
					reportData.put(path, "scrapNum", num);	//	数量
					scrapNum = scrapNum.add(num);

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					amt = Util.isNotNullOrEmpty(rec.get("scrapPrice")) ? new BigDecimal(Util.toStringAndTrim(rec.get("scrapPrice"))) : BigDecimal.ZERO;
					reportData.put(path, "scrapPrice", amt);	//	残值（万元）
					scrapPrice = scrapPrice.add(amt);
				}
			}

			/**  拼组出售信息 */
			if(sellList!=null && sellList.size()>0){
				for(Map<String,Object> rec : sellList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					num = Util.isNotNullOrEmpty(rec.get("sellNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("sellNum"))) : BigDecimal.ZERO;
					reportData.put(path, "sellNum", num);	//	数量
					sellNum = sellNum.add(num);

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

					amt = Util.isNotNullOrEmpty(rec.get("sellPrice")) ? new BigDecimal(Util.toStringAndTrim(rec.get("sellPrice"))) : BigDecimal.ZERO;
					reportData.put(path, "sellPrice", amt);	//	残值（万元）
					sellPrice = sellPrice.add(amt);
				}
			}

			/** 添加总合计 */
			path.clear();

			path.add("999999999999");

			reportData.put(path, "equCategoryName", "总合计");

			path.clear();

			path.add("999999999999");

			reportData.put(path, "type", "TAB_");

			path.clear();

			path.add("999999999999");

			reportData.put(path, "ownNum", ownNum);	//	总合计 - 自有 - 数量

			path.clear();

			path.add("999999999999");

			reportData.put(path, "depreciation", depreciation);	//	总合计 - 自有 - 本期折旧（万元）

			path.clear();

			path.add("999999999999");

			reportData.put(path, "rentNum1", rentNum1);	//	总合计 - 局内租 - 数量

			path.clear();

			path.add("999999999999");

			reportData.put(path, "rentAmt1", rentAmt1);	//	总合计 - 局内租 - 租金（万元）

			path.clear();

			path.add("999999999999");

			reportData.put(path, "rentNum2", rentNum2);	//	总合计 - 外局租 - 数量

			path.clear();

			path.add("999999999999");

			reportData.put(path, "rentAmt2", rentAmt2);	//	总合计 - 外局租 - 租金（万元）

			path.clear();

			path.add("999999999999");

			reportData.put(path, "rentNum3", rentNum3);	//	总合计 - 外租 - 数量

			path.clear();

			path.add("999999999999");

			reportData.put(path, "rentAmt3", rentAmt3);	//	总合计 - 外租 - 租金（万元）

			path.clear();

			path.add("999999999999");

			reportData.put(path, "scrapNum", scrapNum);	//	总合计 - 报废 - 数量

			path.clear();

			path.add("999999999999");

			reportData.put(path, "scrapPrice", scrapPrice);	//	总合计 - 报废 - 残值（万元）

			path.clear();

			path.add("999999999999");

			reportData.put(path, "sellNum", sellNum);	//	总合计 - 出售 - 数量

			path.clear();

			path.add("999999999999");

			reportData.put(path, "sellPrice", sellPrice);	//	总合计 - 出售 - 售价（万元）
		}
		else{//	按小类统计，展示有数据的信息
			/**  拼组自有信息 */
			if(ownList!=null && ownList.size()>0){
				for(Map<String,Object> rec : ownList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));

					reportData.put(path, "type", "TAB_");

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

					reportData.put(path, "ownNum", Util.isNotNullOrEmpty(rec.get("ownNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("ownNum"))) : BigDecimal.ZERO);	//	数量

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

					reportData.put(path, "depreciation", Util.isNotNullOrEmpty(rec.get("depreciation")) ? new BigDecimal(Util.toStringAndTrim(rec.get("depreciation"))) : BigDecimal.ZERO);	//	本期折旧（万元）
				}
			}

			/**  拼组局内租、外局租、外租信息 */
			if(rentList!=null && rentList.size()>0){
				for(Map<String,Object> rec : rentList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));

					reportData.put(path, "type", "TAB_");

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

					busState = Integer.parseInt(Util.toStringAndTrim(rec.get("busState")));	//	业务类型

					switch(busState){
						case 3://	局内租
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							reportData.put(path, "rentNum1", Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO);	//	数量

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
							cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
							amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

							reportData.put(path, "rentAmt1", deductCost.add(cost).subtract(amount).divide(conversion));	//	租金（万元）
							break;
						case 4://	外局租
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							reportData.put(path, "rentNum2", Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO);	//	数量

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
							cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
							amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

							reportData.put(path, "rentAmt2", deductCost.add(cost).subtract(amount).divide(conversion));	//	租金（万元）
							break;
						case 5://	外租
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							reportData.put(path, "rentNum3", Util.isNotNullOrEmpty(rec.get("rentNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("rentNum"))) : BigDecimal.ZERO);	//	数量

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							deductCost = Util.isNotNullOrEmpty(rec.get("deductCost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("deductCost"))) : BigDecimal.ZERO;
							cost = Util.isNotNullOrEmpty(rec.get("cost")) ? new BigDecimal(Util.toStringAndTrim(rec.get("cost"))) : BigDecimal.ZERO;
							amount = Util.isNotNullOrEmpty(rec.get("amount")) ? new BigDecimal(Util.toStringAndTrim(rec.get("amount"))) : BigDecimal.ZERO;

							reportData.put(path, "rentAmt3", deductCost.add(cost).subtract(amount).divide(conversion));	//	租金（万元）
							break;
						default:
							break;
					}
				}
			}

			/**  拼组报废信息 */
			if(scrapList!=null && scrapList.size()>0){
				for(Map<String,Object> rec : scrapList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));

					reportData.put(path, "type", "TAB_");

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

					reportData.put(path, "scrapNum", Util.isNotNullOrEmpty(rec.get("scrapNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("scrapNum"))) : BigDecimal.ZERO);	//	数量

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

					reportData.put(path, "scrapPrice", Util.isNotNullOrEmpty(rec.get("scrapPrice")) ? new BigDecimal(Util.toStringAndTrim(rec.get("scrapPrice"))) : BigDecimal.ZERO);	//	残值（万元）
				}
			}

			/**  拼组外协信息 */
			if(sellList!=null && sellList.size()>0){
				for(Map<String,Object> rec : sellList){
					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));

					reportData.put(path, "type", "TAB_");

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "second", Util.toStringAndTrim(rec.get("second")));	//	计量单位

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

					reportData.put(path, "sellNum", Util.isNotNullOrEmpty(rec.get("sellNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("sellNum"))) : BigDecimal.ZERO);	//	数量

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

					reportData.put(path, "sellPrice", Util.isNotNullOrEmpty(rec.get("sellPrice")) ? new BigDecimal(Util.toStringAndTrim(rec.get("sellPrice"))) : BigDecimal.ZERO);	//	残值（万元）
				}
			}
		}

		return convertReportDataToList(reportData);
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
	 * @param categoryList 设备分类信息
	 * @return List<Map<String,Object>>
	 */
	public List<Map<String,Object>> infoPublishCollection(BusEquipmentReportBean busEquipmentReportBean, List<Map<String,Object>> categoryList) {

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

		if(categoryList!=null && categoryList.size()>0){//	按大类统计，需要展示全部信息
			totalListSql.append("group by EquCategoryId, PubType order by EquCategoryId, PubType ");
			stateListSql.append("group by EquCategoryId, PubType, State order by EquCategoryId, PubType, State ");
		}
		else{//	按小类统计，展示有数据的信息
			sqlParamsMap.put("equCategoryId", busEquipmentReportBean.getEquCategoryId());

			totalListSql.append("and EquCategoryId=:equCategoryId group by EquNameId, PubType order by EquNameId, PubType ");
			stateListSql.append("and EquCategoryId=:equCategoryId group by EquNameId, PubType, State order by EquNameId, PubType, State ");
		}

		List<Map<String, Object>> totalList = query(totalListSql.toString(), sqlParamsMap);	//	拼组按业务类型归类，总发布笔数、预估总金额的查询语句
		List<Map<String, Object>> stateList = query(stateListSql.toString(), sqlParamsMap);	//	拼组按业务类型、成交状态归类，总作废笔数、总成交笔数、总待成交笔数的查询语句

		ReportData reportData = new ReportData();	//	返回资源汇总结果集

		ArrayList<String> path = new ArrayList<String>();

		if(categoryList!=null && categoryList.size()>0){//	按大类统计，需要展示全部信息
			/** 拼组设备分类信息 */
			packageEquTypeInfo(reportData, categoryList, "equCategoryName");

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
//			BigDecimal cancelNum3 = BigDecimal.ZERO;	//	求租信息 - 作废数
//			BigDecimal turnoveredNum3 = BigDecimal.ZERO;	//	求租信息 - 成交数
//			BigDecimal forecastSum3 = BigDecimal.ZERO;	//	求租信息 - 预估金额
//			BigDecimal turnoveringNum3 = BigDecimal.ZERO;	//	求租信息 - 待成交数

			BigDecimal totalNum4 = BigDecimal.ZERO;	//	求购信息 - 发布数
//			BigDecimal cancelNum4 = BigDecimal.ZERO;	//	求购信息 - 作废数
//			BigDecimal turnoveredNum4 = BigDecimal.ZERO;	//	求购信息 - 成交数
//			BigDecimal forecastSum4 = BigDecimal.ZERO;	//	求购信息 - 预估金额
//			BigDecimal turnoveringNum4 = BigDecimal.ZERO;	//	求购信息 - 待成交数

			BigDecimal totalNum = BigDecimal.ZERO;
			BigDecimal forecastSum = BigDecimal.ZERO;
			Integer pubType = null;
			Integer state = null;

			/**  拼组发布数、预估金额 */
			if(totalList!=null && totalList.size()>0){
				for(Map<String,Object> rec : totalList){
					pubType = Integer.parseInt(Util.toStringAndTrim(rec.get("pubType")));	//	业务类型：1-出租，2-出售，3-求租，4-求购

					totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
					forecastSum = Util.isNotNullOrEmpty(rec.get("forecastSum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("forecastSum"))) : BigDecimal.ZERO;
					switch(pubType){
						case 1://	出租信息
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							reportData.put(path, "totalNum1", totalNum);	//	发布数
							totalNum1 = totalNum1.add(totalNum);

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							reportData.put(path, "forecastSum1", forecastSum);	//	预估金额
							forecastSum1 = forecastSum1.add(forecastSum);
							break;
						case 2://	出售信息
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							reportData.put(path, "totalNum2", totalNum);	//	发布数
							totalNum2 = totalNum2.add(totalNum);

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							reportData.put(path, "forecastSum2", forecastSum);	//	预估金额
							forecastSum2 = forecastSum2.add(forecastSum);
							break;
						case 3://	求租信息
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							reportData.put(path, "totalNum3", totalNum);	//	发布数
							totalNum3 = totalNum3.add(totalNum);

//							path.clear();
//
//							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//							reportData.put(path, "forecastSum3", forecastSum);	//	预估金额
//							forecastSum3 = forecastSum3.add(forecastSum);
							break;
						case 4://	求购信息
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

							reportData.put(path, "totalNum4", totalNum);	//	发布数
							totalNum4 = totalNum4.add(totalNum);

//							path.clear();
//
//							path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//							reportData.put(path, "forecastSum4", forecastSum);	//	预估金额
//							forecastSum4 = forecastSum4.add(forecastSum);
							break;
						default:
							break;
					}
				}
			}

			/**  拼组作废数、成交数、待成交数 */
			if(stateList!=null && stateList.size()>0){
				for(Map<String,Object> rec : stateList){
					pubType = Integer.parseInt(Util.toStringAndTrim(rec.get("pubType")));	//	业务类型：1-出租，2-出售，3-求租，4-求购
					state = Util.isNotNullOrEmpty(rec.get("state")) ? Integer.parseInt(Util.toStringAndTrim(rec.get("state"))) : 99;	//	成交状态：1-已成交，2-未成交，3-作废

					totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
					switch(pubType){
						case 1://	出租信息
							switch(state){
								case 3:
									path.clear();

									path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

									reportData.put(path, "cancelNum1", totalNum);	//	作废数
									cancelNum1 = cancelNum1.add(totalNum);
									break;
								case 1:
									path.clear();

									path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

									reportData.put(path, "turnoveredNum1", totalNum);	//	成交数
									turnoveredNum1 = turnoveredNum1.add(totalNum);
									break;
								case 2:
									path.clear();

									path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

									reportData.put(path, "turnoveringNum1", totalNum);	//	待成交数
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

									reportData.put(path, "cancelNum2", totalNum);	//	作废数
									cancelNum2 = cancelNum2.add(totalNum);
									break;
								case 1:
									path.clear();

									path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

									reportData.put(path, "turnoveredNum2", totalNum);	//	成交数
									turnoveredNum2 = turnoveredNum2.add(totalNum);
									break;
								case 2:
									path.clear();

									path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id

									reportData.put(path, "turnoveringNum2", totalNum);	//	待成交数
									turnoveringNum2 = turnoveringNum2.add(totalNum);
									break;
								default:
									break;
							}
							break;
//						case 3://	求租信息
//							switch(state){
//								case 3:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//									reportData.put(path, "cancelNum3", totalNum);	//	作废数
//									cancelNum3 = cancelNum3.add(totalNum);
//									break;
//								case 1:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//									reportData.put(path, "turnoveredNum3", totalNum);	//	成交数
//									turnoveredNum3 = turnoveredNum3.add(totalNum);
//									break;
//								case 2:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//									reportData.put(path, "turnoveringNum3", totalNum);	//	待成交数
//									turnoveringNum3 = turnoveringNum3.add(totalNum);
//									break;
//								default:
//									break;
//							}
//							break;
//						case 4://	求购信息
//							switch(state){
//								case 3:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//									reportData.put(path, "cancelNum4", totalNum);	//	作废数
//									cancelNum4 = cancelNum4.add(totalNum);
//									break;
//								case 1:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//									reportData.put(path, "turnoveredNum4", totalNum);	//	成交数
//									turnoveredNum4 = turnoveredNum4.add(totalNum);
//									break;
//								case 2:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equCategoryId")));	//	设备分类id
//
//									reportData.put(path, "turnoveringNum4", totalNum);	//	待成交数
//									turnoveringNum4 = turnoveringNum4.add(totalNum);
//									break;
//								default:
//									break;
//							}
//							break;
						default:
							break;
					}
				}
			}

			/** 添加总合计 */
			path.clear();

			path.add("999999999999");

			reportData.put(path, "equCategoryName", "总合计");

			path.clear();

			path.add("999999999999");

			reportData.put(path, "type", "TAB_");

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "totalNum1", totalNum1);	//	总合计 - 出租信息 - 发布数

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "totalNum2", totalNum2);	//	总合计 - 出售信息 - 发布数

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "totalNum3", totalNum3);	//	总合计 - 求租信息 - 发布数

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "totalNum4", totalNum4);	//	总合计 - 求购信息 - 发布数

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "cancelNum1", cancelNum1);	//	总合计 - 出租信息 - 作废数

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "cancelNum2", cancelNum2);	//	总合计 - 出售信息 - 作废数

//			path.clear();
//
//			path.add("999999999999");	//	设备分类id
//
//			reportData.put(path, "cancelNum3", cancelNum3);	//	总合计 - 求租信息 - 作废数
//
//			path.clear();
//
//			path.add("999999999999");	//	设备分类id
//
//			reportData.put(path, "cancelNum4", cancelNum4);	//	总合计 - 求购信息 - 作废数

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "turnoveredNum1", turnoveredNum1);	//	总合计 - 出租信息 - 成交数

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "turnoveredNum2", turnoveredNum2);	//	总合计 - 出售信息 - 成交数

//			path.clear();
//
//			path.add("999999999999");	//	设备分类id
//
//			reportData.put(path, "turnoveredNum3", turnoveredNum3);	//	总合计 - 求租信息 - 成交数
//
//			path.clear();
//
//			path.add("999999999999");	//	设备分类id
//
//			reportData.put(path, "turnoveredNum4", turnoveredNum4);	//	总合计 - 求购信息 - 成交数

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "forecastSum1", forecastSum1);	//	总合计 - 出租信息 - 预估金额

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "forecastSum2", forecastSum2);	//	总合计 - 出售信息 - 预估金额

//			path.clear();
//
//			path.add("999999999999");	//	设备分类id
//
//			reportData.put(path, "forecastSum3", forecastSum3);	//	总合计 - 求租信息 - 预估金额
//
//			path.clear();
//
//			path.add("999999999999");	//	设备分类id
//
//			reportData.put(path, "forecastSum4", forecastSum4);	//	总合计 - 求购信息 - 预估金额

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "turnoveringNum1", turnoveringNum1);	//	总合计 - 出租信息 - 待成交数

			path.clear();

			path.add("999999999999");	//	设备分类id

			reportData.put(path, "turnoveringNum2", turnoveringNum2);	//	总合计 - 出售信息 - 待成交数

//			path.clear();
//
//			path.add("999999999999");	//	设备分类id
//
//			reportData.put(path, "turnoveringNum3", turnoveringNum3);	//	总合计 - 求租信息 - 待成交数
//
//			path.clear();
//
//			path.add("999999999999");	//	设备分类id
//
//			reportData.put(path, "turnoveringNum4", turnoveringNum4);	//	总合计 - 求购信息 - 待成交数
		}
		else{//	按小类统计，展示有数据的信息
			BigDecimal totalNum = BigDecimal.ZERO;
			BigDecimal forecastSum = BigDecimal.ZERO;
			Integer pubType = null;
			Integer state = null;

			/**  拼组发布数、预估金额 */
			if(totalList!=null && totalList.size()>0){
				for(Map<String,Object> rec : totalList){
					pubType = Integer.parseInt(Util.toStringAndTrim(rec.get("pubType")));	//	业务类型：1-出租，2-出售，3-求租，4-求购

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

					reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

					path.clear();

					path.add(Util.toStringAndTrim(rec.get("equNameId")));

					reportData.put(path, "type", "TAB_");

					totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
					forecastSum = Util.isNotNullOrEmpty(rec.get("forecastSum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("forecastSum"))) : BigDecimal.ZERO;
					switch(pubType){
						case 1://	出租信息
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							reportData.put(path, "totalNum1", totalNum);	//	发布数

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							reportData.put(path, "forecastSum1", forecastSum);	//	预估金额
							break;
						case 2://	出售信息
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							reportData.put(path, "totalNum2", totalNum);	//	发布数

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							reportData.put(path, "forecastSum2", forecastSum);	//	预估金额
							break;
						case 3://	求租信息
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							reportData.put(path, "totalNum3", totalNum);	//	发布数

//							path.clear();
//
//							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//							reportData.put(path, "forecastSum3", forecastSum);	//	预估金额
							break;
						case 4://	求购信息
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

							reportData.put(path, "totalNum4", totalNum);	//	发布数

//							path.clear();
//
//							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//							reportData.put(path, "forecastSum4", forecastSum);	//	预估金额
							break;
						default:
							break;
					}
				}
			}

			/**  拼组作废数、成交数、待成交数 */
			if(stateList!=null && stateList.size()>0){
				for(Map<String,Object> rec : stateList){
					pubType = Integer.parseInt(Util.toStringAndTrim(rec.get("pubType")));	//	业务类型：1-出租，2-出售，3-求租，4-求购
					state = Util.isNotNullOrEmpty(rec.get("state")) ? Integer.parseInt(Util.toStringAndTrim(rec.get("state"))) : 99;	//	成交状态：1-已成交，2-未成交，3-作废

					totalNum = Util.isNotNullOrEmpty(rec.get("totalNum")) ? new BigDecimal(Util.toStringAndTrim(rec.get("totalNum"))) : BigDecimal.ZERO;
					switch(pubType){
						case 1://	出租信息
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

							reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));

							reportData.put(path, "type", "TAB_");

							switch(state){
								case 3:
									path.clear();

									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

									reportData.put(path, "cancelNum1", totalNum);	//	作废数
									break;
								case 1:
									path.clear();

									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

									reportData.put(path, "turnoveredNum1", totalNum);	//	成交数
									break;
								case 2:
									path.clear();

									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

									reportData.put(path, "turnoveringNum1", totalNum);	//	待成交数
									break;
								default:
									break;
							}
							break;
						case 2://	出售信息
							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id

							reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));

							path.clear();

							path.add(Util.toStringAndTrim(rec.get("equNameId")));

							reportData.put(path, "type", "TAB_");

							switch(state){
								case 3:
									path.clear();

									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

									reportData.put(path, "cancelNum2", totalNum);	//	作废数
									break;
								case 1:
									path.clear();

									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

									reportData.put(path, "turnoveredNum2", totalNum);	//	成交数
									break;
								case 2:
									path.clear();

									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id

									reportData.put(path, "turnoveringNum2", totalNum);	//	待成交数
									break;
								default:
									break;
							}
							break;
//						case 3://	求租信息
//							path.clear();
//
//							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id
//
//							reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));
//
//							path.clear();
//
//							path.add(Util.toStringAndTrim(rec.get("equNameId")));
//
//							reportData.put(path, "type", "TAB_");
//
//							switch(state){
//								case 3:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//									reportData.put(path, "cancelNum3", totalNum);	//	作废数
//									break;
//								case 1:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//									reportData.put(path, "turnoveredNum3", totalNum);	//	成交数
//									break;
//								case 2:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//									reportData.put(path, "turnoveringNum3", totalNum);	//	待成交数
//									break;
//								default:
//									break;
//							}
//							break;
//						case 4://	求购信息
//							path.clear();
//
//							path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备名称id
//
//							reportData.put(path, "equCategoryName", Util.toStringAndTrim(rec.get("equName")));
//
//							path.clear();
//
//							path.add(Util.toStringAndTrim(rec.get("equNameId")));
//
//							reportData.put(path, "type", "TAB_");
//
//							switch(state){
//								case 3:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//									reportData.put(path, "cancelNum4", totalNum);	//	作废数
//									break;
//								case 1:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//									reportData.put(path, "turnoveredNum4", totalNum);	//	成交数
//									break;
//								case 2:
//									path.clear();
//
//									path.add(Util.toStringAndTrim(rec.get("equNameId")));	//	设备分类id
//
//									reportData.put(path, "turnoveringNum4", totalNum);	//	待成交数
//									break;
//								default:
//									break;
//							}
//							break;
						default:
							break;
					}
				}
			}
		}

		return convertReportDataToList(reportData);
	}

}
