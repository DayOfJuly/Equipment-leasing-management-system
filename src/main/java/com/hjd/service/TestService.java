package com.hjd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hjd.base.IFException;
import com.hjd.dao.ITestTableDao;
import com.hjd.domain.TestTable;

@Service
public class TestService {
	@Autowired
	ITestTableDao testTableDao;

	/**
	 * 添加记录
	 * @param testTable
	 * @return
	 */
	@Transactional
	public Integer addTestTable(TestTable testTable){
		if(testTable.getTestId()!=null){
			TestTable testTablePo = testTableDao.findOne(testTable.getTestId());
			if(testTablePo!=null)
				throw new IFException("记录已存在！");
		}
		
		testTableDao.save(testTable);
		return testTable.getTestId();
	}
	/**
	 * 添加记录
	 * @param testTable
	 * @return
	 */
	@Transactional
	public void updateTestTable(TestTable testTable){
		if(testTable.getTestId()==null)
			throw new IFException("请制定要修改的记录id！");
		TestTable testTablePo = testTableDao.findOne(testTable.getTestId());
		if(testTablePo==null)
			throw new IFException("记录不存在或已被删除！"); 
		
		testTablePo.setName(testTable.getName());
		testTablePo.setAmount(testTable.getAmount());
		testTablePo.setDateTest(testTable.getDateTest());
		testTablePo.setTimestampTest(testTable.getTimestampTest());
		testTablePo.setDateTest(testTable.getDateTest());
		testTablePo.setLongTextTest(testTable.getLongTextTest());
		
		testTableDao.save(testTablePo);
	}
	/**
	 * 删除记录
	 * @param testId
	 */
	public void deleteTestTable(Integer testId){
		testTableDao.delete(testId);
	}
	
	/**
	 * 根据id查询记录
	 * @param testId
	 * @return
	 */
	public TestTable getTestTable(Integer testId){
		return testTableDao.findOne(testId);
	}
	
	/**
	 * 根据名字查询记录
	 * @param name
	 * @param pageable
	 * @return
	 */
	public Page<TestTable> findByName(String name, Pageable pageable){
		return testTableDao.findByNameUseQuery(name,pageable);
	}
}
