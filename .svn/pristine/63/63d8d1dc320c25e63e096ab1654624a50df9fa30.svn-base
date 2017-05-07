package com.hjd.dao.base;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.hibernate.SQLQuery;
import org.hibernate.transform.Transformers;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

public class IBaseDaoImpl implements IBaseDao{

	@PersistenceContext  
	protected EntityManager em;  

	/* (non-Javadoc)
	 * @see rdb.dao.base.IBaseDao#saveCommonEntry(java.lang.Object)
	 */
	public <T> T saveCommonEntry(T obj){

		em.persist(obj);
		return obj;
		}

	/* (non-Javadoc)
	 * @see rdb.dao.base.IBaseDao#findCommonEntry(java.lang.Class, java.lang.Object)
	 */
	public <T> T findCommonEntry(Class<T> clazz, Object primaryKey){

		return em.find(clazz, primaryKey);
		}

	/* (non-Javadoc)
	 * @see rdb.dao.base.IBaseDao#removeCommonEntry(java.lang.Object)
	 */
	public void removeCommonEntry(Object obj){

		em.remove(obj);
		}

	/* (non-Javadoc)
	 * @see rdb.dao.base.IBaseDao#findAllByConditions(java.lang.String, java.util.Map, org.springframework.data.domain.Pageable)
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Page<?> findAllByConditions(String jsql, String countJsql, Map<String, ?> paramsMap, Pageable pageable){

		Integer count = 0;
		if(countJsql!=null&&!"".equals(countJsql)){
			Query countQuery = em.createQuery(countJsql);  
			if(paramsMap!=null){
				for (Entry<String, ?> entry: paramsMap.entrySet()) {
					countQuery.setParameter(entry.getKey(), entry.getValue());
				}
			}
			count = Integer.valueOf(countQuery.getSingleResult().toString());
		}

		Query query = em.createQuery(jsql);  
		if(paramsMap!=null){
			for (Entry<String, ?> entry: paramsMap.entrySet()) {
				query.setParameter(entry.getKey(), entry.getValue());
			}
		}
		query.setFirstResult(pageable.getOffset());
		query.setMaxResults(pageable.getPageSize()<100 ? pageable.getPageSize() : 99);
		List<?> list = query.getResultList();
		Page<?> page = new PageImpl(list,pageable,count);
		return page;
		}

	/* (non-Javadoc)
	 * @see rdb.dao.base.IBaseDao#findAllByConditions(java.lang.String, java.lang.String, org.springframework.data.domain.Pageable)
	 */
	public Page<?> findAllByConditions(String jsql, String countJsql,Pageable pageable) {

		return findAllByConditions(jsql, countJsql, null, pageable);
		}

	/* (non-Javadoc)
	 * @see rdb.dao.base.IBaseDao#exeNativeUpdate(java.lang.String, java.util.Map)
	 */
	public int exeNativeUpdate(String sql, Map<String, ?> paramsMap) {

		Query query = em.createNativeQuery(sql);  
		if(paramsMap!=null){
			for (Entry<String, ?> entry: paramsMap.entrySet()) {
				query.setParameter(entry.getKey(), entry.getValue());
			}
		}
		return query.executeUpdate();
		}
	
	/**
	 * @执行原生的SQL语句，注意：SQL语句中的关键词默认全部是大写的特别是SELECT,FROM，另外，所查出来的列必须是明确的，使用AS别名来接收数据，最终返回的结果集中放入的是Map对象
	 * @author Q
	 * @param sql 拼写的原生查询结果集的SQL语句
	 * @param countSql 拼写的原生查询结果集的记录条数的SQL语句
	 * @param paramsMap 传递查询参数值的Map
	 * @param pageable 分页对象
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Page<?> queryAllByNativeSql(String sql,String countSql, Map<String, ?> paramsMap, Pageable pageable)
	{
		//获取结果集的记录总条数
		Integer count = 0;
		if(countSql!=null&&!"".equals(countSql))
		{
			Query countQuery = em.createNativeQuery(countSql);
			if(paramsMap!=null)
			{
				for (Entry<String, ?> entry: paramsMap.entrySet()) 
				{
					countQuery.setParameter(entry.getKey(), entry.getValue());
				}
			}
			count = Integer.valueOf(countQuery.getSingleResult().toString());
		}

		//获取结果集
		Query query = em.createNativeQuery(sql);
		query.unwrap(SQLQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		if(paramsMap!=null)
		{
			for (Entry<String, ?> entry: paramsMap.entrySet()) 
			{
				query.setParameter(entry.getKey(), entry.getValue());
			}
		}
		query.setFirstResult(pageable.getOffset());
		query.setMaxResults(pageable.getPageSize()<100 ? pageable.getPageSize() : 99);
		List<Object> list = query.getResultList();

		//如果结果集为空，则直接返回，否则将对应的结果集中的数据放入Map中，然后将Map放入List中，最后加上分页处理
		if(list==null || list.size()<=0)
		{ 
			list =new ArrayList<Object>();
			return new PageImpl<Object>(list);
	    }
		Page<?> page = new PageImpl(list,pageable,count);
		return page;
		}

	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List query(String jsql, Map<String, ?> paramsMap){
		Query query = em.createNativeQuery(jsql);  
		query.unwrap(SQLQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		if(paramsMap!=null){
			for (Entry<String, ?> entry: paramsMap.entrySet()) {
				query.setParameter(entry.getKey(), entry.getValue());
			}
		}
		List list = query.getResultList();
		return list;
	}

	public Integer queryCount(String jsql, Map<String, ?> paramsMap) {

		Query query = em.createNativeQuery(jsql);  

		if(paramsMap!=null){
			for (Entry<String, ?> entry: paramsMap.entrySet()) {
				query.setParameter(entry.getKey(), entry.getValue());
			}
		}

		List<BigInteger> list = query.getResultList();

		return ((BigInteger)list.get(0)).intValue();
	}

	public static void main(String[] args){
		String sql = " select equnameid from bus_category";
		List<Map> list = new IBaseDaoImpl().query(sql, new HashMap());
		System.out.println(list.size());
	}
	
	
	}