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

import com.hjd.action.bean.RentBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IBizExDataDao;
import com.hjd.dao.IBusPublishInfoDao;
import com.hjd.dao.IEquipmentDao;
import com.hjd.dao.IRentDao;
import com.hjd.domain.BizDataState;
import com.hjd.domain.BizExData;
import com.hjd.domain.BizProcess;
import com.hjd.domain.BusPublishInfoTable;
import com.hjd.domain.EquipmentTable;
import com.hjd.domain.PartyOrg;
import com.hjd.domain.RentTable;
import com.hjd.util.Util;
import com.hjd.util.pinyin.PinyinUtil;

@RestController
public class RentAction extends BaseAction{
	@Autowired
	IEquipmentDao iEquipmentDao;//设备资源管理（台账）Dao
	@Autowired
	IRentDao iRentDao;
	@Autowired
	IBizExDataDao iBizExDataDao;
	@Autowired
	IBusPublishInfoDao iBusPublishInfoDao;
	@Value("${tmpInfoFilePath}")
	String tmpInfoFilePath="";
	
	@Value("${realInfofilePath}")
	String realInfofilePath="";
	
	/**
	 * 出租信息查询
	 * @param parms 查询条件
	 * @return
	 */
	@RequestMapping(value="/BG/Rent",method={RequestMethod.GET})
/*	public Page<?> queryAll(@RequestParam Map parms){
		RentSearchBean rsb = new RentSearchBean();
		Iterator<Entry<String, String>> i = parms.entrySet().iterator();
		Entry<String, String> entry;
		Map<String,Object> map = new HashMap();
		while (i.hasNext()) {
		    entry = i.next();
		    String key = entry.getKey();
		    String value = entry.getValue();
		    if(key.equals("pageNo"))
		    	rsb.setPageNo(Integer.valueOf(value));
		    if(key.equals("pageSize"))
		    	rsb.setPageSize(Integer.valueOf(value));
		}
		return iRentDao.queryAll(rsb.getPageRequest());
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
		listSql.append("FROM RentTable  obj ");
		listSql.append("WHERE 1=1 ");
		
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM RentTable obj ");		
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
			((RentTable)datas.getContent().get(i)).setAtCityDesc(getRegionNameByRegionId2(((RentTable)datas.getContent().get(i)).getAtCity()));
		}
		return datas;	
	}
	
	/**
	 * 出租信息明细查询
	 * @param id 出租信息主键
	 * @return
	 */
	@RequestMapping(value="/BG/Rent/{id}",method={RequestMethod.GET})
	public RentTable queryDesc(@PathVariable Long id){
		return iRentDao.queryDesc(id);
	}
	
