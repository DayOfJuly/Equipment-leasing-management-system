package com.hjd.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.BusOwnHistTable;

public interface IBusOwnHistDao extends JpaRepository<BusOwnHistTable, Integer>{

	/**
	 * 根据设备的ID来获取最近的
	 * @param equipmentId
	 * @return
	 */
    @Query(value="FROM BusOwnHistTable boht WHERE boht.id = (SELECT MAX(id) FROM  BusOwnHistTable WHERE equipmentId=:equipmentId GROUP BY equipmentId)")
	public BusOwnHistTable getByEquipmentId(@Param("equipmentId") Long equipmentId);
}
