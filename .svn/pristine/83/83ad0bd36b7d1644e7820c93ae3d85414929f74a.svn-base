package com.hjd.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.SaleTable;

public interface ISaleDao extends JpaRepository<SaleTable, Integer>{
	
	@Query("from SaleTable t ORDER BY t.releaseDate DESC")
	public Page<SaleTable> queryAll(Pageable pageable);
	
	@Query("from SaleTable t where t.dataId=:dataId")
	public SaleTable queryDesc(@Param("dataId") Long dataId);
	
	@Query("from SaleTable")
	public void updDesc();
	
	@Query("from SaleTable t where t.equipmentTable.equipmentId=:equipmentId")
	public List<SaleTable> queryByEquipmentId(@Param("equipmentId") Long equipmentId);

}
