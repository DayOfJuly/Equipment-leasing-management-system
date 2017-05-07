package com.hjd.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.EquipmentTable;

public interface IEquipmentDao extends JpaRepository<EquipmentTable, Long> {

	@Query("from EquipmentTable t")
	public Page<EquipmentTable> queryAll(Pageable pageable);
	
	@Query("from EquipmentTable t where t.equipmentId=:equipmentId")
	public EquipmentTable queryDesc(@Param("equipmentId") Long equipmentId);
	
	
	/**
	 * 根据设备编号获取设备资源的集合
	 * @param equNo
	 * @return
	 */
	@Query("FROM EquipmentTable t WHERE t.equNo=:equNo and t.delFlag!=1")
	public List<EquipmentTable> queryByEquNo(@Param("equNo") String equNo);
	
	/**
	 * 查看当前项目下是否还有正在使用的资源
	 * @param equNo
	 * @return
	 */
	@Query("FROM EquipmentTable t WHERE t.delFlag!=1  AND t.equState=:equState AND t.projectId=:projectId")
	public List<EquipmentTable> queryEquStateAndProjectId(@Param("equState") Integer equState,@Param("projectId") Long projectId);
	
	/*@Query("from EquipmentCategoryTable t where t.id=:equipmentId")
	public EquipmentCategoryTable queryDesc(@Param("equipmentId") int equipmentId);
	
	@Query("from EquipmentCategoryTable")
	public List test();*/
	
}
