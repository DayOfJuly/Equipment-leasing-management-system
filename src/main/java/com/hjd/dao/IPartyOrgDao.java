package com.hjd.dao;

import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.dao.base.IBaseDao;
import com.hjd.domain.PartyOrg;

public interface IPartyOrgDao extends JpaRepository<PartyOrg, Long>,IBaseDao {

	public PartyOrg findByCodeAndState(@Param("code") String code, @Param("state") Integer state);

	public PartyOrg findByNameAndState(@Param("name") String name, @Param("state") Integer state);
	
	/**
	 * 根据父级企业的编码获取子级企业编码最大的那一个子企业编码
	 * @param parentCode
	 * @return
	 */
	@Query(value="SELECT new Map( MAX(po.code) as maxCode)FROM PartyOrg po WHERE po.parType.parTypeId=4 AND po.parentCode=:parentCode GROUP BY po.parentCode")
	public Map<String,Object> findByParentCode(@Param("parentCode") String parentCode);

	}