	/**
	 * 添加出租信息
	 * @param rentBean 添加的出租信息表单内容
	 * @return
	 */
	@RequestMapping(value="/BG/Rent",method={RequestMethod.PUT})
	@Transactional
	public Map<String, String> add(@RequestBody RentBean rentBean ,HttpSession httpSession){
		
		
		//发布新的出租信息之前，需要判断一下将要出租的设备是否已经发布过出租的信息，并且还没有闭环
		List<BizExData> bizExdataList = iBizExDataDao.queryByEquipmentId(1,rentBean.getEquipmentId(),2);
		if(null!=bizExdataList && bizExdataList.size()>0){throw new IFException("抱歉，此设备的出租发布信息尚未闭环，不能发布新的出租信息");}
		
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo"); //用于压力测试，测试完毕需要恢复
		//选择数据状态表信息
		BizDataState bds = new BizDataState();
		bds.setDataState(1);//1：待审核
		
		//存储业务表信息
		BizProcess bp = new BizProcess();
		bp.setBizType(1);//1：出租信息发布
		bp.setBizName("出租信息发布");
		bp.setDefaultProcFlag(false);
		this.insert(bp);
		
		//选择设备资源
		EquipmentTable et = new EquipmentTable();
		//将设备的发布状态修改为未发布
		et = iEquipmentDao.queryDesc(rentBean.getEquipmentId());
//		et.setPubState(1);
//		iEquipmentDao.save(et);
		
		//存储出租发布信息
		RentTable rt = new RentTable();
		rentBean.copyPropertyToDestBean(rt);
		rt.setDataState(bds);
//		rt.setProcess(bp);
		rt.setProcessId(bp.getProcessId());
		rt.setEquipmentTable(et);
		rt.setDataType(1);//不知道BizExData类里面的 dataType 存什么内容，暂时存成 1：出租信息发布
		rt.setReleaseDate(new Date());
		rt.setUpdateTime(new Date());
		rt.setOperateFlag(0);
		rt.setState(2);//交易状态，初始时为未成交
		
		rt.setManagerId((Long)userMap.get("loginUserId"));//添加发布数据信息的人 //用于压力测试，测试完毕
//		rt.setManagerId(Long.parseLong("3"));
		
		rt.setOriginOrg((Long)userMap.get("orgId"));//添加信息发布人的单位id
		rt.setOrgCode((String)userMap.get("orgCode"));//添加信息发布人的单位code
		
		//如果当前登录人有项目，添加信息发布人的项目ID
		if(Util.isNotNullOrEmpty(userMap.get("proId")))
		{
			rt.setProId((Long)userMap.get("proId"));
		}
//		//设备所在单位非空，就根据单位名称查询出设备所在单位的ID和编码，为了实现搜索页面根据所属单位来查询对应的集合
//		PartyOrg  po=getOrgByName(rt.getEnterpriseName());
//		if(Util.isNotNullOrEmpty(po))
//		{
//			rt.setOriginOrg(po.getPartyId());
//			rt.setOrgCode(po.getCode());
//		}
		rt.setInfoTitlePy(PinyinUtil.getUpperCaseShortPinyin(rt.getInfoTitle()));//信息标题的拼音
		rt.setEquipmentId(et.getEquipmentId());//添加设备的ID到扩展表中，为了提高发布结果登记的速度
		
		//为统计查询添加的冗余字段
		rt.setStandardNameEx(rt.getStandardName());
		rt.setModelNameEx(rt.getModelName());
		rt.setOnProvinceEx(rt.getOnProvince());
		rt.setOnCityEx(rt.getOnCity());
		rt.setOnDistrictEx(rt.getOnDistrict());
		
		iRentDao.save(rt);
		
		//将图片从临时目录移动到真实目录
		if(!Util.isNullOrEmpty(rt.getEquipmentPic())){
			String[] fileNames = rt.getEquipmentPic().split(",");
			Util.copyFileToRealPath(tmpInfoFilePath, realInfofilePath, fileNames);
		}
		//添加我已发布的信息

		BusPublishInfoTable busPublishInfoTable=new BusPublishInfoTable();
		busPublishInfoTable.setDataId(rt.getDataId());
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
	 * 修改出租信息
	 * @param id 需要修改的出租信息主键
	 * @param rb 需要修改的出租信息表单内容
	 * @return
	 */
	@RequestMapping(value="/BG/Rent/{id}",method={RequestMethod.POST})
	@Transactional
	public Map<String, String> upd(@PathVariable Long id,@RequestBody RentBean rb){
		//获取数据库中需要修改的出租发布信息
		RentTable rt = iRentDao.queryDesc(id);
		
		//判断上传的图片是否修改过
		if(!rb.getEquipmentPic().equals(rt.getEquipmentPic())){
			//将图片从临时目录移动到真实目录
			if(!Util.isNullOrEmpty(rb.getEquipmentPic())){
				String[] fileNames = rb.getEquipmentPic().split(",");
				Util.copyFileToRealPath(tmpInfoFilePath, realInfofilePath, fileNames);
			}
		}

		//存储出租发布信息
/*		if(!Util.isNullOrEmpty(rb.getDetailedDescription()))
			rt.setDetailedDescription(rb.getDetailedDescription());*/
		
		/*  if(!Util.isNullOrEmpty(rb.getEquipmentId()))
			rt.getEquipmentTable().setEquipmentId(rb.getEquipmentId());
			rt.setEquipmentTable(rt.getEquipmentTable());*/
		
		if(!Util.isNullOrEmpty(rb.getEquipmentId()))
		{
			EquipmentTable et = new EquipmentTable();
			et.setEquipmentId(rb.getEquipmentId());
			rt.setEquipmentTable(et);
		}
			
/*		if(!Util.isNullOrEmpty(rb.getInfoTitle()))
			rt.setInfoTitle(rb.getInfoTitle());
		if(!Util.isNullOrEmpty(rb.getPrice()))
			rt.setPrice(rb.getPrice());
		if(!Util.isNullOrEmpty(rb.getPriceType()))
			rt.setPriceType(rb.getPriceType());
		if(!Util.isNullOrEmpty(rb.getShortestLease()))
			rt.setShortestLease(rb.getShortestLease());
		if(!Util.isNullOrEmpty(rb.getEnterpriseName()))
			rt.setEnterpriseName(rb.getEnterpriseName());
		if(!Util.isNullOrEmpty(rb.getContactPerson()))
			rt.setContactPerson(rb.getContactPerson());
		if(!Util.isNullOrEmpty(rb.getContactPhone()))
			rt.setContactPhone(rb.getContactPhone());
		if(!Util.isNullOrEmpty(rb.getQqNo()))
			rt.setQqNo(rb.getQqNo());
		if(!Util.isNullOrEmpty(rb.getElectronicMail()))
			rt.setElectronicMail(rb.getElectronicMail());
		if(!Util.isNullOrEmpty(rb.getFixedTelephone()))
			rt.setFixedTelephone(rb.getFixedTelephone());
		if(!Util.isNullOrEmpty(rb.getContactAddress()))
			rt.setContactAddress(rb.getContactAddress());
		if(!Util.isNullOrEmpty(rb.getEquipmentPic()))
			rt.setEquipmentPic(rb.getEquipmentPic());*/
		
		rb.copyPropertyToDestBean(rt);
		
		rt.setUpdateTime(new Date());
		
		BizDataState bds = new BizDataState();
		bds.setDataState(1);//1：待审核，修改之后要求也能再次的审核
		rt.setDataState(bds);
		
		
//		//设备所在单位非空，就根据单位名称查询出设备所在单位的ID和编码，为了实现搜索页面根据所属单位来查询对应的集合
//		
//		PartyOrg  po=getOrgByName(rt.getEnterpriseName());
//		if(Util.isNotNullOrEmpty(po))
//		{
//			rt.setOriginOrg(po.getPartyId());
//			rt.setOrgCode(po.getCode());
//		}
		rt.setInfoTitlePy(PinyinUtil.getUpperCaseShortPinyin(rt.getInfoTitle()));//信息标题的拼音
		rt.setEquipmentId(rt.getEquipmentTable().getEquipmentId());//添加设备的ID到扩展表中，为了提高发布结果登记的速度
		rt.setReleaseDate(new Date());//修改发布信息时要求发布时间也更新
		
		//为统计查询添加的冗余字段
		rt.setStandardNameEx(rt.getStandardName());
		rt.setModelNameEx(rt.getModelName());
		rt.setOnProvinceEx(rt.getOnProvince());
		rt.setOnCityEx(rt.getOnCity());
		rt.setOnDistrictEx(rt.getOnDistrict());
		
		iRentDao.save(rt);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "修改成功.");
		return map;
	}
	
	/**
	 * 删除出租信息
	 * @param id 需要删除的出租信息主键
	 * @return
	 */
	@RequestMapping(value="/BG/Rent/{id}",method={RequestMethod.DELETE})
	@Transactional
	public Map<String, String> del(@PathVariable Integer id){
		iRentDao.delete(id);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "删除成功.");
		return map;
	}
}
