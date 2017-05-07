package com.hjd.dao;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.PartyRegion;
import com.hjd.domain.PartyRegionRelation;
import com.hjd.domain.PartyRegionRelationType;
import com.hjd.domain.ViewParOrg;

public interface IPartyRegionRelationDao extends JpaRepository<PartyRegionRelation, Long> {

	public PartyRegionRelation findByRelationTypeAndRegion2(@Param("relationType") PartyRegionRelationType relationType, @Param("region2") PartyRegion region2);

	@Query(value="select new Map(region2.regionId as regionId,region2.code as code,region2.name as name) from PartyRegionRelation relation where relation.relationType.regionReType=:regionReType and relation.region1.regionId=:regionId")
	public List<Map<String,Object>> findRegionByRegionId1(@Param("regionReType") Integer regionReType, @Param("regionId") Long regionId);
	/**
	 * 根据子级区域ID来获取父级区域
	 * @param regionReType
	 * @param regionId
	 * @return
	 */
	@Query(value="select new Map(region1.regionId as parentRegionId,region1.code as parentCode,region1.name as parentName,region2.regionId as regionId,region2.code as code,region2.name as name) from PartyRegionRelation relation where relation.relationType.regionReType=:regionReType and relation.region2.regionId=:regionId")
	public Map<String,Object> findRegionByRegionId2(@Param("regionReType") Integer regionReType, @Param("regionId") Long regionId);
	
	@Query("FROM PartyRegion t WHERE t.fpy=:fpy AND t.type = 3 ORDER BY t.name")
	public List<PartyRegion> queryRegionNameByFpy(@Param("fpy") String fpy);
	
	@Query("from ViewParOrg t where t.fpy=:fpy")
	public List<ViewParOrg> queryOrgNameByFpy(@Param("fpy") String fpy);
	}
