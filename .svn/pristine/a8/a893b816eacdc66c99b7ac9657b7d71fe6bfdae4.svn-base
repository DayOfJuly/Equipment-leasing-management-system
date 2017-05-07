package com.hjd.dao;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.BusUseInfoTable;

public interface IBusUseInfoDao extends JpaRepository<BusUseInfoTable, Integer>{
	
	@Query("FROM BusUseInfoTable t WHERE t.equAtOrgId=:equAtOrgId AND  t.month=:month ")
	public List<BusUseInfoTable> queryByEquAtOrgIdAndMonth(@Param("equAtOrgId") Long equAtOrgId,@Param("month") String month);
	
	@Query("UPDATE BusUseInfoTable t set t.exitFlag=1,t.exeuntDate=:exeuntDate WHERE t.equAtOrgId=:equAtOrgId AND  t.equipmentId=:equipmentId  AND  t.exitFlag!=1 AND  t.month<=:month ")
	@Modifying
	public void updByEquAtOrgIdAndMonth(@Param("equipmentId") Long equipmentId,@Param("equAtOrgId") Long equAtOrgId,@Param("month") String month,@Param("exeuntDate") Date exeuntDate);
}
