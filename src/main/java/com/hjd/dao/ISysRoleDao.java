package com.hjd.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.SysLoginRoleType;

public interface ISysRoleDao extends JpaRepository<SysLoginRoleType, Long> {

	@Query("FROM SysLoginRoleType t WHERE t.name=:name AND t.state!=2")
	public SysLoginRoleType queryByName(@Param("name") String name);
	
	}
