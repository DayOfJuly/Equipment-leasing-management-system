package com.hjd.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hjd.action.bean.CategoryBean;
import com.hjd.action.bean.CategorySearchBean;
import com.hjd.action.bean.EquCategoryBean;
import com.hjd.action.bean.EquCategorySearchBean;
import com.hjd.action.bean.EquNameBean;
import com.hjd.action.bean.EquNameSearchBean;
import com.hjd.base.BaseAction;
import com.hjd.base.IFException;
import com.hjd.dao.ICategoryDao;
import com.hjd.dao.IEquipmentCategoryDao;
import com.hjd.domain.CategoryTable;
import com.hjd.domain.EquCategoryManageTable;
import com.hjd.domain.EquNameManageTable;
import com.hjd.domain.EquipmentCategoryTable;
import com.hjd.util.Util;

@RestController
public class BusCategoryAction extends BaseAction{
	
	@Autowired
	ICategoryDao iCategoryDao;

	@Autowired
	IEquipmentCategoryDao iEquipmentCategoryDao;
	
	/**
	 * 机械设备分类查询-查询全部信息
	 * @return Page<?>
	 */
	@RequestMapping(value="/BG/Category",method={RequestMethod.GET},params={"Action=All"})
/*	public Page<?> queryAll(@RequestParam Map parms){
		CategorySearchBean cs = new CategorySearchBean();
		Iterator<Entry<String, String>> i = parms.entrySet().iterator();
		Entry<String, String> entry;
		while (i.hasNext()) {
		    entry = i.next();
		    String key = entry.getKey();
		    String value = entry.getValue();
		    if(key.equals("pageNo"))
		    	cs.setPageNo(Integer.valueOf(value));
		    if(key.equals("pageSize"))
		    	cs.setPageSize(Integer.valueOf(value));
		}
		return iCategoryDao.queryAll(cs.getPageRequest());
	}*/
	public Page<?> queryAll(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		CategorySearchBean pageParams = new CategorySearchBean();
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageParams.setPageNo(Integer.valueOf((String)reqParamsMap.get("pageNo")));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageParams.setPageSize(Integer.valueOf((String)reqParamsMap.get("pageSize")));
		}
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT obj ");
		listSql.append("FROM CategoryTable  obj ");
		listSql.append("WHERE 1=1 ");
	    
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM CategoryTable obj ");		
		countSql.append("WHERE 1=1 ");
		
		String relationType=(String)reqParamsMap.get("relationType");
		if(Util.isNotNullOrEmpty(relationType))
		{
			Integer relationType_=Integer.valueOf(relationType);
			sqlParamsMap.put("relationType",relationType_);
			listSql.append(" AND ( obj.relationType = :relationType)");
			countSql.append(" AND ( obj.relationType = :relationType)");
		}
		
		if(Util.isNotNullOrEmpty(reqParamsMap.get("searchParam")))
		{
			sqlParamsMap.put("searchParam", "%"+reqParamsMap.get("searchParam")+"%");
			listSql.append(" AND ( obj.typeNo LIKE :searchParam");
			countSql.append(" AND ( obj.typeNo LIKE :searchParam");

			listSql.append(" OR obj.equCategory.equipmentCategoryName LIKE :searchParam");
			countSql.append(" OR obj.equCategory.equipmentCategoryName LIKE :searchParam");

			listSql.append(" OR obj.equName.equipmentName LIKE :searchParam )");
			countSql.append(" OR obj.equName.equipmentName LIKE :searchParam )");
		}
		//设备分类
		if(Util.isNotNullOrEmpty(reqParamsMap.get("equCategoryId")))
		{
			sqlParamsMap.put("equCategoryId",Integer.parseInt(Util.toStringAndTrim(reqParamsMap.get("equCategoryId"))));
			listSql.append(" AND obj.equCategory.equCategoryId=:equCategoryId ");
			countSql.append(" AND obj.equCategory.equCategoryId=:equCategoryId ");
		}
		//设备名称
		if(Util.isNotNullOrEmpty(reqParamsMap.get("equNameId")))
		{
			sqlParamsMap.put("equNameId",reqParamsMap.get("equNameId"));
			listSql.append(" and obj.equName.equNameId = :equNameId ");
			countSql.append(" and obj.equName.equNameId = :equNameId ");
		}
		
/*		if(Util.isNotNullOrEmpty(reqParamsMap.get("typeNo")))
		{
			sqlParamsMap.put("typeNo", "%"+reqParamsMap.get("typeNo")+"%");
			listSql.append(" AND obj.typeNo LIKE :typeNo");
			countSql.append(" AND obj.typeNo LIKE :typeNo");
		}
		
		if(Util.isNotNullOrEmpty(reqParamsMap.get("equipmentCategoryName")))
		{
			sqlParamsMap.put("equipmentCategoryName", "%"+reqParamsMap.get("equipmentCategoryName")+"%");
			listSql.append(" AND obj.equipmentCategoryName LIKE :equipmentCategoryName");
			countSql.append(" AND obj.equipmentCategoryName LIKE :equipmentCategoryName");
		}*/
		
