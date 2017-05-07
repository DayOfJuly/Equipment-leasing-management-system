package com.hjd.dao;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.action.bean.BusRentHistSearchBean;
import com.hjd.domain.BusRentHistTable;
import com.hjd.domain.ViewEquInfo;
import com.hjd.domain.ViewEquOwnInfo;
import com.hjd.domain.ViewRentHistSum;

public interface IBusRentHistDao extends JpaRepository<BusRentHistTable, Integer>{
	
	@Query("from BusRentHistTable t where t.id=:id")
	public BusRentHistTable queryDesc(@Param("id") Long id);
	
	@Query("FROM BusRentHistTable t WHERE t.equipmentId=:equipmentId AND  t.month=:month AND t.regFlag=:regFlag ORDER BY t.id DESC")
	public List<BusRentHistTable> queryByEquIdAndMonth(@Param("equipmentId") Long equipmentId,@Param("month") String month,@Param("regFlag") Integer regFlag);
	
	/**
	 * 删除某个设备某个月的拥有者登记的租赁费信息
	 * @param equipmentId
	 * @param month
	 * @return
	 */
	@Query("DELETE BusRentHistTable t WHERE t.equipmentId=:equipmentId AND  t.month=:month AND t.regFlag=0")
	@Modifying
	public void deleteByEquIdAndMonth(@Param("equipmentId") Long equipmentId,@Param("month") String month);
	
	/**
	 * 根据ID删除租赁费登记的记录
	 * @param equipmentId
	 * @param month
	 * @return
	 */
	@Query("DELETE BusRentHistTable t WHERE t.id=:id")
	@Modifying
	public void deleteById(@Param("id") Long id);
	
	/**
	 * 此方法还不完善，需要根据月份和登记人所在的单位来查询对应的登记记录
	 * @param month
	 * @return
	 */
	@Query("FROM ViewRentHistSum t WHERE t.month=:month")
	public List<ViewRentHistSum> queryByMonth(@Param("month") String month);
	
	
	
	@Query("from ViewEquInfo t where t.equipmentId=:equipmentId")
	public ViewEquInfo queryViewEquInfo(@Param("equipmentId") Long equipmentId);
	
	/**
	 * 根据设备的所属单位和设备的ID来获取设备的信息
	 * @param equipmentId
	 * @param partyId
	 * @return
	 */
	@Query("from ViewEquOwnInfo t where t.equipmentId=:equipmentId AND t.partyId=:partyId ")
	public ViewEquOwnInfo queryViewEquOwnInfo(@Param("equipmentId") Long equipmentId,@Param("partyId") Long partyId);

	public Page<?> queryOwnerAll(BusRentHistSearchBean busRentHistSearchBean,HttpSession httpSession);
	
	public Page<?> queryUserAll(BusRentHistSearchBean busRentHistSearchBean);
 
	/**
	 * 此方法还不完善，需要根据月份和登记人所在的单位来查询对应的登记记录，可能需要拼写视图
	 * @param month
	 * @return
	 */
	@Query("FROM BusRentHistTable t WHERE t.month=:month AND t.regFlag=1")
	public List<BusRentHistTable> queryByOperatorAndMonth(@Param("month") String month);
	
	/**
	 * 根据设备使用单位和对应的年月，获取对应的设备租赁费登记的集合——使用者
	 * @param month
	 * @return
	 */
	@Query("FROM BusRentHistTable t WHERE t.month=:month AND t.equAtOrgId=:equAtOrgId AND t.regFlag=1")
	public List<BusRentHistTable> queryByEquAtOrgIdAndMonth(@Param("equAtOrgId") Long equAtOrgId,@Param("month") String month);
	
	/**
	 * 根据设备使用单位和对应的年月，获取对应的设备租赁费登记的集合——使用者
	 * @param month
	 * @return
	 */
	@Query("FROM BusRentHistTable t WHERE t.month=:month AND t.equAtOrgCode LIKE:equAtOrgCode AND t.regFlag=1")
	public List<BusRentHistTable> queryByEquAtOrgCodeAndMonth(@Param("equAtOrgCode") String equAtOrgCode,@Param("month") String month);
	
	/**
	 * 根据设备使用单位和对应的年月，获取对应的设备租赁费登记的集合——使用者
	 * @param month
	 * @return
	 */
	@Query("FROM BusRentHistTable t WHERE t.month=:month AND t.equAtOrgCode =:equAtOrgCode AND t.regFlag=1")
	public List<BusRentHistTable> getByEquAtOrgCodeAndMonth(@Param("equAtOrgCode") String equAtOrgCode,@Param("month") String month);
	
	/**
	 * 根据设备拥有单位和对应的年月，获取对应的设备租赁费登记的集合——拥有者
	 * @param month
	 * @return
	 */
	@Query("FROM ViewRentHistSum t WHERE t.month=:month AND t.equAtOrgId=:equAtOrgId ")
	public List<ViewRentHistSum> queryByEquOwnOrgIdAndMonth(@Param("equAtOrgId") Long equAtOrgId,@Param("month") String month);
	
	/**
	 * 根据设备拥有单位和对应的年月，获取对应的设备租赁费登记的集合——拥有者
	 * @param month
	 * @return
	 */
	@Query("FROM ViewRentHistSum t WHERE t.month=:month AND t.equAtOrgCode LIKE:equAtOrgCode ")
	public List<ViewRentHistSum> queryByEquOwnOrgCodeAndMonth(@Param("equAtOrgCode") String equAtOrgCode,@Param("month") String month);
	
	/**
	 * 根据设备拥有单位和对应的年月，获取对应的设备租赁费登记的集合——拥有者
	 * @param month
	 * @return
	 */
	@Query("FROM ViewRentHistSum t WHERE t.month=:month AND t.equAtOrgCode =:equAtOrgCode ")
	public List<ViewRentHistSum> getByEquOwnOrgCodeAndMonth(@Param("equAtOrgCode") String equAtOrgCode,@Param("month") String month);

}
