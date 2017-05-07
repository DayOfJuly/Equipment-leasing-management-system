package com.hjd.action;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.DemandRentBean;
import com.hjd.base.BaseAction;
import com.hjd.dao.IBusPublishInfoDao;
import com.hjd.dao.IDemandRentDao;
import com.hjd.domain.BizDataState;
import com.hjd.domain.BizProcess;
import com.hjd.domain.BusPublishInfoTable;
import com.hjd.domain.DemandRentTable;
import com.hjd.domain.PartyOrg;
import com.hjd.util.Util;
import com.hjd.util.pinyin.PinyinUtil;

@RestController
public class DemandRentAction extends BaseAction{
	
	@Autowired
	IDemandRentDao iDemandRentDao;
	@Autowired
	IBusPublishInfoDao iBusPublishInfoDao;
	
	@Value("${tmpInfoFilePath}")
	String tmpInfoFilePath="";
	
	@Value("${realInfofilePath}")
	String realInfofilePath="";

	/**
	 * 求租信息查询
	 * @param parms 查询条件
	 * @return
	 */
	@RequestMapping(value="/BG/DemandRent",method={RequestMethod.GET})
/*	public Page<?> queryAll(@RequestParam Map parms){
		DemandRentSearchBean drsb = new DemandRentSearchBean();
		Iterator<Entry<String, String>> i = parms.entrySet().iterator();
		Entry<String, String> entry;
		Map<String,Object> map = new HashMap();
		while (i.hasNext()) {
		    entry = i.next();
		    String key = entry.getKey();
		    String value = entry.getValue();
		    if(key.equals("pageNo"))
		    	drsb.setPageNo(Integer.valueOf(value));
		    if(key.equals("pageSize"))
		    	drsb.setPageSize(Integer.valueOf(value));
		}
		return iDemandRentDao.queryAll(drsb.getPageRequest());
	}*/
	
