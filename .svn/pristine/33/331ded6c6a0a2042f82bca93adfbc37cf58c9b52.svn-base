package com.hjd.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.CategoryTable;
import com.hjd.domain.EquCategoryManageTable;
import com.hjd.domain.EquNameManageTable;

public interface ICategoryDao extends JpaRepository<CategoryTable, Integer> {

	@Query("from CategoryTable t")
	public Page<CategoryTable> queryAll(Pageable pageable);
	
	@Query("FROM CategoryTable t WHERE t.relationType=1")
	public List<CategoryTable> queryCategoryTables();
	
	@Query("from CategoryTable t where t.categoryId=:id")
	public CategoryTable queryDesc(@Param("id") int id);
	
	@Query("from EquCategoryManageTable t")
	public List<EquCategoryManageTable> queryHomePage();
	
	@Query("FROM CategoryTable t WHERE t.equCategory.equCategoryId=:equCategoryId AND t.relationType=1")
	public List<CategoryTable> queryByCategoryId(@Param("equCategoryId")Integer equCategoryId);
	
	@Query("from EquCategoryManageTable t ORDER BY t.equipmentCategoryNo")
	public Page<EquCategoryManageTable> queryEquCategory(Pageable pageable);
	
	@Query("delete from EquCategoryManageTable t where t.equCategoryId=:equCategoryId")
	@Modifying
	public void delEquCategory(@Param("equCategoryId") int equCategoryId);
	
/*	@Query("from EquNameManageTable t where t.equCategoryId=:equCategoryId")
	public Page<EquNameManageTable> queryEquName(Pageable pageable,@Param("equCategoryId") int equCategoryId);*/
	
	@Query("delete from EquNameManageTable t where t.equNameId=:equNameId")
	@Modifying
	public void delEquName(@Param("equNameId") int equNameId);
	
/*	@Query("from EquNameManageTable t where t.equCategoryId=:equCategoryId ORDER BY t.equipmentName ASC")*/
	public Page<?> queryEquNamesByEquCategoryId(Pageable pageable,@Param("equCategoryId") int equCategoryId);
	
	/**
	 * 根据设备类别ID获取设备类别
	 * @author Q
	 * @param id
	 * @return
	 */
	@Query("FROM EquCategoryManageTable t WHERE t.equCategoryId=:id")
	public EquCategoryManageTable queryByEquCategoryId(@Param("id") int id);
	
	/**
	 * 根据设备名称ID获取设备名称
	 * @author Q
	 * @param id
	 * @return
	 */
	@Query("FROM EquNameManageTable t WHERE t.equNameId=:id")
	public EquNameManageTable queryByEquNameId(@Param("id") int id);
	
	/**
	 * 删除默认的设备名称和类别的关系
	 * @param equCategoryId
	 */
	@Query("delete from CategoryTable t where relationType=1 AND t.equName.equNameId=:equNameId")
	@Modifying
	public void delCategory(@Param("equNameId") int equNameId);
	
	/**
	 *  根据设备名称获取设备小类的集合
	 * @param equipmentName
	 * @return
	 */
	@Query("FROM EquNameManageTable t WHERE t.equipmentName=:equipmentName")
	public List<EquNameManageTable> queryByEquName11(@Param("equipmentName") String equipmentName);
	
	
	/**
	 *  根据设备名称获取设备小类的集合
	 * @param equipmentName
	 * @return
	 */
	@Query("FROM CategoryTable t WHERE t.equName.equipmentName=:equipmentName and t.equCategory.equCategoryId=:equCategoryId")
	public List<CategoryTable> getByEquName(@Param("equipmentName") String equipmentName,@Param("equCategoryId") Integer equCategoryId);
	
	/**
	 * 根据设备分类号获取设备大类的集合
	 * @param equipmentCategoryNo
	 * @return
	 */
	@Query("FROM EquCategoryManageTable t WHERE t.equipmentCategoryNo=:equipmentCategoryNo")
	public List<EquCategoryManageTable> queryByEquCategoryNo(@Param("equipmentCategoryNo") String equipmentCategoryNo);
	
	/**
	 * 根据设备名称的ID来查询此设备名称是否在设备分类中使用过
	 * @param equNameId
	 * @return
	 */
	@Query("FROM CategoryTable t WHERE t.equName.equNameId=:equNameId AND t.relationType=2")
	public List<CategoryTable> queryByEquName(@Param("equNameId")Integer equNameId);

	/**
	 * 查询符合的前N条设备分类，原生sql
	 * @param equCategoryId
	 * @param limitNum 
	 */
	@Query(value="select equCat.EquCategoryId,equCat.EquipmentCategoryNo,equCat.EquipmentCategoryName from bus_equ_category_manage equCat where equCat.EquCategoryId in (select cat.EquCategoryId from bus_category cat where cat.relationType and relationType=:relationType) limit :limitNum", nativeQuery=true)
	public List<Object[]> nativeQueryEquCategoryManage(@Param("relationType") Integer relationType, @Param("limitNum") Integer limitNum);

	/**
	 * 根据设备类型，查询符合的前N条设备名称，原生sql
	 * @param equCategoryId
	 * @param limitNum 
	 */
	@Query(value="select equName.EquipmentName,equName.EquipmentNo,equName.EquNameId,equName.SearchCount,equName.second from bus_equ_name_manage equName where equName.EquNameId in (select cat.EquNameId from bus_category cat where cat.EquCategoryId=:equCategoryId) limit :limitNum", nativeQuery=true)
	public List<Object[]> nativeQueryEquNameManage(@Param("equCategoryId") Long equCategoryId, @Param("limitNum") Integer limitNum);

	}

