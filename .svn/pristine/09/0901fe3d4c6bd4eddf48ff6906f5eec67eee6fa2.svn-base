package com.hjd.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.RentTable;

public interface IRentDao extends JpaRepository<RentTable, Integer>{
	
	@Query("from RentTable t ORDER BY t.releaseDate DESC")
	public Page<RentTable> queryAll(Pageable pageable);
	
	@Query("from RentTable t where t.dataId=:dataId")
	public RentTable queryDesc(@Param("dataId") Long dataId);
	
	@Query("from RentTable")
	public void updDesc();
	
	@Query("from RentTable t where t.equipmentTable.equipmentId=:equipmentId")
	public List<RentTable> queryByEquipmentId(@Param("equipmentId") Long equipmentId);
	
}
