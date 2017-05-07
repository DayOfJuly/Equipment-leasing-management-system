package com.hjd.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.BusEquManufacturerTable;
import com.hjd.domain.ViewEquManufacturer;

public interface IBusEquManufacturerDao extends JpaRepository<BusEquManufacturerTable, Integer> {
	
	@Query("from ViewEquManufacturer t where t.fpy=:fpy")
	public List<ViewEquManufacturer> queryManufacturerNameByFpy(@Param("fpy") String fpy);
	
}

