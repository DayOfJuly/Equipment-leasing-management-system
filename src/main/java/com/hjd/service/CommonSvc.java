package com.hjd.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjd.base.IDomainBase;
import com.hjd.base.IFException;
import com.hjd.dao.IPartyOrgDao;

@Service
public class CommonSvc {

	@Autowired
	private IPartyOrgDao partyOrgDao	=	null;//这里借用IPartyOrgDao来调用通用方法，其实任何一个dao都可以

	/**
	 * 通用的插入或更新原生升sql方法
	 * @param sql
	 * @param params
	 */
	@Transactional
	public int commonNativeUpdate(String sql, Map<String,?> params) {
		
		return partyOrgDao.exeNativeUpdate(sql, params);
		}

	/**
	 * 通用的分页查询原生sql方法
	 */
	public Object commonQueryAllByNativeSql(String listSql,String countSql, Map<String, ?> paramsMap, PageRequest pageRequest) {

		return partyOrgDao.queryAllByNativeSql(listSql, countSql, paramsMap, pageRequest);
		}

	/**
	 * 通用的保存实体方法
	 * @param obj
	 * @return
	 */
	@Transactional
	public <T> T commonSave(T obj){
		partyOrgDao.saveCommonEntry(obj);
 		return obj;
 		}

	/**
	 * 通用的保存实体方法
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Transactional
	public <T> T commonUpdate(IDomainBase bean){
		T objPo = (T)partyOrgDao.findCommonEntry(bean.getClass(), (bean).getObjectId());
		if(objPo==null)
			throw new IFException("要更新的实体记录不存在！");
		BeanUtils.copyProperties(bean,objPo);
		
		partyOrgDao.saveCommonEntry(objPo);
 		return objPo;
 		}

	/**
	 * 通用删除方法
	 * @param <T>
	 * @param obj
	 */
	public void commonDel(IDomainBase bean){
		Object primaryKey =  (bean).getObjectId();
		if(primaryKey==null)
			throw new IFException("未设置实体主键！");
		Object obj = partyOrgDao.findCommonEntry(bean.getClass(), primaryKey);
		if(obj==null)
			throw new IFException("要删除的实体不存在或已被删除！");
		partyOrgDao.removeCommonEntry(obj);
		}

	/**
	 * 通用的查询指定实体方法
	 * @param clazz 实体类型
	 * @param primaryKey 实体主键
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public <T> T commonFind(IDomainBase bean){
		Object primaryKey =  (bean).getObjectId();
		if(primaryKey==null)
			throw new IFException("未设置实体主键！");
		return (T)partyOrgDao.findCommonEntry(bean.getClass(), primaryKey);
		}

	/**
	 * 通用查询列表的方法
	 * @param jsql
	 * @param countJsql
	 * @param paramsMap
	 * @param pageRequest
	 * @return
	 */
	public Object findAllByConditions(String jsql, String countJsql,Map<String, ?> paramsMap, PageRequest pageRequest) {
		
		return partyOrgDao.findAllByConditions(jsql, countJsql, paramsMap, pageRequest);
		}

	public List<?> queryAllByNative(String nativeSql, Map<String, ?> paramsMap) {

		return partyOrgDao.query(nativeSql, paramsMap);
	}

	public Integer queryCountByNative(String nativeSql, Map<String, ?> paramsMap) {

		return partyOrgDao.queryCount(nativeSql, paramsMap);
	}

	}
