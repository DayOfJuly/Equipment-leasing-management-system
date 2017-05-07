package com.hjd.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.TestTable;

public interface ITestTableDao extends JpaRepository<TestTable, Integer> {
	
	/**
	 * jpa直接根据方法名解析生成sql
	 */
	public Page<TestTable> findByName(String name,Pageable pageable);
	
	/**
	 * jpa根据Query解析生成sql
	 */
//	@Query("select new Map(tt.name as name,tt.amount as amount) from TestTable tt where tt.name like:name")
	@Query("from TestTable tt where tt.name like:name")
	public Page<TestTable> findByNameUseQuery(@Param("name") String name,Pageable pageable);
	
	/**
	 * jpa根据Query解析生成sql
	 */
	@Query("delete from TestTable tt where tt.name=:name and amount=:amount")
	@Modifying
	public void updateName(@Param("name") String name,@Param("amount") String amount);
	
}
