package com.hjd.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
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

import com.hjd.action.bean.SaleBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IBizExDataDao;
import com.hjd.dao.IBusPublishInfoDao;
import com.hjd.dao.IEquipmentDao;
import com.hjd.dao.ISaleDao;
import com.hjd.domain.BizDataState;
import com.hjd.domain.BizExData;
import com.hjd.domain.BizProcess;
import com.hjd.domain.BusPublishInfoTable;
import com.hjd.domain.EquipmentTable;
import com.hjd.domain.PartyOrg;
import com.hjd.domain.SaleTable;
import com.hjd.util.Util;
import com.hjd.util.pinyin.PinyinUtil;

@RestController
public class SaleAction extends BaseAction{
	@Autowired
	IEquipmentDao iEquipmentDao;//设备资源管理（台账）Dao
	@Autowired
	ISaleDao iSaleDao;
	@Autowired
	IBizExDataDao iBizExDataDao;
	@Autowired
	IBusPublishInfoDao iBusPublishInfoDao;
	@Value("${tmpInfoFilePath}")
	String tmpInfoFilePath="";
	
	@Value("${realInfofilePath}")
	String realInfofilePath="";
	
	/**
	 * 出售信息查询
	 * @param parms 查询条件
	 * @return
	 */
	@RequestMapping(value="/BG/Sale",method={RequestMethod.GET})
/*	public Page<?> queryAll(@RequestParam Map parms){
		SaleSearchBean ssb = new SaleSearchBean();
		Iterator<Entry<String, String>> i = parms.entrySet().iterator();
		Entry<String, String> entry;
		Map<String,Object> map = new HashMap();
		while (i.hasNext()) {
		    entry = i.next();
		    String key = entry.getKey();
		    String value = entry.getValue();
		    if(key.equals("pageNo"))
		    	ssb.setPageNo(Integer.valueOf(value));
		    if(key.equals("pageSize"))
		    	ssb.setPageSize(Integer.valueOf(value));
		}
		return iSaleDao.queryAll(ssb.getPageRequest());
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
		listSql.append("FROM SaleTable  obj ");
		listSql.append("WHERE 1=1 ");
		
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM SaleTable obj ");		
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
			((SaleTable)datas.getContent().get(i)).setAtCityDesc(getRegionNameByRegionId2(((SaleTable)datas.getContent().get(i)).getAtCity()));
		}
		return datas;	
	}
	
	/**
	 * 出售信息明细查询
	 * @param id 出售信息主键
	 * @return
	 */
	@RequestMapping(value="/BG/Sale/{id}",method={RequestMethod.GET})
	public SaleTable queryDesc(@PathVariable Long id){
		return iSaleDao.queryDesc(id);
	}
	
