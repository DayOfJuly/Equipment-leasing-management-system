package com.hjd.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.PartyPerson;
import com.hjd.domain.SysLoginUser;

public interface IPerPersonDao extends JpaRepository<SysLoginUser, Long> {

	@Query(value="FROM PartyPerson pp WHERE pp.code=:code")
	public PartyPerson findPartyPersonByCode(@Param("code") String code);
	
	@Query(value="FROM PartyPerson pp WHERE pp.partyId=:partyId")
	public PartyPerson findPartyPersonByPartyId(@Param("partyId") Long partyId);

	}