	public Page<?> queryAll(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		Integer pageNo = 0;
		Integer pageSize = 1;
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

		listSql.append("SELECT obj ");
		listSql.append("FROM DemandRentTable  obj ");
		listSql.append("WHERE 1=1 ");
		
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM DemandRentTable obj ");		
		countSql.append("WHERE 1=1 ");

	    //信息标题
		if(Util.isNotNullOrEmpty(reqParamsMap.get("infoTitle")))
		{
			sqlParamsMap.put("infoTitle", "%"+reqParamsMap.get("infoTitle")+"%");
			listSql.append(" AND obj.infoTitle LIKE :infoTitle");
			countSql.append(" AND obj.infoTitle LIKE :infoTitle");
		}
		listSql.append(" ORDER BY obj.releaseDate DESC");
		
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageRequest);
		for(int i=0;i<datas.getContent().size();i++)
		{
			((DemandRentTable)datas.getContent().get(i)).setAtCityDesc(getRegionNameByRegionId2(((DemandRentTable)datas.getContent().get(i)).getAtCity()));
		}
		return datas;	
	}
	
	/**
	 * 求租信息明细查询
	 * @param id 求租信息主键
	 * @return
	 */
	@RequestMapping(value="/BG/DemandRent/{id}",method={RequestMethod.GET})
	public DemandRentTable queryDesc(@PathVariable Long id){
		return iDemandRentDao.queryDesc(id);
	}
	
	/**
	 * 添加求租信息
	 * @param demandRentBean 添加的求租信息表单内容
	 * @return
	 */
	@RequestMapping(value="/BG/DemandRent",method={RequestMethod.PUT})
	@Transactional
	public Map<String, String> add(@RequestBody DemandRentBean demandRentBean ,HttpSession httpSession){
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");   //用于压力测试，测试完毕
		//选择数据状态表信息
		BizDataState bds = new BizDataState();
		bds.setDataState(1);//1：待审核
		
		//存储业务表信息
		BizProcess bp = new BizProcess();
		bp.setBizType(3);//3：求租信息发布
		bp.setBizName("求租信息发布");
		bp.setDefaultProcFlag(false);
		this.insert(bp);
		
		//存储求租发布信息
		DemandRentTable drt = new DemandRentTable();
		demandRentBean.copyPropertyToDestBean(drt);
		drt.setDataState(bds);
//		drt.setProcess(bp);
		drt.setProcessId(bp.getProcessId());
		drt.setDataType(3);//不知道BizExData类里面的 dataType 存什么内容，暂时存成3：求租信息发布
		drt.setReleaseDate(new Date());
		drt.setUpdateTime(new Date());
		drt.setOperateFlag(0);
		
		drt.setManagerId((Long)userMap.get("loginUserId"));//添加发布数据信息的人
//		drt.setManagerId(Long.parseLong("3"));
		
		drt.setOriginOrg((Long)userMap.get("orgId"));//添加信息发布人的单位id
		drt.setOrgCode((String)userMap.get("orgCode"));//添加信息发布人的单位code
		
		//如果当前登录人有项目，添加信息发布人的项目ID
		if(Util.isNotNullOrEmpty(userMap.get("proId")))
		{
			drt.setProId((Long)userMap.get("proId"));
		}
		
//		//设备所在单位非空，就根据单位名称查询出设备所在单位的ID和编码，为了实现搜索页面根据所属单位来查询对应的集合
//		PartyOrg  po=getOrgByName(drt.getEnterpriseName());
//		if(Util.isNotNullOrEmpty(po))
//		{
//			drt.setOriginOrg(po.getPartyId());
//			drt.setOrgCode(po.getCode());
//		}
		drt.setInfoTitlePy(PinyinUtil.getUpperCaseShortPinyin(drt.getInfoTitle()));//信息标题的拼音

		//为统计查询添加的冗余字段
		drt.setStandardNameEx(drt.getStandardName());
		drt.setModelNameEx(drt.getModelName());
		drt.setOnProvinceEx(drt.getOnProvince());
		drt.setOnCityEx(drt.getOnCity());
		drt.setOnDistrictEx(drt.getOnDistrict());
		
		
		iDemandRentDao.save(drt);
		
		//将图片从临时目录移动到真实目录
		if(!Util.isNullOrEmpty(drt.getEquipmentPic())){
			String[] fileNames = drt.getEquipmentPic().split(",");
			Util.copyFileToRealPath(tmpInfoFilePath, realInfofilePath, fileNames);
		}
		
		//添加我已发布的信息

		BusPublishInfoTable busPublishInfoTable=new BusPublishInfoTable();
		busPublishInfoTable.setDataId(drt.getDataId());
		busPublishInfoTable.setOperateFlag(0);
		busPublishInfoTable.setOperateDate(new Date());
		busPublishInfoTable.setLoginUserId((Long)userMap.get("loginUserId"));//用于压力测试，测试完毕
		busPublishInfoTable.setPartyId((Long)userMap.get("orgId"));
		if(Util.isNotNullOrEmpty(userMap.get("proId")))
		{
			busPublishInfoTable.setProId((Long)userMap.get("proId"));//添加发布数据信息的项目
		}
		
//		busPublishInfoTable.setLoginUserId(Long.parseLong("3"));
//		busPublishInfoTable.setPartyId(Long.parseLong("322"));
		
		iBusPublishInfoDao.save(busPublishInfoTable);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "添加成功.");
		return map;
	}
	
	/**
	 * 修改求租信息
	 * @param id 需要修改的求租信息主键
	 * @param drb 需要修改的求租信息表单内容
	 * @return
	 */
	@RequestMapping(value="/BG/DemandRent/{id}",method={RequestMethod.POST})
	@Transactional
	public Map<String, String> upd(@PathVariable Long id,@RequestBody DemandRentBean drb){
		//获取数据库中需要修改的求租发布信息
		DemandRentTable drt = iDemandRentDao.queryDesc(id);
		
		//判断上传的图片是否修改过
/*		if(!drt.getEquipmentPic().equals(drb.getEquipmentPic())){
			//将图片从临时目录移动到真实目录
			if(!Util.isNullOrEmpty(drb.getEquipmentPic())){
				String[] fileNames = drb.getEquipmentPic().split(",");
				Util.copyFileToRealPath(tmpInfoFilePath, realInfofilePath, fileNames);
			}
		}*/
		
		//存储求租发布信息
/*		if(!Util.isNullOrEmpty(drb.getPriceType()))
			drt.setPriceType(drb.getPriceType());
		if(!Util.isNullOrEmpty(drb.getDetailedDescription()))
			drt.setDetailedDescription(drb.getDetailedDescription());
		if(!Util.isNullOrEmpty(drb.getInfoTitle()))
			drt.setInfoTitle(drb.getInfoTitle());
		if(!Util.isNullOrEmpty(drb.getExpectedAmount()))
			drt.setExpectedAmount(drb.getExpectedAmount());
		if(!Util.isNullOrEmpty(drb.getExpectedDeposit()))
			drt.setExpectedDeposit(drb.getExpectedDeposit());
		if(!Util.isNullOrEmpty(drb.getQuantity()))
			drt.setQuantity(drb.getQuantity());
		if(!Util.isNullOrEmpty(drb.getEnterpriseName()))
			drt.setEnterpriseName(drb.getEnterpriseName());
		if(!Util.isNullOrEmpty(drb.getContactPerson()))
			drt.setContactPerson(drb.getContactPerson());
		if(!Util.isNullOrEmpty(drb.getContactPhone()))
			drt.setContactPhone(drb.getContactPhone());
		if(!Util.isNullOrEmpty(drb.getQqNo()))
			drt.setQqNo(drb.getQqNo());
		if(!Util.isNullOrEmpty(drb.getElectronicMail()))
			drt.setElectronicMail(drb.getElectronicMail());
		if(!Util.isNullOrEmpty(drb.getFixedTelephone()))
			drt.setFixedTelephone(drb.getFixedTelephone());
		if(!Util.isNullOrEmpty(drb.getContactAddress()))
			drt.setContactAddress(drb.getContactAddress());
		if(!Util.isNullOrEmpty(drb.getEquipmentPic()))
			drt.setEquipmentPic(drb.getEquipmentPic());*/
		
/*		DemandRentTable drt = new DemandRentTable();*/
		drb.copyPropertyToDestBean(drt);
		
		drt.setUpdateTime(new Date());
		
		BizDataState bds = new BizDataState();
		bds.setDataState(1);//1：待审核，修改之后要求也能再次的审核
		drt.setDataState(bds);
		
//		//设备所在单位非空，就根据单位名称查询出设备所在单位的ID和编码，为了实现搜索页面根据所属单位来查询对应的集合
//		PartyOrg  po=getOrgByName(drt.getEnterpriseName());
//		if(Util.isNotNullOrEmpty(po))
//		{
//			drt.setOriginOrg(po.getPartyId());
//			drt.setOrgCode(po.getCode());
//		}
		drt.setInfoTitlePy(PinyinUtil.getUpperCaseShortPinyin(drt.getInfoTitle()));//信息标题的拼音
		drt.setReleaseDate(new Date());//修改发布信息时要求发布时间也更新
		
		//为统计查询添加的冗余字段
		drt.setStandardNameEx(drt.getStandardName());
		drt.setModelNameEx(drt.getModelName());
		drt.setOnProvinceEx(drt.getOnProvince());
		drt.setOnCityEx(drt.getOnCity());
		drt.setOnDistrictEx(drt.getOnDistrict());
		
		iDemandRentDao.save(drt);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "修改成功.");
		return map;
	}