	/**
	 * 添加出售信息
	 * @param saleBean 添加的出售信息表单内容
	 * @return
	 */
	@RequestMapping(value="/BG/Sale",method={RequestMethod.PUT})
	@Transactional
	public Map<String, String> add(@RequestBody SaleBean saleBean ,HttpSession httpSession){
		
		//发布新的出售信息之前，需要判断一下将要出售的设备是否已经发布过出售的信息，并且还没有闭环
		List<BizExData> bizExdataList = iBizExDataDao.queryByEquipmentId(2,saleBean.getEquipmentId(),2);
		if(null!=bizExdataList && bizExdataList.size()>0){throw new IFException("抱歉，此设备的出售发布信息尚未闭环，不能发布新的出售信息");}
		
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo"); //用于压力测试，测试完毕需要恢复
		//选择数据状态表信息
		BizDataState bds = new BizDataState();
		bds.setDataState(1);//1：待审核
		
		//存储业务表信息
		BizProcess bp = new BizProcess();
		bp.setBizType(2);//2：出售信息发布
		bp.setBizName("出售信息发布");
		bp.setDefaultProcFlag(false);
		this.insert(bp);
		
		//选择设备资源
		EquipmentTable et = new EquipmentTable();
		//将设备的发布状态修改为未发布
		et = iEquipmentDao.queryDesc(saleBean.getEquipmentId());
//		et.setPubState(1);
//		iEquipmentDao.save(et);
		
		//存储出售发布信息
		SaleTable st = new SaleTable();
		saleBean.copyPropertyToDestBean(st);
		st.setDataState(bds);
//		st.setProcess(bp);
		st.setProcessId(bp.getProcessId());
		st.setEquipmentTable(et);
		st.setDataType(2);//不知道BizExData类里面的 dataType 存什么内容，暂时存成 2：出售信息发布
		st.setReleaseDate(new Date());
		st.setUpdateTime(new Date());
		st.setOperateFlag(0);
		st.setState(2);//交易状态，初始时为未成交
		
		st.setManagerId((Long)userMap.get("loginUserId"));//添加发布数据信息的人 //用于压力测试，测试完毕
//		st.setManagerId(Long.parseLong("3"));
		
		st.setOriginOrg((Long)userMap.get("orgId"));//添加信息发布人的单位id
		st.setOrgCode((String)userMap.get("orgCode"));//添加信息发布人的单位code
		
		//如果当前登录人有项目，添加信息发布人的项目ID
		if(Util.isNotNullOrEmpty(userMap.get("proId")))
		{
			st.setProId((Long)userMap.get("proId"));
		}
//		//设备所在单位非空，就根据单位名称查询出设备所在单位的ID和编码，为了实现搜索页面根据所属单位来查询对应的集合
//		PartyOrg  po=getOrgByName(st.getEnterpriseName());
//		if(Util.isNotNullOrEmpty(po))
//		{
//			st.setOriginOrg(po.getPartyId());
//			st.setOrgCode(po.getCode());
//		}
		st.setInfoTitlePy(PinyinUtil.getUpperCaseShortPinyin(st.getInfoTitle()));//信息标题的拼音
		st.setEquipmentId(et.getEquipmentId());//添加设备的ID到扩展表中，为了提高发布结果登记的速度
		
		//为统计查询添加的冗余字段
		st.setStandardNameEx(st.getStandardName());
		st.setModelNameEx(st.getModelName());
		st.setOnProvinceEx(st.getOnProvince());
		st.setOnCityEx(st.getOnCity());
		st.setOnDistrictEx(st.getOnDistrict());
		
		iSaleDao.save(st);
		
		//将图片从临时目录移动到真实目录
		if(!Util.isNullOrEmpty(st.getEquipmentPic())){
			String[] fileNames = st.getEquipmentPic().split(",");
			Util.copyFileToRealPath(tmpInfoFilePath, realInfofilePath, fileNames);
		}
		
		//添加我已发布的信息

		BusPublishInfoTable busPublishInfoTable=new BusPublishInfoTable();
		busPublishInfoTable.setDataId(st.getDataId());
		busPublishInfoTable.setOperateFlag(0);
		busPublishInfoTable.setOperateDate(new Date());
		busPublishInfoTable.setLoginUserId((Long)userMap.get("loginUserId")); //用于压力测试，测试完毕
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
	 * 修改出售信息
	 * @param id 需要修改的出售信息主键
	 * @param saleBean 需要修改的出售信息表单内容
	 * @return
	 */
	@RequestMapping(value="/BG/Sale/{id}",method={RequestMethod.POST})
	@Transactional
	public Map<String, String> upd(@PathVariable Long id,@RequestBody SaleBean saleBean){
		//获取数据库中需要修改的出售发布信息
		SaleTable st = iSaleDao.queryDesc(id);
		
		//判断上传的图片是否修改过
		if(!st.getEquipmentPic().equals(saleBean.getEquipmentPic())){
			//将图片从临时目录移动到真实目录
			if(!Util.isNullOrEmpty(saleBean.getEquipmentPic())){
				String[] fileNames = saleBean.getEquipmentPic().split(",");
				Util.copyFileToRealPath(tmpInfoFilePath, realInfofilePath, fileNames);
			}
		}
		
		//存储出售发布信息
/*		if(!Util.isNullOrEmpty(saleBean.getDetailedDescription()))
			st.setDetailedDescription(saleBean.getDetailedDescription());*/
		
		/*if(!Util.isNullOrEmpty(saleBean.getEquipmentId()))
			st.getEquipmentTable().setEquipmentId(saleBean.getEquipmentId());
			st.setEquipmentTable(st.getEquipmentTable());*/
			
		if(!Util.isNullOrEmpty(saleBean.getEquipmentId()))
		{
			EquipmentTable et = new EquipmentTable();
			et.setEquipmentId(saleBean.getEquipmentId());
			st.setEquipmentTable(et);
		}
		
			
/*		if(!Util.isNullOrEmpty(saleBean.getInfoTitle()))
			st.setInfoTitle(saleBean.getInfoTitle());
		if(!Util.isNullOrEmpty(saleBean.getPrice()))
			st.setPrice(saleBean.getPrice());
		if(!Util.isNullOrEmpty(saleBean.getPriceType()))
			st.setPriceType(saleBean.getPriceType());
		if(!Util.isNullOrEmpty(saleBean.getShortestLease()))
			st.setShortestLease(saleBean.getShortestLease());
		if(!Util.isNullOrEmpty(saleBean.getEnterpriseName()))
			st.setEnterpriseName(saleBean.getEnterpriseName());
		if(!Util.isNullOrEmpty(saleBean.getContactPerson()))
			st.setContactPerson(saleBean.getContactPerson());
		if(!Util.isNullOrEmpty(saleBean.getContactPhone()))
			st.setContactPhone(saleBean.getContactPhone());
		if(!Util.isNullOrEmpty(saleBean.getQqNo()))
			st.setQqNo(saleBean.getQqNo());
		if(!Util.isNullOrEmpty(saleBean.getElectronicMail()))
			st.setElectronicMail(saleBean.getElectronicMail());
		if(!Util.isNullOrEmpty(saleBean.getFixedTelephone()))
			st.setFixedTelephone(saleBean.getFixedTelephone());
		if(!Util.isNullOrEmpty(saleBean.getContactAddress()))
			st.setContactAddress(saleBean.getContactAddress());
		if(!Util.isNullOrEmpty(saleBean.getEquipmentPic()))
			st.setEquipmentPic(saleBean.getEquipmentPic());*/
		
		saleBean.copyPropertyToDestBean(st);
		
		st.setUpdateTime(new Date());
		
		BizDataState bds = new BizDataState();
		bds.setDataState(1);//1：待审核，修改之后要求也能再次的审核
		st.setDataState(bds);
		
//		//设备所在单位非空，就根据单位名称查询出设备所在单位的ID和编码，为了实现搜索页面根据所属单位来查询对应的集合
//		PartyOrg  po=getOrgByName(st.getEnterpriseName());
//		if(Util.isNotNullOrEmpty(po))
//		{
//			st.setOriginOrg(po.getPartyId());
//			st.setOrgCode(po.getCode());
//		}
		st.setInfoTitlePy(PinyinUtil.getUpperCaseShortPinyin(st.getInfoTitle()));//信息标题的拼音
		st.setEquipmentId(st.getEquipmentTable().getEquipmentId());//添加设备的ID到扩展表中，为了提高发布结果登记的速度
		st.setReleaseDate(new Date());//修改发布信息时要求发布时间也更新
		
		//为统计查询添加的冗余字段
		st.setStandardNameEx(st.getStandardName());
		st.setModelNameEx(st.getModelName());
		st.setOnProvinceEx(st.getOnProvince());
		st.setOnCityEx(st.getOnCity());
		st.setOnDistrictEx(st.getOnDistrict());
		
		iSaleDao.save(st);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "修改成功.");
		return map;
	}
	
	/**
	 * 删除出售信息
	 * @param id 需要删除的出售信息主键
	 * @return
	 */
	@RequestMapping(value="/BG/Sale/{id}",method={RequestMethod.DELETE})
	@Transactional
	public Map<String, String> del(@PathVariable Integer id){
		iSaleDao.delete(id);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "删除成功.");
		return map;
	}

}
