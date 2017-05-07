package com.hjd.action;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.EquipmentBean;
import com.hjd.action.bean.EquipmentSearchBean;
import com.hjd.action.bean.IssueSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IBizExDataDao;
import com.hjd.dao.IBusOwnHistDao;
import com.hjd.dao.IBusRentHistDao;
import com.hjd.dao.IBusUseInfoDao;
import com.hjd.dao.IEquipmentCategoryDao;
import com.hjd.dao.IEquipmentAscriptionDao;
import com.hjd.dao.IEquipmentDao;
import com.hjd.dao.IPartyOrgDao;
import com.hjd.dao.IPartyRelationDao;
import com.hjd.dao.IRentDao;
import com.hjd.dao.ISaleDao;
import com.hjd.domain.BizExData;
import com.hjd.domain.BusOwnHistTable;
import com.hjd.domain.BusRentHistTable;
import com.hjd.domain.BusUseInfoTable;
import com.hjd.domain.CategoryTable;
import com.hjd.domain.EquipmentAscriptionTable;
import com.hjd.domain.EquipmentCategoryTable;
import com.hjd.domain.EquipmentTable;
import com.hjd.domain.Party;
import com.hjd.domain.PartyOrg;
import com.hjd.domain.RentTable;
import com.hjd.domain.SaleTable;
import com.hjd.domain.ViewEquInfo;
import com.hjd.util.Util;

@RestController
public class BusEquipmentAction extends BaseAction {

	/**
	 * 备注
	 * “设备资源（台账）信息表” 与 “设备分类信息表” ，数据库再设计的时候是多对多的关系 所以设计了一个中间表 “设备分类表”
	 * 但是在EquipmentAction这个类在使用的时候 暂时写成 1 对 多的关系 ，并记录到 中间表 “设备分类表” 中
	 */

	@Autowired
	IEquipmentDao iEquipmentDao;//设备资源管理（台账）Dao

	@Autowired
	IEquipmentAscriptionDao iEquipmentAscriptionDao;//资产归属Dao

	@Autowired
	IEquipmentCategoryDao iEquipmentCategoryDao;//设备分类Dao

	@Autowired
	ISaleDao iSaleDao;

	@Autowired
	IRentDao iRentDao;

	@Autowired
	IBusUseInfoDao iBusUseInfoDao;

	@Autowired
	IPartyRelationDao partyRelationDao;

	@Autowired
	IBusRentHistDao iBusRentHistDao;

	@Autowired
	IBusOwnHistDao iBusOwnHistDao;

	@Autowired
	IPartyOrgDao iPartyOrgDao;
	
	@Autowired
	IBizExDataDao iBizExDataDao;
	/**
	 * 资源管理（中铁用户）
	 * 列表查询 - 根据查询条件，查询未删除的资源的拥有情况和使用情况（包含内部租用和外部租用）
	 * @author haopeng
	 * @since 2016-08-08
	 * @param orgFlag 所属单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
	 * @param orgPartyId 所属单位/项目id
	 * @param isInclude 是否包含下级单位：1-包含
	 * @param equAtOrgFlag 使用单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
	 * @param equAtOrgPartyId 使用单位/项目id
	 * @param equAtOrgName 使用单位名称
	 * @param isCrecOrg 使用单位是否是中铁用户：1-非中铁用户
	 * @param equState 设备状态（''-全部（不包含已出售和已报废）、1-闲置、2-使用中）
	 * @param isSaled 包含已出售：1-包含
	 * @param isScraped 包含已报废：1-包含
	 * @param equName 设备名称（模糊查询）
	 * @return Page<?>
	 */
	@RequestMapping(value="/BG/Equipment", method=RequestMethod.POST, params={"Action=AllUseOwn"})
	public Page<?> queryAll(@RequestBody EquipmentSearchBean equipmentSearchBean) {

		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select vEqu ");
		listSql.append("from ViewEquInfo vEqu ");	//	设备拥有者和设备使用者的设备信息
		listSql.append("where vEqu.delFlag!=1 ");

		//	拼写的总数查询语句
		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(1) ");
		countSql.append("from ViewEquInfo vEqu ");	//	设备拥有者和设备使用者的设备信息
		countSql.append("where vEqu.delFlag!=1 ");

		//	拼组所属单位/项目的查询条件
		int orgFlag = equipmentSearchBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
		Long orgPartyId = equipmentSearchBean.getOrgPartyId();	//	所属单位/项目id
		Integer isInclude = equipmentSearchBean.getIsInclude();	//	是否包含下级单位：1-包含
		if(Util.isNullOrEmpty(orgFlag)){
			throw new IFException("所属单位信息不能为空！");
		}

		//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
		if(orgFlag==9){//	总公司
			listSql.append("and (vEqu.bureauOrgParTypeId=4 or vEqu.equAtOrgParTypeId=4) ");
			countSql.append("and (vEqu.bureauOrgParTypeId=4 or vEqu.equAtOrgParTypeId=4) ");
		}
		else if(orgFlag==1){//	局级单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);

			if(isInclude!=null && isInclude==1){
				listSql.append("and (vEqu.bureauOrgPartyId=:orgPartyId or vEqu.equAtOrgId=:orgPartyId) ");
				countSql.append("and (vEqu.bureauOrgPartyId=:orgPartyId or vEqu.equAtOrgId=:orgPartyId) ");
			}
			else{
				listSql.append("and ((vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null) or (vEqu.equAtOrgId=:orgPartyId and vEqu.equAtSubOrgId is null)) ");
				countSql.append("and ((vEqu.bureauOrgPartyId=:orgPartyId and vEqu.sonOrgPartyId is null) or (vEqu.equAtOrgId=:orgPartyId and vEqu.equAtSubOrgId is null)) ");
			}
		}
		else if(orgFlag==2){//	处级单位
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);
			listSql.append("and (vEqu.sonOrgPartyId=:orgPartyId or vEqu.equAtSubOrgId=:orgPartyId) ");
			countSql.append("and (vEqu.sonOrgPartyId=:orgPartyId or vEqu.equAtSubOrgId=:orgPartyId) ");
		}
		else if(orgFlag==3){//	项目
			if(Util.isNullOrEmpty(orgPartyId)){
				throw new IFException("所属单位信息不能为空！");
			}
			sqlParamsMap.put("orgPartyId", orgPartyId);
			listSql.append("and (vEqu.proOrgPartyId=:orgPartyId or vEqu.equAtProjectId=:orgPartyId) ");
			countSql.append("and (vEqu.proOrgPartyId=:orgPartyId or vEqu.equAtProjectId=:orgPartyId) ");
		}
		else{
			throw new IFException("所属单位信息错误！");
		}

		//	拼组使用单位/项目的查询条件
		Integer equAtOrgFlag = equipmentSearchBean.getEquAtOrgFlag();	//	使用单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
		Long equAtOrgPartyId = equipmentSearchBean.getEquAtOrgPartyId();	//	使用单位/项目id
		String equAtOrgName = equipmentSearchBean.getEquAtOrgName();	//	使用单位名称
		Integer isCrecOrg = equipmentSearchBean.getIsCrecOrg();	//	使用单位是否是中铁用户：1-非中铁用户
		//	根据使用单位名称判断是否输入了使用单位信息
		if(Util.isNotNullOrEmpty(equAtOrgName)){
			if(isCrecOrg!=null && isCrecOrg==1){//	非中铁用户
				sqlParamsMap.put("equAtOrgName", "%" + equAtOrgName + "%");
				listSql.append("and (vEqu.equAtOrgParTypeId=8 or vEqu.equAtOrgParTypeId is null) and vEqu.equAtOrgName like :equAtOrgName ");
				countSql.append("and (vEqu.equAtOrgParTypeId=8 or vEqu.equAtOrgParTypeId is null) and vEqu.equAtOrgName like :equAtOrgName ");
			}
			else{//	中铁用户
				if(Util.isNullOrEmpty(equAtOrgFlag)){
					throw new IFException("使用单位信息错误！");
				}
				if(equAtOrgFlag==9){//	总公司
					listSql.append("and vEqu.equAtOrgParTypeId=4 ");
					countSql.append("and vEqu.equAtOrgParTypeId=4 ");
				}
				else if(equAtOrgFlag==1){//	局级单位
					if(Util.isNullOrEmpty(equAtOrgPartyId)){
						throw new IFException("使用单位信息错误！");
					}
					sqlParamsMap.put("equAtOrgPartyId", equAtOrgPartyId);
					listSql.append("and vEqu.equAtOrgId=:equAtOrgPartyId ");
					countSql.append("and vEqu.equAtOrgId=:equAtOrgPartyId ");
				}
				else if(equAtOrgFlag==2){//	处级单位
					if(Util.isNullOrEmpty(equAtOrgPartyId)){
						throw new IFException("使用单位信息错误！");
					}
					sqlParamsMap.put("equAtOrgPartyId", equAtOrgPartyId);
					listSql.append("and vEqu.equAtSubOrgId=:equAtOrgPartyId ");
					countSql.append("and vEqu.equAtSubOrgId=:equAtOrgPartyId ");
				}
				else if(equAtOrgFlag==3){//	项目
					if(Util.isNullOrEmpty(equAtOrgPartyId)){
						throw new IFException("使用单位信息错误！");
					}
					sqlParamsMap.put("equAtOrgPartyId", equAtOrgPartyId);
					listSql.append("and vEqu.equAtProjectId=:equAtOrgPartyId ");
					countSql.append("and vEqu.equAtProjectId=:equAtOrgPartyId ");
				}
				else{
					throw new IFException("使用单位信息错误！");
				}
			}
		}

		//	拼组设备状态的查询条件
		StringBuffer state_StrBuff = new StringBuffer();
		Integer equState = equipmentSearchBean.getEquState();
		if(Util.isNullOrEmpty(equState)){
			state_StrBuff.append("1,2");
			}
		else if(equState==1){
			state_StrBuff.append("1");
		}
		else if(equState==2){
			state_StrBuff.append("2");
		}
		else{
			throw new IFException("设备状态错误！");
		}

		Integer isSaled = equipmentSearchBean.getIsSaled();
		if(isSaled!=null && isSaled==1){
			state_StrBuff.append(",3");
		}

		Integer isScraped = equipmentSearchBean.getIsScraped();
		if(isScraped!=null && isScraped==1){
			state_StrBuff.append(",4");
		}

		String state = state_StrBuff.toString();
		listSql.append("and (vEqu.equState in (").append(state).append(") or vEqu.equState is null) ");
		countSql.append("and (vEqu.equState in (").append(state).append(") or vEqu.equState is null) ");

		//	拼组设备名称的查询条件
		String equName = equipmentSearchBean.getEquName();	//	设备名称
		if(Util.isNotNullOrEmpty(equName)){
			sqlParamsMap.put("equName", "%" + equName + "%");
			listSql.append("and vEqu.equName like :equName ");
			countSql.append("and vEqu.equName like :equName ");
		}