/*	public Map<String, String> upd(@PathVariable Long id,@RequestBody DemandRentBean drb){
		//获取数据库中需要修改的求租发布信息
		DemandRentTable drt = iDemandRentDao.queryDesc(id);
		
		//判断上传的图片是否修改过
		if(!drt.getEquipmentPic().equals(drb.getEquipmentPic())){
			//将图片从临时目录移动到真实目录
			if(!Util.isNullOrEmpty(drb.getEquipmentPic())){
				String[] fileNames = drb.getEquipmentPic().split(",");
				Util.copyFileToRealPath(tmpInfoFilePath, realInfofilePath, fileNames);
			}
		}
		
		//存储求租发布信息
		if(!Util.isNullOrEmpty(drb.getPriceType()))
			drt.setPriceType(drb.getPriceType());
		if(!Util.isNullOrEmpty(drb.getDetailedDescription()))
			drt.setDetailedDescription(drb.getDetailedDescription());
		if(!Util.isNullOrEmpty(drb.getInfoTitle()))
			drt.setInfoTitle(drb.getInfoTitle());
		if(!Util.isNullOrEmpty(drb.getExpectedAmount()))
			drt.setExpectedAmount(drb.getExpectedAmount());
		if(!Util.isNullOrEmpty(drb.getExpectedDeposit()))
			drt.setExpectedDeposit(drb.getExpectedDeposit());
		if(!Util.isNullOrEmpty(drb.getQuantity()))
			drt.setQuantity(drb.getQuantity());
		if(!Util.isNullOrEmpty(drb.getEnterpriseName()))
			drt.setEnterpriseName(drb.getEnterpriseName());
		if(!Util.isNullOrEmpty(drb.getContactPerson()))
			drt.setContactPerson(drb.getContactPerson());
		if(!Util.isNullOrEmpty(drb.getContactPhone()))
			drt.setContactPhone(drb.getContactPhone());
		if(!Util.isNullOrEmpty(drb.getQqNo()))
			drt.setQqNo(drb.getQqNo());
		if(!Util.isNullOrEmpty(drb.getElectronicMail()))
			drt.setElectronicMail(drb.getElectronicMail());
		if(!Util.isNullOrEmpty(drb.getFixedTelephone()))
			drt.setFixedTelephone(drb.getFixedTelephone());
		if(!Util.isNullOrEmpty(drb.getContactAddress()))
			drt.setContactAddress(drb.getContactAddress());
		if(!Util.isNullOrEmpty(drb.getEquipmentPic()))
			drt.setEquipmentPic(drb.getEquipmentPic());
		drt.setUpdateTime(new Date());
		
		BizDataState bds = new BizDataState();
		bds.setDataState(1);//1：待审核，修改之后要求也能再次的审核
		drt.setDataState(bds);
		
		//设备所在单位非空，就根据单位名称查询出设备所在单位的ID和编码，为了实现搜索页面根据所属单位来查询对应的集合
		PartyOrg  po=getOrgByName(drt.getEnterpriseName());
		if(Util.isNotNullOrEmpty(po))
		{
			drt.setOriginOrg(po.getPartyId());
			drt.setOrgCode(po.getCode());
		}
		
		iDemandRentDao.save(drt);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "修改成功.");
		return map;
	}*/
	
	/**
	 * 删除求租信息
	 * @param id 需要删除的求租信息主键
	 * @return
	 */
	@RequestMapping(value="/BG/DemandRent/{id}",method={RequestMethod.DELETE})
	@Transactional
	public Map<String, String> del(@PathVariable Integer id){
		iDemandRentDao.delete(id);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "删除成功.");
		return map;
	}
	
}
