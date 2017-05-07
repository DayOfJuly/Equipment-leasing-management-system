package com.hjd.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.BusEquNameParameterTable;
import com.hjd.domain.BusEquParameterTable;


public interface IBusEquParameterDao extends JpaRepository<BusEquParameterTable, Integer> {
	/**
	 * 根据设备参数的ID查询设备参数
	 * @author Qian
	 * @param parameterId
	 * @return
	 * @since 2016-08-03
	 */
	@Query("FROM BusEquParameterTable t WHERE t.parameterId=:parameterId")
	public BusEquParameterTable queryByParameterId(@Param("parameterId") Long parameterId);
	
	/**
	 * 根据设备小类的ID和设备参数的ID来查询，设备小类名称和设备参数是否存在关系
	 * @author Qian
	 * @param parameterId
	 * @return
	 * @since 2016-08-03
	 */
	@Query("FROM BusEquNameParameterTable t WHERE t.equName.equNameId=:equNameId AND t.equParameter.parameterId=:parameterId AND t.equParameter.status=:status")
	public List<BusEquNameParameterTable> queryByEquNameIdAndParameterId(@Param("equNameId") Integer equNameId,@Param("parameterId") Long parameterId,@Param("status") Integer status);
	
	
	/**
	 * 格局
	 * @author Qian
	 * @param parameterId
	 * @return
	 * @since 2016-08-15
	 */
	@Query("FROM BusEquParameterTable t WHERE t.status=:status AND t.type=:type AND t.namePy LIKE:namePy")
	public List<BusEquParameterTable> queryByEquNamePy(@Param("status") Integer status,@Param("type") Integer type,@Param("namePy") String namePy);
	
	
	/**
	 * 根据设备参数的名称查询设备参数的列表
	 * @author Qian
	 * @param status
	 * @param type
	 * @param name
	 * @return
	 * @since 2016-08-22
	 */
	@Query("FROM BusEquParameterTable t WHERE t.status=:status AND t.type=:type AND t.name =:name")
	public List<BusEquParameterTable> queryByEquName(@Param("status") Integer status,@Param("type") Integer type,@Param("name") String name);

}

