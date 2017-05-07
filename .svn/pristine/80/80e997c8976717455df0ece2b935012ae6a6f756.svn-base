package com.hjd.dao;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.BusDealInfoTable;
import com.hjd.domain.ViewDealInfo;

public interface IBusDealInfoDao extends JpaRepository<BusDealInfoTable, Integer>{
	
	@Query("from BusDealInfoTable t where t.id=:id")
	public BusDealInfoTable queryDesc(@Param("id") Long id);
	
	/**
	 * 根据发布信息的ID和当前登录人的ID来判断，当前登录人是否已经点击了我想交易的按钮
	 * @param loginUserId
	 * @param dataId
	 * @return
	 */
	@Query("from BusDealInfoTable t where t.loginUserId=:loginUserId AND t.dataId=:dataId AND t.operateFlag=0")
	public List<BusDealInfoTable> queryByIdAndDataId(@Param("loginUserId") Long loginUserId,@Param("dataId")Long dataId);
	
	/**
	 * 对应的发布信息，我想交易的有效次数
	 * @param id
	 * @return
	 */
	@Query(value="SELECT new Map (COUNT(obj) AS dealCount,obj.dataId AS dataId)FROM BusDealInfoTable obj WHERE obj.operateFlag=0 AND obj.dataId=:dataId GROUP BY obj.dataId,obj.operateFlag")
	public Map<String,Object> queryDealCount(@Param("dataId") Long dataId);
	
	@Query("from ViewDealInfo t where t.id=:id")
	public ViewDealInfo queryDescs(@Param("id") Long id);

}
