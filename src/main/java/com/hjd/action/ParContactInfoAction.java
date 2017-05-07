package com.hjd.action;

import java.util.HashMap;
import java.util.Map;




import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.ParContactInfoBean;
import com.hjd.action.bean.ParContactInfoSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.IParContactInfoDao;
import com.hjd.domain.ParContactInfoTable;
import com.hjd.util.Util;

@RestController
public class ParContactInfoAction extends BaseAction{
	@Autowired
	IParContactInfoDao iBusContactInfoDao;

	//1：查询当前登录人也就是供应商对应的联系人列表
	/**
	 * 查询当前登录人，主要是供应商对应的联系人集合
	 * @param parContactInfoSearchBean
	 * @return
	 */
	@RequestMapping(value="/BG/Party/ContactInfo", method={RequestMethod.POST})
	public Page<?> searchAll(@RequestBody ParContactInfoSearchBean parContactInfoSearchBean,HttpSession httpSession) 
	{
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
		parContactInfoSearchBean.setCurrOrgId((Long)userMap.get("perPartyId"));
//		parContactInfoSearchBean.setCurrOrgId(Long.parseLong("330"));
		
		Long currOrgId = parContactInfoSearchBean.getCurrOrgId();
		if(currOrgId==null){throw new IFException("当前查询当事人标识不能为空");}
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT obj ");
		listSql.append("FROM ParContactInfoTable  obj ");
		listSql.append("WHERE 1=1 ");
		
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM ParContactInfoTable obj ");		
		countSql.append("WHERE 1=1 ");
		
		listSql.append(" AND obj.partyId = ").append(currOrgId);
		countSql.append(" AND obj.partyId = ").append(currOrgId);

		if(Util.isNotNullOrEmpty(parContactInfoSearchBean.getDefConFlag())){
			listSql.append(" and obj.defConFlag=").append(parContactInfoSearchBean.getDefConFlag());
			countSql.append(" and obj.defConFlag=").append(parContactInfoSearchBean.getDefConFlag());
		}

		//排序，将对应的默认联系人放在第一位
		listSql.append(" ORDER BY  obj.defConFlag DESC ");
		
		Map<String,Object> params = new HashMap<String,Object>();
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),params,parContactInfoSearchBean.getPageRequest());

		return datas;
	}
	//2：添加联系人的信息
	/**
	 * 添加联系人信息，如果添加的是默认的，就将其他默认的置为非默认的
	 * @param parContactInfoBean
	 * @return
	 */
	@RequestMapping(value="/BG/Party/ContactInfo", method={RequestMethod.PUT})
	@Transactional
	public Map<String, String> addContactInfo(@RequestBody ParContactInfoBean parContactInfoBean,HttpSession httpSession) 
	{
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
		parContactInfoBean.setPartyId((Long)userMap.get("perPartyId")); // 压力测试，测试完毕需要恢复
//		parContactInfoBean.setPartyId(Long.parseLong("330"));
		
		//	1-校验联系人信息
		Long partyId = parContactInfoBean.getPartyId();
		/*if(partyId==null){throw new IFException("发布单位不能为空");}*/
		
		String partyName = parContactInfoBean.getPartyName();
		verifyNotEmpty(partyName,"联系单位");
/*		Long atCity = parContactInfoBean.getAtCity();
		verifyNotEmpty(atCity,"所在城市");*/
		String name = parContactInfoBean.getName();
		verifyNotEmpty(name,"联系人");
		String tel = parContactInfoBean.getTel();
		verifyNotEmpty(tel,"联系电话");

		// 2判断添加的联系人信息是否为默认联系方式，如果是，则将其他已有的联系方式置为非默认的
		Integer dcf=parContactInfoBean.getDefConFlag();
		if(dcf==1)
		{
			iBusContactInfoDao.updateByPartyId(partyId);
		}
		//	3-添加联系人信息
		ParContactInfoTable parContactInfoTable = new ParContactInfoTable();
		parContactInfoBean.copyPropertyToDestBean(parContactInfoTable);
		
		insert(parContactInfoTable);

		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "联系方式保存成功");
		return map;
	 }	
	//3：修改联系人的信息
	@RequestMapping(value="/BG/Party/ContactInfo/{id}", method={RequestMethod.POST})
	@Transactional
	public Map<String, String> modifyPartyEnt(@PathVariable Long id, @RequestBody ParContactInfoBean parContactInfoBean,HttpSession httpSession)
	{
		Map<?, ?> userMap=(Map<?, ?>)httpSession.getAttribute("userInfo");
		parContactInfoBean.setPartyId((Long)userMap.get("perPartyId"));
		//	1-校验联系人信息
		String partyName = parContactInfoBean.getPartyName();
		verifyNotEmpty(partyName,"联系单位");
	/*	Long atCity = parContactInfoBean.getAtCity();
		verifyNotEmpty(atCity,"所在城市");*/
		String name = parContactInfoBean.getName();
		verifyNotEmpty(name,"联系人");
		String tel = parContactInfoBean.getTel();
		verifyNotEmpty(tel,"联系电话");

		// 2判断添加的联系人信息是否为默认联系方式，如果是，则将其他已有的联系方式置为非默认的
		Integer dcf=parContactInfoBean.getDefConFlag();
		if(dcf==1)
		{
			iBusContactInfoDao.updateByPartyId(parContactInfoBean.getPartyId());
		}
		//	3-添加联系人信息
		ParContactInfoTable parContactInfoTable =iBusContactInfoDao.queryDesc(id);
		parContactInfoTable.setAddress(parContactInfoBean.getAddress());
		/*parContactInfoTable.setAtCity(atCity);*/
		parContactInfoTable.setDefConFlag(parContactInfoBean.getDefConFlag());
		parContactInfoTable.setName(name);
		parContactInfoTable.setPartyName(partyName);
		parContactInfoTable.setQq(parContactInfoBean.getQq());
		parContactInfoTable.setTel(parContactInfoBean.getTel());
		
		parContactInfoTable.setOnProvince(parContactInfoBean.getOnProvince());
		parContactInfoTable.setOnCity(parContactInfoBean.getOnCity());
		parContactInfoTable.setOnDistrict(parContactInfoBean.getOnDistrict());
		parContactInfoTable.setOnProvinceId(parContactInfoBean.getOnProvinceId());
		parContactInfoTable.setOnCityId(parContactInfoBean.getOnCityId());
		parContactInfoTable.setOnDistrictId(parContactInfoBean.getOnDistrictId());

		iBusContactInfoDao.save(parContactInfoTable);

		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "修改成功");
		return map;
		}
	
	//4：删除联系人的信息
	/**
	 * 删除联系人信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/BG/Party/ContactInfo/{id}", method={RequestMethod.DELETE})
	@Transactional
	public Map<String, String> deleteContactInfo(@PathVariable Long id)
	{
		ParContactInfoTable pcit = new ParContactInfoTable();
		pcit.setContactId(id);
		iBusContactInfoDao.delete(pcit);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "删除成功");
		return map;
	 }
	
	//4：获取联系人的信息信息，主要用于修改
	/**
	 * 获取联系人的信息信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/BG/Party/ContactInfo/{id}", method={RequestMethod.GET})
	public Map<String, Object> queryContactInfo(@PathVariable Long id)
	{
		ParContactInfoTable parContactInfoTable =iBusContactInfoDao.queryDesc(id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("contactInfo", parContactInfoTable);
		return map;
	 }
}
