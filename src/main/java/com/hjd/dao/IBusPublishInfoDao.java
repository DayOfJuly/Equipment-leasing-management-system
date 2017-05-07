package com.hjd.dao;

import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.action.bean.BusPublishInfoSearchBean;
import com.hjd.domain.BusPublishInfoTable;

public interface IBusPublishInfoDao extends JpaRepository<BusPublishInfoTable, Integer>{
	
	@Query("from BusPublishInfoTable t where t.id=:id")
	public BusPublishInfoTable queryDesc(@Param("id") Long id);

	/**
	 * 为了提高查询语句的速度，将查询视图的方式修改为查询原生SQL语句的形式
	 * @param busPublishInfoSearchBean
	 * @param httpSession
	 * @return
	 */
	public Page<?> queryAll(BusPublishInfoSearchBean busPublishInfoSearchBean,HttpSession httpSession);
	
}
