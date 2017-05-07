package com.hjd.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.EquipmentAscriptionTable;

public interface IEquipmentAscriptionDao extends JpaRepository<EquipmentAscriptionTable, Integer>{
	
	@Query("delete from EquipmentAscriptionTable t where t.equipmentAscriptionId=:equipmentAscriptionId")
	@Modifying
	public void deleteDesc(@Param("equipmentAscriptionId") int equipmentAscriptionId);
	
	@Query("from EquipmentAscriptionTable t where t.equipmentAscriptionId=:equipmentAscriptionId")
	public EquipmentAscriptionTable queryDesc(@Param("equipmentAscriptionId") int equipmentAscriptionId);

	@Query("delete from EquipmentAscriptionTable t where t.equipmentId=:equipmentId")
	@Modifying
	public void deleteEquAscription(@Param("equipmentId") Long equipmentId);
	
}
