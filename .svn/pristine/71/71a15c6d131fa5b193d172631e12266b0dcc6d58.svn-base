package com.hjd.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.EquNameManageTable;
import com.hjd.domain.ViewEquName;

public interface IBusEquNameManageDao extends JpaRepository<EquNameManageTable, Integer> {
	
/*	@Query("from EquNameManageTable t where t.equCategoryId=:equCategoryId")
	public Page<EquNameManageTable> queryEquName(Pageable pageable,@Param("equCategoryId") int equCategoryId);*/
	
	@Query("from ViewEquName t where t.fpy=:fpy")
	public List<ViewEquName> queryEquNameByFpy(@Param("fpy") String fpy);

	@Query("from ViewEquName t where t.equipmentName like :equipmentName")
	public List<ViewEquName> queryEquNameByLike(@Param("equipmentName") String equipmentName);

}

