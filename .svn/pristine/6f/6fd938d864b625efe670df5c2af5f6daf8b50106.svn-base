package com.hjd.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.EquipmentCategoryTable;

public interface IEquipmentCategoryDao extends JpaRepository<EquipmentCategoryTable, Integer>{
	
	@Query("delete from EquipmentCategoryTable t where t.equipmentCategoryId=:equipmentCategoryId")
	@Modifying
	public void deleteDesc(@Param("equipmentCategoryId") int equipmentCategoryId);

	@Query("delete from EquipmentCategoryTable t where t.equipmentId=:equipmentId")
	@Modifying
	public void deleteEquCat(@Param("equipmentId") Long equipmentId);

	@Query("from EquipmentCategoryTable t where t.equipmentCategoryId=:equipmentCategoryId")
	public EquipmentCategoryTable queryDesc(@Param("equipmentCategoryId") int equipmentCategoryId);

	/**
	 * 根据设备类型查询设备类型与设备是否存在关系
	 * @param categoryId
	 * @return
	 */
	@Query("FROM EquipmentCategoryTable t WHERE t.categoryTable.categoryId=:categoryId")
	public List<EquipmentCategoryTable> queryByCategory(@Param("categoryId") int categoryId);
	
}
