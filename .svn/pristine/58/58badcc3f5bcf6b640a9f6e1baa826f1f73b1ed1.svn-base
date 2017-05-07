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

import com.hjd.action.bean.DemandSaleBean;
import com.hjd.base.BaseAction;
import com.hjd.dao.IBusPublishInfoDao;
import com.hjd.dao.IDemandSaleDao;
import com.hjd.domain.BizDataState;
import com.hjd.domain.BizProcess;
import com.hjd.domain.BusPublishInfoTable;
import com.hjd.domain.DemandSaleTable;
import com.hjd.domain.PartyOrg;
import com.hjd.util.Util;
import com.hjd.util.pinyin.PinyinUtil;

@RestController
public class DemandSaleAction extends BaseAction{

	@Autowired
	IDemandSaleDao iDemandSaleDao;
	@Autowired
	IBusPublishInfoDao iBusPublishInfoDao;
	@Value("${tmpInfoFilePath}")
	String tmpInfoFilePath="";
	
	@Value("${realInfofilePath}")
	String realInfofilePath="";

	/**
	 * 求购信息查询
	 * @param parms 查询条件
	 * @return
	 */
	@RequestMapping(value="/BG/DemandSale",method={RequestMethod.GET})
/*	public Page<?> queryAll(@RequestParam Map parms){
		DemandSaleSearchBean dssb = new DemandSaleSearchBean();
		Iterator<Entry<String, String>> i = parms.entrySet().iterator();
		Entry<String, String> entry;
		Map<String,Object> map = new HashMap();
		while (i.hasNext()) {
		    entry = i.next();
		    String key = entry.getKey();
		    String value = entry.getValue();
		    if(key.equals("pageNo"))
		    	dssb.setPageNo(Integer.valueOf(value));
		    if(key.equals("pageSize"))
		    	dssb.setPageSize(Integer.valueOf(value));
		}
		return iDemandSaleDao.queryAll(dssb.getPageRequest());
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
		listSql.append("FROM DemandSaleTable  obj ");
		listSql.append("WHERE 1=1 ");
		
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM DemandSaleTable obj ");		
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
			((DemandSaleTable)datas.getContent().get(i)).setAtCityDesc(getRegionNameByRegionId2(((DemandSaleTable)datas.getContent().get(i)).getAtCity()));
		}		
		
		return datas;	
	}
	
	/**
	 * 求购信息明细查询
	 * @param id 求购信息主键
	 * @return
	 */
	@RequestMapping(value="/BG/DemandSale/{id}",method={RequestMethod.GET})
	public DemandSaleTable queryDesc(@PathVariable Long id){
		return iDemandSaleDao.queryDesc(id);
	}
	
