package com.hjd.dao;

import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.hjd.domain.EquipmentTable;
import com.hjd.domain.ViewEquCount;

public interface IIssueDao extends JpaRepository<EquipmentTable, Integer>{
	
	/**
	 * 获取资源的统计列表
	 * @return
	 */
	@Query("from ViewEquCount t")
	public ViewEquCount queryViewEquCount();
	
	/**
	 * 获取发布信息，一样的发布信息题目的记录条数
	 * @param reqParamsMap
	 * @return
	 */
	public Page<?> queryCount(Map<?, ?> reqParamsMap);

}