		//	按照设备编号升序
		listSql.append("order by vEqu.equNo");

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,equipmentSearchBean.getPageRequest());

		//	结果集为空时，直接返回
		if(!datas.hasContent()){
			return datas;
		}

		//	对返回的资源进行处理，区分出拥有单位的资源和使用单位的资源
		List<ViewEquInfo> list = (List<ViewEquInfo>)datas.getContent();
		for(ViewEquInfo equInfo : list){
			//	根据选择的orgFlag（所属单位/项目标志），判断记录是拥有单位还是使用单位
			if(orgFlag==9){//	总公司
				if(4==equInfo.getBureauOrgParTypeId()){//	拥有者
					equInfo.setEquFlag(1);
				}
				else{//	使用者
					equInfo.setEquFlag(0);
				}
			}
			else if(orgFlag==1){//	局级单位
				if(orgPartyId.equals(equInfo.getBureauOrgPartyId())){//	拥有者
					equInfo.setEquFlag(1);
				}
				else{//	使用者
					equInfo.setEquFlag(0);
				}
			}
			else if(orgFlag==2){//	处级单位
				if(orgPartyId.equals(equInfo.getSonOrgPartyId())){//	拥有者
					equInfo.setEquFlag(1);
				}
				else{//	使用者
					equInfo.setEquFlag(0);
				}
			}
			else if(orgFlag==3){//	项目
				if(orgPartyId.equals(equInfo.getProOrgPartyId())){//	拥有者
					equInfo.setEquFlag(1);
				}
				else{//	使用者
					equInfo.setEquFlag(0);
				}
			}
		}

		return datas;
		}

	/**
	 * 资源管理（中铁用户/非中铁用户）
	 * 详情查询 - 根据设备资源id，查询设备资源详情
	 * @author haopeng
	 * @since 2016-08-11
	 * @param equipmentId 设备资源id
	 * @return ViewEquInfo
	 */
	@RequestMapping(value="/BG/Equipment/{equipmentId}", method={RequestMethod.GET})
	public ViewEquInfo queryDesc(@PathVariable Long equipmentId){

		ViewEquInfo viewEquInfo = new ViewEquInfo();

		viewEquInfo.setEquipmentId(equipmentId);

		return queryOne(viewEquInfo);
	}

	/**
	 * 资源管理（中铁用户/非中铁用户）
	 * 设备资源删除 - 根据设备资源id，删除设备资源，
	 *     且在设备资源所属的历史表中，记录设备资源删除情况，
	 *     且在设备资源使用情况表中，记录设备资源退场情况。
	 * @author haopeng
	 * @since 2016-08-12
	 * @param equipmentId 设备资源id
	 * @return Map<String, Object>
	 */
	@Transactional
	@RequestMapping(value="/BG/Equipment/{equipmentId}", method={RequestMethod.DELETE})
	public Map<String, Object> del(@PathVariable Long equipmentId, HttpSession httpSession) {

		//	获取设备表信息
		EquipmentTable et = iEquipmentDao.findOne(equipmentId);

		//	判断对应设备是否已经发布，如果发布，是不允许删除设备的
		List<SaleTable> rts = iSaleDao.queryByEquipmentId(equipmentId);
		List<RentTable> sts = iRentDao.queryByEquipmentId(equipmentId);
		Map<String, Object> map = new HashMap<String, Object>();
		if((rts!=null && rts.size()>0) || (sts!=null && sts.size()>0)){
			map.put("msg", "该设备资源已经发布，不能删除！");

			return map;
			}

		//	判断对应设备是否已出售或已报废，如果不是，是不允许删除设备的
		if(et.getEquState()!=3 && et.getEquState()!=4){
			map.put("msg", "该设备资源不是已出售或已报废，不能删除！");

			return map;
		}

		//	删除设备资源（台账）表信息，逻辑删除
		et.setDelFlag(1);
		et.setDelDate(new Date());

		iEquipmentDao.save(et);

		//	删除设备资源时，在设备资源所属的历史表中，记录设备资源删除情况
		addBusOwnHistTable(equipmentId, httpSession);

		//	删除设备资源时，在设备资源使用情况表中，记录设备资源退场情况
		Map<?, ?> userMap = (Map<?, ?>)httpSession.getAttribute("userInfo");

		BusUseInfoTable busUseInfo = new BusUseInfoTable();

		busUseInfo.setEquipmentId(equipmentId);
		busUseInfo.setEquipmentSourceNo(et.getEquipmentSourceNo());
		busUseInfo.setEquipmentSourceName(et.getEquipmentSourceName());
		busUseInfo.setEquState(et.getEquState());
		busUseInfo.setBusState(et.getBusState());
		busUseInfo.setPubState(et.getPubState());
		busUseInfo.setAddress(et.getAddress());
		busUseInfo.setCustodian(et.getCustodian());
		busUseInfo.setContactPersonPhone(et.getContactPersonPhone());
		busUseInfo.setApproachDate(et.getApproachDate());
		busUseInfo.setExitDate(et.getExitDate());

		if(Util.isNotNullOrEmpty(et.getLeaseModeName())){
			busUseInfo.setLeaseModeNo(Integer.parseInt(et.getLeaseModeName()));
		}

		busUseInfo.setLeasePrice(et.getLeasePrice());

		if(Util.isNotNullOrEmpty(et.getSettlementModeName())){
			busUseInfo.setSettlementModeNo(Integer.parseInt(et.getSettlementModeName()));
		}

		busUseInfo.setContractNo(et.getContractNo());
		busUseInfo.setRemark(et.getRemark());

		Date now = new Date();

		busUseInfo.setOperator(Long.parseLong(Util.toStringAndTrim(userMap.get("loginUserId"))));
		busUseInfo.setExitFlag(1);
		busUseInfo.setExeuntDate(now);
		busUseInfo.setMonth(Util.convertDateToStr(now, "yyyy-MM"));
		busUseInfo.setOperateDate(now);

		busUseInfo.setBureauOrgPartyId(et.getEquAtOrgId());
		busUseInfo.setSonOrgPartyId(et.getEquAtSubOrgId());
		busUseInfo.setProOrgPartyId(et.getEquAtProjectId());

		iBusUseInfoDao.save(busUseInfo);

		map.put("msg", "删除成功.");

		return map;
		}

	/**
	 * 添加、修改或删除设备资源时，添加设备资源拥有者的历史记录
	 * @author haopeng
	 * @since 2016-08-12
	 * @param equipmentId 设备资源id
	 * @param HttpSession 用户登录信息
	 */
	private void addBusOwnHistTable(Long equipmentId, HttpSession httpSession) {

		ViewEquInfo viewEquInfo = new ViewEquInfo();

		viewEquInfo.setEquipmentId(equipmentId);

		viewEquInfo = queryOne(viewEquInfo);

		BusOwnHistTable busOwnHist = new BusOwnHistTable();

		//	设置设备的相关信息
		busOwnHist.setEquipmentId(equipmentId);	//	设备资源id
		busOwnHist.setEquipmentSourceNo(viewEquInfo.getEquipmentSourceNo());	//	设备来源分类
		busOwnHist.setEquState(viewEquInfo.getEquState());	//	设备状态
		busOwnHist.setBusState(viewEquInfo.getBusState());	//	业务状态
		busOwnHist.setDelFlag(viewEquInfo.getDelFlag());	//	发布状态

		busOwnHist.setBureauOrgPartyId(viewEquInfo.getBureauOrgPartyId());
		busOwnHist.setSonOrgPartyId(viewEquInfo.getSonOrgPartyId());
		busOwnHist.setProOrgPartyId(viewEquInfo.getProOrgPartyId());

		//	设置设备拥有历史表的操作历史信息
		Date now = new Date();

		busOwnHist.setMonth(Util.convertDateToStr(now, "yyyy-MM"));
		busOwnHist.setOperateDate(now);

		Map<?, ?> userMap = (Map<?, ?>)httpSession.getAttribute("userInfo");

		busOwnHist.setOperator(Long.parseLong(Util.toStringAndTrim(userMap.get("loginUserId"))));

		iBusOwnHistDao.save(busOwnHist);
	}

	/**
	 * 根据设备编号获取设备资源的集合
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/BG/Equipment",method={RequestMethod.GET},params={"Action=GetByEquNo"})
	public Map<String, List<EquipmentTable>> getAdmin(@RequestParam Map<?, ?> reqParamsMap) {

		String equNo = (String)reqParamsMap.get("equNo");

		Map<String, List<EquipmentTable>> map = new HashMap<String, List<EquipmentTable>>();

		if(Util.isNullOrEmpty(equNo)){
			map.put("msg", new ArrayList<EquipmentTable>());
			return map;
		}

		map.put("msg", iEquipmentDao.queryByEquNo(equNo));

		return map;
	}

	/**
	 * 资源管理（中铁用户/非中铁用户）
	 * 设备资源添加 - 添加设备资源、添加设备资源与分类关系表（已弃用但是保留操作）、添加设备资源与登记者关系表（已弃用但是保留操作），
	 *     且在设备资源所属的历史表中，记录设备资源拥有情况、在租赁费登记表中，记录拥有者记录，
	 *     且在设备资源使用情况表中，记录设备资源进场情况、在租赁费登记表中，记录使用者记录。
	 * @author haopeng
	 * @since 2016-08-17
	 * @param equipmentBean 设备资源请求参数
	 * @return Map<String, Object>
	 */
	@Transactional
	@RequestMapping(value="/BG/Equipment", method={RequestMethod.PUT})
	public Map<String, Object> add(@RequestBody EquipmentBean equipmentBean, HttpSession httpSession) {

		Map<?, ?> userMap = (Map<?, ?>)httpSession.getAttribute("userInfo");

		//	添加设备资源
		EquipmentTable equipment = new EquipmentTable();

		equipmentBean.copyPropertyToDestBean(equipment);

		//	设备使用单位非空时，根据使用局级单位名称，查询设备使用单位id（主要是针对使用方为非中铁用户的使用单位信息）
		PartyOrg equAtOrg = getOrgByName(equipment.getEquAtOrgName());
		if(Util.isNotNullOrEmpty(equAtOrg)){
			equipment.setEquAtOrgId(equAtOrg.getPartyId());
		}

		equipment.setDelFlag(0);	//	删除标志（0或者null正常，1-已删除）
		equipment.setPubState(1);	//	发布状态：1-未发布
		equipment.setAssetOwnersId(Long.parseLong(Util.toStringAndTrim(userMap.get("orgId"))));	//	设备资源登记单位id
		equipment.setCreateUser(Long.parseLong(Util.toStringAndTrim(userMap.get("perPartyId"))));	//	创建人
		equipment.setCreateTime(new Date());	//	创建时间
		equipment.setTotalDepreciation(new BigDecimal("0.00"));	//	累计折旧费，默认为0

		//	拼组设备编号（内部单位） = 所属单位编号 + 设备编号 设备编号（外部单位） = 所属单位id + 设备编号
		StringBuffer sb = new StringBuffer();

		Long orgId = Util.isNullOrEmpty(equipmentBean.getSubsidiaryId()) ? equipmentBean.getBureauId() : equipmentBean.getSubsidiaryId();	//	所属单位id
		//	根据所属单位id，查询所属单位编号
		PartyOrg org = new PartyOrg();

		org.setPartyId(orgId);

		org = queryOne(org);

		String orgCode = org.getParType().getParTypeId()==8 ? Util.toStringAndTrim(orgId) : org.getCode(); 

		sb.append(orgCode);
		sb.append("-").append(equipmentBean.getEquNo());

		equipment.setEquNo(sb.toString());

		iEquipmentDao.save(equipment);

		//	在设备资源所属的历史表中，记录设备资源拥有情况
		addBusOwnHistTable(equipment.getEquipmentId(), httpSession);

		//	在租赁费登记表中，记录拥有者记录。租赁费-拥有者
		addBusRentHistTable(equipment, 0, httpSession);

		//	在设备资源使用情况表中，记录设备资源进场情况
		BusUseInfoTable busUseInfo = new BusUseInfoTable();

		busUseInfo.setEquipmentId(equipment.getEquipmentId());
		busUseInfo.setEquipmentSourceNo(equipment.getEquipmentSourceNo());
		busUseInfo.setEquipmentSourceName(equipment.getEquipmentSourceName());
		busUseInfo.setEquState(equipment.getEquState());
		busUseInfo.setBusState(equipment.getBusState());
		busUseInfo.setPubState(equipment.getPubState());
		busUseInfo.setAddress(equipment.getAddress());
		busUseInfo.setCustodian(equipment.getCustodian());
		busUseInfo.setContactPersonPhone(equipment.getContactPersonPhone());
		busUseInfo.setApproachDate(equipment.getApproachDate());
		busUseInfo.setExitDate(equipment.getExitDate());

		if(Util.isNotNullOrEmpty(equipment.getLeaseModeName())){
			busUseInfo.setLeaseModeNo(Integer.parseInt(equipment.getLeaseModeName()));
		}

		busUseInfo.setLeasePrice(equipment.getLeasePrice());

		if(Util.isNotNullOrEmpty(equipment.getSettlementModeName())){
			busUseInfo.setSettlementModeNo(Integer.parseInt(equipment.getSettlementModeName()));
		}

		busUseInfo.setContractNo(equipment.getContractNo());
		busUseInfo.setRemark(equipment.getRemark());

		Date now = new Date();

		busUseInfo.setOperator(Long.parseLong(Util.toStringAndTrim(userMap.get("loginUserId"))));
		busUseInfo.setExitFlag(0);
		busUseInfo.setMonth(Util.convertDateToStr(now, "yyyy-MM"));
		busUseInfo.setOperateDate(now);

		busUseInfo.setBureauOrgPartyId(equipment.getEquAtOrgId());
		busUseInfo.setSonOrgPartyId(equipment.getEquAtSubOrgId());
		busUseInfo.setProOrgPartyId(equipment.getEquAtProjectId());

		iBusUseInfoDao.save(busUseInfo);

		//	当设备来源分类为“自有”、设备状态为“使用中”、业务状态为“调拨”或“局内租”或“外局租”或“外租”时，往租赁费登记表中增加一条使用者记录。租赁费-使用者
		if(1==equipment.getEquipmentSourceNo() && 2==equipment.getEquState() && (2==equipment.getBusState() || 3==equipment.getBusState() || 4==equipment.getBusState() || 5==equipment.getBusState())){
			if(Util.isNotNullOrEmpty(equipment.getEquAtOrgId())){//	若使用单位在设备租赁中注册过，才记录使用者租赁费登记
				addBusRentHistTable(equipment, 1, httpSession);
			}
		}

		//	添加设备资源与分类关系表（已弃用但是保留操作）
		EquipmentCategoryTable equipmentCategory = new EquipmentCategoryTable();

		equipmentCategory.setEquipmentId(equipment.getEquipmentId());
		equipmentCategory.setCategoryTable(new CategoryTable(equipmentBean.getCategoryId().intValue()));

		iEquipmentCategoryDao.save(equipmentCategory);

		//	添加设备资源与登记者关系表（已弃用但是保留操作）
		EquipmentAscriptionTable equipmentAscription = new EquipmentAscriptionTable();

		equipmentAscription.setParty(new Party(Long.parseLong(Util.toStringAndTrim(userMap.get("orgId")))));
		equipmentAscription.setEquipmentId(equipment.getEquipmentId());

		insert(equipmentAscription);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("msg", "添加成功.");

		return map;
		}

	/**
	 * 添加、修改或删除设备资源时，添加使用者租赁费登记信息
	 * @author haopeng
	 * @since 2016-08-17
	 * @param equipment
	 * @param regFlag
	 * @param httpSession
	 */
	private void addBusRentHistTable(EquipmentTable equipment, Integer regFlag, HttpSession httpSession) {

		BusRentHistTable busRentHist = new BusRentHistTable();

		busRentHist.setEquipmentId(equipment.getEquipmentId());
		busRentHist.setManualFlag(0);
		busRentHist.setRegFlag(regFlag);

		if(regFlag==0){//	租赁费登记 - 拥有者
			busRentHist.setBureauOrgPartyId(equipment.getBureauId());	//	所属局级单位id

			if(Util.isNotNullOrEmpty(equipment.getSubsidiaryId())){//	所属处级单位id
				busRentHist.setSonOrgPartyId(equipment.getSubsidiaryId());
			}

			if(Util.isNotNullOrEmpty(equipment.getProjectId())){//	所属项目id
				busRentHist.setProOrgPartyId(equipment.getProjectId());
			}
		}
		else if(regFlag==1){//	租赁费登记 - 使用者
			busRentHist.setBureauOrgPartyId(equipment.getEquAtOrgId());	//	使用局级单位id

			if(Util.isNotNullOrEmpty(equipment.getEquAtSubOrgId())){//	使用处级单位id
				busRentHist.setSonOrgPartyId(equipment.getEquAtSubOrgId());
			}

			if(Util.isNotNullOrEmpty(equipment.getEquAtProjectId())){//	使用项目id
				busRentHist.setProOrgPartyId(equipment.getEquAtProjectId());
			}
		}

		Date now = new Date();

		busRentHist.setMonth(Util.convertDateToStr(now, "yyyy-MM"));
		busRentHist.setOperateDate(now);

		Map<?, ?> userMap = (Map<?, ?>)httpSession.getAttribute("userInfo");

		busRentHist.setOperator(Long.parseLong(Util.toStringAndTrim(userMap.get("loginUserId"))));

		iBusRentHistDao.save(busRentHist);
	}

	/**
	 * 资源管理（中铁用户/非中铁用户）
	 * 设备资源修改 - 修改设备资源、修改设备资源与分类关系表（已弃用但是保留操作）、修改设备资源与登记者关系表（已弃用但是保留操作），
	 *     且在设备资源所属的历史表中，记录设备资源拥有情况、在租赁费登记表中，记录拥有者记录，
	 *     且在设备资源使用情况表中，记录设备资源进场情况、在租赁费登记表中，记录使用者记录。
	 * @author haopeng
	 * @since 2016-08-19
	 * @param equipmentId 设备资源id
	 * @param equipmentBean 设备资源请求参数
	 * @param httpSession
	 * @return Map<String, Object>
	 */
	@Transactional
	@RequestMapping(value="/BG/Equipment/{equipmentId}", method={RequestMethod.POST})
	public Map<String, Object> upd(@PathVariable Long equipmentId, @RequestBody EquipmentBean equipmentBean, HttpSession httpSession) {

		Map<?, ?> userMap = (Map<?, ?>)httpSession.getAttribute("userInfo");

		//	获取资源原信息
		EquipmentTable equipment = iEquipmentDao.findOne(equipmentId);
		if(equipment.getDelFlag()!=0){
			throw new IFException("该设备资源已删除，不允许修改");
		}

		//	删除旧的设备资源与分类关系，插入新的设备资源与分类关系（已弃用但是保留操作）
		if(Util.isNotNullOrEmpty(equipmentBean.getCategoryId())){
			//	删除原资源与设备分类关系
			iEquipmentCategoryDao.deleteEquCat(equipmentId);

			//	插入新的设备资源与分类关系
			EquipmentCategoryTable equipmentCategory = new EquipmentCategoryTable();

			equipmentCategory.setEquipmentId(equipment.getEquipmentId());
			equipmentCategory.setCategoryTable(new CategoryTable(equipmentBean.getCategoryId().intValue()));

			iEquipmentCategoryDao.save(equipmentCategory);
		}

		//	删除旧的设备资源与登记者关系，插入新的设备资源与登记者关系（已弃用但是保留操作）
		if(!Util.isNotNullOrEmpty(equipmentBean.getAssetOwnersId())){
			//	删除原设备资源与登记者关系
			iEquipmentAscriptionDao.deleteEquAscription(equipmentId);

			//	插入新的设备资源与登记者关系
			EquipmentAscriptionTable equipmentAscription = new EquipmentAscriptionTable();

			equipmentAscription.setEquipmentId(equipment.getEquipmentId());
			equipmentAscription.setParty(new Party(Long.parseLong(Util.toStringAndTrim(userMap.get("orgId")))));

			insert(equipmentAscription);
		}

		//	修改设备资源
		EquipmentTable equipment_ = new EquipmentTable();

		equipmentBean.copyPropertyToDestBean(equipment_);

		//	设备使用单位非空时，根据使用局级单位名称，查询设备使用单位id（主要是针对使用方为非中铁用户的使用单位信息）
		PartyOrg equAtOrg = getOrgByName(equipment_.getEquAtOrgName());
		if(Util.isNotNullOrEmpty(equAtOrg)){
			equipment_.setEquAtOrgId(equAtOrg.getPartyId());
		}

		equipment_.setAssetOwnersId(Long.parseLong(Util.toStringAndTrim(userMap.get("orgId"))));	//	设备资源登记单位id
		equipment_.setDelFlag(equipment.getDelFlag());	//	删除标志（0或者null正常，1-已删除）
		equipment_.setPubState(equipment.getPubState());	//	发布状态：1-未发布
		equipment_.setCreateUser(equipment.getCreateUser());	//	创建人
		equipment_.setCreateTime(equipment.getCreateTime());	//	创建时间
		equipment_.setTotalDepreciation(equipment.getTotalDepreciation());	//	累计折旧费，默认为0

		//	拼组设备编号（内部单位） = 所属单位编号 + 设备编号 设备编号（外部单位） = 所属单位id + 设备编号
		StringBuffer sb = new StringBuffer();

		Long orgId = Util.isNullOrEmpty(equipmentBean.getSubsidiaryId()) ? equipmentBean.getBureauId() : equipmentBean.getSubsidiaryId();	//	所属单位id
		//	根据所属单位id，查询所属单位编号
		PartyOrg org = new PartyOrg();

		org.setPartyId(orgId);

		org = queryOne(org);

		String orgCode = org.getParType().getParTypeId()==8 ? Util.toStringAndTrim(orgId) : org.getCode(); 

		sb.append(orgCode);
		sb.append("-").append(equipmentBean.getEquNo());

		equipment_.setEquNo(sb.toString());

		equipment_.setEquipmentId(equipmentId);

		iEquipmentDao.save(equipment_);

		//	如果设备资源的设备来源分类、设备状态、业务状态中，任意一个发生了改变，就往设备资源所属的历史表中插入一条新记录
		BusOwnHistTable busOwnHist = iBusOwnHistDao.getByEquipmentId(equipmentId);
		if(Util.isNullOrEmpty(busOwnHist) || !(busOwnHist.getBusState()==equipment_.getBusState() && busOwnHist.getEquipmentSourceNo()==equipment_.getEquipmentSourceNo() && busOwnHist.getEquState()==equipment_.getEquState())){
			//	添加设备资源所属的历史表
			addBusOwnHistTable(equipmentId, httpSession);
		}

		String month = Util.convertDateToStr(new Date(), "yyyy-MM");
		//	如果当前月份修改的设备资源在租赁费——拥有者表中有记录，则不做什么操作，否则往租赁费 - 拥有者中插入一条记录
		String nativeSql = "select count(*) as counts from bus_rent_hist t where t.month=:month and t.regFlag=:regFlag and t.equipmentId=:equipmentId and t.bureauOrgPartyId=:bureauId";

		Map<String,Object> params = new HashMap<String,Object>();

		params.put("month", month);
		params.put("regFlag", 0);
		params.put("equipmentId", equipmentId);
		params.put("bureauId", equipment_.getBureauId());

		if(Util.isNotNullOrEmpty(equipment_.getSubsidiaryId())){
			sb.append(" and t.sonOrgPartyId=:subsidiaryId");
			params.put("subsidiaryId", equipment_.getSubsidiaryId());
		}

		if(Util.isNotNullOrEmpty(equipment_.getProjectId())){
			sb.append(" and t.proOrgPartyId=:projectId");
			params.put("projectId", equipment_.getProjectId());
		}

		Integer count = queryCountByNative(nativeSql, params);
		if(count<=0){
			if(1==equipment_.getEquipmentSourceNo() && 2==equipment_.getEquState() && (2==equipment_.getBusState() || 3==equipment_.getBusState() || 4==equipment_.getBusState() || 5==equipment_.getBusState())){
				addBusRentHistTable(equipment, 0, httpSession);
			}
		}

		//	在设备资源使用情况表中，记录设备资源进场情况
		BusUseInfoTable busUseInfo = new BusUseInfoTable();

		busUseInfo.setEquipmentId(equipment.getEquipmentId());
		busUseInfo.setEquipmentSourceNo(equipment.getEquipmentSourceNo());
		busUseInfo.setEquipmentSourceName(equipment.getEquipmentSourceName());
		busUseInfo.setEquState(equipment.getEquState());
		busUseInfo.setBusState(equipment.getBusState());
		busUseInfo.setPubState(equipment.getPubState());
		busUseInfo.setAddress(equipment.getAddress());
		busUseInfo.setCustodian(equipment.getCustodian());
		busUseInfo.setContactPersonPhone(equipment.getContactPersonPhone());
		busUseInfo.setApproachDate(equipment.getApproachDate());
		busUseInfo.setExitDate(equipment.getExitDate());

		if(Util.isNotNullOrEmpty(equipment.getLeaseModeName())){
			busUseInfo.setLeaseModeNo(Integer.parseInt(equipment.getLeaseModeName()));
		}

		busUseInfo.setLeasePrice(equipment.getLeasePrice());

		if(Util.isNotNullOrEmpty(equipment.getSettlementModeName())){
			busUseInfo.setSettlementModeNo(Integer.parseInt(equipment.getSettlementModeName()));
		}

		busUseInfo.setContractNo(equipment.getContractNo());
		busUseInfo.setRemark(equipment.getRemark());

		Date now = new Date();

		busUseInfo.setOperator(Long.parseLong(Util.toStringAndTrim(userMap.get("loginUserId"))));
		busUseInfo.setExitFlag(0);
		busUseInfo.setMonth(Util.convertDateToStr(now, "yyyy-MM"));
		busUseInfo.setOperateDate(now);

		busUseInfo.setBureauOrgPartyId(equipment.getEquAtOrgId());
		busUseInfo.setSonOrgPartyId(equipment.getEquAtSubOrgId());
		busUseInfo.setProOrgPartyId(equipment.getEquAtProjectId());

		iBusUseInfoDao.save(busUseInfo);

		if(Util.isNotNullOrEmpty(equipment_.getEquAtOrgId())){//	若使用单位在设备租赁中注册过，才记录使用者租赁费登记
			//	如果当前月份修改的设备资源在租赁费——使用者表中有记录，则不做什么操作，否则往租赁费 - 使用者中插入一条记录
			sb.setLength(0);

			sb.append("select count(*) as counts from bus_rent_hist t where t.month=:month and t.regFlag=:regFlag and t.equipmentId=:equipmentId and t.bureauOrgPartyId=:equAtOrgId");

			params = new HashMap<String,Object>();

			params.put("month", month);
			params.put("regFlag", 1);
			params.put("equipmentId", equipmentId);
			params.put("equAtOrgId", equipment_.getEquAtOrgId());

			if(Util.isNotNullOrEmpty(equipment_.getEquAtSubOrgId())){
				sb.append(" and t.sonOrgPartyId=:equAtSubOrgId");
				params.put("equAtSubOrgId", equipment_.getEquAtSubOrgId());
			}

			if(Util.isNotNullOrEmpty(equipment_.getEquAtProjectId())){
				sb.append(" and t.proOrgPartyId=:equAtProjectId");
				params.put("equAtProjectId", equipment_.getEquAtProjectId());
			}

			count = queryCountByNative(sb.toString(), params);
			if(count<=0){
				if(1==equipment_.getEquipmentSourceNo() && 2==equipment_.getEquState() && (2==equipment_.getBusState() || 3==equipment_.getBusState() || 4==equipment_.getBusState() || 5==equipment_.getBusState())){
					addBusRentHistTable(equipment, 1, httpSession);
				}
			}
		}

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("msg", "修改成功.");

		return map;
		}

	/**
	 * 资源管理（中铁用户/非中铁用户）
	 * 使用情况登记 - 修改设备资源、修改设备资源与分类关系表（已弃用但是保留操作）、修改设备资源与登记者关系表（已弃用但是保留操作），
	 *     且在设备资源所属的历史表中，记录设备资源拥有情况、在租赁费登记表中，记录拥有者记录，
	 *     且在设备资源使用情况表中，记录设备资源进场情况、在租赁费登记表中，记录使用者记录。
	 * @author haopeng
	 * @since 2016-08-19
	 * @param equipmentId 设备资源id
	 * @param equipmentBean 设备资源请求参数
	 * @param httpSession
	 * @return Map<String, Object>
	/**
	 * 添加设备的使用历史信息
	 * @param equipmentBean
	 * @return
	 */
	@Transactional
	@RequestMapping(value="/BG/Equipment", method={RequestMethod.PUT}, params={"Action=AddUseInfo"})
	public Map<String, Object> addUseInfo(@RequestBody EquipmentBean equipmentBean, HttpSession httpSession) {

		Map<?, ?> userMap = (Map<?, ?>)httpSession.getAttribute("userInfo");

		//	使用情况登记
		BusUseInfoTable busUseInfo = new BusUseInfoTable();

		PartyOrg equAtOrg = getOrgByName(equipmentBean.getEquAtOrgName());
		if(Util.isNotNullOrEmpty(equAtOrg)){
			busUseInfo.setBureauOrgPartyId(equAtOrg.getPartyId());
		}

		busUseInfo.setEquipmentId(equipmentBean.getEquipmentId());
		busUseInfo.setEquipmentSourceNo(equipmentBean.getEquipmentSourceNo());
		busUseInfo.setEquipmentSourceName(equipmentBean.getEquipmentSourceName());
		busUseInfo.setEquState(equipmentBean.getEquState());
		busUseInfo.setBusState(equipmentBean.getBusState());
		busUseInfo.setPubState(equipmentBean.getPubState());
		busUseInfo.setAddress(equipmentBean.getAddress());
		busUseInfo.setCustodian(equipmentBean.getCustodian());
		busUseInfo.setContactPersonPhone(equipmentBean.getContactPersonPhone());
		busUseInfo.setApproachDate(equipmentBean.getApproachDate());
		busUseInfo.setExitDate(equipmentBean.getExitDate());

		if(Util.isNotNullOrEmpty(equipmentBean.getLeaseModeName())){
			busUseInfo.setLeaseModeNo(Integer.parseInt(equipmentBean.getLeaseModeName()));
		}

		busUseInfo.setLeasePrice(equipmentBean.getLeasePrice());

		if(Util.isNotNullOrEmpty(equipmentBean.getSettlementModeName())){
			busUseInfo.setSettlementModeNo(Integer.parseInt(equipmentBean.getSettlementModeName()));
		}

		busUseInfo.setContractNo(equipmentBean.getContractNo());
		busUseInfo.setRemark(equipmentBean.getRemark());

		Long loginUserId = Long.parseLong(Util.toStringAndTrim(userMap.get("loginUserId")));

		Date now = new Date();

		String month = Util.convertDateToStr(now, "yyyy-MM");

		busUseInfo.setOperator(loginUserId);
		busUseInfo.setExitFlag(0);
		busUseInfo.setMonth(month);
		busUseInfo.setOperateDate(now);

		busUseInfo.setSonOrgPartyId(equipmentBean.getEquAtSubOrgId());
		busUseInfo.setProOrgPartyId(equipmentBean.getEquAtProjectId());

		iBusUseInfoDao.save(busUseInfo);

		if(Util.isNotNullOrEmpty(equipmentBean.getEquAtOrgId())){//	若使用单位在设备租赁中注册过，才记录使用者租赁费登记
			//	如果当前月份修改的设备资源在租赁费——使用者表中有记录，则不做什么操作，否则往租赁费 - 使用者中插入一条记录
			StringBuffer sb = new StringBuffer();

			sb.setLength(0);

			sb.append("select count(*) as counts from bus_rent_hist t where t.month=:month and t.regFlag=:regFlag and t.equipmentId=:equipmentId and t.bureauOrgPartyId=:equAtOrgId");

			Map<String,Object> params = new HashMap<String,Object>();

			params.put("month", month);
			params.put("regFlag", 1);
			params.put("equipmentId", equipmentBean.getEquipmentId());
			params.put("equAtOrgId", equipmentBean.getEquAtOrgId());

			if(Util.isNotNullOrEmpty(equipmentBean.getEquAtSubOrgId())){
				sb.append(" and t.sonOrgPartyId=:equAtSubOrgId");
				params.put("equAtSubOrgId", equipmentBean.getEquAtSubOrgId());
			}

			if(Util.isNotNullOrEmpty(equipmentBean.getEquAtProjectId())){
				sb.append(" and t.proOrgPartyId=:equAtProjectId");
				params.put("equAtProjectId", equipmentBean.getEquAtProjectId());
			}

			Integer count = queryCountByNative(sb.toString(), params);
			if(count<=0){
				if(1==equipmentBean.getEquipmentSourceNo() && 2==equipmentBean.getEquState() && (2==equipmentBean.getBusState() || 3==equipmentBean.getBusState() || 4==equipmentBean.getBusState() || 5==equipmentBean.getBusState())){
					BusRentHistTable busRentHist = new BusRentHistTable();

					busRentHist.setBureauOrgPartyId(equipmentBean.getEquAtOrgId());
					busRentHist.setSonOrgPartyId(equipmentBean.getEquAtSubOrgId());
					busRentHist.setProOrgPartyId(equipmentBean.getEquAtProjectId());
					busRentHist.setEquipmentId(equipmentBean.getEquipmentId());
					busRentHist.setMonth(month);
					busRentHist.setOperateDate(now);
					busRentHist.setOperator(loginUserId);
					busRentHist.setRegFlag(1);
					busRentHist.setManualFlag(0);

					iBusRentHistDao.save(busRentHist);
				}
			}
		}

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("msg", "添加成功.");

		return map;
	}

	/**
	 * 设备资源（台账管理 ）-查询全部信息-供发布出租、出售设备的时候调用
	 * @return Map
	 */
	@RequestMapping(value="/BG/Equipment",method={RequestMethod.POST},params={"Action=All"})
	public Page<?> queryAllOwn(@RequestBody EquipmentSearchBean equipmentSearchBean) {


		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select obj ");
		listSql.append("from ViewEquInfo obj "); // 设备拥有者的设备信息
		listSql.append("where obj.delFlag!=1 ");

		//	拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(1) ");
		countSql.append("from ViewEquInfo obj "); // 设备拥有者的设备信息
		countSql.append("where obj.delFlag!=1 ");

		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		Integer isProvider = equipmentSearchBean.getIsProvider();	//	费中铁单位：1-费中铁单位、0或者空位中铁单位
		if(Util.isNotNullOrEmpty(isProvider) && 1==isProvider)//如果是非中铁单位时的处理方式
		{
			String orgName = equipmentSearchBean.getOrgName();
			Long orgPartyId = equipmentSearchBean.getOrgPartyId();
			if(Util.isNotNullOrEmpty(orgName)){
				sqlParamsMap.put("orgName", "%"+orgName+"%");
				listSql.append(" and obj.orgName LIKE:orgName ");
				countSql.append("and obj.orgName LIKE:orgName ");	
			}
			if(Util.isNotNullOrEmpty(orgPartyId)){
				sqlParamsMap.put("orgPartyId",orgPartyId);
				listSql.append(" and obj.orgPartyId =:orgPartyId ");
				countSql.append("and obj.orgPartyId =:orgPartyId ");
			}
		}
		else//如果是中单位的处理方式
		{
			//	拼组所属单位/项目的查询条件
			Integer orgFlag = equipmentSearchBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
			Long orgPartyId = equipmentSearchBean.getOrgPartyId();	//	所属单位/项目id
			Integer isInclude = equipmentSearchBean.getIsInclude();	//	是否包含下级单位：1-包含
			if(Util.isNullOrEmpty(orgFlag)){throw new IFException("所属单位信息不能为空！");}
			if(Util.isNullOrEmpty(orgPartyId)){throw new IFException("所属单位信息不能为空！");}
			//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
			if(orgFlag==9){//	总公司
				listSql.append(" AND obj.bureauOrgParTypeId=4");
				countSql.append(" AND obj.bureauOrgParTypeId=4");
			}
			else if(orgFlag==1){//	局级单位
				sqlParamsMap.put("orgPartyId", orgPartyId);
				if(isInclude!=null && isInclude==1){
					listSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");
					countSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");
				}
				else{
					listSql.append(" AND (obj.bureauOrgPartyId=:orgPartyId AND obj.sonOrgPartyId=null)");
					countSql.append(" AND (obj.bureauOrgPartyId=:orgPartyId AND obj.sonOrgPartyId=null)");
				}
			}
			else if(orgFlag==2){//	处级单位
				sqlParamsMap.put("orgPartyId", orgPartyId);
				listSql.append(" AND obj.sonOrgPartyId=:orgPartyId");
				countSql.append(" AND obj.sonOrgPartyId=:orgPartyId");
			}
			else if(orgFlag==3){//	项目
				sqlParamsMap.put("orgPartyId", orgPartyId);
				listSql.append(" AND obj.proOrgPartyId=:orgPartyId");
				countSql.append(" AND obj.proOrgPartyId=:orgPartyId");
			}
			else{
				throw new IFException("所属单位信息错误！");
			}	    	
		}
		
		//	设备名称
		if(Util.isNotNullOrEmpty(equipmentSearchBean.getEquName())){
			sqlParamsMap.put("equName", equipmentSearchBean.getEquName());
			listSql.append(" and obj.equName=:equName ");
			countSql.append(" and obj.equName=:equName ");
			}

		//	设备所在单位
		if(Util.isNotNullOrEmpty(equipmentSearchBean.getEquAtOrgName())){
			sqlParamsMap.put("equAtOrgName", equipmentSearchBean.getEquAtOrgName());
			listSql.append(" and obj.equAtOrgName=:equAtOrgName ");
			countSql.append(" and obj.equAtOrgName=:equAtOrgName ");
			}

		//	设备状态
		if(Util.isNotNullOrEmpty(equipmentSearchBean.getEquState())){
			sqlParamsMap.put("equState", equipmentSearchBean.getEquState());
			listSql.append(" and obj.equState=:equState ");
			countSql.append(" and obj.equState=:equState ");
			}

		//	发布状态
		if(Util.isNotNullOrEmpty(equipmentSearchBean.getPubState())){
			sqlParamsMap.put("pubState", equipmentSearchBean.getPubState());
			listSql.append(" and obj.pubState=:pubState ");
			countSql.append(" and obj.pubState=:pubState ");
			}
		
		//	发布类型，1：出租、2：出售
		if(Util.isNotNullOrEmpty(equipmentSearchBean.getPubType())){
			Integer pubType = equipmentSearchBean.getPubType();
			if(pubType==1)
			{
				listSql.append(" and obj.pubState !=2 and  obj.pubState !=4 ");
				countSql.append(" and obj.pubState !=2 and  obj.pubState !=4  ");
			}
			else if(pubType==2)
			{
				listSql.append(" and obj.pubState !=3 and  obj.pubState !=4  ");
				countSql.append(" and obj.pubState !=3 and  obj.pubState !=4  ");
			}

		}

		//	设备来源分类
		if(Util.isNotNullOrEmpty(equipmentSearchBean.getEquipmentSourceNo())){
			sqlParamsMap.put("equipmentSourceNo", equipmentSearchBean.getEquipmentSourceNo());
			listSql.append(" and obj.equipmentSourceNo=:equipmentSourceNo ");
			countSql.append(" and obj.equipmentSourceNo=:equipmentSourceNo ");
			}

		//	按照设备编号排序
		listSql.append("order by obj.equNo ");

		Page<ViewEquInfo> datas = (Page<ViewEquInfo>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,equipmentSearchBean.getPageRequest());
		
		//	发布类型，1：出租、2：出售
		/*
		 * 同一个设备可以同时发布出租、出售的信息，不过不能在没闭环的情况再次发布出租、或者出售的信息
		 * 当发布信息的时候需要做如下的控制：
		 * 1：当发布出租信息后不能再次的发布出租信息了
		 * 2：当发布出售信息后不能再次的发布出售信息了
		 * 3：当对出租信息做过发布结果登记后，能继续的发布出租的信息了，但是不能做出售的发布信息，
		 *      对于出售信息也是同样的道理
		 * 下面是对3做的控制，针对查询出来的结果，循环便利一下看看有没有没鼻环的，如果有则将其从集合中剔除掉，让发布者看不到
		*/
//		if(Util.isNotNullOrEmpty(equipmentSearchBean.getPubType())){
//			Integer pubType = equipmentSearchBean.getPubType();
//			List<BizExData> bizExdataList=null;
//			List<ViewEquInfo> veiList=datas.getContent();
//			if((pubType==1 || pubType==2) && null!=veiList && veiList.size()>0)
//			{
//				for(int i=0; i<veiList.size(); i++)
//				{
//					bizExdataList = iBizExDataDao.queryByEquipmentId(pubType,veiList.get(i).getEquipmentId(),2);
//					if(null!=bizExdataList && bizExdataList.size()>0)
//					{
//						veiList.remove(i);
//						datas.getTotalElements()
//					}
//				}
//				
//			}
//		}
		
		
		return datas;	
		}
	/**
	 * 根据发布类型和将要发布的设备判断设备是否可以继续发布
	 */
	@RequestMapping(value="/BG/Equipment",method={RequestMethod.GET},params={"Action=EQU_CAN_RELEASE"})
	public Map<String,String> checkEquRelease(@RequestParam Map<?, ?> reqParamsMap)
	{
//		发布类型，1：出租、2：出售
		Integer pubType = Integer.parseInt(reqParamsMap.get("pubType").toString());
		Long equipmentId = Long.parseLong(reqParamsMap.get("equipmentId").toString());
		List<BizExData> bizExdataList = iBizExDataDao.queryByEquipmentId(pubType,equipmentId,2);
		Map<String, String> map = new HashMap<String, String>();
		if(null!=bizExdataList && bizExdataList.size()>0)
		{
			map.put("equCanRelease", "N");
		}
		else
		{
			map.put("equCanRelease", "Y");
		}
		return map;
	}
	
	/**
	 * 获取设备名称
	 */
	@RequestMapping(value="/BG/Equipment",method={RequestMethod.POST},params={"Action=GetEquName"})
	public Page<?> queryEquName(@RequestBody EquipmentSearchBean equipmentSearchBean, HttpSession httpSession) {

		String orgCode = equipmentSearchBean.getOrgCode();
		Integer isInclude = equipmentSearchBean.getIsInclude();

		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select distinct equCat.equipmentCategoryName as equipmentCategoryName,equName.equipmentName as equName ");
		listSql.append("from bus_equipment equ, bus_category cat, bus_equ_category_manage equCat, bus_equ_name_manage equName ");
		listSql.append("where equ.categoryId=cat.categoryId and cat.equCategoryId=equCat.equCategoryId and cat.equNameId=equName.equNameId and equ.delFlag!=1 ");

		//	拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(distinct equCat.equipmentCategoryName,equName.equipmentName) ");
		countSql.append("from bus_equipment equ, bus_category cat, bus_equ_category_manage equCat, bus_equ_name_manage equName ");
		countSql.append("where equ.categoryId=cat.categoryId and cat.equCategoryId=equCat.equCategoryId and cat.equNameId=equName.equNameId and equ.delFlag!=1 ");

		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		Integer isProvider=equipmentSearchBean.getIsProvider();
		if(isProvider!=null && isProvider==1){
			//	从session中获取用户数据
			Map<?, ?> userMap = (Map<?, ?>)httpSession.getAttribute("userInfo");
			Long orgPartyId = (Long)userMap.get("orgId");

			sqlParamsMap.put("orgPartyId", orgPartyId);
			listSql.append("and equ.assetOwnersId=:orgPartyId");
			countSql.append("and equ.assetOwnersId=:orgPartyId");
			}
		else{
			if(Util.isNullOrEmpty(orgCode))
				throw new IFException("当前登录人员的单位编码不能为空");

			//如果包含下级单位，就是采用模糊查询的方式，如果不包含下级单位就采用等于查询的方式
			if(isInclude!=null && isInclude==1){
				sqlParamsMap.put("orgCode",orgCode+"%");
				listSql.append("and equ.assetOwnersId in (select org.partyId from par_org org where org.code like :orgCode)");
				countSql.append("and equ.assetOwnersId in (select org.partyId from par_org org where org.code like :orgCode)");
				}
			else{
				sqlParamsMap.put("orgCode",orgCode);
				listSql.append("and equ.assetOwnersId in (select org.partyId from par_org org where org.code=:orgCode)");
				countSql.append("and equ.assetOwnersId in (select org.partyId from par_org org where org.code=:orgCode)");	
				}
			}

		Page<?> datas = (Page<?>)queryListByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,equipmentSearchBean.getPageRequest());

		return datas;	
		}

	/**
	 * 获取设备所在单位的信息
	 */
	@RequestMapping(value="/BG/Equipment",method={RequestMethod.POST},params={"Action=GetEquAtOrgName"})
	public Page<?> queryEquAtOrgName(@RequestBody EquipmentSearchBean equipmentSearchBean,HttpSession httpSession) {

		String orgCode = equipmentSearchBean.getOrgCode();
		Integer isInclude = equipmentSearchBean.getIsInclude();

		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select distinct ifnull(org.name,equ.equAtOrgName) as equAtOrgName ");
		listSql.append("from bus_equipment equ, par_org org ");
		listSql.append("where equ.equAtOrgId=org.partyId and equ.delFlag!=1 ");

		//	拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(distinct ifnull(org.name,equ.equAtOrgName)) ");
		countSql.append("from bus_equipment equ, par_org org ");
		countSql.append("where equ.equAtOrgId=org.partyId and equ.delFlag!=1 ");

		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		Integer isProvider=equipmentSearchBean.getIsProvider();
		if(isProvider!=null && isProvider==1){
			//	从session中获取用户数据
			Map<?, ?> userMap = (Map<?, ?>)httpSession.getAttribute("userInfo");
			Long orgPartyId = (Long)userMap.get("orgId");

			sqlParamsMap.put("orgPartyId", orgPartyId);
			listSql.append("and equ.assetOwnersId=:orgPartyId");
			countSql.append("and equ.assetOwnersId=:orgPartyId");
			}
		else{
			if(Util.isNullOrEmpty(orgCode))
				throw new IFException("当前登录人员的单位编码不能为空");

			//	如果包含下级单位，就是采用模糊查询的方式，如果不包含下级单位就采用等于查询的方式
			if(isInclude!=null && isInclude==1){
				sqlParamsMap.put("orgCode", orgCode + "%");
				listSql.append("and equ.assetOwnersId in (select org2.partyId from par_org org2 where org2.code like :orgCode)");
				countSql.append("and equ.assetOwnersId in (select org2.partyId from par_org org2 where org2.code like :orgCode)");
				}
			else{
				sqlParamsMap.put("orgCode", orgCode);
				listSql.append("and equ.assetOwnersId in (select org2.partyId from par_org org2 where org2.code=:orgCode)");
				countSql.append("and equ.assetOwnersId in (select org2.partyId from par_org org2 where org2.code=:orgCode)");
				}
			}

		Page<?> datas = (Page<?>)queryListByNativeSql(listSql.toString(),countSql.toString(),sqlParamsMap,equipmentSearchBean.getPageRequest());

		return datas;	
		}

	/**
	 * 添加查询的过滤条件，目前供求租求购来使用。注意：为了提高查询效率，对于能够精确查询的就精确查询
	 * @param listSql
	 * @param countSql
	 * @param sqlParamsMap
	 * @param issueSearchBean
	 */
	private void addSelectParams(StringBuffer listSql, StringBuffer countSql, Map<String,Object> sqlParamsMap, IssueSearchBean issueSearchBean, HttpSession httpSession) {

		Integer isProvider = issueSearchBean.getIsProvider();	//	费中铁单位：1-费中铁单位、0或者空位中铁单位
		if(Util.isNotNullOrEmpty(isProvider) && 1==isProvider)//如果是非中铁单位时的处理方式
		{
			String orgName = issueSearchBean.getOrgName();
			if(Util.isNotNullOrEmpty(orgName))
			{
				sqlParamsMap.put("bureauOrgPartyName", "%"+orgName+"%");
				listSql.append(" and obj.bureauOrgPartyName LIKE:bureauOrgPartyName  AND obj.bureauOrgParTypeId=8 ");
				countSql.append("and obj.bureauOrgPartyName LIKE:bureauOrgPartyName AND obj.bureauOrgParTypeId=8 ");	
			}
		}
		else//如果是中单位的处理方式
		{
			//	拼组所属单位/项目的查询条件
			Integer orgFlag = issueSearchBean.getOrgFlag();	//	所属单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
			Long orgPartyId = issueSearchBean.getOrgPartyId();	//	所属单位/项目id
			Integer isInclude = issueSearchBean.getIsInclude();	//	是否包含下级单位：1-包含
//			if(Util.isNullOrEmpty(orgFlag)){throw new IFException("所属单位信息不能为空！");}
//			if(Util.isNullOrEmpty(orgPartyId)){throw new IFException("所属单位信息不能为空！");}
			//	根据选择的orgFlag（所属单位/项目标志）和isInclude（是否包含下级单位），拼组所属单位的查询条件
			if(Util.isNotNullOrEmpty(orgFlag) && Util.isNotNullOrEmpty(orgPartyId))
			{
				if(orgFlag==9){//	总公司
					listSql.append(" AND obj.bureauOrgParTypeId=4");
					countSql.append(" AND obj.bureauOrgParTypeId=4");
				}
				else if(orgFlag==1){//	局级单位
					sqlParamsMap.put("orgPartyId", orgPartyId);
					if(isInclude!=null && isInclude==1){
						listSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");
						countSql.append(" AND obj.bureauOrgPartyId=:orgPartyId");
					}
					else{
						listSql.append(" AND (obj.bureauOrgPartyId=:orgPartyId AND obj.sonOrgPartyId=null)");
						countSql.append(" AND (obj.bureauOrgPartyId=:orgPartyId AND obj.sonOrgPartyId=null)");
					}
				}
				else if(orgFlag==2){//	处级单位
					sqlParamsMap.put("orgPartyId", orgPartyId);
					listSql.append(" AND obj.sonOrgPartyId=:orgPartyId");
					countSql.append(" AND obj.sonOrgPartyId=:orgPartyId");
				}
				else if(orgFlag==3){//	项目
					sqlParamsMap.put("orgPartyId", orgPartyId);
					listSql.append(" AND obj.proOrgPartyId=:orgPartyId");
					countSql.append(" AND obj.proOrgPartyId=:orgPartyId");
				}
//				else{
//					throw new IFException("所属单位信息错误！");
//				}	    	
			}

		}

		
		
/*		String orgCode = issueSearchBean.getOrgCode();
		if(Util.isNotNullOrEmpty(orgCode)){
			Integer isInclude = issueSearchBean.getIsInclude();
			//	如果包含下级单位，就是采用模糊查询的方式，如果不包含下级单位就采用等于查询的方式
			if(isInclude!=null && isInclude==1){
				sqlParamsMap.put("orgCode", orgCode + "%");
				listSql.append("and obj.orgCode like :orgCode ");
				countSql.append("and obj.orgCode like :orgCode ");
				}
			else{
				sqlParamsMap.put("orgCode", orgCode);
				listSql.append("and obj.orgCode=:orgCode ");
				countSql.append("and obj.orgCode=:orgCode ");	
				}
			}*/

	    //	所在省-新增-2016-08-09
		if(Util.isNotNullOrEmpty(issueSearchBean.getOnProvince())){
			sqlParamsMap.put("onProvince", issueSearchBean.getOnProvince());
			listSql.append(" and obj.onProvince=:onProvince ");
			countSql.append(" and obj.onProvince=:onProvince ");
		}		
		
	    //	所在城市
		if(Util.isNotNullOrEmpty(issueSearchBean.getOnCity())){
			sqlParamsMap.put("onCity", issueSearchBean.getOnCity());
			listSql.append(" and obj.onCity=:onCity ");
			countSql.append(" and obj.onCity=:onCity ");
		}

	    //	品牌
		if(Util.isNotNullOrEmpty(issueSearchBean.getBrandNames())){
			listSql.append(" and obj.brandName in (").append(Util.arrayToString(issueSearchBean.getBrandNames())).append(") ");
			countSql.append(" and obj.brandName in (").append(Util.arrayToString(issueSearchBean.getBrandNames())).append(") ");
			}
	    //	设备大类-新增-2016-08-09
		if(Util.isNotNullOrEmpty(issueSearchBean.getEquCategoryId())){
			sqlParamsMap.put("equCategoryId", issueSearchBean.getEquCategoryId());
			listSql.append(" and obj.equCategoryId=:equCategoryId ");
			countSql.append(" and obj.equCategoryId=:equCategoryId ");
		}
	    //	设备小类-新增-2016-08-09
		if(Util.isNotNullOrEmpty(issueSearchBean.getEquNameId())){
			sqlParamsMap.put("equNameId", issueSearchBean.getEquNameId());
			listSql.append(" and obj.equNameId=:equNameId ");
			countSql.append(" and obj.equNameId=:equNameId ");
		}
//	    //	设备名称
//		if(Util.isNotNullOrEmpty(issueSearchBean.getEquName())){
//			sqlParamsMap.put("equName", issueSearchBean.getEquName());
//			listSql.append("and obj.equName=:equName ");
//			countSql.append("and obj.equName=:equName ");
//			}

	    //	型号
		if(Util.isNotNullOrEmpty(issueSearchBean.getModelNames())){
			listSql.append(" and obj.models in (").append(Util.arrayToString(issueSearchBean.getModelNames())).append(") ");
			countSql.append(" and obj.models in (").append(Util.arrayToString(issueSearchBean.getModelNames())).append(") ");
			}

	    //	规格
		if(Util.isNotNullOrEmpty(issueSearchBean.getStandardNames())){
			listSql.append(" and obj.specifications in (").append(Util.arrayToString(issueSearchBean.getStandardNames())).append(") ");
			countSql.append(" and obj.specifications in (").append(Util.arrayToString(issueSearchBean.getStandardNames())).append(") ");
			}

		//	单位范围，比较特殊，不是一个字段所能表示的，他代表查询的范围
		/**
		 * 根据选定的单位范围，拼组查询条件
		 * 
		 * 1-处内，2-局内，3-外局，4-外单位
		 * 
		 * 1）单位范围可以多选，使用该功能的只有内部企业，有总公司、局级单位、处级单位三类人员
		 * 2）根据登录人员的企业级别不同，单位范围拼组查询条件也不同
		 * 3）同一单位级别的人员，不同情况之间是or的关系
		 * 4）未选择单位范围或全选，不需要拼组此查询条件
		 * 
		 * 总公司：分为内部企业（处内、局内、外局任意一种或多种）和外部企业（外单位）两种情况考虑
		 *     内部企业（处内、局内、外局任意一种或多种）情况：根据操作人员的orgCode模糊查询
		 *     外部企业（外单位）情况：根据操作人员的企业类型查询
		 * 局级单位：分为处内、局内（包含处内）、局外、外单位和非局内（包含局外和外单位）情况五种情况考虑
		 *     处内情况：根据处级单位级别和操作人员的orgCode模糊查询
		 *     局内（包含处内）情况：根据操作人员的orgCode模糊查询
		 *     局外情况：根据非操作人员的orgCode且非外单位模糊查询
		 *     外单位情况：根据操作人员的企业类型查询
		 *     非局内（包含局外和外单位）情况：根据非操作人员的orgCode模糊查询
		 * 处级单位：分为处内、局内（包含处内）、局外、外单位和非局内（包含局外和外单位）情况五种情况考虑
		 *     处内情况：根据操作人员的orgCode模糊查询
		 *     局内（包含处内）情况：根据操作人员的orgCode的前6位模糊查询
		 *     局外情况：根据非操作人员的orgCode的前6位且非外单位模糊查询
		 *     外单位情况：根据操作人员的企业类型查询
		 *     非局内（包含局外和外单位）情况：根据非操作人员的orgCode的前6位模糊查询
		 */
		Integer[] orgScope = issueSearchBean.getOrgScope();
		if(orgScope!=null && orgScope.length>0 && orgScope.length<4){
			String searchCondition = getOrgScopeCond(orgScope, httpSession);

			if(Util.isNotNullOrEmpty(searchCondition)){
				listSql.append(searchCondition);
				countSql.append(searchCondition);
				}
			}

		//	设备来源
		if(Util.isNotNullOrEmpty(issueSearchBean.getEquipmentSourceNos())){
			listSql.append(" and obj.equipmentSourceNo in (").append(Util.arrayToString(issueSearchBean.getEquipmentSourceNos())).append(") ");
			countSql.append(" and obj.equipmentSourceNo in (").append(Util.arrayToString(issueSearchBean.getEquipmentSourceNos())).append(") ");
			}

		//	设备状态
		if(Util.isNotNullOrEmpty(issueSearchBean.getEquStates())){
			listSql.append(" and (");
			countSql.append(" and (");

			//	设备状态对应的是四个字段的值：设备状态、发布状态，现在约定
			//	1-闲置；2-使用中；4-可出租；5-可出售
			Integer[] equStatesTemp = issueSearchBean.getEquStates();

			StringBuffer sb = new StringBuffer();

			for(int i=0;i<equStatesTemp.length;i++){
				if(equStatesTemp[i]==1)
					sb.append("obj.equState=1 or ");
				else if(equStatesTemp[i]==2)
					sb.append("obj.equState=2 or ");
				else if(equStatesTemp[i]==4)
					sb.append("obj.rentFlag=1 or ");
				else if(equStatesTemp[i]==5)
					sb.append("obj.saleFlag=1 or ");
				}

			String equStates = sb.substring(0, sb.length() -4);

			listSql.append(equStates).append(") ");
			countSql.append(equStates).append(") ");
			}

		/*	发布状态 （1-未发布，2-出租发布中，3-出售发布中，4-租售发布中）
		   前台也面现在只有两个选项 2-出租发布中，3-出售发布中
		   目前确定的处理逻辑是：
		   1：当选择出租发布中的时候，查询出出租发布中和租售发布中的数据
		   2：当选择出租发布中的时候，查询出出售发布中和租售发布中的数据
		   3：当选择个出租发布中和出售发布中的时候，查询出出租发布中、出售发布中、租售发布中的数据
		*/
		if(Util.isNotNullOrEmpty(issueSearchBean.getPubStates())){
			Integer[] pubStates=issueSearchBean.getPubStates();
			if(pubStates.length==1)//当选择了出租发布中或者出售发布中时
			{
				int pubState=pubStates[0];
				listSql.append(" and obj.pubState in (").append(pubState).append(" , 4").append(") ");
				countSql.append(" and obj.pubState in (").append(pubState).append(" , 4").append(") ");
			}
			else//当选择了出租发布中和出售发布中两个选项时
			{
				listSql.append(" and obj.pubState in (2,3,4) ");
				countSql.append(" and obj.pubState in (2,3,4) ");
			}
			
			
//			listSql.append(" and obj.pubState in (").append(Util.arrayToString(issueSearchBean.getPubStates())).append(") ");
//			countSql.append(" and obj.pubState in (").append(Util.arrayToString(issueSearchBean.getPubStates())).append(") ");
			}

		//	业务状态
		if(Util.isNotNullOrEmpty(issueSearchBean.getBusStates())){
			listSql.append(" and obj.busState in (").append(Util.arrayToString(issueSearchBean.getBusStates())).append(") ");
			countSql.append(" and obj.busState in (").append(Util.arrayToString(issueSearchBean.getBusStates())).append(") ");
			}

	    //	最低价格
		if(Util.isNotNullOrEmpty(issueSearchBean.getMinPrice())){
			sqlParamsMap.put("minPrice", issueSearchBean.getMinPrice());
			listSql.append(" and obj.equipmentCost>=:minPrice ");
			countSql.append(" and obj.equipmentCost>=:minPrice ");
			}

	    //	最高价格
		if(Util.isNotNullOrEmpty(issueSearchBean.getMaxPrice())){
			sqlParamsMap.put("maxPrice", issueSearchBean.getMaxPrice());
			listSql.append(" and obj.equipmentCost<=:maxPrice ");
			countSql.append(" and obj.equipmentCost<=:maxPrice ");
			}

	    //	价格类型
		if(Util.isNotNullOrEmpty(issueSearchBean.getPriceType())){
			sqlParamsMap.put("priceType", issueSearchBean.getPriceType());
			listSql.append(" and obj.priceType=:priceType ");
			countSql.append(" and obj.priceType=:priceType ");
			}
		}


	/**
	 * 根据选定的单位范围，拼组查询条件
	 * 
	 * 1-处内，2-局内，3-外局，4-外单位
	 * 
	 * 1）单位范围可以多选，使用该功能的只有内部企业，有总公司、局级单位、处级单位三类人员
	 * 2）根据登录人员的企业级别不同，单位范围拼组查询条件也不同
	 * 3）同一单位级别的人员，不同情况之间是or的关系
	 * 4）未选择单位范围或全选，不需要拼组此查询条件
	 * 
	 * 总公司：分为内部企业（处内、局内、外局任意一种或多种）和外部企业（外单位）两种情况考虑
	 *     内部企业（处内、局内、外局任意一种或多种）情况：根据操作人员的orgCode模糊查询
	 *     外部企业（外单位）情况：根据操作人员的企业类型查询
	 * 局级单位：分为处内、局内（包含处内）、局外、外单位和非局内（包含局外和外单位）五种情况考虑
	 *     处内情况：根据处级单位级别和操作人员的orgCode模糊查询
	 *     局内（包含处内）情况：根据操作人员的orgCode模糊查询
	 *     局外情况：根据非操作人员的orgCode且非外单位模糊查询
	 *     外单位情况：根据操作人员的企业类型查询
	 *     非局内（包含局外和外单位）情况：根据非操作人员的orgCode模糊查询
	 * 处级单位：分为处内、局内（包含处内）、局外、外单位和非局内（包含局外和外单位）五种情况考虑
	 *     处内情况：根据操作人员的orgCode模糊查询
	 *     局内（包含处内）情况：根据操作人员的orgCode的前6位模糊查询
	 *     局外情况：根据非操作人员的orgCode的前6位且非外单位模糊查询
	 *     外单位情况：根据操作人员的企业类型查询
	 *     非局内（包含局外和外单位）情况：根据非操作人员的orgCode的前6位模糊查询
	 */
	private String getOrgScopeCond(Integer[] orgScope, HttpSession httpSession) {

		Map<?, ?> session_user = (Map<?, ?>)httpSession.getAttribute("userInfo");

		if(Util.isNullOrEmpty(session_user.get("orgLevel")))
			throw new IFException("当前登录人员的单位级别不能为空");

		Integer orgLevel = (Integer)session_user.get("orgLevel");	//	1-总公司，2-局级单位，3-处级单位，6-外部供应商

		if(Util.isNullOrEmpty(session_user.get("orgCode")))
			throw new IFException("当前登录人员的单位编码不能为空");

		String orgCode_ = (String)session_user.get("orgCode");

		String orgRange = "";
		if(1==orgLevel)//	总公司的人员
			orgRange = getOrgScopeCondBy1(orgScope, orgCode_);
		else if(2==orgLevel)//	局级单位的人员
			orgRange = getOrgScopeCondBy2(orgScope, orgCode_);
		else if(3==orgLevel)//	处级单位的人员
			orgRange = getOrgScopeCondBy3(orgScope, orgCode_);
		else//	数据有问题，或者非中国中铁的人员登录
			throw new IFException("登录人员的企业级别有误，请联系管理员");

		StringBuffer sb = new StringBuffer();
		if(Util.isNotNullOrEmpty(orgRange))
			sb.append(" and (").append(orgRange).append(")");

		return sb.toString();
		}

	/**
	 * 根据选定的单位范围，拼组查询条件
	 * 
	 * 总公司：分为内部企业（处内、局内、外局任意一种或多种）和外部企业（外单位）两种情况考虑
	 *     内部企业（处内、局内、外局任意一种或多种）情况：根据操作人员的orgCode模糊查询
	 *     外部企业（外单位）情况：根据操作人员的企业类型查询
	 */
	private String getOrgScopeCondBy1(Integer[] orgScope, String orgCode_) {

		String orgRange = "";
		boolean conditionFlag = false;	//	一种以上情况的标志
		boolean continueFlag = false;	//	相同情况的标志
		for(int i=0;i<orgScope.length;i++){
			if(4==orgScope[i]){//	外部企业（外单位）情况：根据操作人员的企业类型查询
				if(conditionFlag){//内部企业和外部企业都有的情况下，不需要拼组查询条件
					orgRange = "";

					break ;
					}

				orgRange = addSqlByOrgParType(8);

				conditionFlag = true;
				}
			else if(3==orgScope[i] || 2==orgScope[i] || 1==orgScope[i]){//	内部企业（处内、局内、外局任意一种或多种）情况：根据操作人员的orgCode模糊查询
				if(continueFlag)//处内、局内、外局属于相同情况，不需要重复拼组查询条件
					continue ;

				if(conditionFlag){//内部企业和外部企业都有的情况下，不需要拼组查询条件
					orgRange = "";

					break ;
					}

				orgRange = addSqlByOrgCode(orgCode_);

				continueFlag = true;
				conditionFlag = true;
				}
			}

		return orgRange;
		}

	/**
	 * 根据选定的单位范围，拼组查询条件
	 * 
	 * 局级单位：分为处内、局内（包含处内）、局外、外单位和非局内（包含局外和外单位）五种情况考虑
	 *     处内情况：根据处级单位级别和操作人员的orgCode模糊查询
	 *     局内（包含处内）情况：根据操作人员的orgCode模糊查询
	 *     局外情况：根据非操作人员的orgCode且非外单位模糊查询
	 *     外单位情况：根据操作人员的企业类型查询
	 *     非局内（包含局外和外单位）情况：根据非操作人员的orgCode模糊查询
	 */
	private String getOrgScopeCondBy2(Integer[] orgScope, String orgCode_) {

		boolean condition2Flag = false;	//	局内情况标志
		boolean condition3Flag = false;	//	局外情况标志
		boolean condition4Flag = false;	//	外单位情况标志
		boolean condition5Flag = false;	//	非局内情况标志
		for(int i=0;i<orgScope.length;i++){
			if(2==orgScope[i])
				condition2Flag = true;
			else if(3==orgScope[i])
				condition3Flag = true;
			else if(4==orgScope[i])
				condition4Flag = true;
			}

		StringBuffer orgRange = new StringBuffer();

		//	局内、局外和外单位都有的情况下，不需要拼组查询条件
		if(condition4Flag && condition3Flag && condition2Flag)
			return orgRange.toString();

		boolean continueFlag = false;	//	相同情况的标志
		//	有局内的情况下，不需要拼组处内查询条件
		if(condition2Flag)
			continueFlag = true;

		boolean conditionFlag = false;	//	一种以上情况的标志

		if(condition4Flag && condition3Flag){//	非局内（包含局外和外单位）情况：根据非操作人员的orgCode模糊查询
			condition5Flag = true;

			orgRange.append(addSqlByNonOrgCodes(orgCode_));

			conditionFlag = true;
			}

		for(int i=0;i<orgScope.length;i++){
			if(4==orgScope[i]){//	外部企业（外单位）情况：根据操作人员的企业类型查询
				if(condition5Flag)
					continue ;

				if(conditionFlag)
					orgRange.append(" or");

				orgRange.append(addSqlByOrgParType(8));

				conditionFlag = true;
				}
			else if(3==orgScope[i]){//	局外情况：根据非操作人员的orgCode模糊查询
				if(condition5Flag)
					continue ;

				if(conditionFlag)
					orgRange.append(" or");

				orgRange.append(addSqlByNonOrgCode(orgCode_));

				conditionFlag = true;
				}
			else if(2==orgScope[i]){//	局内（包含处内）情况：根据操作人员的orgCode模糊查询
				if(conditionFlag)
					orgRange.append(" or");

				orgRange.append(addSqlByOrgCode(orgCode_));

				conditionFlag = true;
				}
			else if(1==orgScope[i]){//	处内情况：根据处级单位级别和操作人员的orgCode模糊查询
				if(continueFlag)
					continue;

				if(conditionFlag)
					orgRange.append(" or");

				orgRange.append(addSqlByOrgLvAndOrgCode(3, orgCode_));

				conditionFlag = true;
				}
			}

		return orgRange.toString();
		}

	/**
	 * 根据选定的单位范围，拼组查询条件
	 * 
	 * 处级单位：分为处内、局内（包含处内）、局外、外单位和非局内（包含局外和外单位）五种情况考虑
	 *     处内情况：根据操作人员的orgCode模糊查询
	 *     局内（包含处内）情况：根据操作人员的orgCode的前6位模糊查询
	 *     局外情况：根据非操作人员的orgCode的前6位且非外单位模糊查询
	 *     外单位情况：根据操作人员的企业类型查询
	 *     非局内（包含局外和外单位）情况：根据非操作人员的orgCode的前6位模糊查询
	 */
	private String getOrgScopeCondBy3(Integer[] orgScope, String orgCode_) {

		boolean condition2Flag = false;	//	局内情况标志
		boolean condition3Flag = false;	//	局外情况标志
		boolean condition4Flag = false;	//	外单位情况标志
		boolean condition5Flag = false;	//	非局内情况标志
		for(int i=0;i<orgScope.length;i++){
			if(2==orgScope[i])
				condition2Flag = true;
			else if(3==orgScope[i])
				condition3Flag = true;
			else if(4==orgScope[i])
				condition4Flag = true;
			}

		StringBuffer orgRange = new StringBuffer();

		//	局内、局外和外单位都有的情况下，不需要拼组查询条件
		if(condition4Flag && condition3Flag && condition2Flag)
			return orgRange.toString();

		boolean continueFlag = false;	//	相同情况的标志
		//	有局内的情况下，不需要拼组处内查询条件
		if(condition2Flag)
			continueFlag = true;

		boolean conditionFlag = false;	//	一种以上情况的标志

		if(condition4Flag && condition3Flag){//	非局内（包含局外和外单位）情况：根据非操作人员的orgCode的前6位模糊查询
			condition5Flag = true;

			orgRange.append(addSqlByNonOrgCodes(orgCode_));

			conditionFlag = true;
			}

		for(int i=0;i<orgScope.length;i++){
			if(4==orgScope[i]){//	外部企业（外单位）情况：根据操作人员的企业类型查询
				if(condition5Flag)
					continue ;

				if(conditionFlag)
					orgRange.append(" or");

				orgRange.append(addSqlByOrgParType(8));

				conditionFlag = true;
				}
			else if(3==orgScope[i]){//	局外情况：根据非操作人员的orgCode的前6位模糊查询
				if(condition5Flag)
					continue ;

				if(conditionFlag)
					orgRange.append(" or");

				orgRange.append(addSqlByNonOrgCode(orgCode_.substring(0,6)));

				conditionFlag = true;
				}
			else if(2==orgScope[i]){//	局内（包含处内）情况：根据操作人员的orgCode的前6位模糊查询
				if(conditionFlag)
					orgRange.append(" or");

				orgRange.append(addSqlByOrgCode(orgCode_.substring(0,6)));

				conditionFlag = true;
				}
			else if(1==orgScope[i]){//	处内情况：根据操作人员的orgCode模糊查询
				if(continueFlag)
					continue;

				if(conditionFlag)
					orgRange.append(" or");

				orgRange.append(addSqlByOrgCode(orgCode_));

				conditionFlag = true;
				}
			}

		return orgRange.toString();
		}

	/**
	 * 根据操作人员的企业类型查询
	 */
	private String addSqlByOrgParType(int orgParTypeId) {

		StringBuffer param = new StringBuffer();

		param.append(" obj.orgParTypeId=").append(orgParTypeId);

		return param.toString();
		}

	/**
	 * 根据操作人员的orgCode模糊查询
	 * 根据操作人员的orgCode的前6位模糊查询
	 */
	private String addSqlByOrgCode(String orgCode) {

		StringBuffer param = new StringBuffer();

		param.append(" obj.orgCode like '").append(orgCode).append("%'");

		return param.toString();
		}

	/**
	 * 根据非操作人员的orgCode且非外单位模糊查询
	 * 根据非操作人员的orgCode的前6位且非外单位模糊查询
	 */
	private String addSqlByNonOrgCode(String orgCode) {

		StringBuffer param = new StringBuffer();

		param.append(" obj.orgParTypeId!=8 and obj.orgCode not like '").append(orgCode).append("%'");

		return param.toString();
		}

	/**
	 * 根据非操作人员的orgCode模糊查询
	 * 根据非操作人员的orgCode的前6位模糊查询
	 */
	private String addSqlByNonOrgCodes(String orgCode) {

		StringBuffer param = new StringBuffer();

		param.append(" obj.orgCode not like '").append(orgCode).append("%'");

		return param.toString();
		}

	/**
	 * 根据处级单位级别和操作人员的orgCode模糊查询
	 */
	private String addSqlByOrgLvAndOrgCode(int orgLevel, String orgCode) {

		StringBuffer param = new StringBuffer();

		param.append(" (obj.orgLevel=").append(orgLevel).append(" and obj.orgCode like '").append(orgCode).append("%')");

		return param.toString();
		}

	/**
	 * 前端求购搜索页面的查询方法
	 * @param issueSearchBean
	 * @return
	 */
	@RequestMapping(value="/BG/Equipment",method={RequestMethod.POST},params={"Action=Equipment"})
	public Page<?> queryEquAll(@RequestBody IssueSearchBean issueSearchBean,HttpSession httpSession) {
		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		//	资源搜索列表中查询出来的数据都是未删除的数据
		sqlParamsMap.put("delFlag", 1);

		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select obj ");
		listSql.append("from ViewEquInfo obj ");
		listSql.append("where obj.delFlag!=:delFlag ");

		//	拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(1) ");
		countSql.append("from ViewEquInfo obj ");
		countSql.append("where obj.delFlag!=:delFlag ");

		//	添加查询的过滤条件
		addSelectParams(listSql,countSql,sqlParamsMap,issueSearchBean,httpSession);

		//按照设备名称（注意：在拼视图的时候已经按照汉语拼音从A-Z排序了，不过实验证明，数据库中的修改，优先级小于程序中的修改）、设备编号升序排序
        listSql.append(" order by obj.equNo");

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,issueSearchBean.getPageRequest());
		return datas;	
		}

