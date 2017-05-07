package com.hjd.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.Party;
import com.hjd.domain.PartyOrg;
import com.hjd.domain.PartyPerson;
import com.hjd.domain.PartyRelation;
import com.hjd.domain.PartyRelationType;

public interface IPartyRelationDao extends JpaRepository<PartyRelation, Long> {

	public void deleteByRelationTypeAndParty2(@Param("relationType") PartyRelationType relationType, @Param("party2") Party party2);

	@Query(value="select count(1) from PartyRelation relation where relation.relationType.relationType=:relationType and relation.party1=:party1 and relation.party2.state=:state")
	public Integer findPartyByPartyId1(@Param("relationType") Integer relationType, @Param("party1") Party party1, @Param("state") Integer state);

	public PartyRelation findByRelationTypeAndParty2(@Param("relationType") PartyRelationType relationType, @Param("party2") Party party2);

	@Query(value="FROM PartyOrg org WHERE (org.parType.parTypeId=4 OR org.parType.parTypeId=8) AND  org.partyId in (select relation.party1.partyId from PartyRelation relation where relation.relationType.relationType=:relationType and relation.party2.partyId=:partyId)")
	public PartyOrg findPartyOrgByPartyId2(@Param("relationType") Integer relationType, @Param("partyId") Long partyId);
	
	@Query(value="FROM PartyOrg org WHERE org.parType.parTypeId=5 AND  org.partyId in (select relation.party1.partyId from PartyRelation relation where relation.relationType.relationType=:relationType and relation.party2.partyId=:partyId)")
	public PartyOrg findPartyProByPartyId2(@Param("relationType") Integer relationType, @Param("partyId") Long partyId);

	/**
	 * 获取当前组织的下级组织，通过当前组织的ID和下级组织的名称，当然，获取的是有效的组织
	 * @param relationType
	 * @param partyId
	 * @param name
	 * @param state
	 * @return
	 */
	@Query(value="from PartyOrg org where org.partyId in (select relation.party2.partyId from PartyRelation relation where relation.relationType.relationType=:relationType and relation.party1.partyId=:partyId) and org.name=:name and org.state=:state")
	public PartyOrg findPartyOrgByPartyId1AndName(@Param("relationType") Integer relationType, @Param("partyId") Long partyId, @Param("name") String name, @Param("state") Integer state);
	
	
	@Query(value="FROM PartyOrg org WHERE org.partyId IN (SELECT relation.party2.partyId FROM PartyRelation relation WHERE relation.relationType.relationType=1 AND relation.party1.partyId=:parentOrgId) AND org.name IS NOT NULL AND org.contacts IS NULL AND org.state=0 AND (org.parType.parTypeId=4 OR org.parType.parTypeId=8)")
	public List<PartyOrg> findPartyOrgByPartyId1AndName_test(@Param("parentOrgId") Long parentOrgId);
	
	@Query(value="FROM PartyOrg org WHERE org.partyId IN (SELECT relation.party2.partyId FROM PartyRelation relation WHERE relation.relationType.relationType=1 AND relation.party1.partyId=:parentOrgId) AND org.name IS NOT NULL AND org.contacts IS NOT NULL AND org.state=0 AND (org.parType.parTypeId=4 OR org.parType.parTypeId=8)")
	public List<PartyOrg> findPartyOrgByPartyId1AndName_test2(@Param("parentOrgId") Long parentOrgId);

	/**
	 * 根据企业的id获取该企业下的管理员员工
	 * @param parentOrgId
	 * @return
	 */
	@Query(value="FROM PartyPerson pp WHERE pp.partyId IN (SELECT relation.party2.partyId FROM PartyRelation relation WHERE relation.relationType.relationType=1 AND relation.party1.partyId=:parentOrgId) AND pp.admFlag=1 AND pp.state=0")
	public List<PartyPerson> findPersonByParentOrgId(@Param("parentOrgId") Long parentOrgId);
	}