		if(Util.isNotNullOrEmpty(reqParamsMap.get("equipmentName")))
		{
			sqlParamsMap.put("equipmentName", "%"+reqParamsMap.get("equipmentName")+"%");
			listSql.append(" AND obj.equName.equipmentName LIKE :equipmentName");
			countSql.append(" AND obj.equName.equipmentName LIKE :equipmentName");
		}

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageParams.getPageRequest());
		
		return datas;	
	}
	
	
	/**
	 * 机械设备分类查询-根据设备类型和设备名称来查询对应的结果集
	 * @return Page<?>
	 */
	@RequestMapping(value="/BG/Category",method={RequestMethod.GET},params={"Action=ByEquCategoryName"})
	public Page<?> queryByEquCategoryName(@RequestParam Map<?, ?> reqParamsMap)
	{
		//传递分页参数的载体
		CategorySearchBean pageParams = new CategorySearchBean();
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap<String, Object>();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageParams.setPageNo(Integer.valueOf((String)reqParamsMap.get("pageNo")));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageParams.setPageSize(Integer.valueOf((String)reqParamsMap.get("pageSize")));
		}
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT obj ");
		listSql.append("FROM CategoryTable  obj ");
		listSql.append("WHERE 1=1 ");
	    
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM CategoryTable obj ");		
		countSql.append("WHERE 1=1 ");
		
		String relationType=(String)reqParamsMap.get("relationType");
		if(Util.isNotNullOrEmpty(relationType))
		{
			Integer relationType_=Integer.valueOf(relationType);
			sqlParamsMap.put("relationType",relationType_);
			listSql.append(" AND ( obj.relationType = :relationType)");
			countSql.append(" AND ( obj.relationType = :relationType)");
		}
		String equCategoryId=(String)reqParamsMap.get("equCategoryId");
		if(Util.isNotNullOrEmpty(equCategoryId))
		{
			Integer equCategoryId_=Integer.valueOf(equCategoryId);
			sqlParamsMap.put("equCategoryId",equCategoryId_);
			listSql.append(" AND obj.equCategory.equCategoryId = :equCategoryId");
			countSql.append(" AND obj.equCategory.equCategoryId = :equCategoryId");
		}
		String equNameId=(String)reqParamsMap.get("equNameId");
		if(Util.isNotNullOrEmpty(equNameId))
		{
			Integer equNameId_=Integer.valueOf(equNameId);
			sqlParamsMap.put("equNameId",equNameId_);
			listSql.append(" AND obj.equName.equNameId = :equNameId )");
			countSql.append(" AND obj.equName.equNameId = :equNameId )");
		}
		String equipmentName=(String)reqParamsMap.get("equipmentName");
		if(Util.isNotNullOrEmpty(equipmentName))
		{
			sqlParamsMap.put("equipmentName","%"+equipmentName+"%");
			listSql.append(" AND obj.equName.equipmentName LIKE :equipmentName )");
			countSql.append(" AND obj.equName.equipmentName LIKE :equipmentName )");
		}

		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageParams.getPageRequest());
		
		return datas;	
	}
	
	
	
	/**
	 * 机械设备分类查询-查询明细信息
	 * @return CategoryTable
	 */
	@RequestMapping(value="/BG/Category/{id}",method={RequestMethod.GET})
	public CategoryTable queryDesc(@PathVariable Integer id){
		return iCategoryDao.queryDesc(id);
	}
	
	/**
	 * 根据设备类别ID获取设备类别
	 * @author Q
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/BG/Category/{id}",method={RequestMethod.GET},params={"Action=EquCategoryId"})
	public EquCategoryManageTable queryEquCategoryManageTable(@PathVariable Integer id){
		return iCategoryDao.queryByEquCategoryId(id);
	}
	
	/**
	 * 根据设备名称ID获取设备名称
	 * @author Q
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/BG/Category/{id}",method={RequestMethod.GET},params={"Action=EquNameId"})
	public EquNameManageTable queryEquNameManageTable(@PathVariable Integer id){
		return iCategoryDao.queryByEquNameId(id);
	}
	

	
	/**
	 * 机械设备分类-添加
	 * @param categoryBean 传入表单对象
	 * @return Map
	 */
	@RequestMapping(value="/BG/Category",method={RequestMethod.PUT})
	@Transactional
	public Map<String, String> add(@RequestBody CategoryBean categoryBean){
		CategoryTable ct = new CategoryTable();
		categoryBean.copyPropertyToDestBean(ct);
		
		EquCategoryManageTable ec=new EquCategoryManageTable();
		ec.setEquCategoryId(categoryBean.getEquCategoryId());
		ct.setEquCategory(ec);
		
		EquNameManageTable en=new EquNameManageTable();
		en.setEquNameId(categoryBean.getEquNameId());
		ct.setEquName(en);
		
		ct.setRelationType(2);//关系类型 1：代表默认的关系，一个大类对应多个小类 。2：新建的关系一个大类和其对应的某个小类对应的关系
		
		iCategoryDao.save(ct);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "添加成功.");
		return map;
	}
	
	/**
	 * 机械设备分类-修改
	 * @param categoryBean 传入表单对象
	 * @return Map
	 */
	@RequestMapping(value="/BG/Category/{id}",method={RequestMethod.POST})
	@Transactional
	public Map<String, String> upd(@PathVariable Integer id,@RequestBody CategoryBean categoryBean){
		
		CategoryTable ct =queryDesc(id);
		
		EquCategoryManageTable ec=new EquCategoryManageTable();
		ec.setEquCategoryId(categoryBean.getEquCategoryId());
		ct.setEquCategory(ec);
		
		EquNameManageTable en=new EquNameManageTable();
		en.setEquNameId(categoryBean.getEquNameId());
		ct.setEquName(en);
		
		iCategoryDao.save(ct);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "修改成功.");
		return map;
	}
	
	/**
	 * 机械设备分类-删除
	 * @return Map
	 */
	@RequestMapping(value="/BG/Category/{id}",method={RequestMethod.DELETE})
	@Transactional
	public Map<String, String> del(@PathVariable Integer id){
		
		//先判断是否作为主外键，然后再决定是否能执行删除操作
		List<EquipmentCategoryTable> ects=iEquipmentCategoryDao.queryByCategory(id);
		if(ects!=null && ects.size()>0)
		{
			throw new IFException("此机械设备分类已使用，不允许删除！");
		}
		iCategoryDao.delete(id);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "删除成功.");
		return map;
	}
	
	/**
	 * 设备分类-查询全部信息
	 * @return Page<?>
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/BG/Category",method={RequestMethod.GET},params={"Action=EquCategory"})
	public Page<?> queryEquCategory(@RequestParam Map parms){
		EquCategorySearchBean ecs = new EquCategorySearchBean();
		Iterator<Entry<String, String>> i = parms.entrySet().iterator();
		Entry<String, String> entry;
		while (i.hasNext()) {
		    entry = i.next();
		    String key = entry.getKey();
		    String value = entry.getValue();
		    if(key.equals("pageNo"))
		    	ecs.setPageNo(Integer.valueOf(value));
		    if(key.equals("pageSize"))
		    	ecs.setPageSize(Integer.valueOf(value));
		}
		return iCategoryDao.queryEquCategory(ecs.getPageRequest());
	}
	
	/**
	 * 设备分类-添加
	 * @param equCategoryBean 传入表单对象
	 * @return Map
	 */
	@RequestMapping(value="/BG/Category",method={RequestMethod.PUT},params={"Action=EquCategory"})
	@Transactional
	public Map<String, String> addEquCategory(@RequestBody EquCategoryBean equCategoryBean){
		EquCategoryManageTable ecmt = new EquCategoryManageTable();
		equCategoryBean.copyPropertyToDestBean(ecmt);
		this.insert(ecmt);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "添加成功.");
		return map;
	}
	
	/**
	 * 设备分类-修改
	 * @param equCategoryBean 传入表单对象
	 * @return Map
	 */
	@RequestMapping(value="/BG/Category/{id}",method={RequestMethod.POST},params={"Action=EquCategory"})
	@Transactional
	public Map<String, String> updEquCategory(@PathVariable Integer id,@RequestBody EquCategoryBean equCategoryBean){
		EquCategoryManageTable ecmt = new EquCategoryManageTable();
		equCategoryBean.copyPropertyToDestBean(ecmt);
		ecmt.setEquCategoryId(id);
		this.update(ecmt);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "修改成功.");
		return map;
	}
	
	/**
	 * 设备分类-删除
	 * @return Map
	 */
	@RequestMapping(value="/BG/Category/{id}",method={RequestMethod.DELETE},params={"Action=EquCategory"})
	@Transactional
	public Map<String, String> delEquCategory(@PathVariable Integer id){
		iCategoryDao.delEquCategory(id);
		
/*		需要删除关系
		iCategoryDao.de*/
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "删除成功.");
		return map;
	}
	
	/**
	 * 设备名称-查询全部信息
	 * @return Page<?>
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/BG/Category",method={RequestMethod.GET},params={"Action=EquName"})
	public Page<?> queryEquName(@RequestParam Map reqParamsMap)
    {
		EquNameSearchBean ens = new EquNameSearchBean();
		Iterator<Entry<String, String>> i = reqParamsMap.entrySet().iterator();
		Entry<String, String> entry;
		while (i.hasNext()) {
		    entry = i.next();
		    String key = entry.getKey();
		    String value = entry.getValue();
		    if(key.equals("pageNo"))
		    	ens.setPageNo(Integer.valueOf(value));
		    if(key.equals("pageSize"))
		    	ens.setPageSize(Integer.valueOf(value));
		    if(key.equals("equCategoryId"))
		    	ens.setEquCategoryId(Integer.valueOf(value));
		    
		    //需要从关系表中查询
		    
		}
		return iCategoryDao.queryEquNamesByEquCategoryId(ens.getPageRequest(),ens.getEquCategoryId());
	}
/*	{
		//传递分页参数的载体
		EquNameSearchBean pageParams = new EquNameSearchBean();
		//传递条件查询参数的载体
		Map<String,Object> sqlParamsMap = new HashMap();
		//获取并初步处理页面传递的请求参数
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageNo")))
		{
			pageParams.setPageNo(Integer.valueOf((String)reqParamsMap.get("pageNo")));
		}
		if(Util.isNotNullOrEmpty(reqParamsMap.get("pageSize")))
		{
			pageParams.setPageSize(Integer.valueOf((String)reqParamsMap.get("pageSize")));
		}
		
		//拼写的列表查询语句
		StringBuffer listSql = new StringBuffer();
		listSql.append("SELECT obj ");
		listSql.append("FROM CategoryTable  obj ");
		listSql.append("WHERE 1=1 ");
	    
		//拼写获取总的记录条数的查询语句
		StringBuffer countSql = new StringBuffer();
		countSql.append("SELECT count(1) "); 
		countSql.append("FROM CategoryTable obj ");		
		countSql.append("WHERE 1=1 ");
		
		listSql.append(" AND ( obj.relationType = 1)");//默认的关系类型
		countSql.append(" AND ( obj.relationType = 1)");
		
		String equCategoryId=(String)reqParamsMap.get("equCategoryId");
		if(Util.isNotNullOrEmpty(equCategoryId))
		{
			Integer equCategoryId_=Integer.valueOf(equCategoryId);
			sqlParamsMap.put("equCategoryId",equCategoryId_);
			listSql.append(" AND ( obj.equCategory.equCategoryId = :equCategoryId)");
			countSql.append(" AND ( obj.equCategory.equCategoryId = :equCategoryId)");
		}
		
		listSql.append("ORDER BY obj.equName.equipmentNo, CONVERT(obj.equName.equipmentName USING gbk) ASC ");
		
		Page<?> datas = (Page<?>)queryList(listSql.toString(),countSql.toString(),sqlParamsMap,pageParams.getPageRequest());
		
		return datas;	
	}*/
	
