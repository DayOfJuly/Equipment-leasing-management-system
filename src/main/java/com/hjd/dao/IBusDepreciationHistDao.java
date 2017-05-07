package com.hjd.dao;


import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.action.bean.BusDepreciationHistSearchBean;
import com.hjd.domain.BusDepreciationHistTable;

public interface IBusDepreciationHistDao extends JpaRepository<BusDepreciationHistTable, Integer>{
	
	@Query("from BusDepreciationHistTable t where t.id=:id")
	public BusDepreciationHistTable queryDesc(@Param("id") Long id);
	
	@Query("FROM BusDepreciationHistTable t WHERE t.equipmentId=:equipmentId AND  t.month=:month")
	public BusDepreciationHistTable queryByEquIdAndMonth(@Param("equipmentId") Long equipmentId,@Param("month") String month);
	
	public Page<?> queryAll(BusDepreciationHistSearchBean busDepreciationHistSearchBean);
	
	public Page<?> queryAllProvider(BusDepreciationHistSearchBean busDepreciationHistSearchBean);

}
