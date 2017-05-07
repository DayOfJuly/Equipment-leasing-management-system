package com.hjd.dao;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.SysLoginFun;
import com.hjd.domain.SysLoginUser;

public interface ISysLoginFunDao extends JpaRepository<SysLoginFun, Long> {
	/**
	 * 删除用户的功能关系
	 * @param loginUser
	 */
	
/*	@Query("DELETE FROM SysLoginFun t where t.loginUser=:loginUser")
	@Modifying
	public void deleteByLoginUser(@Param("loginUser") SysLoginUser loginUser);*/
	
	public void deleteByLoginUser(@Param("loginUser") SysLoginUser loginUser);
	/**
	 * 查询用户的功能信息列表
	 * @param loginUserId
	 * @return
	 */
	@Query(value="SELECT new Map(loginFun.functionId as funId,loginFun.name as funName,loginFun.note as funNote) FROM ProdFunSet loginFun WHERE loginFun.functionId in (SELECT loginRelation.functionId.functionId FROM SysLoginFun loginRelation WHERE loginRelation.loginUser.loginUserId=:loginUserId)")
	public List<Map<String,Object>> findSysLoginFunByLoginUser(@Param("loginUserId") Long loginUserId);

	}