/*	{
		EquNameSearchBean ens = new EquNameSearchBean();
		Iterator<Entry<String, String>> i = parms.entrySet().iterator();
		Entry<String, String> entry;
		while (i.hasNext()) {
		    entry = i.next();
		    String key = entry.getKey();
		    String value = entry.getValue();
		    if(key.equals("pageNo"))
		    	ens.setPageNo(Integer.valueOf(value));
		    if(key.equals("pageSize"))
		    	ens.setPageSize(Integer.valueOf(value));
		    if(key.equals("equCategoryId"))
		    	ens.setEquCategoryId(Integer.valueOf(value));
		    
		    需要从关系表中查询
		    
		}
		return iCategoryDao.queryEquNamesByEquCategoryId(ens.getPageRequest(),ens.getEquCategoryId());
	}*/
	
	/**
	 * 设备名称-添加
	 * @param equNameBean 传入表单对象
	 * @return Map
	 */
	@RequestMapping(value="/BG/Category",method={RequestMethod.PUT},params={"Action=EquName"})
	@Transactional
	public Map<String, String> addEquName(@RequestBody EquNameBean equNameBean){
		
		EquNameManageTable enmt = new EquNameManageTable();
		equNameBean.copyPropertyToDestBean(enmt);
		this.insert(enmt);
		
		
		//添加默认关系
		CategoryTable ct = new CategoryTable();
		
		EquCategoryManageTable ec=new EquCategoryManageTable();
		ec.setEquCategoryId(equNameBean.getEquCategoryId());
		ct.setEquCategory(ec);
	
		ct.setEquName(enmt);
		
		ct.setRelationType(1);//关系类型 1：代表默认的关系，一个大类对应多个小类 。2：新建的关系一个大类和其对应的某个小类对应的关系
		
		iCategoryDao.save(ct);
		
		
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "添加成功.");
		return map;
	}
	
	/**
	 * 设备名称-修改
	 * @param equNameBean 传入表单对象
	 * @return Map
	 */
	@RequestMapping(value="/BG/Category/{id}",method={RequestMethod.POST},params={"Action=EquName"})
	@Transactional
	public Map<String, String> updEquName(@PathVariable Integer id,@RequestBody EquNameBean equNameBean){
		EquNameManageTable enmt = new EquNameManageTable();
		equNameBean.copyPropertyToDestBean(enmt);
		enmt.setEquNameId(id);
		this.update(enmt);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "修改成功.");
		return map;
	}
	
	/**
	 * 设备名称-删除
	 * @return Map
	 */
	@RequestMapping(value="/BG/Category/{id}",method={RequestMethod.DELETE},params={"Action=EquName"})
	@Transactional
	public Map<String, String> delEquName(@PathVariable Integer id){
		
		//先判断是否作为主外键，然后再决定是否能执行删除操作
		List<CategoryTable> cts=iCategoryDao.queryByEquName(id);
		if(cts!=null && cts.size()>0)
		{
			throw new IFException("此设备名称已使用，不允许删除！");
		}
		
	    //先删除关系
		iCategoryDao.delCategory(id);;
		
		iCategoryDao.delEquName(id);
		Map<String, String> map = new HashMap<String, String>();
		map.put("msg", "删除成功.");
		return map;
	}
	
	/**
	 * 根据设备名称获取设备小类的集合
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/BG/Category",method={RequestMethod.GET},params={"Action=GetByEquName"})
	public Map<String, List<CategoryTable>> getCategoryTableByEquName(@RequestParam Map<?, ?> reqParamsMap) 
	{
		String equipmentName=(String)reqParamsMap.get("equipmentName");
		String equCategoryId=(String)reqParamsMap.get("equCategoryId");
		Map<String, List<CategoryTable>> map = new HashMap<String, List<CategoryTable>>();
		List<CategoryTable> l= new ArrayList<CategoryTable>();
		if(Util.isNullOrEmpty(equipmentName))
		{
			map.put("msg",l);
		}
		l=iCategoryDao.getByEquName(equipmentName ,Integer.parseInt(equCategoryId));
		map.put("msg",l);
		return map;
	}
	
	/**
	 * 根据设备分类号获取设备大类的集合
	 * @param reqParamsMap
	 * @return
	 */
	@RequestMapping(value="/BG/Category",method={RequestMethod.GET},params={"Action=GetByEquCategoryNo"})
	public Map<String, List<EquCategoryManageTable>> getByEquCategoryNo(@RequestParam Map<?, ?> reqParamsMap) 
	{
		String equipmentCategoryNo=(String)reqParamsMap.get("equipmentCategoryNo");
		Map<String, List<EquCategoryManageTable>> map = new HashMap<String, List<EquCategoryManageTable>>();
		List<EquCategoryManageTable> l= new ArrayList<EquCategoryManageTable>();
		if(Util.isNullOrEmpty(equipmentCategoryNo))
		{
			map.put("msg",l);
		}
		l=iCategoryDao.queryByEquCategoryNo(equipmentCategoryNo);
		map.put("msg",l);
		return map;
	}
	
	/*不做用户是否登录的验证+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

	/**
	 * 首页-查询设备分类信息
	 * @return EquCategoryManageTable
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=HomePage"})
	public List<Map<String, Object>> queryHomePage() {

		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();

		// 查询设备类型
		List<Object[]> ecmts = iCategoryDao.nativeQueryEquCategoryManage(1,14);
		if(ecmts==null || ecmts.size()<=0)
			return mapList;

		Map<String, Object> map = new HashMap<String, Object>();
		List<Object[]> equNames = new  ArrayList<Object[]>();
		List<Map<String,Object>> equNameInfos = new  ArrayList<Map<String,Object>>();
		Map<String, Object> equNameInfo = new HashMap<String, Object>();
		for(Object[] equCategory : ecmts){
			map = new HashMap<String, Object>();

			map.put("equCategoryId", equCategory[0]);
			map.put("equipmentCategoryNo", equCategory[1]);
			map.put("equipmentCategoryName", equCategory[2]);

			//	根据设备类型，查询每种设备名称前5条
			equNames = iCategoryDao.nativeQueryEquNameManage(Long.parseLong(Util.toStringAndTrim(equCategory[0])),5);

			equNameInfos = new  ArrayList<Map<String,Object>>();
			for(Object[] equName : equNames){
				equNameInfo = new HashMap<String, Object>();

				equNameInfo.put("equipmentName", equName[0]);
				equNameInfo.put("equipmentNo", equName[1]);
				equNameInfo.put("equNameId", equName[2]);
				equNameInfo.put("searchCount", equName[3]);
				equNameInfo.put("second", equName[4]);

				equNameInfos.add(equNameInfo);
				}

			map.put("equNameInfos", equNameInfos);

			mapList.add(map);
			}

		return mapList;
		}

	/**
	 * 移动端首页-查询设备分类信息
	 * @return EquCategoryManageTable
	 */
	@RequestMapping(value="/Category",method={RequestMethod.GET},params={"Action=HomePage"})
	public List<Map<String, Object>> queryMobileHomePage(@RequestParam Map<?, ?> parms) {

		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();

		// 查询设备类型
		List<Object[]> ecmts = iCategoryDao.nativeQueryEquCategoryManage(1,10);
		if(ecmts==null || ecmts.size()<=0)
			return mapList;

		Map<String, Object> map = new HashMap<String, Object>();
		List<Object[]> equNames = new  ArrayList<Object[]>();
		List<Map<String,Object>> equNameInfos = new  ArrayList<Map<String,Object>>();
		Map<String, Object> equNameInfo = new HashMap<String, Object>();
		for(Object[] equCategory : ecmts){
			map = new HashMap<String, Object>();

			map.put("equCategoryId", equCategory[0]);
			map.put("equipmentCategoryNo", equCategory[1]);
			map.put("equipmentCategoryName", equCategory[2]);

			//	根据设备类型，查询每种设备名称前5条
			equNames = iCategoryDao.nativeQueryEquNameManage(Long.parseLong(Util.toStringAndTrim(equCategory[0])),15);

			equNameInfos = new  ArrayList<Map<String,Object>>();
			for(Object[] equName : equNames){
				equNameInfo = new HashMap<String, Object>();

				equNameInfo.put("equipmentName", equName[0]);
				equNameInfo.put("equipmentNo", equName[1]);
				equNameInfo.put("equNameId", equName[2]);
				equNameInfo.put("searchCount", equName[3]);
				equNameInfo.put("second", equName[4]);

				equNameInfos.add(equNameInfo);
				}

			map.put("equNameInfos", equNameInfos);

			mapList.add(map);
			}

		return mapList;
		}

	/**
	 * 
	 * @param parms
	 * @return
	 */
	@RequestMapping(value="/Issue",method={RequestMethod.GET},params={"Action=ByCategoryId"})
	public List<CategoryTable> queryByCategoryId(@RequestParam Map<?, ?> parms){
		Integer equCategoryId=Integer.valueOf((String)parms.get("equCategoryId"));
		return iCategoryDao.queryByCategoryId(equCategoryId);
	}
}
