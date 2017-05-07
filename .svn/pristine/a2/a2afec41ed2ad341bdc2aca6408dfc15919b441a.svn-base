package com.hjd.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.DemandSaleTable;

public interface IDemandSaleDao extends JpaRepository<DemandSaleTable, Integer>{
	
	@Query("from DemandSaleTable t ORDER BY t.releaseDate DESC")
	public Page<DemandSaleTable> queryAll(Pageable pageable);
	
	@Query("from DemandSaleTable t where t.dataId=:dataId")
	public DemandSaleTable queryDesc(@Param("dataId") Long dataId);

}
