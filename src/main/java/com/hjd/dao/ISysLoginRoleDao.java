package com.hjd.dao;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.SysLoginRole;
import com.hjd.domain.SysLoginUser;

public interface ISysLoginRoleDao extends JpaRepository<SysLoginRole, Long> {

	public void deleteByLoginUser(@Param("loginUser") SysLoginUser loginUser);

	@Query(value="select new Map(loginRole.role as roleId,loginRole.name as roleName,loginRole.note as note,loginRole.updateTime as updateTime,loginRole.party.partyId as partyId,(select org.name from PartyOrg org where org.partyId=loginRole.party.partyId) as deptName) from SysLoginRoleType loginRole where loginRole.role in (select loginRelation.role.role from SysLoginRole loginRelation where loginRelation.loginUser.loginUserId=:loginUserId) and loginRole.state=:state")
	public List<Map<String,Object>> findSysLoginRoleByLoginUser(@Param("loginUserId") Long loginUserId, @Param("state") Integer state);

	}
