package com.hjd.dao;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.ParContactInfoTable;

public interface IParContactInfoDao extends JpaRepository<ParContactInfoTable, Integer>{
	
	
	@Query("UPDATE ParContactInfoTable t SET t.defConFlag=0 where t.partyId=:partyId")
	@Modifying
	public void updateByPartyId(@Param("partyId") Long partyId);
	
	@Query(" FROM ParContactInfoTable t WHERE t.partyId=:partyId AND defConFlag=1 ")
	public ParContactInfoTable queryByPartyIdAndDefFlag(@Param("partyId") Long partyId);
	
	@Query(" FROM ParContactInfoTable t WHERE t.contactId=:contactId")
	public ParContactInfoTable queryDesc(@Param("contactId") Long contactId);
	
}
