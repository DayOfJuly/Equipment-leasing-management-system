package com.hjd.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.BusRefuseReasonTable;

public interface IBusRefuseReasonDao extends JpaRepository<BusRefuseReasonTable, Integer>{
	
	@Query("from BusRefuseReasonTable t where t.dataId=:dataId")
	public List<BusRefuseReasonTable> queryDescs(@Param("dataId") Long dataId);
	
}
