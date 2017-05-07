package com.hjd.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.BizExData;
import com.hjd.domain.ViewPublishHist;

public interface IBizExDataDao extends JpaRepository<BizExData, Long> {
	
	@Query("from ViewPublishHist t where t.dataId=:dataId")
	public ViewPublishHist queryDescs(@Param("dataId") Long dataId);
	
	/**
	 * 发现自带的方法getOne()有些问题，所以自己写了一个，通过dataId获取扩展对象的方法
	 * @param dataId
	 * @return
	 */
	@Query("FROM BizExData t WHERE t.dataId=:dataId")
	public BizExData queryByDataId(@Param("dataId") Long dataId);
	
	/**
	 * 查询将要出租、出售的设备是否还有未闭环的数据，如果有则不让继续发布新的信息
	 * dataType 1：求租、2：求购、3：出租、4：出售 
	 * state ：1：已成交、2：未成交、3：作废
	 * @param equipmentId
	 * @return
	 */
	@Query("FROM BizExData t WHERE  t.dataType=:dataType AND t.equipmentId=:equipmentId  AND t.state =:state ")
	public List<BizExData> queryByEquipmentId(@Param("dataType") Integer dataType,@Param("equipmentId") Long equipmentId,@Param("state") Integer state);

}
