package com.hjd.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.DemandRentTable;

public interface IDemandRentDao extends JpaRepository<DemandRentTable, Integer>{
	
	@Query("from DemandRentTable t ORDER BY t.releaseDate DESC")
	public Page<DemandRentTable> queryAll(Pageable pageable);
	
	@Query("from DemandRentTable t where t.dataId=:dataId")
	public DemandRentTable queryDesc(@Param("dataId") Long dataId);

}
