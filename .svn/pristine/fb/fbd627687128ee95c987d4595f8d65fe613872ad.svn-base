package com.hjd.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.SysLoginRoleType;
import com.hjd.domain.SysRoleFun;

public interface ISysRoleFunDao extends JpaRepository<SysRoleFun, Long> {

	public void deleteByRole(@Param("role") SysLoginRoleType role);

	public List<SysRoleFun> findByRole(@Param("role") SysLoginRoleType role);

	}
