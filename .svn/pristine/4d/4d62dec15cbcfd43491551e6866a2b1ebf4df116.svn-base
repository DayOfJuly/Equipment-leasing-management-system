package com.hjd.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.Party;
import com.hjd.domain.SysLoginUser;

public interface ISysLoginUserDao extends JpaRepository<SysLoginUser, Long> {

	public SysLoginUser findByParty(@Param("party") Party party);

	/**
	 * 根据用户登录名，获取有效的系统登录用户，有效的员工——员工对应的企业没被删除，员工本身没被停用
	 * @param loginId
	 * @param state
	 * @return
	 */
	
	@Query(value="FROM SysLoginUser loginUser WHERE loginUser.loginId=:loginId AND loginUser.party.state=:state AND loginUser.state=:state AND loginUser.party.parType.parTypeId=:parTypeId")
	public SysLoginUser findAduitUserByLoginId(@Param("loginId") String loginId, @Param("state") Integer state,@Param("parTypeId") Integer parTypeId );
	
	/**
	 * 根据用户登录名，获取有效的系统登录用户，有效的员工——员工对应的企业没被删除，员工本身没被停用
	 * @param loginId
	 * @param state
	 * @return
	 */
	@Query(value="FROM SysLoginUser loginUser WHERE loginUser.loginId=:loginId AND loginUser.party.state=:state AND loginUser.state=:state")
	public SysLoginUser findSysLoginUserByLoginId(@Param("loginId") String loginId, @Param("state") Integer state);
	

	}