/**外部供应商******************************************************************************************************************************************************************************************/

	/**
	 * 资源管理（非中铁用户）
	 * 列表查询 - 根据查询条件，查询未删除的资源的拥有情况和使用情况（包含内部租用和外部租用）
	 * @author haopeng
	 * @since 2016-08-15
	 * @param equAtOrgFlag 使用单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
	 * @param equAtOrgPartyId 使用单位/项目id
	 * @param equAtOrgName 使用单位名称
	 * @param isCrecOrg 使用单位是否是中铁用户：1-非中铁用户
	 * @param equState 设备状态（''-全部（不包含已出售和已报废）、1-闲置、2-使用中）
	 * @param isSaled 包含已出售：1-包含
	 * @param isScraped 包含已报废：1-包含
	 * @param equName 设备名称（模糊查询）
	 * @return Page<?>
	 */
	@RequestMapping(value="/BG/Equipment", method={RequestMethod.POST}, params={"Action=Provider"})
	public Page<?> queryAllProvider(@RequestBody EquipmentSearchBean equipmentSearchBean, HttpSession httpSession) {

		//	从session中获取用户数据
		Map<?, ?> userMap = (Map<?, ?>)httpSession.getAttribute("userInfo");
		if(Util.isNullOrEmpty(userMap)){
			throw new IFException("抱歉，您尚未登录或者登录超时，请重新登录！");
		}

		Integer partyTypeId = Integer.parseInt(Util.toStringAndTrim(userMap.get("partyTypeId")));	//	当前登录人员类型：6-外部员工
		if(6!=partyTypeId){
			throw new IFException("您不是供应商，不能操作此功能！");
		}

		Long orgPartyId = Long.parseLong(Util.toStringAndTrim(userMap.get("orgId")));	//	当前登录人员所属机构id

		//	拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();

		listSql.append("select viewEqu ");
		listSql.append("from ViewEquInfo viewEqu ");

		//	拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();

		countSql.append("select count(1) "); 
		countSql.append("from ViewEquInfo viewEqu ");

		//	传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();

		//	资源搜索列表中查询出来的数据都是未删除的数据
		listSql.append("where viewEqu.delFlag!=1 ");
		countSql.append("where viewEqu.delFlag!=1 ");

		sqlParamsMap.put("orgPartyId", orgPartyId);
		listSql.append("and (viewEqu.bureauOrgPartyId=:orgPartyId or viewEqu.equAtOrgId=:orgPartyId) ");
		countSql.append("and (viewEqu.bureauOrgPartyId=:orgPartyId or viewEqu.equAtOrgId=:orgPartyId) ");

		//	拼组使用单位/项目的查询条件
		Integer equAtOrgFlag = equipmentSearchBean.getEquAtOrgFlag();	//	使用单位/项目标志：1-局级单位，2-处级单位，3-项目，9-总公司
		Long equAtOrgPartyId = equipmentSearchBean.getEquAtOrgPartyId();	//	使用单位/项目id
		String equAtOrgName = equipmentSearchBean.getEquAtOrgName();	//	使用单位名称
		Integer isCrecOrg = equipmentSearchBean.getIsCrecOrg();	//	使用单位是否是中铁用户：1-非中铁用户
		//	根据使用单位名称判断是否输入了使用单位信息
		if(Util.isNotNullOrEmpty(equAtOrgName)){
			if(isCrecOrg!=null && isCrecOrg==1){//	非中铁用户
				sqlParamsMap.put("equAtOrgName", "%" + equAtOrgName + "%");
				listSql.append("and (viewEqu.equAtOrgParTypeId=8 or viewEqu.equAtOrgParTypeId is null) and viewEqu.equAtOrgName like :equAtOrgName ");
				countSql.append("and (viewEqu.equAtOrgParTypeId=8 or viewEqu.equAtOrgParTypeId is null) and viewEqu.equAtOrgName like :equAtOrgName ");
			}
			else{//	中铁用户
				if(Util.isNullOrEmpty(equAtOrgFlag)){
					throw new IFException("使用单位信息错误！");
				}
				if(equAtOrgFlag==9){//	总公司
					listSql.append("and viewEqu.equAtOrgParTypeId=4 ");
					countSql.append("and viewEqu.equAtOrgParTypeId=4 ");
				}
				else if(equAtOrgFlag==1){//	局级单位
					if(Util.isNullOrEmpty(equAtOrgPartyId)){
						throw new IFException("使用单位信息错误！");
					}
					sqlParamsMap.put("equAtOrgPartyId", equAtOrgPartyId);
					listSql.append("and viewEqu.equAtOrgId=:equAtOrgPartyId ");
					countSql.append("and viewEqu.equAtOrgId=:equAtOrgPartyId ");
				}
				else if(equAtOrgFlag==2){//	处级单位
					if(Util.isNullOrEmpty(equAtOrgPartyId)){
						throw new IFException("使用单位信息错误！");
					}
					sqlParamsMap.put("equAtOrgPartyId", equAtOrgPartyId);
					listSql.append("and viewEqu.equAtSubOrgId=:equAtOrgPartyId ");
					countSql.append("and viewEqu.equAtSubOrgId=:equAtOrgPartyId ");
				}
				else if(equAtOrgFlag==3){//	项目
					if(Util.isNullOrEmpty(equAtOrgPartyId)){
						throw new IFException("使用单位信息错误！");
					}
					sqlParamsMap.put("equAtOrgPartyId", equAtOrgPartyId);
					listSql.append("and viewEqu.equAtProjectId=:equAtOrgPartyId ");
					countSql.append("and viewEqu.equAtProjectId=:equAtOrgPartyId ");
				}
				else{
					throw new IFException("使用单位信息错误！");
				}
			}
		}

		//	拼组设备状态的查询条件
		StringBuffer state_StrBuff = new StringBuffer();
		Integer equState = equipmentSearchBean.getEquState();
		if(Util.isNullOrEmpty(equState)){
			state_StrBuff.append("1,2");
			}
		else if(equState==1){
			state_StrBuff.append("1");
		}
		else if(equState==2){
			state_StrBuff.append("2");
		}
		else{
			throw new IFException("设备状态错误！");
		}

		Integer isSaled = equipmentSearchBean.getIsSaled();
		if(isSaled!=null && isSaled==1){
			state_StrBuff.append(",3");
		}

		Integer isScraped = equipmentSearchBean.getIsScraped();
		if(isScraped!=null && isScraped==1){
			state_StrBuff.append(",4");
		}

		String state = state_StrBuff.toString();
		listSql.append("and viewEqu.equState in (").append(state).append(") ");
		countSql.append("and viewEqu.equState in (").append(state).append(") ");

		//	拼组设备名称的查询条件
		String equName = equipmentSearchBean.getEquName();	//	设备名称
		if(Util.isNotNullOrEmpty(equName)){
			sqlParamsMap.put("equName", "%" + equName + "%");
			listSql.append("and viewEqu.equName like :equName ");
			countSql.append("and viewEqu.equName like :equName ");
		}

		//	按照设备编号排序
		listSql.append("order by viewEqu.equNo");

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,equipmentSearchBean.getPageRequest());

		//	结果集为空时，直接返回
		if(!datas.hasContent()){
			return datas;
		}

		//	对返回的资源进行处理，区分出拥有单位的资源和使用单位的资源
		List<ViewEquInfo> list = (List<ViewEquInfo>)datas.getContent();
		for(ViewEquInfo equInfo : list){
			if(orgPartyId.equals(equInfo.getBureauOrgPartyId())){//	拥有者
				equInfo.setEquFlag(1);
			}
			else{
				equInfo.setEquFlag(0);
			}
		}

		return datas;	
		}

	}