	/**
	 * 添加求购信息
	 * @param demandSaleBean 添加的求购信息表单内容
	 * @return
	 */
	@RequestMapping(value="/BG/DemandSale",method={RequestMethod.PUT})
	@Transactional
	public Map<String, String> add(@RequestBody DemandSaleBean demandSaleBean, HttpSession httpSession){
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo"); //用于压力测试，测试完毕需要恢复
		//选择数据状态表信息
		BizDataState bds = new BizDataState();
		bds.setDataState(1);//1：待审核
		
		//存储业务表信息
		BizProcess bp = new BizProcess();
		bp.setBizType(4);//4：求购信息发布
		bp.setBizName("求购信息发布");
		bp.setDefaultProcFlag(false);
		this.insert(bp);
		
		//存储求购发布信息
		DemandSaleTable dst = new DemandSaleTable();
		demandSaleBean.copyPropertyToDestBean(dst);
		dst.setDataState(bds);
//		dst.setProcess(bp);
		dst.setProcessId(bp.getProcessId());
		dst.setDataType(4);//不知道BizExData类里面的 dataType 存什么内容，暂时存成4：求购信息发布
		dst.setReleaseDate(new Date());
		dst.setUpdateTime(new Date());
		dst.setOperateFlag(0);
		
		dst.setManagerId((Long)userMap.get("loginUserId"));//添加发布数据信息的人
//		dst.setManagerId(Long.parseLong("3")); //用于压力测试，测试完毕
		
		dst.setOriginOrg((Long)userMap.get("orgId"));//添加信息发布人的单位id
		dst.setOrgCode((String)userMap.get("orgCode"));//添加信息发布人的单位code
		
		//如果当前登录人有项目，添加信息发布人的项目ID
		if(Util.isNotNullOrEmpty(userMap.get("proId")))
		{
			dst.setProId((Long)userMap.get("proId"));
		}
//		//设备所在单位非空，就根据单位名称查询出设备所在单位的ID和编码，为了实现搜索页面根据所属单位来查询对应的集合
//		PartyOrg  po=getOrgByName(dst.getEnterpriseName());
//		if(Util.isNotNullOrEmpty(po))
//		{
//			dst.setOriginOrg(po.getPartyId());
//			dst.setOrgCode(po.getCode());
//		}
		dst.setInfoTitlePy(PinyinUtil.getUpperCaseShortPinyin(dst.getInfoTitle()));//信息标题的拼音

		//为统计查询添加的冗余字段
		dst.setStandardNameEx(dst.getStandardName());
		dst.setModelNameEx(dst.getModelName());
		dst.setOnProvinceEx(dst.getOnProvince());
		dst.setOnCityEx(dst.getOnCity());
		dst.setOnDistrictEx(dst.getOnDistrict());
		
		iDemandSaleDao.save(dst);
		
		//将图片从临时目录移动到真实目录
		if(!Util.isNullOrEmpty(dst.getEquipmentPic())){
			String[] fileNames = dst.getEquipmentPic().split(",");
			Util.copyFileToRealPath(tmpInfoFilePath, realInfofilePath, fileNames);
		}
		
		//添加我已发布的信息

		BusPublishInfoTable busPublishInfoTable=new BusPublishInfoTable();
		busPublishInfoTable.setDataId(dst.getDataId());
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
	 * 修改求购信息
	 * @param id 需要修改的求购信息主键
	 * @param dsb 需要修改的求购信息表单内容
	 * @return
	 */
	@RequestMapping(value="/BG/DemandSale/{id}",method={RequestMethod.POST})
	@Transactional
	public Map<String, String> upd(@PathVariable Long id,@RequestBody DemandSaleBean dsb){
		//获取数据库中需要修改的求购发布信息
		DemandSaleTable dst = iDemandSaleDao.queryDesc(id);
		
		//判断上传的图片是否修改过
/*		if(!dst.getEquipmentPic().equals(dsb.getEquipmentPic())){
			//将图片从临时目录移动到真实目录
			if(!Util.isNullOrEmpty(dsb.getEquipmentPic())){
				String[] fileNames = dsb.getEquipmentPic().split(",");
				Util.copyFileToRealPath(tmpInfoFilePath, realInfofilePath, fileNames);
			}
		}*/
		
		//存储求购发布信息
/*		if(!Util.isNullOrEmpty(dsb.getPriceType()))
			dst.setPriceType(dsb.getPriceType());
		if(!Util.isNullOrEmpty(dsb.getDetailedDescription()))
			dst.setDetailedDescription(dsb.getDetailedDescription());
		if(!Util.isNullOrEmpty(dsb.getInfoTitle()))
			dst.setInfoTitle(dsb.getInfoTitle());
		if(!Util.isNullOrEmpty(dsb.getExpectedAmount()))
			dst.setExpectedAmount(dsb.getExpectedAmount());
		if(!Util.isNullOrEmpty(dsb.getExpectedDeposit()))
			dst.setExpectedDeposit(dsb.getExpectedDeposit());
		if(!Util.isNullOrEmpty(dsb.getQuantity()))
			dst.setQuantity(dsb.getQuantity());
		if(!Util.isNullOrEmpty(dsb.getEnterpriseName()))
			dst.setEnterpriseName(dsb.getEnterpriseName());
		if(!Util.isNullOrEmpty(dsb.getContactPerson()))
			dst.setContactPerson(dsb.getContactPerson());
		if(!Util.isNullOrEmpty(dsb.getContactPhone()))
			dst.setContactPhone(dsb.getContactPhone());
		if(!Util.isNullOrEmpty(dsb.getQqNo()))
			dst.setQqNo(dsb.getQqNo());
		if(!Util.isNullOrEmpty(dsb.getElectronicMail()))
			dst.setElectronicMail(dsb.getElectronicMail());
		if(!Util.isNullOrEmpty(dsb.getFixedTelephone()))
			dst.setFixedTelephone(dsb.getFixedTelephone());
		if(!Util.isNullOrEmpty(dsb.getContactAddress()))
			dst.setContactAddress(dsb.getContactAddress());
		if(!Util.isNullOrEmpty(dsb.getEquipmentPic()))
			dst.setEquipmentPic(dsb.getEquipmentPic());*/
		
/*		DemandSaleTable dst = new DemandSaleTable();*/
		dsb.copyPropertyToDestBean(dst);
		dst.setUpdateTime(new Date());
		
		BizDataState bds = new BizDataState();
		bds.setDataState(1);//1：待审核，修改之后要求也能再次的审核
		dst.setDataState(bds);
		
//		//设备所在单位非空，就根据单位名称查询出设备所在单位的ID和编码，为了实现搜索页面根据所属单位来查询对应的集合
//		PartyOrg  po=getOrgByName(dst.getEnterpriseName());
//		if(Util.isNotNullOrEmpty(po))
//		{
//			dst.setOriginOrg(po.getPartyId());
//			dst.setOrgCode(po.getCode());
//		}
		dst.setInfoTitlePy(PinyinUtil.getUpperCaseShortPinyin(dst.getInfoTitle()));//信息标题的拼音
		dst.setReleaseDate(new Date());//修改发布信息时要求发布时间也更新
		
		//为统计查询添加的冗余字段
		dst.setStandardNameEx(dst.getStandardName());
		dst.setModelNameEx(dst.getModelName());
		dst.setOnProvinceEx(dst.getOnProvince());
		dst.setOnCityEx(dst.getOnCity());
		dst.setOnDistrictEx(dst.getOnDistrict());
		
		iDemandSaleDao.save(dst);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "修改成功.");
		return map;
	}
	
	/**
	 * 删除求购信息
	 * @param id 需要删除的求购信息主键
	 * @return
	 */
	@RequestMapping(value="/BG/DemandSale/{id}",method={RequestMethod.DELETE})
	@Transactional
	public Map<String, String> del(@PathVariable Integer id){
		iDemandSaleDao.delete(id);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "删除成功.");
		return map;
	}
}
