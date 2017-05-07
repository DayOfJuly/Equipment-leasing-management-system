package com.hjd.dao.base;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IBaseDao {

	/**
	 * 根据jsql查询
	 * @param jsql (如需返回的结果集中每条记录是一个map，可以这样写：select new Map(t1.title as title,t2.name as name) from ...)
	 * @param countJsql
	 * @param paramsMap
	 * @param pageable
	 * @return
	 */
	public Page<?> findAllByConditions(String jsql, String countJsql, Map<String, ?> paramsMap, Pageable pageable);

	/**
	 * 根据jsql查询（参数需自己拼接到jsql中）
	 * @param jsql (如需返回的结果集中每条记录是一个map，可以这样写：select new Map(t1.title as title,t2.name as name) from ...)
	 * @param countJsql
	 * @param pageable
	 * @return
	 */
	public Page<?> findAllByConditions(String jsql, String countJsql,Pageable pageable);

	/**
	 * 执行原生sql更新或插入
	 * @param sql
	 * @param paramsMap
	 */
	public int exeNativeUpdate(String sql, Map<String, ?> paramsMap);

	/**
	 * 执行原生sql查询
	 */
	public Page<?> queryAllByNativeSql(String listSql, String countSql, Map<String, ?> paramsMap, Pageable pageable);

	/**
	 * 通用保存
	 * @param obj
	 * @return
	 */
	public <T> T saveCommonEntry(T obj);

	/**
	 * 通用查询
	 * @param clazz 实体类型
	 * @param primaryKey 主键
	 * @return 实体
	 */
	public <T> T findCommonEntry(Class<T> clazz, Object primaryKey);

	/**
	 * 通用删除
	 * @param obj 要删除的实体
	 */
	public void removeCommonEntry(Object obj);
	
	
	/**
	 * 不分页查询结果集
	 * @param jsql
	 * @param paramsMap
	 * @return
	 */
	public List<?> query(String jsql, Map<String, ?> paramsMap);
	
	/**
	 * 不分页查询结果集
	 * @param jsql
	 * @param paramsMap
	 * @return
	 */
	public Integer queryCount(String jsql, Map<String, ?> paramsMap);

	}
