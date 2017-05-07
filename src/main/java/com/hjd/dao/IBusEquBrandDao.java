package com.hjd.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.BusEquBrandTable;
import com.hjd.domain.ViewEquBrand;

public interface IBusEquBrandDao extends JpaRepository<BusEquBrandTable, Integer> {
	
	@Query("from ViewEquBrand t where t.fpy=:fpy")
	public List<ViewEquBrand> queryBrandNameByFpy(@Param("fpy") String fpy);
	
}

